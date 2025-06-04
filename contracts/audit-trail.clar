;; Audit Trail Contract
;; Maintains comprehensive access control audit trails

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_INVALID_ACTION (err u401))

(define-map audit-logs
  { log-id: uint }
  {
    user: principal,
    facility-id: uint,
    action: (string-ascii 50),
    timestamp: uint,
    success: bool,
    details: (string-ascii 500),
    ip-hash: (buff 32)
  }
)

(define-data-var log-counter uint u0)

(define-map authorized-loggers
  { logger: principal }
  { authorized: bool }
)

(define-public (authorize-logger (logger principal))
  (begin
    (asserts! (is-eq tx-sender contract-caller) ERR_UNAUTHORIZED)
    (map-set authorized-loggers { logger: logger } { authorized: true })
    (ok true)
  )
)

(define-public (log-access-attempt
  (user principal)
  (facility-id uint)
  (action (string-ascii 50))
  (success bool)
  (details (string-ascii 500))
  (ip-hash (buff 32))
)
  (let ((log-id (+ (var-get log-counter) u1)))
    (asserts!
      (default-to false
        (get authorized (map-get? authorized-loggers { logger: tx-sender }))
      )
      ERR_UNAUTHORIZED
    )
    (map-set audit-logs
      { log-id: log-id }
      {
        user: user,
        facility-id: facility-id,
        action: action,
        timestamp: block-height,
        success: success,
        details: details,
        ip-hash: ip-hash
      }
    )
    (var-set log-counter log-id)
    (ok log-id)
  )
)

(define-read-only (get-audit-log (log-id uint))
  (map-get? audit-logs { log-id: log-id })
)

(define-read-only (get-logs-count)
  (var-get log-counter)
)

(define-public (log-facility-access (user principal) (facility-id uint) (success bool))
  (log-access-attempt
    user
    facility-id
    "FACILITY_ACCESS"
    success
    "User attempted facility access"
    0x00
  )
)

(define-public (log-permission-change (user principal) (facility-id uint) (action (string-ascii 50)))
  (log-access-attempt
    user
    facility-id
    action
    true
    "Permission modified"
    0x00
  )
)

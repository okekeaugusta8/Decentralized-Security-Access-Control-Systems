;; Credential Verification Contract
;; Verifies access credentials and identity

(define-constant ERR_INVALID_CREDENTIAL (err u300))
(define-constant ERR_CREDENTIAL_EXPIRED (err u301))
(define-constant ERR_CREDENTIAL_REVOKED (err u302))
(define-constant ERR_UNAUTHORIZED (err u303))

(define-map credentials
  { credential-id: (buff 32) }
  {
    owner: principal,
    credential-type: uint,
    issued-at: uint,
    expires-at: uint,
    issuer: principal,
    revoked: bool,
    metadata: (string-ascii 500)
  }
)

(define-map authorized-issuers
  { issuer: principal }
  { authorized: bool }
)

(define-public (authorize-issuer (issuer principal))
  (begin
    (asserts! (is-eq tx-sender contract-caller) ERR_UNAUTHORIZED)
    (map-set authorized-issuers { issuer: issuer } { authorized: true })
    (ok true)
  )
)

(define-public (issue-credential
  (credential-id (buff 32))
  (owner principal)
  (credential-type uint)
  (duration uint)
  (metadata (string-ascii 500))
)
  (begin
    (asserts!
      (default-to false
        (get authorized (map-get? authorized-issuers { issuer: tx-sender }))
      )
      ERR_UNAUTHORIZED
    )
    (map-set credentials
      { credential-id: credential-id }
      {
        owner: owner,
        credential-type: credential-type,
        issued-at: block-height,
        expires-at: (+ block-height duration),
        issuer: tx-sender,
        revoked: false,
        metadata: metadata
      }
    )
    (ok true)
  )
)

(define-public (revoke-credential (credential-id (buff 32)))
  (let ((credential (unwrap! (map-get? credentials { credential-id: credential-id }) ERR_INVALID_CREDENTIAL)))
    (asserts! (is-eq tx-sender (get issuer credential)) ERR_UNAUTHORIZED)
    (map-set credentials
      { credential-id: credential-id }
      (merge credential { revoked: true })
    )
    (ok true)
  )
)

(define-read-only (verify-credential (credential-id (buff 32)))
  (match (map-get? credentials { credential-id: credential-id })
    credential
      (and
        (not (get revoked credential))
        (< block-height (get expires-at credential))
      )
    false
  )
)

(define-read-only (get-credential (credential-id (buff 32)))
  (map-get? credentials { credential-id: credential-id })
)

(define-read-only (get-credential-owner (credential-id (buff 32)))
  (match (map-get? credentials { credential-id: credential-id })
    credential (some (get owner credential))
    none
  )
)

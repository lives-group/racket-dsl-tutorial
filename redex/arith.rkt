#lang racket

(require redex/reduction-semantics)

;; syntax of our language

(define-language Arith
  (e ::= true
         false
         zero
         (succ e)
         (pred e)
         (is-zero? e)
         (ift e e e))
  (nv ::= zero
          (succ nv))
  (bv ::= true false)
  (v  ::= nv bv)
  (E ::= hole
         (succ E)
         (pred E)
         (is-zero? E)
         (ift E e e))
  (t ::= nat
         bool))

;; semantics

(define ->
  (reduction-relation
   Arith
   #:domain e
   (--> (pred zero) zero "pred-zero")
   (--> (pred (succ e)) e "pred-succ")
   (--> (is-zero? zero) true "iszero-zero")
   (--> (is-zero? (succ e) false) "iszero-succ")
   (--> (ift true e1 e2) e1 "if-true")
   (--> (ift false e1 e2) e2 "if-false")))

(define ->*
  (compatible-closure -> Arith e))

;; simple interpreter

(define-metafunction Arith
  eval : e -> v
  ((eval e)
   ,(car (apply-reduction-relation* ->* (term e)))))

;; typing rules

(define-judgment-form Arith
  #:contract (type-of e t)
  #:mode (type-of I I)

  (-------------------"zero"
   (type-of zero nat))

  ((type-of e1 nat)
   ----------------------- "succ"
   (type-of (succ e1) nat))

  ((type-of e1 nat)
   -----------------------"pred"
   (type-of (pred e1) nat))

  ((type-of e1 nat)
   -----------------------"is-zero"
   (type-of (is-zero e1) bool))

  ((type-of e1 bool)
   (type-of e2 T)
   (type-of e3 T)
   -----------------------"if"
   (type-of (ift e1 e2 e3) T)))


;; random testing: checking type soundness
;; all well typed programs evaluate to values

(redex-check
 Arith
 #:satisfying (type-of e t)
 (redex-match? Arith v (term (eval e)))
 #:attempts 1000)

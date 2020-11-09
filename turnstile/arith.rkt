#lang turnstile/quicklang

(provide int bool ->
         zero
         succ
         pred
         true
         false
         is-zero?
         (rename-out (typed-app #%app)
                     (typed-if if)))

;; definition of the basic types

(define-base-types int bool)

(define-type-constructor -> #:arity > 0)

;; definition of the constants

(define-primop succ : (-> int int))
(define-primop pred : (-> int int))
(define-primop zero : int)
(define-primop true : bool)
(define-primop false : bool)
(define-primop is-zero? : (-> int bool))

;; semantics of the constants

(define succ- add1)
(define pred- sub1)
(define zero- 0)
(define true- #t)
(define false- #f)
(define (is-zero?- n)
  (eq? n 0))

;; type rule of our language

(define-typerule (typed-app f e ...) ≫
  (⊢ f ≫ f- ⇒  (~-> tin ... tout))
  (⊢ e ≫ e- ⇐ tin) ...
  ----------------------------------
  (⊢ (#%plain-app f- e- ...) ⇒ tout))

(define-typerule (typed-if e1 e2 e3) ≫
  (⊢ e1 ≫ e1- ⇒ bool)
  (⊢ e2 ≫ e2- ⇒ t)
  (⊢ e3 ≫ e3- ⇐ t)
  ----------------------------------
  (⊢ (if e1- e2- e3-) ⇒ t))

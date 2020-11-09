#lang turnstile/quicklang

(provide int bool ->
         zero
         succ
         pred
         (rename-out (typed-app #%app)))

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

(define-typerule (typed-app f e ...) ≫
  (⊢ f ≫ f- ⇒  (~-> tin ... tout))
  (⊢ e ≫ e- ⇐ tin) ...
  ----------------------------------
  (⊢ (#%plain-app f- e- ...) ⇒ tout))


(define succ- add1)
(define pred- sub1)
(define zero- 0)

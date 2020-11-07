#lang racket

(require (for-syntax racket)
         br/macro)
  

(define-macro (arith-mb EXPR)
  #'(#%module-begin
     (to-nat 'EXPR)))

(define (to-nat e)
  (match e
    [(cons 'expr e1) (to-nat e1)]
    [(cons 'ZERO _)  0]
    [(cons 'SUCC e1) (add1 (to-nat e1))]
    [(cons 'PRED e1)
     (let ([r (to-nat e1)])
       (if (eq? r 0) 0 (sub1 r)))]
    [(cons 'ISZERO e1)
       (eq? (to-nat e1) 0)]))

(provide (rename-out [arith-mb #%module-begin])
         #%top-interaction
         #%top
         #%app
         #%datum)

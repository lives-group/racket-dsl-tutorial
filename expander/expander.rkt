#lang racket

(require (for-syntax racket)
         br/macro)
  

(define-macro (arith-mb EXPR)
  #'(#%module-begin
     'EXPR
     (eval 'EXPR)))

(define (eval e)
  (match e
    [(cons 'expr e1) (eval e1)]
    [(cons 'ZERO _)  0]
    [(cons 'SUCC e1) (add1 (eval e1))]
    [(cons 'PRED e1)
     (let ([r (eval e1)])
       (if (eq? r 0) 0 (sub1 r)))]
    [(cons 'ISZERO e1)
     (eq? (eval e1) 0)]
    [(cons 'IF (cons e1 (cons e2 e3)))
     (let ([x (eval e1)])
       (if x (eval e2) (eval e3)))]))

(provide (rename-out [arith-mb #%module-begin])
         #%top-interaction
         #%top
         #%app
         #%datum)

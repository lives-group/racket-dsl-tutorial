#lang racket

(require (for-syntax syntax/parse
                     racket)
         br/macro)
  

(define-macro (arith-mb EXPR)
  #'(#%module-begin
     (to-nat 'EXPR)))

(define (to-nat e)
  (define (peano n)
    (cond
      [(eq? 'expr (car n)) (peano (cdr n))]
      [(eq? 'ZERO (car n)) 0]      
      [(eq? 'SUCC (car n)) (add1 (peano (cdr n)))]))
  (peano e))
      

(provide (rename-out [arith-mb #%module-begin])
         #%top-interaction
         #%top
         #%app
         #%datum)

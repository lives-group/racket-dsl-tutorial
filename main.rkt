#lang racket

(require arith/parser/arith
         arith/parser/tokenizer
         syntax/strip-context)

(define (read-syntax path port)
  (define parse-tree
    (parse path
           (make-tokenizer port path)))
  (strip-context
   #`(module arith-mod arith/expander/expander
       #,parse-tree)))

(module+ reader
  (provide read-syntax))

#lang racket

(require arith/syntax
         arith/tokenizer
         syntax/strip-context)

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port path)))
  (strip-context
   #`(module arith-mod arith/expander
       #,parse-tree)))

(module+ reader
  (provide read-syntax))
#lang racket

(require brag/support
         arith/parser/lexer)

(define (make-tokenizer ip [path #f])
  (port-count-lines! ip)
  (lexer-file-path path)
  (define (next-token) (basic-lexer ip))
  next-token)

(provide make-tokenizer)

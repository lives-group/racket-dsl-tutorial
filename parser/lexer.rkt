#lang racket

(require brag/support)

(define basic-lexer
  (lexer-srcloc
   ["\n" (token lexeme #:skip? #t)]
   [whitespace (token lexeme #:skip? #t)]
   ["ZERO" (token lexeme 'ZERO)]
   ["SUCC" (token lexeme 'SUCC)]
   [(:or "(" ")") (token lexeme lexeme)]))

(provide basic-lexer)
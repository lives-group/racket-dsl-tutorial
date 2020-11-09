#lang s-exp "arith.rkt"

(if (is-zero? (pred (succ zero)))
    zero
    (succ zero))

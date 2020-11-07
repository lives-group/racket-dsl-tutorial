#lang brag

expr : ZERO
| SUCC @expr
| PRED @expr
| ISZERO @expr
| /"(" @expr /")"

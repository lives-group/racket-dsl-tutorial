#lang brag

expr : ZERO
| SUCC @expr
| PRED @expr
| ISZERO @expr
| IF expr /THEN expr /ELSE expr
| /"(" @expr /")"

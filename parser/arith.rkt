#lang brag

expr : ZERO
| SUCC @expr
| /"(" @expr /")"
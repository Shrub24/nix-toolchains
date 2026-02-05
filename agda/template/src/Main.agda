module Main where

open import Agda.Builtin.IO
open import Agda.Builtin.Unit
open import Agda.Builtin.String

main : IO ⊤
main = primPutStrLn "Hello, Agda!"

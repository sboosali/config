#!/usr/bin/env turtle
{-# OPTIONS_GHC -F -pgmF turtle -optF --extensions= -optF --imports= -optF --sandbox= #-}
{-# LANGUAGE LambdaCase #-}
import Control.Monoid

-- "top-level" statements
let filename = "hello-turtle.hs"
permissions <- chmod executable filename
print permissions

-- top-level declarations are not top-level: they are independent let-bindings in a monad. use case to define functions and where to define mutually recursive definitions. 
let even = \case
 0 -> True
 n -> not (odd (n-1))
 where
  odd n
   | n < 0  = False
   | n == 0 = False
   | n > 0  = not (even (n-1))

-- or, use indented let
let
 even = \case
  0 -> True
  n -> not (odd (n-1))
 odd n
  | n < 0  = False
  | n == 0 = False
  | n > 0  = not (even (n-1))



->


#!/usr/bin/env runhaskell
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
import Turtle
import Control.Monoid
main = do
 -- "top-level" statements
 let filename = "hello-turtle.hs"
 permissions <- chmod executable filename
 print permissions

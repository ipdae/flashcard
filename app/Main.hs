{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Monoid (mconcat)
import Control.Monad.IO.Class (liftIO)

import qualified Data.Text.Lazy.IO as TI
import Data.Text.Lazy (append)
import Web.Scotty


main :: IO ()
main = scotty 3000 $ do
  get "/favicon.ico" $ do
    html "blah"

  get "/:word" $ do
    word <- param "word"
    liftIO $ TI.appendFile "./flashcard.txt" (append word "\n") 
    redirect (append "http://endic.naver.com/search.nhn?sLn=kr&isOnlyViewEE=N&query=" word)

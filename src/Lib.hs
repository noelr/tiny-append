{-# LANGUAGE OverloadedStrings #-}

module Lib (go) where

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import System.FilePath ((</>))
import Prelude
import Control.Monad.IO.Class

db = "log" </> "log"

go :: IO ()
go = scotty 4002 $ do
  middleware logStdoutDev
  get "/" $ do
    setHeader "cache-control" "no-cache"
    file db
  post "/append" $ do
    l <- param "line"
    liftIO $ appendFile db (mconcat [l, "\n"])
    text "OK"

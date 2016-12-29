{-# LANGUAGE OverloadedStrings #-}

module Lib (go) where

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Cors
import System.FilePath ((</>))
import Prelude
import Control.Monad.IO.Class

db = "log" </> "log"

go :: IO ()
go = scotty 4002 $ do
  middleware simpleCors
  middleware logStdoutDev
  get "/" $ file db
  post "/append" $ do
    l <- param "line"
    liftIO $ appendFile db (mconcat [l, "\n"])
    text "OK"

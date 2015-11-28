{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( someFunc
    ) where

import GHCJS.Foreign ()
import GHCJS.Types
import GHCJS.DOM

import GHCJS.DOM.Document
import GHCJS.DOM.Node (appendChild)

foreign import javascript unsafe "window.alert($1)" js_alert :: JSString -> IO ()
foreign import javascript unsafe "document.getElementById($1).appendChild(document.createTextNode($2))" js_doc_append :: JSString -> JSString -> IO ()

someFunc :: IO ()
someFunc = do
    js_doc_append "dev" ": Hello from GHCJS FFI!"
    m_doc <- currentDocument
    case m_doc of
         Nothing -> return ()
         Just doc -> do
            m_devDiv <- getElementById doc ("dev" :: String)
            case m_devDiv of
                 Just devDiv -> do
                     t <- createTextNode doc ("Hello from GHCJS Dom!" :: String)
                     appendChild devDiv t
                     return ()
                 Nothing -> return ()

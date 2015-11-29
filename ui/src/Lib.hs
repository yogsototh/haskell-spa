{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( someFunc
    ) where

import GHCJS.Foreign ()
import GHCJS.Types
import GHCJS.DOM

import GHCJS.DOM.Document
import GHCJS.DOM.Node (appendChild)

-- foreign import javascript unsafe "window.alert($1)" js_alert :: JSString -> IO ()
foreign import javascript unsafe "document.body.appendChild(document.createElement(\"div\").appendChild(document.createTextNode($1)))" js_doc_append :: JSString -> IO ()

mbind :: IO (Maybe a) -> (a -> IO (Maybe b)) -> IO (Maybe b)
mbind v f = v >>= maybe (return Nothing) f

void :: IO a -> IO ()
void f = f >> return ()

someFunc :: IO ()
someFunc = do
    js_doc_append "Hello from GHCJS FFI! Live-reload 4"
    void $ currentDocument `mbind` (\ doc ->
            getBody doc `mbind` (\ body ->
              createElement doc (Just "div" :: Maybe String) `mbind` (\divElem -> do
                 t <- createTextNode doc ("Hello from GHCJS Dom!" :: String)
                 _ <- appendChild divElem t
                 _ <- appendChild body (Just divElem)
                 return Nothing)))
    void $ currentDocument `mbind` (\ doc ->
            getElementById doc ("main-title" :: String) `mbind` (\ title -> do
                 t <- createTextNode doc ("Hello from GHCJS Dom!" :: String)
                 _ <- appendChild title t
                 return Nothing))

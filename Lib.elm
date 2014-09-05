-- -*- coding: utf-8; -*-
module Lib where

import Char
import Text
import String

margin = 200
headerHeight = 70

pageTemplate : [Element] -> String -> String -> String -> Int -> Element
pageTemplate content leftHref upHref rightHref w =
  let line = collage w 5 [ filled black (rect (toFloat w) 1) ]
      linkArrow href code = if href == ""
                            then empty
                            else String.fromList [ Char.fromCode code ] |>
                                 toText |>
                                 Text.height 60 |>
                                 centered |>
                                 link (href ++ ".html")
      leftArrow = linkArrow leftHref 8678
      upArrow = linkArrow upHref 8679
      rightArrow = linkArrow rightHref 8680
      footerContent = [markdown|
<center>Elm by Example. Copyright © [Grzegorz Balcerek](http://www.grzegorzbalcerek.net) 2014.<br>
This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
</center>
|]
      footerContentSize = sizeOf footerContent
  in
  flow down [
    layers [container w headerHeight midLeft leftArrow
           ,container w headerHeight middle upArrow
           ,container w headerHeight midRight rightArrow]
    , line
    , width (w - 2*margin) <| flow down <| map (\c ->
      flow right [
        spacer margin 1,
        width (w - 2*margin) c]) content
    , line
    , container w (snd footerContentSize) middle footerContent ]

sigHorizontalLine w x y = outlined defaultLine <| polygon [(x-w/2,y),(x+w/2,y)]
sigVerticalLine h x y = outlined defaultLine <| polygon [(x,y-h/2),(x,y+h/2)]
sigDownwardArrow x y = ngon 3 10 |> filled black |> rotate (degrees 30) |> move (x,y)
signalFunctionBox f1 f2 h t1 t2 t3 w x y = group
  [ outlined defaultLine (rect w h) |> move (x,y)
  , toForm (toText t1 |> Text.height f1 |> centered) |> moveY (h/3) |> move (x,y)
  , toForm (toText t2 |> Text.height f2 |> bold |> centered)                |> move (x,y)
  , toForm (toText t3 |> Text.height f1 |> centered) |> moveY (-h/3) |> move (x,y)
  ]

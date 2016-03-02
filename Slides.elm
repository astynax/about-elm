module Slides where

import String

import Html exposing
  (Html, text, a, p, pre, code, div, span, img, br, ul, li, small)
import Html.Attributes exposing (class, href)

import SlideShow exposing (..)

main : Signal Html
main = start slides |> .html

slides : List Slide
slides =
  [ title <| slide ""
      [ text "Разработка", nl
      , text "интерактивных", nl
      , text "Web-приложений", nl
      , text "на языке Elm", nl, nl
      , img_ "static/elm.png", nl, nl
      , note [ text "Алексей Пирогов" ]
      ]

  , section "Введение" "что за Elm?"

  , slide "Elm?"
      [ text "Elm, это"
      , ul_
          [ text "Функциональный язык"
          , text "Сильная статическая типизация"
          , text "Алгебраические Типы Данных"
          , text "Компиляция в JavaScript"
          , text "Нацеленность на построение UI"
          , text "Контроль над side-эффектами"
          , text "FRP, Time-travel Debugging, ..."
          ]
      ]

  , section "С чего начать?" "готовим окружение"

  , slide "Установка"
      [ source
          "shell"
          "$ npm install -g elm"
      ]

  , slide "Компоненты"
      [ ul_ <| List.map
          code_
          [ "elm-make"
          , "elm-package"
          , "elm-reactor"
          , "elm-repl"
          ]
      ]

  , slide "Минимальный проект"
      [ source
          "shell"
          "$ tree
.
└── Main.elm

0 directories, 1 file

$ cat Main.elm
module Main where

import Graphics.Element exposing (show)

main = show \"Hello World!\""
      ]

  , slide "Минимальный проект (запуск)"
      [ source
          "shell"
          "$ elm-make Main.elm
Some new packages are needed.
Here is the upgrade plan.

  Install:
    elm-lang/core 3.0.0

Do you approve of this plan? (y/n) y
...
Successfully generated index.html"
      ]

  , section "Синтаксис" "кратенько"

  , slide "Синтаксис" <| snippet
      "Алгебраические Типы Данных:"
      "type Color = Red | Green | Blue

type Point = Point Int Int

type Shape
  = Circle   Point Int
  | Triangle Point Point Point
  | Rect     Point Point"

  , slide "Синтаксис" <| snippet
      "Записи (Records):"
      "type alias User =
  { name : String
  , age  : Int    }

user = { name = \"Moe\", age = 42 }

userAge = user.age

newUser = { user | age = user.age + 1 }"

  , slide "Синтаксис" <| snippet
      "Функции"
      "add : Int -> Int -> Int
add x y = x + y

add5 : Int -> Int
add5 = add 5"

  , section "It's alive!" "галопом по FRP"

  , slide "Базис"
      [ code_ "Signal", text " + ", code_ "Element", text " = основа всего!"
      , nl, nl
      , text "Самый главный тип в приложении:"
      , source
          "elm"
          "main : Signal Element
main = show \"Hello world!\""
      , nl
      , text "Другой пример:"
      , source
           "elm"
           "import Mouse

Mouse.x        : Signal Int
Mouse.position : Signal (Int, Int)
Mouse.isDown   : Signal Bool"
      ]

  , section "The End" "Вопросы?"
  ]


section : String -> String -> Slide
section t n =
  title <| slide "" [ text t, nl, note [ text n ] ]


note : List Html -> Html
note =
  span [ class "note" ]


snippet : String -> String -> List Html
snippet description content =
  [ text description
  , nl, nl
  , source "elm" content
  , nl
  , note [ a_ "http://elm-lang.org/try" "try it" ]
  ]

a_ : String -> String -> Html
a_ url txt =
  a [ href url ] [ text txt ]

share : String -> String -> Html
share id txt =
  a_ (String.append "http://www.share-elm.com/sprout/" id) txt

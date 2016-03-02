module Slides where

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

  , slide "Установка"
      [ source
          "shell"
          "$ npm install -g elm"
      , ul_ <| List.map
          code_
          [ "elm-make"
          , "elm-package"
          , "elm-reactor"
          , "elm-repl"
          ]
      ]

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
      "type User =
  User { name : String
       , age  : Int     }

user = User { name = \"Moe\", age = 42 }

userAge = user.age

newUser = { user | age = user.age + 1 }"

  , slide "Синтаксис" <| snippet
      "Функции"
      "add : Int -> Int -> Int
add x y = x + y

add : Int -> Int
add5 = add 5"

  , slide "Базис" []

  , slide "Model-View-Update" []

  , title <| slide "The End" [ text "Вопросы?" ]
  ]


note : List Html -> Html
note =
  span [ class "note" ]


snippet : String -> String -> List Html
snippet description content =
  [ text description
  , nl, nl
  , source "elm" content
  , nl
  , note [ a [ href "http://elm-lang.org/try" ] [ text "try it" ] ]
  ]

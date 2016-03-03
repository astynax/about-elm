module Slides where

import Maybe exposing (Maybe(..))
import String

import Html exposing
  (Html, text, a, p, pre, code, div, span, img, br, ul, li, small, textarea)
import Html.Attributes exposing (class, href, value, target)

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
      [ text "Алгебраические Типы Данных:" ]
      "type Color = Red | Green | Blue

type Point = Point Int Int

type Shape
  = Circle   Point Int
  | Triangle Point Point Point
  | Rect     Point Point"
      Nothing

  , slide "Синтаксис" <| snippet
      [ text "Записи (Records):" ]
      "type alias User =
  { name : String
  , age  : Int    }

user = { name = \"Moe\", age = 42 }

userAge = user.age

newUser = { user | age = user.age + 1 }"
      Nothing

  , slide "Синтаксис" <| snippet
      [ text "Функции" ]
      "add : Int -> Int -> Int
add x y = x + y

add5 : Int -> Int
add5 = add 5"
      Nothing

  , section "It's alive!" "Концепция, или галопом по FRP"

  , slide "Концепция"
      [ div [ class "center" ]
         [ text "\"Stream processing", nl
         , text "lets us model systems that have state", nl
         , text "without ever using", nl
         , text "assignment or mutable data.\"", nl
         , note [ text "SICP" ]
         ]
      ]

  , slide "Концепция"
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

   , slide "Концепция" <| snippet
      [ text "Работа с сигналами:" ]
      "clicks =
  Signal.foldp (+) 0
  <| Signal.map (always 1)
       Mouse.clicks

main =
  Signal.map show
  <| Signal.map2 (,) clicks Mouse.isDown"
      <| Just "import Graphics.Element exposing (centered)
import Text
import Signal
import Mouse

clicks =
  Signal.foldp (+) 0
  <| Signal.map (always 1)
       Mouse.clicks

main =
  Signal.map show
  <| Signal.map2 (,) clicks Mouse.isDown

show =
  centered << Text.height 40
  << Text.fromString << toString"

  , slide "Концепция"
      [ text "Ещё примеры:"
      , ul_ [ share "56d6dd25e4b070fd20daa274" "red circle"
            , share "56d7e93ce4b070fd20daa2e1" "blue circle" ]
      ]

  , section "Ближе к Web" "Дайте уже мне HTML и CSS!"

  , slide "Web" <| snippet
      [ text "(HTML + CSS) * Elm = "
      , package "evancz/elm-html/4.0.2" "elm-html"
      , text "("
      , a_ "https://mbylstra.github.io/html-to-elm/" "*"
      , text "):"
      ]
      "page =
  div [ class \"content\" ]
    [ h1 [ style [ (\"color\", \"red\") ] ]
         [ text \"Hello, World!\" ]
    , ul [ id \"items\" ]
         [ item \"apple\"
         , item \"orange\" ]]

item x = li [] [ text x ]"
     <| Just "import Html exposing (..)
import Html.Attributes exposing (..)
import Signal

main =
  Signal.constant page

page =
  div [ class \"content\" ]
    [ h1 [ style [ (\"color\", \"red\") ] ]
       [ text \"Hello, World!\" ]
    , ul [ id \"items\" ]
       [ item \"apple\"
       , item \"orange\" ]]

item x = li [] [ text x ]"

  , slide "Web" <| snippet
      [ text "Model-View-Action-Update ("
      , package "evancz/start-app/2.0.2" "start-app"
      , text "):"
      ]
      "model : Model

view : Model -> Html

update : Action -> Model -> Model"
      <| Just "import StartApp.Simple as StartApp
import Html exposing (..)
import Html.Events exposing (onClick)

type Action = Inc | Dec

main =
  StartApp.start
  { model = model
  , view = view
  , update = update
  }

model = 0

view address model =
  div []
    [ h1 [] [ text <| toString model ]
    , button [ onClick address Dec ] [ text \"-\" ]
    , button [ onClick address Inc ] [ text \"+\" ]
    ]

update action model =
  case action of
    Inc -> model + 1
    Dec -> model - 1"

  , section "Напоследок" "Да-да, уже почти конец!"

  , slide "Напоследок"
      [ text "Плюсы:"
      , ul_
         [ text "Отличный tooling!"
         , text "Null-safety"
         , text "Отсутствие исключений в runtime"
         , a_ "https://github.com/evancz/elm-architecture-tutorial/"
             "Elm architecture"
         , a_ "http://package.elm-lang.org/" "Elm Packages"
         ]
      ]

  , slide "Напоследок"
      [ text "Минусы:"
      , ul_
         [ text "Язык ещё молод и всё ещё меняется"
         , text "Elm - не General Purpose Language"
         , text "Сообщество elmer'ов не слишком велико"
         , text "Иногда приходится писать на JavaScript"
         , text "Elm сияет, когда \"стоит у руля\""
         ]
      ]

  , slide "Напоследок"
      [ text "Стоит упомянуть:"
      , ul_
          [ a_ "http://elm-lang.org/guide/interop#ports" "JavaScript interop"
          , a_ "https://evancz.github.io/todomvc-perf-comparison/" "Benchmarks!"
          , a_ "http://debug.elm-lang.org/" "Time Traveling Debugger"
          , a_ "http://builtwithelm.co/" "\"Built with Elm\""
          , a_ "http://www.elm-tutorial.org/" "Elm tutorial"
          ]
      ]

  , section "The End" "Вопросы?"
  ]

--------------------------------------------------------------------------------
--| Helpers

section : String -> String -> Slide
section t n =
  title <| slide "" [ text t, nl, note [ text n ] ]


note : List Html -> Html
note =
  span [ class "note" ]


snippet : List Html -> String -> Maybe String -> List Html
snippet description content paste =
  List.append
    description
  <| List.append
    [ nl, nl
    , source "elm" content
    ]
  <| Maybe.withDefault [] <| Maybe.map (\x ->
    [ nl
    , note
        [ text "Скопируйте это "
        , textarea [ value x ] []
        , text " и попробуйте "
        , a_ "http://elm-lang.org/try" "здесь"
        , text "."
        ]
    ]
    ) paste

a_ : String -> String -> Html
a_ url txt =
  a [ href url, target "blank" ] [ text txt ]

share : String -> String -> Html
share id =
  a_ (String.append "http://www.share-elm.com/sprout/" id)

package : String -> String -> Html
package path =
  a_ (String.append "http://package.elm-lang.org/packages/" path)

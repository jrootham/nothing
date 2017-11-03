module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Translations 

main =
  Html.beginnerProgram { model = model, view = view, update = update }

--  Types

type alias Model = 
    { language: Translations.Lang
    , text : String
    , visual : Bool
    , textCSS : String
    , themeCSS : String
    }

type Msg = Language Translations.Lang | Reset | Set 

-- MODEL

model = Model Translations.En "" True "normal" "light"

-- UPDATE

update : Msg -> Model -> Model
update msg model =
  case msg of
    Language which ->
        {model | language = which}

    Reset -> 
        {model | text = ""} 

    Set ->
        {model | text = Translations.nothing model.language}


-- VIEW

view : Model -> Html Msg
view model =
  page model

page: Model -> Html Msg
page model =
    div [class model.textCSS, class model.themeCSS] 
    [ div [] [h1 [] [text (Translations.title model.language)]]
    , div [] [pickLanguage model Translations.En "English", pickLanguage model Translations.Fr "Français"]
    , div [class "instructions"] [text (Translations.instructions model.language)]
    , div [] [text model.text]
    , div [] 
        [ button [onClick Set] [text (Translations.button model.language)]
        , button[onClick Reset] [text (Translations.clear model.language)]
        ]
    ]

pickLanguage : Model -> Translations.Lang -> String -> Html Msg
pickLanguage model thisOne labelText =
    label [class "group"]
        [ input
            [ type_ "radio"
            , name "change-language"
            , onClick (Language thisOne)
            , checked (thisOne == model.language)
            ]
            []
        , text labelText
        ]

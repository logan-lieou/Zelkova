module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

main =
    Browser.sandbox { init = init, view = view, update = update }

-- MODEL

type alias LoginModel =
    { name: String
    , password: String
    , passwordAgain: String
    }

init : LoginModel
init =
    LoginModel "" "" ""


-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordAgain String

update : Msg -> LoginModel -> LoginModel 
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

-- VIEW

view : LoginModel -> Html Msg
view model =
    div [ style "text-align" "center"
        , style "padding" "2cm"
        ]
        [ h1 [style "text-align" "center", style "font-family" "Arial"] [text "Login Page"]
        , viewInput "text" "Name" model.name Name , br [] []
        , viewInput "password" "Password" model.password Password, br [] []
        , viewInput "password" "Re-Enter Password" model.passwordAgain PasswordAgain, br [] []
        , viewValidation model
        ]

-- VIEW INPUT

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg, style "padding" "15px", style "margin-bottom" "15px"] []


-- VIEW VALIDATION

viewValidation : LoginModel -> Html msg
viewValidation model =
    if model.password /= "" && model.password == model.passwordAgain then
        button 
        [ style "background-color" "#555555"
        , style "text-decoration" "none"
        , style "font-family" "Arial"
        , style "border" "none"
        , style "padding" "5px"
        , style "text-align" "center"
        , style "color" "white"
        ] [text "Submit"]
    else if model.password == "" then
        div [] []
    else
        div [style "color" "red", style "font-family" "Arial"] [text "Passwords do not match!"]


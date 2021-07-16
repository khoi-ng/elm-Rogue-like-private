module Main exposing (..)

import Browser
import Html exposing (Attribute, Html, article, div, h1, p, progress, text)
import Html.Attributes exposing (class, style)
import Svg exposing (Svg, rect, svg)
import Svg.Attributes exposing (fill, height, origin, stroke, width, x, y)



{--
map_width : Int
map_width =
    80


map_height : Int
map_height =
    45


room_max_size : Int
room_max_size =
    10


room_min_size : Int
room_min_size =
    6


max_rooms : Int
max_rooms =
    30


roomGen : GameMap
roomGen =
    GameMap map_width map_height room_max_size room_min_size


type GameMap
    = GameMap Int Int Int Int
--}
---- MODEL ----


screenWidth : Int
screenWidth =
    1000


screenHeight : Int
screenHeight =
    800


type Point
    = Point Int Int


type Msg
    = Direction Direction
    | Move


type Direction
    = Left
    | Up
    | Right
    | Down


type alias Damage =
    Int


type Weapon
    = Fist
    | Bow
    | NormalSword
    | Excalibur


type alias Player =
    { life : Int
    , inventory : List Weapon
    , currentWeapon : Weapon
    , position : Point
    }


type alias Model =
    { player : Player
    }


weaponDamage : Weapon -> Damage
weaponDamage weapon =
    case weapon of
        Fist ->
            5

        Bow ->
            10

        NormalSword ->
            15

        Excalibur ->
            40


init : ( Model, Cmd Msg )
init =
    ( { player =
            { life = 100
            , inventory = []
            , currentWeapon = Fist
            , position = Point 300 300
            }
      }
    , Cmd.none
    )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


playerToSvg : Player -> Svg Msg
playerToSvg { position } =
    case position of
        Point xp yp ->
            rect
                [ x (String.fromInt xp)
                , y (String.fromInt yp)
                , width "20"
                , height "20"
                , fill "green"
                ]
                []


svgCanvasStyle : List (Attribute msg)
svgCanvasStyle =
    [ width (String.fromInt screenWidth)
    , height (String.fromInt screenHeight)
    , style "background-color" "gray"
    ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Elm Rougelike" ]
        , svg svgCanvasStyle
            [ playerToSvg model.player
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

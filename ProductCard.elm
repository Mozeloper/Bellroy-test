module ProductCard exposing (view, Msg, Model, init, update)

import Html exposing (Html, div, img, text, button)
import Html.Attributes exposing (class, src, alt)
import Html.Events exposing (onClick)
import Http

-- MODEL
type alias Model =
    { product : Maybe Product }

type alias Product =
    { name : String
    , imageUrl : String
    , price : String
    }

init : Model
init =
    { product = Nothing }

-- UPDATE
type Msg
    = FetchProduct
    | ProductFetched (Result Http.Error Product)

update : Msg -> Model -> Model
update msg model =
    case msg of
        FetchProduct ->
            model  -- Here, you'd trigger an HTTP request in a real-world case
        
        ProductFetched (Ok product) ->
            { model | product = Just product }

        ProductFetched (Err _) ->
            model

-- VIEW
view : Model -> Html Msg
view model =
    case model.product of
        Just product ->
            div [ class "p-4 shadow-lg rounded-lg" ]
                [ img [ src product.imageUrl, alt product.name, class "w-full h-48 object-cover rounded" ] []
                , div [ class "mt-2" ] [ text product.name ]
                , div [ class "text-gray-700" ] [ text product.price ]
                , button [ class "bg-black text-white px-4 py-2 rounded mt-2", onClick FetchProduct ] [ text "Add to Cart" ]
                ]
        Nothing ->
            div [ class "p-4 text-center" ] [ text "Loading product..." ]

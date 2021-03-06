module Main where
import Data.List
import Data.List.Split

type Point = (Int,Int)

-- Exapmle ["123", "987"] -> (123,987)
toTuple :: [String] -> Point
toTuple [x,y] = ((read x::Int),(read y::Int))

-- Example ["#7","@","49,222:","19x20"] -> (49,222)
parseStartIndex :: [String] -> Point
parseStartIndex (_:_:index:_) = toTuple $ splitOn "," $ index \\ ":"

-- Example ["#7","@","49,222:","19x20"] -> (19,20)
parseDimensions :: [String] -> Point
parseDimensions (_:_:_:dimensions:_) = toTuple $ splitOn "x" dimensions

-- Example ["#7","@","49,222:","19x20"] -> [(49,222), (19,20)]
parseClaim :: [String] -> [Point]
parseClaim claim = [parseStartIndex claim, parseDimensions claim]

-- Example: [(2, 5), (2,3)] -> [(3,6), (4,6), (3,7), (4,7), (3,8), (4,8)]
expandClaim :: [Point] -> [Point]
expandClaim [] = []
expandClaim [(xStart,yStart),(xOffset,yOffset)] = [(x,y) | x <- xs, y <- ys]
    where
    xs = map (+xStart) [1..xOffset]
    ys = map (+yStart) [1..yOffset]

main :: IO ()
main = do
    input <- (readFile "../input")
    let claims = concatMap (expandClaim . parseClaim . words) $ lines input
    let overLappingSquares = filter ((>1) . length) $ (group . sort) claims
    print $ length overLappingSquares

module Main where
import Data.Char

reactsWith :: Char -> Char -> Bool
reactsWith x y = (toUpper x == toUpper y) && x /= y

fullyReact :: String -> String
fullyReact = foldr react []
    where react x [] = [x]
          react x (y:ys)
            | x `reactsWith` y = ys
            | otherwise = (x:y:ys)

main :: IO ()
main = do
    polymer <- (readFile "../input")
    print $ length $ fullyReact polymer
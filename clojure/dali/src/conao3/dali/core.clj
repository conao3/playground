(ns conao3.dali.core
  (:require [dali.io :as io])
  (:gen-class))

(def document
 [:dali/page
  [:circle
   {:stroke :indigo :stroke-width 4 :fill :darkorange}
   [30 30] 20]])

(defn render-png []
  (io/render-png document "/tmp/hello.png"))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

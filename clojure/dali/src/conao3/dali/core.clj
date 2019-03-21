(ns conao3.dali.core
  (:require [dali.io :as io]
            [ring.adapter.jetty :as server])
  (:gen-class))

(defonce server (atom nil))

(def document
 [:dali/page
  [:circle
   {:stroke :indigo :stroke-width 4 :fill :darkorange}
   [30 30] 20]])

(defn render-png []
  (io/render-png document "/tmp/hello.png"))

(defn handler [req]
  {:status 200
   :headers {"Content-Type" "text/plain"}
   :body "Hello, world"})

(defn start-server []
  (when-not @server
    (reset! server (server/run-jetty #'handler {:port 3000 :join? false}))))

(defn stop-server []
  (when @server
    (.stop @server)
    (reset! server nil)))

(defn restart-server []
  (stop-server)
  (start-server))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

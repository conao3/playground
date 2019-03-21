(ns conao3.dali.core
  (:require [compojure.core :refer [defroutes context GET]]
            [compojure.route :as route]
            [ring.adapter.jetty :as server]
            [ring.util.response :as res]
            [dali.io :as io])
  (:gen-class))

(defonce server (atom nil))

(def document
  [:dali/page
   [:circle
    {:stroke :indigo :stroke-width 4 :fill :darkorange}
    [30 30] 20]])

(defn render-png [path]
  (io/render-png document path))

(defn html [res]
  (res/content-type res "text/html; charset=utf-8"))

(defn png [req]
  (render-png "/tmp/hello.png")
  (-> (slurp "/tmp/hello.png")
      res/response
      (res/content-type "image/png")))

(defroutes handler
  (GET "/png" req png)
  (route/not-found "<h1>404 page not found</h1>"))

(defn start-server []
  (when-not @server
    (reset! server (server/run-jetty #'handler {:port 3000 :join? false}))))

(defn stop-server []
  (when @server
    (.stop @server)
    (reset! server nil)))

(defn restart-server []
  (when @server
    (stop-server)
    (start-server)))

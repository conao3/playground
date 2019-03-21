(defproject conao3/dali "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.9.0"]
                 [ring "1.7.1"]
                 [dali "0.7.4"]]
  :main ^:skip-aot conao3.dali.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})

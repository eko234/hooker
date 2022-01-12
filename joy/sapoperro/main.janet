(use joy)

# Layout
(defn app-layout [{:body body :request request}]
  (application/json
    body))


(defn getls
  "gets ls from bin dir" [{:where where :what what :with with}]
  (try
   (do
     (check where is dir)
     (check what is a script)
     (if with use it as ainput)
     (def proc 
       (os/spawn 
        ["/usr/bin/bash" 
         "-c" 
         (string/format "cd %s && %s" 
                        where
                        what)] :p {:in :pipe :out :pipe :err :pipe}))
     (def result 
       # [(:read (proc :out) :all)
       #  (:read (proc :err) :all)]
       (:read (proc :out) :all))
     (:wait proc)
     result)
  ([err] "err")))

# Routes
(route :get "/" :home)
(route :post "/" :home)

(defn home [request]
  (application/json
   {:hello :world
    :result (getls)}))

# [:div {:class "tc"}
#    [:h1 "You found joy!"]
#    [:p {:class "code"}
#     [:b "Joy Version:"]
#     [:span (string " " version)]]
#    [:p {:class "code"}
#     [:b "Gonorrea"]
#     [:span (string " " (getls))]]
#    [:p {:class "code"}
#     [:b "Janet Version:"]
#     [:span janet/version]]]

# Middleware
(def app (-> (handler)
             (layout app-layout)
             # (with-csrf-token)
             (with-session)
             (extra-methods)
             (query-string)
             (body-parser)
             (json-body-parser)
             (server-error)
             (x-headers)
             (static-files)
             (not-found)
             (logger)))


# Server
(defn main [& args]
  (let [port (get args 1 (os/getenv "PORT" "9001"))
        host (get args 2 "localhost")]
    (server app port host)))

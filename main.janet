(import circlet :as ci)

(defn getls
  "gets ls from bin dir" []
  (try
   (do
     (def proc (os/spawn ["ls"] :p {:in :pipe :out :pipe :err :pipe}))
     (def result 
       [(:read (proc :out) :all)
        (:read (proc :err) :all)])
     (:wait proc)
     result)
  ([err] [err])))

(defn getlsnr
  "gets ls from bin dir" []
  (try
   (do
     (def proc (os/spawn ["ls"] :p {:in :pipe :out :pipe :err :pipe}))
     (def result 
       [(proc :out)
        (proc :err)])
     (:wait proc)
     result)
  ([err] [err])))

(defn app
  [req]
  (try
   (do
     (pp :REQ_START)
     (def channel (ev/thread-chan 1))
     (ev/spawn-thread (ev/give channel (getls)))
     # (ev/do-thread (ev/give channel (getls)))
     (def result (ev/take channel))

     (pp :REQ_RETURNING)
     {:status 200
      :headers {"Content-Type" "application/json"}
      :body result})
   ([err] 
    {:status 500
      :headers {"Content-Type" "application/json"}
      :body [:OOPS err]})))

(defn app2 [req]
  (try 
   (do
     (def res
       (try 
         (do
           (print :GONORREA)
           (pp (getlsnr))
           (print :IJUEPUTA))
         ([err] (pp err))))
     {:status 200
      :body "hi"})
   ([err] (pp err) {:status 500})))

(defn main "entry point" [& args]
  (ci/server app2 8087))

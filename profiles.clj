{:user
 {:injections [(load-file (.getAbsolutePath (clojure.java.io/file (System/getenv "HOME") ".lein/inject.clj")))]
  :dependencies [[commons-io/commons-io "2.4"]
                 [spyscope "0.1.4"]
                 [org.clojure/tools.namespace "0.2.4"]
                 [io.aviso/pretty "0.1.10"]
                 [im.chit/vinyasa "0.1.8"]
                 [leiningen "2.3.4"]
                 [slamhound "1.5.4"]]
  :aliases {"slamhound" ["run" "-m" "slam.hound"]}
  :plugins
  [[lein-ancient "0.5.5"]
   [lein-bikeshed "0.1.6"]
   [lein-ring "0.8.10"]
   [lein-catnip "0.5.1"]
   [lein-exec "0.3.2"]]}}

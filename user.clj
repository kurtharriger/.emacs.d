(ns user)
(require '[clojure.java.io :as io])
(require 'spyscope.core)
(require 'vinyasa.inject)


(vinyasa.inject/inject 'clojure.core '>
                       '[[cemerick.pomegranate add-classpath get-classpath resources]
                         [clojure.tools.namespace.repl refresh]
                         [clojure.repl apropos dir doc find-doc source pst
                          [root-cause >cause]]
                         [clojure.pprint pprint]
                         [clojure.java.shell sh]])

(defmacro prepns []
  (vinyasa.inject/inject *ns*
                         '[[vinyasa.inject inject]
                           [vinyasa.pull pull]
                           [vinyasa.lein lein]
                           [vinyasa.reimport reimport]]))

(prepns)

;; (require 'io.aviso.repl
;;          'clojure.repl
;;          'clojure.main)
;; (alter-var-root #'clojure.main/repl-caught
;;                 (constantly @#'io.aviso.repl/pretty-pst))
;; (alter-var-root #'clojure.repl/pst;
                                        ;                (constantly @#'io.aviso.repl/pretty-pst))

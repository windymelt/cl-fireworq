(in-package #:cl-fireworq)

;;; Queue management

(def-cmd queues () () :get "/queues"
         "Returns defined queues.")

(def-cmd queues-stats () () :get "/queues/stats"
         "Returns stats of queues.")

(def-cmd queue (queue-name) () :get "/queue/~A"
         "Returns the definition of a queue.")

(def-cmd put-queue (queue-name) (polling_interval max_workers) :put "/queue/~A"
         "Creates a new queue or override the definition of an existing queue.")

(def-cmd delete-queue (queue-name) () :delete "/queue/~A"
         "Deletes a queue.")

(def-cmd queue-nodes (queue-name) () :get "/queue/~A/node"
         "Returns information of a node which is active on a queue.")

(def-cmd queue-stats (queue-name) () :get "/queue/~A/stats"
         "Returns stats of a queue.")

;;; Routing management

(def-cmd routings () () :get "/routings"
         "Returns defined routings.")

(def-cmd routing (job-category) () :get "/routing/~A"
         "Returns the definition of a routing.")

(def-cmd put-routing (job-category) (queue_name) :put "/routing/~A"
         "Creates a new routing or override the definition of an existing routing.")

(def-cmd delete-routing (job-category) () :delete "/routing/~A"
         "Deletes the routing of a job category.")

;;; Job management

(def-cmd queue-grabbed (queue-name) (limit cursor) :get "/queue/~A/grabbed"
         "Returns a list of grabbed jobs in a queue. Grabbed jobs are running or be prepared to run.")

(def-cmd queue-waiting (queue-name) (limit cursor) :get "/queue/~A/waiting"
         "Returns a list of waiting jobs in a queue. Waiting jobs are queued but not grabbed yet just because there is not enough space or time to grab them.")

(def-cmd queue-deferred (queue-name) (limit cursor) :get "/queue/~A/deferred"
         "Returns a list of deferred jobs in a queue. Deferred jobs are not going to run for now because of specified delays.")

(def-cmd queue-job (queue-name job-id) () :get "/queue/~A/job/~A"
         "Returns a job in a queue.")

(def-cmd delete-queue-job (queue-name job-id) () :delete "/queue/~A/job/~A"
         "Deletes a job in a queue.")

(def-cmd queue-failed-jobs (queue-name) (order limit cursor) :get "/queue/~A/failed"
         "Returns a list of failed jobs in a queue.")

(def-cmd failed-job (queue-name job-id) () :get "/queue/~A/failed/~A"
         "Returns a job in a failure log.")

(def-cmd delete-failed-job (queue-name job-id) () :delete "/queue/~A/failed/~A"
         "Deletes a job in a failure log.")

;; TODO: check behaviour
(def-cmd push-new-job (job-category) (url payload run_after max_retries retry_delay timeout) :post "/job/~A"
         "Pushes a new job.")

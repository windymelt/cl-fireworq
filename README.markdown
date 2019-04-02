# Cl-Fireworq

Common Lisp client for [Fireworq](https://github.com/fireworq/fireworq)

## Usage

```lisp
;; load system
(asdf:load-system :cl-fireworq)

(cl-fireworq:with-connection (:host "redis-host.test" :port 8080)
  (fwq:queue-stats "default")
  ...)
```

Check [commands.lisp](https://github.com/windymelt/cl-fireworq/blob/master/src/commands.lisp) to see supported commands.

## Installation

Will be available on quicklisp

## Author

* Windymelt

## Copyright

Copyright (c) 2019 Windymelt

## License

Licensed under the Apache License 2 License.

This software is inspired from [cl-redis](https://github.com/vseloved/cl-redis).

;;; tdd-status-mode-line-tests.el --- TDD status on the mode-line, tests

;; Copyright (C) 2013 Gergely Nagy <algernon@madhouse-project.org>

;; Author: Gergely Nagy <algernon@madhouse-project.org>
;; URL: https://github.com/algernon/tdd-status-mode-line

;;; License:
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;

;;; Code:

(require 'tdd-status-mode-line)
(require 'ert)

;; Tests

(ert-deftest test-tdd-status/advance ()
  "Tests that tdd-status/advance functions correctly."

  ;; Start with a clean slate
  (setq tdd-status/current-status-index -1)

  (should (= (tdd-status/advance) 0))
  (should (= (tdd-status/advance) 1))
  (should (= (tdd-status/advance) 2))
  (should (= (tdd-status/advance) 0)))

(ert-deftest test-tdd-status/back ()
  "Tests that tdd-status/back functions correctly."

  ;; Start with a clean slate
  (setq tdd-status/current-status-index -1)
  (should (= (tdd-status/back) 2))
  (should (= (tdd-status/back) 1))
  (should (= (tdd-status/back) 0))
  (should (= (tdd-status/back) 2)))

(ert-deftest test-tdd-status/clear ()
  "Tests that tdd-status/clear functions properly."

  ;; Start with an unclean state
  (setq tdd-status/current-status-index 1)
  (should (= (tdd-status/clear) -1)))

;;; tdd-status-mode-line-tests.el ends here

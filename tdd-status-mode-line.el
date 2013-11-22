;;; tdd-status-mode-line.el --- TDD status on the mode-line

;; Copyright (C) 2013 Gergely Nagy <algernon@madhouse-project.org>

;; Author: Gergely Nagy <algernon@madhouse-project.org>
;; URL: https://github.com/algernon/tdd-status-mode-line
;; Version: 0.1.1
;; Keywords: faces tdd
;; Prefix: tdd-status
;; Separator: /

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

(require 'custom)
(require 'cus-face)
(require 'cl-lib)
(require 'ert)

;; Customisation groups

(defgroup tdd-status-mode-line '()
  "Customisation group for the `tdd-status-mode-line.el' package."

  :group 'convenience
  :prefix 'tdd-status/)

(defgroup tdd-status-mode-line-faces '()
  "Font (face) colors for the `tdd-status-mode-line.el' package."

  :prefix 'tdd-status/
  :group 'tdd-status-mode-line
  :group 'faces)

;; Face defintions

(defface tdd-status/fail '((t :foreground "Red"
                              :weight bold))
  "Face of the `FAIL' TDD state."
  :group 'tdd-status-mode-line-faces)

(defface tdd-status/pass '((t :foreground "Green"
                              :weight bold))
  "Face of the `PASS' TDD state."
  :group 'tdd-status-mode-line-faces)

(defface tdd-status/refactor '((t :foreground "Cyan"
                                  :weight bold))
  "Face of the `REFACTOR' TDD state."
  :group 'tdd-status-mode-line-faces)

;; States

(defcustom tdd-status/states '(("FAIL" 'tdd-status/fail)
                               ("PASS" 'tdd-status/pass)
                               ("REFACTOR" 'tdd-status/refactor))
  "A list of state-face pairs used by tdd-status-mode-line.")

;; Implementation

(defvar tdd-status/current-status-index -1
  "Index of the current TDD status state.")

(defun tdd-status/info-update ()
  "Update the TDD status info, based on the current index and
available states."

  (when (and (>= tdd-status/current-status-index 0)
             (car (nth tdd-status/current-status-index
                       tdd-status/states)))
    (propertize (concat " [" (car (nth tdd-status/current-status-index tdd-status/states)) "] ")
                'face (cadr (nth tdd-status/current-status-index
                                 tdd-status/states)))))

(defun tdd-status/advance ()
  "Advance the TDD status further."
  (interactive)

  (if (>= tdd-status/current-status-index (1- (length tdd-status/states)))
      (setq tdd-status/current-status-index 0)
    (cl-incf tdd-status/current-status-index))
  (force-mode-line-update)
  tdd-status/current-status-index)

(defun tdd-status/back ()
  "Step back in the TDD status."
  (interactive)

  (if (<= tdd-status/current-status-index 0)
      (setq tdd-status/current-status-index (1- (length tdd-status/states)))
    (cl-decf tdd-status/current-status-index))
  (force-mode-line-update)
  tdd-status/current-status-index)

(defun tdd-status/clear ()
  "Clear the TDD status."
  (interactive)

  (setq tdd-status/current-status-index -1)
  (force-mode-line-update)
  tdd-status/current-status-index)

;; Key bindings

(defvar tdd-status-map nil
  "Keybindings for the `tdd-status-mode-line.el' package.")

(unless tdd-status-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "n") 'tdd-status/advance)
    (define-key map (kbd "p") 'tdd-status/back)
    (define-key map (kbd "c") 'tdd-status/clear)
    (setq tdd-status-map map)))

(define-key global-map (kbd "C-x t") tdd-status-map)

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

;; Setup code

(add-to-list 'mode-line-misc-info '(:eval (tdd-status/info-update)))

(provide 'tdd-status-mode-line)

;;; tdd-status-mode-line.el ends here

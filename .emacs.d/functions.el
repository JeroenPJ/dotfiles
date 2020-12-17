(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background
                                       (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(dolist (hook emacs-lisp-mode-hook)
  (add-hook hook 'hexcolour-add-to-font-lock))

(defun regexp-orrify (&rest disjuncts)
  "Return the regexp disjunction of the given regexps"
  (cond ((null disjuncts) "")
        ((null (cdr disjuncts)) (car disjuncts))
        (t (concat (car disjuncts)
                   "\\|"
                   (apply #'regexp-orrify (cdr disjuncts))))))

(defun angle-bracketify (s)
  "Enclose a string in angle brackets. From \"abc\" to \"<abc>\""
  (concat "<" s ">"))

;;   Don't have access to this and emacs hangs at contacting melpa:443 so commenting this
;; (defun edit-imap ()
;;   (interactive)
;;   (tramp-cleanup-all-connections)
;;   (find-file "/ssh:rekenwolk.nl:code/python/imap_transfer.py"))

(defun make-this-file-executable ()
  "If the file the current buffer is visiting is not executable, make it so."
  (let ((my-shebang-patterns (list "^#! ?/bin/sh"
                                   "^#! ?/bin/bash"
                                   "^#! ?/usr/bin/sh"
                                   "^#! ?/usr/bin/bash"
                                   "^#! ?/bin/env racket"
                                   "^#! ?/bin/env python")))
    (unless (zerop (shell-command (concat "test -x " (buffer-file-name))))
      (save-excursion
        (goto-char (point-min))
        (catch 'done
          (dolist (my-shebang-pat my-shebang-patterns)
            (when (looking-at my-shebang-pat)
              (shell-command (concat "chmod u+x " (buffer-file-name)))
              (throw 'done nil))))))))

;; (defun make-this-file-executable ()
;;   (let ((bfn (shell-quote-argument buffer-file-name)))
;;     (and (save-excursion
;;            (save-restriction
;;              (widen)
;;              (goto-char (point-min))
;;              (save-match-data
;;                (looking-at "^#!"))))
;;          (not (file-executable-p bfn))
;;          (shell-command (concat "chmod u+x " bfn))
;;          (message (concat "Made executable: " bfn)))))

(defun toggle-text-modes ()
  "Toggle auto-fill and visual-line modes."
  (interactive)
  (auto-fill-mode)
  (visual-line-mode))

(defun sq-to-parens ()
  "Replace all square brackets by parens"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "[" nil t)
    (replace-match "("))

  (goto-char (point-min))
  (while (search-forward "]" nil t)
    (replace-match ")")))
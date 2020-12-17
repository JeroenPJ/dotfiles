;; (require 'auctex)
(require 'mode-local)
  (use-package auctex
    :defer t
    :ensure t
    :hook (LaTeX-mode-hook .
    electric-quote-local-mode)
    :config
    ;; Some LaTeX packages need to run a shell command, e.g. minted needs
    ;; pygmentize
    (push '("LaTeX-shell"
            "%`%l -shell-escape %(mode)%' %t"
            TeX-run-TeX
            nil
            (latex-mode doctex-mode)
            :help "Run LaTeX allowing shell escape")
          TeX-command-list)
    (setq font-latex-fontify-script nil)
    (setq-mode-local latex-mode region-extract-function latex--region-extract-function)
    )


  ;; configs below need to be outside the use-package since org-mode may need
  ;; them directly.

  (setq TeX-view-program-list
        '(("mupdf" "/bin/mupdf %s.pdf"))
        TeX-view-program-selection
        '((output-pdf "PDF Tools")
          ;; (output-pdf "mupdf")
          ((output-dvi style-pstricks) "dvips and gv")
          (output-dvi "xdvi")
          (output-html "xdg-open"))
        TeX-source-correlate-start-server t
        LaTeX-electric-left-right-brace t)

  (setq bibtex-completion-bibliography
        (mapcar (lambda (f)
                  (concat
                   "/path/to/media/data/tie/path/to/media/writing/bib/"
                   f
                   ".bib"))
                '("bon" "counting" "dsls" "etc")))

  ;; Update PDF buffers after successful LaTeX runs
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)

(defun has-face-at (pos face-in-question &optional object)
  (let ((face-result-at-pos (get-text-property pos 'face object)))
    (if (eq (type-of face-result-at-pos) 'cons)
        (seq-contains face-result-at-pos face-in-question)
      (eq face-result-at-pos face-in-question))
    ))
;; (face-at-post ))


(defun latex--add-math-delimiters (substr)
  "add $ if necessary"
  (if (<= (length substr) 1)
      substr
    ;; (message (format "%s" (has-face-at  0 'font-latex-math-face substr)))
    (let*
        (;; (face-result-at-start (get-text-property 0 'face substr))
         ;; (face-at-start (if (eq (type-of face-result-at-start) 'cons) (first face-result-at-start) face-result-at-start))
         (substr-prefixed (if (and (not (string-prefix-p "$" substr))
                                   (has-face-at  0 'font-latex-math-face substr)
                                   )
                              (concat "$" substr)
                            substr))
         (substr-suffixed
          (if (and (not (string-suffix-p "$" substr-prefixed))
                   ;; (has-face-at  (- (length substr-prefixed) 1) 'font-latex-math-face substr-prefixed)
                   (has-face-at (- (length substr-prefixed) 1)
                   ;; (has-face-at (length substr-prefixed)
                                'font-latex-math-face substr-prefixed)
                   )
              (concat  substr-prefixed "$")
            substr-prefixed))
         )
      substr-suffixed

      )

    )
  )


;; (defun latex--add-math-delimiters (str)
;;   (let ((max-pos (length str)))
;;     (message "AAA")
;;     str
;; ))

(defvar latex--region-extract-function
  (lambda (method)
    (when (region-beginning)
      (cond
       ((eq method 'bounds)
        (list (cons (region-beginning) (region-end))))
       ((eq method 'delete-only)
        (delete-region (region-beginning) (region-end)))
       (t
        (latex--add-math-delimiters (filter-buffer-substring (region-beginning) (region-end) method))
        ;; (message out)
        ;; (message (latex--add-math-delimiters out))
        ))))
  "Function to get the region's content.
Called with one argument METHOD which can be:
- nil: return the content as a string (list of strings for
  non-contiguous regions).
- `delete-only': delete the region; the return value is undefined.
- `bounds': return the boundaries of the region as a list of one
  or more cons cells of the form (START . END).
- anything else: delete the region and return its content
  as a string (or list of strings for non-contiguous regions),
  after filtering it with `filter-buffer-substring', which
c  is called, for each contiguous sub-region, with METHOD as its
  3rd argument.")
(setq-mode-local latex-mode region-extract-function latex--region-extract-function)

(defun has-face (face-in-question face-seq)
  )

(defun latex--possibly-remove-math-delimiters (face start end)
  ;; (message (format "%s" (seq-contains face 'font-latex-math-face)))
  ;; (message (format "%s" (get-text-property (+ start 1) :foreground)))
  (let* ((substr (buffer-substring start end))
         ;; (face-after (get-text-property (+ end 1) 'face ))
         ;; (face-before (get-text-property (- start 1) 'face ))
         (has-face-after (has-face-at (+ end 1) 'font-latex-math-face);; (get-text-property (+ end 1) 'face )
                         )
         (has-face-before (has-face-at (- start 1) 'font-latex-math-face);; (get-text-property (+ end 1) 'face )
                          )
         ;; (face-before (get-text-property (- start 1) 'face ))
         )
    (if (and (string-equal "$" substr)
             has-face-after has-face-before)
        (delete-region start end))))


    ;; (progn (message (format "%s"  substr ))
    ;;        (message (format "%s"  (get-text-property start 'face )))
    ;;        (message (format "face after %s"  (get-text-property (+ end 1) 'face )))
    ;;        (message (format "face before %s"  ))
    ;;        ;; (message (format "%s"  (null face)))
    ;;        (message (format "%s" face))
    ;; ;; (message (format "%s" (call-interactively 'delete-char)))
    ;; (if (and
    ;;      (eq substr "$")
    ;;      (null (get-text-property start 'face ))
    ;;      (not (null face)))
    ;;     (call-interactively delete-char)))
;; ))
;; (message "CALLED")
;;   (message (format "%s" face))
;;   (message (format "%s" start))
;;   (message (format "%s" end))
;;   (message (buffer-substring start end))
;; ;; (message (format "%s" (get-text-property start 'face )))
;;   ;; (message (format "%s" (get-text-property (+ 1 start) :face )))
;;   ;; (message (format "%s" (get-text-property (+ 1 start) 'face )))
;;   (message (format "%s" (get-text-property start 'face )))
;;   (cond ((and (seq-contains face 'font-latex-math-face)
;;              (not (seq-contains  (get-text-property (+ 1 start) 'face ) 'font-latex-math-face)))
;;          (message "HERE")
;;         (message (format "%s" face)))
;;         )
;; (cond ((
;;   (progn (message (format "%s" face))
;;   (message (format "%s" start))
;;   (message (format "%s" end)))
;; )))
;; )



(defvar-mode-local latex-mode yank-handled-properties
  '((font-lock-face . yank-handle-font-lock-face-property)
    (face . latex--possibly-remove-math-delimiters)
    ;; ('foreground . latex--possibly-add-math-delimiters)
    (category . yank-handle-category-property)))

;; (modify-syntax-entry ?^ " " tex-mode-syntax-table)
;; (modify-syntax-entry ?^ "" )
;; (modify-syntax-entry ?^ " " LaTeX-mode-syntax-table)

;; (defun latex--filter-buffer-substring (beg end &optional delete)
;;   "Return the buffer substring between BEG and END, after filtering.
;; If DELETE is non-nil, delete the text between BEG and END from the buffer.

;; This calls the function that `filter-buffer-substring-function' specifies
;; \(passing the same three arguments that it received) to do the work,
;; and returns whatever it does.  The default function does no filtering,
;; unless a hook has been set.

;; Use `filter-buffer-substring' instead of `buffer-substring',
;; `buffer-substring-no-properties', or `delete-and-extract-region' when
;; you want to allow filtering to take place.  For example, major or minor
;; modes can use `filter-buffer-substring-function' to exclude text properties
;; that are special to a buffer, and should not be copied into other buffers."
;;   (let* ((substr (funcall filter-buffer-substring-function beg end delete)))
;;     (if (<= (length substr) 1)
;;         substr
;;       (let*
;;           ((substr-prefixed (if (and (not (string-prefix-p "$" substr))
;;                                      (eq (get-text-property 0 'face substr) 'font-latex-math-face)
;;                                      )
;;                                 (concat "$" substr)
;;                               substr))
;;            (substr-suffixed (if (and (not (string-suffix-p "$" substr-prefixed))
;;                                      (eq (get-text-property (length substr-prefixed)
;;                                                             'face substr-prefixed) 'font-latex-math-face)
;;                                      )
;;                                 (concat  substr-prefixed "$")
;;                               substr-prefixed))))
;;       )
;;     )
;;   )




;; (defvar latex--region-extract-function
;;   (lambda (method)
;;     (when (region-beginning)
;;       (cond
;;        ((eq method 'bounds)
;;         (list (cons (region-beginning) (region-end))))
;;        ((eq method 'delete-only)
;;         (delete-region (region-beginning) (region-end)))
;;        (t
;;         (latex--filter-buffer-substring (region-beginning) (region-end) method)))))
;;   "Function to get the region's content.
;; Called with one argument METHOD which can be:
;; - nil: return the content as a string (list of strings for
;;   non-contiguous regions).
;; - `delete-only': delete the region; the return value is undefined.
;; - `bounds': return the boundaries of the region as a list of one
;;   or more cons cells of the form (START . END).
;; - anything else: delete the region and return its content
;;   as a string (or list of strings for non-contiguous regions),
;;   after filtering it with `filter-buffer-substring', which
;;   is called, for each contiguous sub-region, with METHOD as its
;;   3rd argument.")
;; (require 'mode-local)
;; (setq-mode-local latex-mode region-extract-function latex--region-extract-function)
;; (add-hook 'latex-mode-hook
;;           (lambda ()
;;             (setq-mode-local latex-mode region-extract-function latex--region-extract-function)))

(defun ans-copy ()
  (interactive)
  (let ((tmp-file (make-temp-file "ans_" nil nil
                                  (substring-no-properties
                                   (buffer-string) (region-beginning) (region-end)))))
    (kill-new (shell-command-to-string
                  (format "~/.virtualenvs/py3.8/bin/python ~/src/latex2ans.py %s" tmp-file))
                 nil)
))


  ;; (while (< current end)
  ;;   (cond ((and (has-face-at current font-latex-math-face)
  ;;               (string-equal (substring-no-properties current (+ current 1) "$")))
  ;;          (
  ;;          )

;; (defcustom prettify-symbols-unprettify-at-point nil
;;   "If non-nil, show the non-prettified version of a symbol when point is on it.
;; If set to the symbol `right-edge', also unprettify if point
;; is immediately after the symbol.  The prettification will be
;; reapplied as soon as point moves away from the symbol.  If
;; set to nil, the prettification persists even when point is
;; on the symbol."
;;   :version "25.1"
;;   :type '(choice (const :tag "Never unprettify" nil)
;;                  (const :tag "Unprettify when point is inside" t)
;;                  (const :tag "Unprettify when point is inside or at right edge" right-edge))
;;   :group 'prog-mode)
(setq prettify-symbols-unprettify-at-point t)

;; (add-to-list 'tex--prettify-symbols-alist '("\\subseteq" . 08838))
  ;; (add-to-list 'tex--prettify-symbols-alist '("\\heree" . "0093100095001230009700125"))
  ;; (add-to-list 'tex--prettify-symbols-alist '("\\nowcheck" . 12315))
;; (add-to-list 'tex--prettify-symbols-alist '("\\mathcal{L}" . "9212010150921205652921205750"))
;; (add-to-list 'tex--prettify-symbols-alist '("\\vec{a}" . "o0009708407"))

(require 'unicode-fonts)
(unicode-fonts-setup)

(require 'latex-unicode-math-mode)
;; Enable latex-unicode-math-mode automatically for all LaTeX files.
;; This converts LaTeX to Unicode inside math environments.
(add-hook 'LaTeX-mode-hook (lambda () (modify-syntax-entry ?^ " ")))
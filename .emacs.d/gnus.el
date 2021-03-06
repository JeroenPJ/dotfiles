(defun gnus-vertical-buffer-configuration ()
  (interactive)
  (setq gnus-buffer-configuration
        '((group (vertical 1.0 (group 1.0 point)))
          (summary (vertical 1.0 (summary 1.0 point)))
          (article (cond (gnus-use-trees (quote (vertical 1.0 (summary 0.25 point)
                                                          (tree 0.25)
                                                          (article 1.0))))
                         (t (quote (vertical 1.0
                                             (summary 0.25 point)
                                             (article 1.0))))))
          (server (vertical 1.0 (server 1.0 point)))
          (browse (vertical 1.0 (browse 1.0 point)))
          (message (vertical 1.0 (message 1.0 point)))
          (pick (vertical 1.0 (article 1.0 point)))
          (info (vertical 1.0 (info 1.0 point)))
          (summary-faq (vertical 1.0 (summary 0.25)
                                 (faq 1.0 point)))
          (only-article (vertical 1.0 (article 1.0 point)))
          (edit-article (vertical 1.0 (article 1.0 point)))
          (edit-form (vertical 1.0 (group 0.5)
                               (edit-form 1.0 point)))
          (edit-score (vertical 1.0 (summary 0.25)
                                (edit-score 1.0 point)))
          (edit-server (vertical 1.0 (server 0.5)
                                 (edit-form 1.0 point)))
          (post (vertical 1.0 (post 1.0 point)))
          (reply (vertical 1.0 (article 0.5)
                           (message 1.0 point)))
          (forward (vertical 1.0 (message 1.0 point)))
          (reply-yank (vertical 1.0 (message 1.0 point)))
          (mail-bounce (vertical 1.0 (article 0.5)
                                 (message 1.0 point)))
          (pipe (vertical 1.0 (summary 0.25 point)
                          ("*Shell Command Output*" 1.0)))
          (bug (vertical 1.0 (if gnus-bug-create-help-buffer (quote ("*Gnus Help Bug*" 0.5)))
                         ("*Gnus Bug*" 1.0 point)))
          (score-trace (vertical 1.0 (summary 0.5 point)
                                 ("*Score Trace*" 1.0)))
          (score-words (vertical 1.0 (summary 0.5 point)
                                 ("*Score Words*" 1.0)))
          (split-trace (vertical 1.0 (summary 0.5 point)
                                 ("*Split Trace*" 1.0)))
          (category (vertical 1.0 (category 1.0)))
          (compose-bounce (vertical 1.0 (article 0.5)
                                    (message 1.0 point)))
          (display-term (vertical 1.0 ("*display*" 1.0)))
          (mml-preview (vertical 1.0 (message 0.5)
                                 (mml-preview 1.0 point))))))

(defun gnus-horizontal-buffer-configuration ()
  (interactive)
  (setq gnus-buffer-configuration
        '((group (vertical 1.0 (group 1.0 point)))
          (summary (vertical 1.0 (summary 1.0 point)))
          (article (cond (gnus-use-trees (quote (vertical 1.0 (summary 0.25 point)
                                                          (tree 0.25)
                                                          (article 1.0))))
                         (t (quote (horizontal 1.0
                                               (article 0.5 )
                                               (summary 1.0 point))))))
          (server (vertical 1.0 (server 1.0 point)))
          (browse (vertical 1.0 (browse 1.0 point)))
          (message (vertical 1.0 (message 1.0 point)))
          (pick (vertical 1.0 (article 1.0 point)))
          (info (vertical 1.0 (info 1.0 point)))
          (summary-faq (vertical 1.0 (summary 0.25)
                                 (faq 1.0 point)))
          (only-article (vertical 1.0 (article 1.0 point)))
          (edit-article (vertical 1.0 (article 1.0 point)))
          (edit-form (vertical 1.0 (group 0.5)
                               (edit-form 1.0 point)))
          (edit-score (vertical 1.0 (summary 0.25)
                                (edit-score 1.0 point)))
          (edit-server (vertical 1.0 (server 0.5)
                                 (edit-form 1.0 point)))
          (post (vertical 1.0 (post 1.0 point)))
          (reply (vertical 1.0 (article 0.5)
                           (message 1.0 point)))
          (forward (vertical 1.0 (message 1.0 point)))
          (reply-yank (vertical 1.0 (message 1.0 point)))
          (mail-bounce (vertical 1.0 (article 0.5)
                                 (message 1.0 point)))
          (pipe (vertical 1.0 (summary 0.25 point)
                          ("*Shell Command Output*" 1.0)))
          (bug (vertical 1.0 (if gnus-bug-create-help-buffer (quote ("*Gnus Help Bug*" 0.5)))
                         ("*Gnus Bug*" 1.0 point)))
          (score-trace (vertical 1.0 (summary 0.5 point)
                                 ("*Score Trace*" 1.0)))
          (score-words (vertical 1.0 (summary 0.5 point)
                                 ("*Score Words*" 1.0)))
          (split-trace (vertical 1.0 (summary 0.5 point)
                                 ("*Split Trace*" 1.0)))
          (category (vertical 1.0 (category 1.0)))
          (compose-bounce (vertical 1.0 (article 0.5)
                                    (message 1.0 point)))
          (display-term (vertical 1.0 ("*display*" 1.0)))
          (mml-preview (vertical 1.0 (message 0.5)
                                 (mml-preview 1.0 point))))))

(require 'gnus-start)

(setq gnus-activate-level 3

      ;; Get the headers thoroughly.
      gnus-extract-address-components 'mail-extract-address-components
      gnus-boring-article-headers '(empty followup-to reply-to long-to many-to)
      gnus-extra-headers '(To Cc Newsgroups)
      nnmail-extra-headers gnus-extra-headers

      ;; Saved articles.
      gnus-default-article-saver 'gnus-summary-save-in-folder

      gnus-add-to-list t)

  ;;; MIME display preferences.

(eval-after-load "mm-decode"
  '(setq mm-inline-text-html-with-images t
         mm-text-html-renderer 'shr ; Generally better than 'gnus-w3m
         ))

  ;;; Topics.

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

  ;;; Summary, Threads & Article.

(setq gnus-summary-line-format "%U%R%3t%I%( %[%4k: %-20,22f%]%) %s\n"
      gnus-summary-mode-line-format "Gnus: %p [%A] %Z"
      gnus-summary-ignore-duplicates t

      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject

      ;; Sort first by date, then by number.
      gnus-thread-sort-functions
      '(gnus-thread-sort-by-number gnus-thread-sort-by-date)
      gnus-thread-hide-subtree t
      gnus-thread-indent-level 2

      gnus-treat-date-combined-lapsed 'head)

(gnus-horizontal-buffer-configuration)

(use-package visual-fill-column :ensure t)

(defun my-message-hook ()
  (auto-fill-mode -1)
  (visual-fill-column-mode 1)
  ;; (messages-are-flowing-use-and-mark-hard-newlines)
  (visual-line-mode 1))

  ;; fill-column is 72. rfc5322 goes to 78

  (setq message-setup-hook 'my-message-hook
        message-from-style 'angles
        message-syntax-checks '((signature . disabled) (sender . disabled))
        message-generate-headers-first t
        message-mail-alias-type 'ecomplete
        message-sendmail-envelope-from 'header

        ;; Citation (without supercite)
        message-cite-function 'message-cite-original-without-signature
        message-cite-reply-position 'above ; top posting :(

        gnus-message-archive-group
        '((if (message-news-p)
              (concat "news." (format-time-string "%Y-%m" (current-time)))
              (concat "mail." (format-time-string "%Y-%m" (current-time)))))
        send-mail-function 'message-send-mail-with-sendmail
        message-send-mail-function 'message-send-mail-with-sendmail

        message-directory (concat gnus-directory "mail")

        gnus-newsgroup-variables '(message-default-mail-headers)

        ecomplete-database-file-coding-system 'utf-8

        ;; http://nullprogram.com/blog/2017/06/15/
        ;; use-hard-newlines t
        )

(setq gnus-select-method '(nntp "nntp.aioe.org"))

(add-to-list 'gnus-secondary-select-methods '(nnml ""))
(setq mail-sources '(
                     (imap  :server "imap-mail.outlook.com"
                            :port 993
                            :user "paul_lodder@live.nl"
                            :stream 'tls)
                     (smtp  :server "smtp.live.com"
                            :port 587
                            :user "paul_lodder@live.nl"
                            :stream 'starttls)))

;; (pop :server "pop-mail-outlook.com"
;;      :port 995
;;      :user "paul_lodder@live.nl"
;;      :stream 'tls))

(setq smtpmail-default-smtp-server "smtp.live.com")
(require 'smtpmail)
(setq send-mail-function 'smtpmail-send-it) ; not for Gnus
(setq message-send-mail-function 'smtpmail-send-it) ; for Gnus
(setq smtpmail-default-smtp-server "smtp.live.com")
(setq smtpmail-smtp-server "smtp.live.com")
(setq smtpmail-local-domain "live.nl")
(setq smtpmail-debug-info t) ; only to debug problems
(setq smtpmail-debug-verb t) ; only to debug problems

;; (setq gnus-select-method '(nntp "foo.bar.com"))
      ;; (add-to-list 'gnus-secondary-select-methods '(nntp "localhost"))
      ;; (add-to-list 'gnus-secondary-select-methods '(nntp "news.gnus.org"))
      ;; (add-to-list 'gnus-secondary-select-methods '(nnml ""))
      ;; (setq mail-sources '((pop :server "pop.provider.org"
      ;;                           :user "you"
      ;;                           :password "secret")))
   ;; random news server

                                                     ;; nnml-directory "home/paul/gnusmail/"
                                                     ;; nnml-active-file "home/paul/gnusmail/active"))
  ;; (add-to-list 'gnus-secondary-select-methods '(nnml-active-file "home/paul/gnusmail/active"))
  ;; (add-to-list 'gnus-secondary-select-methods '(nnml-directory "home/paul/gnusmail/"))

      ;; (setq gnus-secondary-select-methods '((nntp "smtp.office365.com")))
      ;; (defvar message-send-mail-function 'message-smtpmail-send-it)  ;; (a)
      ;; (setq smtpmail-smtp-server "nntp.aioe.org")  ;; (b)
      ;; (setq smtpmail-smtp-service 587) ;; (b)
      ;; (setq smtpmail-stream-type 'starttls) ;; e(b)
      ;; (setq smtpmail-smtp-user "paul_lodder@live.nl")  ;; (c)
    ;;   (setq mail-sources '((imap  :server "imap-mail.outlook.com"
    ;;                               :port "993"
    ;;                               :user "paul_lodder@live.nl"
    ;;                               :stream "ssl")
  ;; ))
;; (smtp  :server "smtp-mail-outlook.com"
;;        :port 587
;;        :user "paul_lodder@live.nl"
;;        :stream 'starttls)



  ;; (setq mail-sources '((pop :server "outlook.office365.com"
  ;;                           :port 995
  ;;                           :user "paul_lodder@live.nl"
  ;;                           :stream 'tls)
  ;;                      (imap  :server "outlook.office365.com"
  ;;                             :port 995
  ;;                             :user "paul_lodder@live.nl"
  ;;                             :stream 'tls)
  ;;                      (smtp  :server "smtp.office365.com"
  ;;                             :port 587
  ;;                             :user "paul_lodder@live.nl"
  ;;                             :stream 'starttls)))

  ;; (setq mail-sources '((imap  :server "imap-mail.outlook.com"
      ;;                             :porte "993"
      ;;                             :user "paul_lodder@live.nl"
      ;;                             :stream "ssl")))
     ;; n  (add-to-list 'gnus-secondary-select-methods '(nnml ""))
      ;; (setq send-mail-function		'smtpmail-send-it)
      ;; ;; (setq smtpmail-smtp-server		"mail.live.nl")
      ;; ;; mnessage-send-mail-function	'smtpmail-send-it)
      ;; ;; smtpmail-smtp-server		"your.smtp-server.com")

      ;; ;; outgoing mail?
      ;; (setq send-mail-function 'smtpmail-send-it) ; not for Gnus
      ;; (setq message-send-mail-function 'smtpmail-send-it) ; for Gnus
      ;; (setq smtpmail-default-smtp-server "smtp-mail.outlook.com")
      ;; ;; (setq smtpmail-local-domain "YOUR DOMAIN NAME")
      ;; (setq smtpmail-sendto-domain "YOUR DOMAIN NAME")
      (setq smtpmail-debug-info t) ; only to debug problems

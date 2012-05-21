(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-icon-directory
      (expand-file-name "etc" (file-name-directory (locate-library "mew.el"))))
(setq mew-use-cached-passwd t)

;; Optional setup (Read Mail menu):
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))

;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

(setq mew-pop-size 0)
(setq mew-smtp-auth-list nil)
(setq toolbar-mail-reader 'Mew)
(set-default 'mew-decode-quoted 't) 
(when (boundp 'utf-translate-cjk)
  (setq utf-translate-cjk t)
  (custom-set-variables
   '(utf-translate-cjk t)))
(if (fboundp 'utf-translate-cjk-mode)
    (utf-translate-cjk-mode 1))

(defvar mew-cite-fields '("From:" "Subject:" "Date:"))
(defvar mew-cite-format "From: %s\nSubject: %s\nDate: %s\n\n")
(defvar mew-cite-prefix "> ")

(setq mew-ssl-verify-level 0)
(setq mew-use-cached-passwd t)

(setq mew-signature-file "~/Mail/signature")
(setq mew-signature-as-lastpart t)
(setq mew-signature-insert-last t)
(add-hook 'mew-before-cite-hook 'mew-header-goto-body)
(add-hook 'mew-draft-mode-newdraft-hook 'mew-draft-insert-signature)

;; (setq mew-refile-guess-alist
;;       '(("To:"
;;          ("@octave.org"                       . "+math/octave")
;;          ("@freebsd.org"                      . "+unix/freebsd"))
;;         ("Cc:"
;;          ("@octave.org"                       . "+math/octave")
;;          ("@freebsd.org"                      . "+unix/freebsd"))
;;         (nil . "+inbox")))
(setq mew-refile-guess-control
      '(mew-refile-guess-by-folder
        mew-refile-guess-by-alist))

(setq mew-summary-form
      '(type (5 date) " " (14 from) " " t (0 subj)))
(setq mew-summary-form-extract-rule '(name))

;;
;;用w3m来读html格式邮件
;; 
(setq mew-mime-multipart-alternative-list '("Text/Html" "Text/Plain" "*."))
(condition-case nil
    (require 'mew-w3m)
  (file-error nil))

(setq mew-use-text/html t)

;; Password
(setq mew-use-master-passwd t)

;;(setq mew-ssl-verify-level 0)
(setq mew-prog-ssl "/usr/local/bin/stunnel")

;; setup mail
(setq mew-config-alist
      '(
        (default
          (mailbox-type          imap)
          (proto                 "%")
          (prog-ssl              "/usr/local/bin/stunnel")
          (imap-server           "imap.gmail.com")
          (imap-ssl-port         "993")
          (imap-user             "ranmocy@gmail.com")
          (name                  "Ranmocy Sheng")
          (user                  "ranmocy")
          (mail-domain           "gmail.com")
          (imap-ssl              t)
          (imap-size             0)
          (imap-delete           t)
          (imap-queue-folder     "%queue")
          (imap-trash-folder     "%Trash")
          ;; This must be in concile with your IMAP box setup
          (smtp-ssl              t)
          (smtp-auth-list        ("PLAIN" "LOGIN" "CRAM-MD5"))
          (smtp-user             "ranmocy@gmail.com")
          (smtp-server           "smtp.gmail.com")
          (smtp-ssl-port         "465")
          )))

(provide 'set-mew)
;;; set-mew.el ends here

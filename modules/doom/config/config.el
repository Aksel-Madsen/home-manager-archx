;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Source Code Pro" :size 40)
     doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 40))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Set editing style for cpp files
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "gnu")))

(setq scroll-margin '7)

(defun scrot-move (dest-filename)
  "Move a hardcoded file from the home directory to a hardcoded subfolder under the current buffer's directory, renaming it to DEST-FILENAME."
  (interactive "sEnter destination filename: ")
  (let* ((source-filename "scrot_clip.png")  ;; Hardcoded source file name
         (subfolder "images")                ;; Hardcoded subfolder name
         (source-path (expand-file-name source-filename "~"))
         (buffer-dir (file-name-directory (or (buffer-file-name)
                                              default-directory)))
         (target-dir (expand-file-name subfolder buffer-dir))
         (target-path (expand-file-name dest-filename target-dir)))
    (unless (file-exists-p source-path)
      (error "Source file does not exist: %s" source-path))
    (unless (file-directory-p target-dir)
      (make-directory target-dir t))
    (rename-file source-path target-path)
   (save-excursion (insert (format "%s" dest-filename)))
   (message "Moved '%s' to '%s'" source-path target-path)))


;; Force line breaks after TOC when exporting LaTeX to PDF
(setq org-latex-toc-command "\\tableofcontents \\clearpage")

(defun my/open-associated-pdf ()
  "If PDF with same name as the current buffer exists, open it in zathura."
  (interactive)
  (if-let* ((file buffer-file-name)
            (pdf (concat (file-name-sans-extension file) ".pdf")))
      (if (file-exists-p pdf)
          (start-process "zathura" nil "zathura" pdf)
        (message "No PDF found: %s" pdf))
    (message "Current buffer is not visiting a file")))

(defun my/compile-cpp-file ()
  "Simple compilation for .cpp files using clang++"
  (interactive)
  (if-let* ((file (buffer-file-name))
            ((string-equal (file-name-extension file) "cpp"))
            (out (file-name-sans-extension file)))
      (compile (format "clang++ %s -o %s" 
                       (shell-quote-argument file) 
                       (shell-quote-argument out)))
    (message "Not a .cpp file or no file visiting this buffer.")))

;; Command to list academic books
(defun my/academic-books ()
  (interactive)
  (let ((file (read-file-name "Open with zathura: " "~/books/")))
    (start-process "zathura" nil "zathura" "--fork" file)))

;; Enable lsp-imenu for new c++ buffers
(add-hook 'c++-mode-hook
          (lambda ()
            (lsp)))

(map! :after cc-mode
      :map c++-mode-map
      :n "C-c d" #'lsp-ui-peek-find-definitions
      :n "C-c m" #'+evil:make
      :n "C-c r" #'lsp-ui-peek-find-references
      :n "C-c l" #'lsp-ui-imenu
      :n "C-c c" #'my/compile-cpp-file)

(map! :after org
      :map org-mode-map
      :n "C-c o" #'my/open-associated-pdf
      :n "C-c e" #'org-latex-export-to-pdf)

(map! "C-c h" #'treemacs)

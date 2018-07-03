;;; init-editor.el --- Initialize editor configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2015-2018 lin.jiang

;; Author: lin.jiang <xiyang0807@gmail.com>
;; URL: https://github.com/honmaple/dotfiles/tree/master/emacs.d

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Editor configurations.
;;

;;; Code:

(eval-when-compile
  (require 'init-basic))

;; (use-package adaptive-wrap
;;   :hook (visual-line-mode adaptive-wrap-prefix-mode))

;; 修改外部文件自动载入
(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode)
  :config
  (setq global-auto-revert-non-file-buffers t
        auto-revert-verbose nil)
  :diminish auto-revert-mode)

(use-package semantic
  :ensure nil
  :hook (after-init . semantic-mode)
  :config
  (setq semanticdb-default-save-directory
        (concat maple-cache-directory "semantic/"))
  :config
  (add-to-list 'semantic-default-submodes
               'global-semantic-stickyfunc-mode)
  (add-to-list 'semantic-default-submodes
               'global-semantic-idle-summary-mode))


(use-package elec-pair
  :ensure nil
  :hook (after-init . electric-pair-mode)
  :config
  ;; (setq electric-pair-pairs '((?\' . ?\')))
  (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit))

;; 高亮括号配对
(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t))

;; (use-package which-func
;;   :hook (after-init which-function-mode))

;; (use-package dumb-jump
;;   :evil-bind
;;   (normal prog-mode-map
;;           "gd"  'dumb-jump-go))
(use-package tramp
  :ensure nil
  :config
  (setq tramp-ssh-controlmaster-options
        "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no"))

(use-package isearch
  :ensure nil
  :config
  (defun maple/evil-search-paste()
    (when (region-active-p)
      (isearch-yank-string
       (save-excursion
         (buffer-substring-no-properties
          (region-beginning) (1+ (region-end)))))
      (deactivate-mark)))
  :hook (isearch-mode . maple/evil-search-paste)
  :bind (:map isearch-mode-map
              ([remap isearch-delete-char] . isearch-del-char)))

(use-package eldoc
  :ensure nil
  :diminish eldoc-mode)

(use-package comint
  :ensure nil
  :evil-state
  (comint-mode . insert)
  :config
  (setq comint-prompt-read-only t)
  :bind
  (:map comint-mode-map
        ("<up>" . comint-previous-input)
        ("<down>" . comint-next-input)
        ("<escape>" . (lambda() (interactive)
                        (goto-char (cdr comint-last-prompt))))
        ))

(use-package hideshow
  :ensure nil
  :diminish hs-minor-mode
  :hook ((yaml-mode conf-mode prog-mode) . hs-minor-mode))


(use-package projectile
  :diminish projectile-mode "ⓟ"
  :hook (after-init . projectile-mode)
  :config
  (setq projectile-sort-order 'recentf
        projectile-cache-file
        (concat maple-cache-directory "projectile.cache")
        projectile-known-projects-file
        (concat maple-cache-directory "projectile-bookmarks.eld")))


(provide 'init-editor)

;;; init-editor.el ends here

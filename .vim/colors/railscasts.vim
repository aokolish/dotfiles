" Vim color scheme
"
" Name:        railscast.vim
" Maintainer:  Josh O'Rourke <jorourke23@gmail.com> 
" License:     public domain
"
" A GUI Only port of the RailsCasts TextMate theme [1] to Vim.
" Some parts of this theme were borrowed from the well-documented Lucius theme [2].
" 
" [1] http://railscasts.com/about 
" [2] http://www.vim.org/scripts/script.php?script_id=2536

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
  endif
  let g:colors_name = "railscasts"

  " Colors
  " Brown        #BC9458
  " Dark Blue    #6D9CBE
  " Dark Green   #519F50
  " Dark Orange  #CC7833
  " Light Blue   #D0D0FF
  " Light Green  #A5C261
  " Tan          #FFC66D

  hi Normal                    guifg=#E6E1DC ctermfg=7 guibg=#2B2B2B ctermbg=235
  hi Cursor                    guibg=#FFFFFF ctermbg=15
  hi CursorLine                guibg=#333435 ctermbg=236
  hi LineNr                    guifg=#888888 ctermfg=102 guibg=#DEDEDE ctermbg=253
  hi Search                    guibg=#5A647E ctermbg=60
  hi Visual                    guibg=#5A647E ctermbg=60

  " Folds
  " -----
  " line used for closed folds
  hi Folded                    guifg=#F6F3E8 ctermfg=7 guibg=#444444 ctermbg=238 gui=NONE

  " Misc
  " ----
  " directory names and other special names in listings
  hi Directory                 guifg=#A5C261 ctermfg=143 gui=NONE

  " Popup Menu
  " ----------
  " normal item in popup
  hi Pmenu                     guifg=#F6F3E8 ctermfg=7 guibg=#444444 ctermbg=238 gui=NONE
  " selected item in popup
  hi PmenuSel                  guifg=#000000 ctermfg=0 guibg=#A5C261 ctermbg=143 gui=NONE
  " scrollbar in popup
  hi PMenuSbar                 guibg=#5A647E ctermbg=60 gui=NONE
  " thumb of the scrollbar in the popup
  hi PMenuThumb                guibg=#AAAAAA ctermbg=248 gui=NONE


  "rubyComment
  hi Comment                   guifg=#584223 ctermfg=237 gui=italic
  hi Todo                      guifg=#BC9458 ctermfg=137 guibg=NONE gui=italic

  "rubyPseudoVariable
  "nil, self, symbols, etc
  hi Constant                  guifg=#6D9CBE ctermfg=73

  "rubyClass, rubyModule, rubyDefine
  "def, end, include, etc
  hi Define                    guifg=#CC7833 ctermfg=173

  "rubyInterpolation
  hi Delimiter                 guifg=#519F50 ctermfg=71

  "rubyError, rubyInvalidVariable
  hi Error                     guifg=#FFFFFF ctermfg=15 guibg=#990000 ctermbg=88

  "rubyFunction
  hi Function                  guifg=#FFC66D ctermfg=221 gui=NONE

  "rubyIdentifier
  "@var, @@var, $var, etc
  hi Identifier                guifg=#D0D0FF ctermfg=189 gui=NONE

  "rubyInclude
  "include, autoload, extend, load, require
  hi Include                   guifg=#CC7833 ctermfg=173 gui=NONE

  "rubyKeyword, rubyKeywordAsMethod
  "alias, undef, super, yield, callcc, caller, lambda, proc
  hi Keyword                   guifg=#CC7833 ctermfg=173

  " same as define
  hi Macro                     guifg=#CC7833 ctermfg=173 gui=NONE

  "rubyInteger
  hi Number                    guifg=#A5C261 ctermfg=143

  " #if, #else, #endif
  hi PreCondit                 guifg=#CC7833 ctermfg=173 gui=NONE

  " generic preprocessor
  hi PreProc                   guifg=#CC7833 ctermfg=173 gui=NONE

  "rubyControl, rubyAccess, rubyEval
  "case, begin, do, for, if unless, while, until else, etc.
  hi Statement                 guifg=#CC7833 ctermfg=173 gui=NONE

  "rubyString
  hi String                    guifg=#A5C261 ctermfg=143

  hi Title                     guifg=#FFFFFF ctermfg=15

  "rubyConstant
  hi Type                      guifg=#DA4939 ctermfg=167 gui=NONE

  hi DiffAdd                   guifg=#E6E1DC ctermfg=7 guibg=#144212 ctermbg=235
  hi DiffDelete                guifg=#E6E1DC ctermfg=7 guibg=#660000 ctermbg=52

  hi link htmlTag              xmlTag
  hi link htmlTagName          xmlTagName
  hi link htmlEndTag           xmlEndTag

  hi xmlTag                    guifg=#E8BF6A ctermfg=179
  hi xmlTagName                guifg=#E8BF6A ctermfg=179
  hi xmlEndTag                 guifg=#E8BF6A ctermfg=179

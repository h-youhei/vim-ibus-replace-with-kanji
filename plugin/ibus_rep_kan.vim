if exists('g:loaded_vim_ibus')
	finish
endif
if !executable('ibus')
	finish
endif
"ibus isn't running
if system('ibus engine') =~ 'No engine is set'
	finish
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ibus_rep_kan#handle_insert_mode')
	let g:ibus_rep_kan#handle_insert_mode = v:true
endif
if !exists('g:ibus_rep_kan#handle_search_command')
	let g:ibus_rep_kan#handle_search_command = v:false
endif

augroup ibus_rep_kan
	autocmd!
augroup END

if g:ibus_rep_kan#handle_insert_mode
	augroup ibus_rep_kan
		au BufEnter,CmdwinEnter * let b:was_im_on = v:false
		au InsertEnter * call ibus_rep_kan#restore_state()
		au InsertLeave * call ibus_rep_kan#inactivate_with_state()
	augroup END
endif

if g:ibus_rep_kan#handle_search_command
	nnoremap <expr> / (ibus_rep_kan#restore_state() . '/')
	nnoremap <expr> ? (ibus_rep_kan#restore_state() . '?')
	cnoremap <expr> <CR> (ibus_rep_kan#inactivate_with_state() . '<CR>')
	"<C-u><BS> is used because <Esc> doesn't work properly
	cnoremap <expr> <Esc> (ibus_rep_kan#inactivate_with_state() . '<C-u><BS>')
endif

let g:loaded_vim_ibus = v:true

let &cpo = s:save_cpo
unlet s:save_cpo

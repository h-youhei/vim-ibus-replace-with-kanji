"return '' is for map <expr>

function! ibus_rep_kan#inactivate()
	call system('gsettings set org.freedesktop.ibus.engine.replace-with-kanji-python mode A')
	return ''
endfunction

function! ibus_rep_kan#activate()
	call system('gsettings set org.freedesktop.ibus.engine.replace-with-kanji-python mode あ')
	return ''
endfunction

function! ibus_rep_kan#toggle()
	if ibus_rep_kan#is_on()
		return ibus_rep_kan#inactivate()
	else
		return ibus_rep_kan#activate()
	endif
endfunction

function! ibus_rep_kan#is_on()
	return system('gsettings get org.freedesktop.ibus.engine.replace-with-kanji-python mode') =~ 'A' ? v:false : v:true
endfunction

function! ibus_rep_kan#inactivate_with_state()
	let b:was_im_on = ibus_rep_kan#is_on()
	return ibus_rep_kan#inactivate()
endfunction

function! ibus_rep_kan#restore_state()
	if b:was_im_on
		return ibus_rep_kan#activate()
	else
		return ibus_rep_kan#inactivate()
	endif
endfunction

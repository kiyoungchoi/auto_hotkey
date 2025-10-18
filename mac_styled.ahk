Control::Alt
Alt::Control
^Space::Send("{vk15sc1F2}")

SetCapsLockState "AlwaysOff"
CapsLock::LAlt

<!h::Send("{Left}")
<!j::Send("{Down}")
<!k::Send("{Up}")
<!l::Send("{Right}")


; Ctrl + Tab → Alt + Tab처럼 작동
^Tab::Send("!{Tab}")

<!c:: {
    ret := IME_CHECK("A")
    if ret != 0 {
        ;Send("{Esc}")
        Send("{vk15sc138}")  ; 한글 상태면 Esc + 한/영 키
    } else {
        ;Send("{Esc}")   ; 영어 상태면 Esc만
    }
}


IME_CHECK(winTitle) {
    hWnd := WinGetID(winTitle)
    return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd), 0x005, "")
}

Send_ImeControl(defaultIMEWnd, wParam, lParam) {
    detectSave := A_DetectHiddenWindows
    DetectHiddenWindows("On")
    
    result := SendMessage(0x283, wParam, lParam,, "ahk_id " defaultIMEWnd)
    
    if detectSave != A_DetectHiddenWindows
        DetectHiddenWindows(detectSave)
    
    return result
}


ImmGetDefaultIMEWnd(hWnd) {
    return DllCall("imm32\ImmGetDefaultIMEWnd", "UInt", hWnd, "UInt")
}


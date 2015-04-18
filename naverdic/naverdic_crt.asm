.486
.model flat, stdcall
option casemap:none

public WinMain
WndProc proto stdcall :dword, :dword, :dword, :dword

include windows.inc
include exdisp.inc

.DATA
CLSID_InternetExplorer GUID <02DF01H,0H,0H,<0C0H,0H,0H,0H,0H,0H,0H,046H>>
IID_IWebBrowser2 GUID <0D30C1661H,0CDAFH,011D0H,<08AH,03EH,0H,0C0H,04FH,0C9H,0E2H,06EH>>

WND_CLSNAME db "FrameWnd",0
WND_TITLE db "NAVER Dictionary v0.1.0.3",0
WND_WIDTH dword 405
WND_HEIGHT dword 513
SNAP_TH dword 15

;http://endic.naver.com/popManager.nhn?m=miniPopMain
DIC_URL dw "h", "t", "t", "p", ":", "/", "/", "e", "n", "d", "i", "c"
        dw ".", "n", "a", "v", "e", "r", ".", "c", "o", "m", "/", "p"
        dw "o", "p", "M", "a", "n", "a", "g", "e", "r", ".", "n", "h"
        dw "n", "?", "m", "=", "m", "i", "n", "i", "P", "o", "p", "M"
        dw "a", "i", "n", 0

g_hFrameWnd dword 0
g_ptSize POINT<>
g_hWebWnd dword 0
g_hOldParentWnd dword 0
g_pWeb dword 0
g_oldWndStyle dword 0

.CODE
WinMain proc stdcall hInstance:dword, hPrevInstance:dword, lpCmdLine:dword, nCmdShow:dword
  local wc:WNDCLASS
  local msg:MSG
  local style:dword
  local rect:RECT
  local url:dword
  local varEmpty:VARIANT
  local flag:dword
    
  mov wc.style, 0
  mov wc.lpfnWndProc, offset WndProc
  mov wc.cbClsExtra, 0
  mov wc.cbWndExtra, 0
  push hInstance
  pop wc.hInstance
  mov wc.hbrBackground, COLOR_WINDOW + 1
  mov wc.lpszMenuName, 0
  mov wc.lpszClassName, offset WND_CLSNAME
  invoke LoadIconA, hInstance, 1000
  mov wc.hIcon, eax
  invoke LoadCursorA, 0, IDC_ARROW
  mov wc.hCursor, eax

  invoke RegisterClassA, addr wc
    
  mov eax, WS_MAXIMIZEBOX
  not eax
  and eax, WS_OVERLAPPEDWINDOW
  or eax, WS_CLIPCHILDREN
  mov style, eax

  mov rect.left, 0
  mov rect.top, 0
  push WND_WIDTH
  pop rect.right
  push WND_HEIGHT
  pop rect.bottom
  invoke AdjustWindowRect, addr rect, style, 0
  mov eax, rect.right
  sub eax, rect.left
  mov g_ptSize.x, eax
  mov eax, rect.bottom
  sub eax, rect.top
  mov g_ptSize.y, eax
    
  invoke CreateWindowExA, WS_EX_TOPMOST, addr WND_CLSNAME, addr WND_TITLE, \
    style, CW_USEDEFAULT, CW_USEDEFAULT, g_ptSize.x, g_ptSize.y, \
    0, 0, hInstance, 0
  mov g_hFrameWnd, eax
    
  invoke OleInitialize, 0
  invoke CoCreateInstance, addr CLSID_InternetExplorer, 0, \
    CLSCTX_LOCAL_SERVER, addr IID_IWebBrowser2, addr g_pWeb
  cmp eax, 0
  jge CREATE_SUCCEED
  ret
    
CREATE_SUCCEED:
  push VARIANT_TRUE
  mov eax, [g_pWeb]
  push eax
  mov eax, [eax]
  call [IWebBrowser2.put_FullScreen][eax]
    
  mov eax, offset g_hWebWnd
  push eax
  mov eax, [g_pWeb]
  push eax
  mov eax, [eax]
  call [IWebBrowser2.get_HWND][eax]
    
  mov eax, WS_CHILD
  or  eax, WS_VISIBLE
  mov style, eax
    
  invoke SetWindowLongA, g_hWebWnd, GWL_STYLE, style
  mov g_oldWndStyle, eax
    
  invoke SetParent, g_hWebWnd, g_hFrameWnd
  mov g_hOldParentWnd, eax
    
  mov eax, SWP_NOMOVE
  or  eax, SWP_NOSIZE
  or  eax, SWP_NOZORDER
  or  eax, SWP_FRAMECHANGED
  mov flag, eax
  invoke SetWindowPos, g_hWebWnd, 0, 0, 0, 0, 0, flag
    
  invoke VariantInit, addr varEmpty
    
  invoke SysAllocString, addr DIC_URL
  mov url, eax
    
  lea eax, varEmpty
  push eax
  push eax
  push eax
  push eax
  mov eax, url
  push eax
  mov eax, [g_pWeb]
  push eax
  mov eax, [eax]
  call [IWebBrowser2.Navigate][eax]
  cmp eax, 0
  jge NAVIGATE_SUCCEED
  ret
    
NAVIGATE_SUCCEED:
  invoke SysFreeString, url

  push VARIANT_TRUE
  mov eax, [g_pWeb]
  push eax
  mov eax, [eax]
  call [IWebBrowser2.put_Visible][eax]
    
  invoke ShowWindow, g_hFrameWnd, nCmdShow
  invoke UpdateWindow, g_hFrameWnd
    
  .WHILE 1
      invoke GetMessageA, addr msg, 0, 0, 0
      .BREAK .IF (!eax) 
      invoke TranslateMessage, addr msg
      invoke DispatchMessageA, addr msg
  .ENDW
   
  invoke OleUninitialize
   
  mov eax, msg.wParam
  ret 
WinMain endp

WndProc proc hWnd:dword, uMsg:dword, wParam:dword, lParam:dword
  LOCAL pt:POINT
  LOCAL hMonitor:dword
  LOCAL mi:MONITORINFO
  LOCAL x:dword
  LOCAL y:dword
  LOCAL nWidth:dword
  LOCAL nHeight:dword

  .IF uMsg == WM_DESTROY
    invoke PostQuitMessage, 0
        
  .ELSEIF uMsg == WM_CLOSE
    push VARIANT_FALSE
    mov eax, [g_pWeb]
    push eax
    mov eax, [eax]
    call [IWebBrowser2.put_Visible][eax]
      
    invoke SetWindowLongA, g_hWebWnd, GWL_STYLE, g_oldWndStyle
    invoke SetParent, g_hWebWnd, g_hOldParentWnd
    invoke PostMessageA, g_hWebWnd, uMsg, wParam, lParam
      
    mov eax, [g_pWeb]
    push eax
    mov eax, [eax]
    call [IWebBrowser2.Release][eax]
      
    invoke DefWindowProcA, hWnd, uMsg, wParam, lParam
    ret
    
  .ELSEIF uMsg == WM_GETMINMAXINFO
    cmp g_hFrameWnd, 0
    je  DEFAULT
    mov edi, lParam
    mov eax, g_ptSize.x
    mov [edi + 18h], eax
    mov [edi + 20h], eax
    mov eax, g_ptSize.y
    mov [edi + 1ch], eax
    mov [edi + 24h], eax
        
  .ELSEIF uMsg == WM_WINDOWPOSCHANGING
    mov edi, lParam
    mov eax, [edi + 8h]
    mov pt.x, eax
    mov eax, [edi + 0ch]
    mov pt.y, eax
    mov eax, [edi + 10h]
    mov nWidth, eax
    mov eax, [edi + 14h]
    mov nHeight, eax
        
    invoke MonitorFromPoint, pt.x, pt.y, MONITOR_DEFAULTTONEAREST
    mov hMonitor, eax
    mov eax, sizeof mi
    mov mi.cbSize, eax
    invoke GetMonitorInfoA, hMonitor, addr mi
        
    mov eax, pt.x
    mov x, eax
    mov eax, mi.rcWork.left
    add eax, SNAP_TH
    cmp x, eax
    jl  SNAP_LEFT_A
    jmp SNAP_RIGHT_A

SNAP_LEFT_A:
    mov eax, mi.rcWork.left
    sub eax, SNAP_TH
    cmp x, eax
    jg  SNAP_LEFT_B
    jmp SNAP_RIGHT_A
SNAP_LEFT_B:
    mov eax, mi.rcWork.left
    mov x, eax
        
SNAP_RIGHT_A:
    mov ebx, x
    add ebx, nWidth
    mov eax, mi.rcWork.right
    sub eax, SNAP_TH
    cmp ebx, eax
    jg  SNAP_RIGHT_B
    jmp SNAP_HORZ_APPLIED
SNAP_RIGHT_B:
    mov eax, mi.rcWork.right
    add eax, SNAP_TH
    cmp ebx, eax
    jl  SNAP_RIGHT_C
    jmp SNAP_HORZ_APPLIED
SNAP_RIGHT_C:
    mov eax, mi.rcWork.right
    sub eax, nWidth
    mov x, eax

SNAP_HORZ_APPLIED:
    mov edi, lParam
    mov eax, x
    mov [edi + 8h], eax
    mov eax, pt.y
    mov y, eax
    mov eax, mi.rcWork.top
    add eax, SNAP_TH
    cmp y, eax
    jl  SNAP_TOP_A
    jmp SNAP_BOTTOM_A

SNAP_TOP_A:
    mov eax, mi.rcWork.top
    sub eax, SNAP_TH
    cmp y, eax
    jg  SNAP_TOP_B
    jmp SNAP_BOTTOM_A
SNAP_TOP_B:
    mov eax, mi.rcWork.top
    mov y, eax
        
SNAP_BOTTOM_A:
    mov ebx, y
    add ebx, nHeight
    mov eax, mi.rcWork.bottom
    sub eax, SNAP_TH
    cmp ebx, eax
    jg  SNAP_BOTTOM_B
    jmp SNAP_VERT_APPLIED
SNAP_BOTTOM_B:
    mov eax, mi.rcWork.bottom
    add eax, SNAP_TH
    cmp ebx, eax
    jl  SNAP_BOTTOM_C
    jmp SNAP_VERT_APPLIED
SNAP_BOTTOM_C:
    mov eax, mi.rcWork.bottom
    sub eax, nHeight
    mov y, eax
SNAP_VERT_APPLIED:
    mov edi, lParam
    mov eax, y
    mov [edi + 0ch], eax

  .ELSE
    invoke DefWindowProcA, hWnd, uMsg, wParam, lParam
    ret
        
  .ENDIF
    
DEFAULT:
    xor eax,eax 
    ret
WndProc endp

END

; message
WM_CREATE equ 1h
WM_DESTROY equ 2h
WM_CLOSE equ 10h
WM_GETMINMAXINFO equ 24h
WM_WINDOWPOSCHANGING equ 46h

; constant
WS_EX_TOPMOST equ 8h
WS_CHILD equ 40000000h
WS_VISIBLE equ 10000000h
WS_MAXIMIZEBOX equ 10000h
WS_CLIPCHILDREN equ 2000000h
WS_OVERLAPPEDWINDOW equ 0cf0000h
CW_USEDEFAULT equ 80000000h

SWP_NOSIZE equ 1h
SWP_NOMOVE equ 2h
SWP_NOZORDER equ 4h
SWP_FRAMECHANGED equ 20h

VARIANT_TRUE equ 0ffffh
VARIANT_FALSE equ 0

COLOR_WINDOW equ 5
GWL_STYLE equ -16
MONITOR_DEFAULTTONEAREST equ 2
IDC_ARROW equ 32512
CLSCTX_LOCAL_SERVER equ 4
SW_SHOWNORMAL equ 1

; type
HWND typedef dword

WNDCLASS STRUCT
  style dword ?
  lpfnWndProc dword ?
  cbClsExtra dword ?
  cbWndExtra dword ?
  hInstance dword ?
  hIcon dword ?
  hCursor dword ?
  hbrBackground dword ?
  lpszMenuName dword ?
  lpszClassName dword ?
WNDCLASS ENDS

GUID STRUCT
  Data1 dd ?
  Data2 dw ?
  Data3 dw ?
  Data4 db 8 dup(?)
GUID ENDS

POINT STRUCT
  x dword ?
  y dword ?
POINT ENDS

RECT STRUCT
  left dd ?
  top dd ?
  right dd ?
  bottom dd ?
RECT ENDS

MSG STRUCT
  hwnd dword ?
  message dword ?
  wParam dword ?
  lParam dword ?
  time dword ?
  pt POINT <>
MSG ENDS

MONITORINFO STRUCT
  cbSize dword ?
  rcMonitor RECT <>
  rcWork RECT <>
  dwFlags dword ?
MONITORINFO ENDS

; Win32 API
GetModuleHandleA proto stdcall :dword
LoadIconA proto stdcall :dword, :dword
LoadCursorA proto stdcall :dword, :dword
RegisterClassA proto stdcall :dword
AdjustWindowRect proto stdcall :dword, :dword, :dword
CreateWindowExA proto stdcall :dword, :dword, :dword, :dword, :dword, :dword, :dword, :dword, :dword, :dword, :dword, :dword
OleInitialize proto stdcall :dword
OleUninitialize proto stdcall
CoCreateInstance proto stdcall :dword, :dword, :dword, :dword, :dword
SetWindowLongA proto stdcall :dword, :dword, :dword
SetParent proto stdcall :dword, :dword
SetWindowPos proto stdcall :dword, :dword, :dword, :dword, :dword, :dword, :dword
VariantInit proto stdcall :dword
ShowWindow proto stdcall :dword, :dword
UpdateWindow proto stdcall :dword
GetMessageA proto stdcall :dword, :dword, :dword, :dword
TranslateMessage proto stdcall :dword
DispatchMessageA proto stdcall :dword
ExitProcess proto stdcall :dword
PostQuitMessage proto stdcall :dword
PostMessageA proto stdcall :dword, :dword, :dword, :dword
DefWindowProcA proto stdcall :dword, :dword, :dword, :dword
MonitorFromPoint proto stdcall :dword, :dword, :dword
GetMonitorInfoA proto stdcall :dword, :dword
SysAllocString proto stdcall :dword
SysFreeString proto stdcall :dword

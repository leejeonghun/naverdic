DECIMAL	STRUCT
  wReserved word ?
  scale qword ?
  sign qword ?
  Hi32 dword ?
  Lo64 qword ?
DECIMAL ENDS

CY STRUCT
  lo dword ?
  hi dword ?
CY ENDS

__tagVARIANT equ	
__VARIANT_NAME_1 equ	
__VARIANT_NAME_2 equ	
__VARIANT_NAME_3 equ	
__tagBRECORD equ	
__VARIANT_NAME_4 equ	

VARIANT	STRUCT
  union	__VARIANT_NAME_1
  STRUCT __VARIANT_NAME_2
  vt word ?
  wReserved1 word ?
  wReserved2 word ?
  wReserved3 word ?
  union	__VARIANT_NAME_3
  llVal qword ?
  lVal dword ?
  bVal byte ?
  iVal word ?
  fltVal real4 ?
  dblVal real8 ?
  boolVal word ?
  bool word ?
  scode dword ?
  cyVal CY <> 
  date qword ?
  bstrVal dword ?
  punkVal dword ?
  pdispVal dword ?
  parray dword ?
  pbVal dword ?
  piVal dword ?
  plVal dword ?
  pllVal dword ?
  pfltVal dword ?
  pdblVal dword ?
  pboolVal dword ?
  pbool dword ?
  pscode dword ?
  pcyVal dword ?
  pdate dword ?
  pbstrVal dword ?
  ppunkVal dword ?
  ppdispVal dword ?
  pparray dword ?
  pvarVal dword ?
  byref dword ?
  cVal byte ?
  uiVal word ?
  ulVal dword ?
  ullVal qword ?
  intVal dword ?
  uintVal dword ?
  pdecVal dword ?
  pcVal dword ?
  puiVal dword ?
  pulVal dword ?
  pullVal dword ?
  pintVal dword ?
  puintVal dword ?
  STRUCT	__VARIANT_NAME_4
  pvRecord dword ?
  pRecInfo dword ?
  ENDS
  ENDS
  ENDS
  decVal DECIMAL <> 
  ENDS
VARIANT		ENDS

pcomethod1 TYPEDEF PROTO :dword
pcomethod2 TYPEDEF PROTO :dword, :dword
pcomethod3 TYPEDEF PROTO :dword, :dword, :dword
pcomethod4 TYPEDEF PROTO :dword, :dword, :dword, :dword
pcomethod5 TYPEDEF PROTO :dword, :dword, :dword, :dword, :dword
pcomethod6 TYPEDEF PROTO :dword, :dword, :dword, :dword, :dword, :dword
pcomethod9 TYPEDEF PROTO :dword, :dword, :dword, :dword, :dword, :dword, :dword, :dword, :dword

comethod1	TYPEDEF PTR pcomethod1
comethod2	TYPEDEF PTR pcomethod2
comethod3	TYPEDEF PTR pcomethod3
comethod4	TYPEDEF PTR pcomethod4
comethod5	TYPEDEF PTR pcomethod5
comethod6	TYPEDEF PTR pcomethod6
comethod9	TYPEDEF PTR pcomethod9

IWebBrowser2_PutProperty TYPEDEF PROTO :dword, :dword, :VARIANT 
FIWebBrowser2_PutProperty TYPEDEF PTR IWebBrowser2_PutProperty

IWebBrowser2	STRUCT
  QueryInterface comethod3 ?
  AddRef comethod1 ?
  Release comethod1 ?
  GetTypeInfoCount comethod2 ?
  GetTypeInfo comethod4 ?
  GetIDsOfNames comethod6 ?
  invoke1 comethod9 ?
  GoBack comethod1 ?
  GoForward comethod1 ?
  GoHome comethod1 ?
  GoSearch comethod1 ?
  Navigate comethod6 ?
  Refresh comethod1 ?
  Refresh2 comethod2 ?
  Stop comethod1 ?
  get_Application comethod2 ?
  get_Parent comethod2 ?
  get_Container comethod2 ?
  get_Document comethod2 ?
  get_TopLevelContainer comethod2 ?
  get_Type comethod2 ?
  get_Left comethod2 ?
  put_Left comethod2 ?
  get_Top comethod2 ?
  put_Top comethod2 ?
  get_Width comethod2 ?
  put_Width comethod2 ?
  get_Height comethod2 ?
  put_Height comethod2 ?
  get_LocationName comethod2 ?
  get_LocationURL comethod2 ?
  get_Busy comethod2 ?
  Quit comethod1 ?
  ClientToWindow comethod3 ?
  PutProperty FIWebBrowser2_PutProperty ?
  GetProperty comethod3 ?
  get_Name comethod2 ?
  get_HWND comethod2 ?
  get_FullName comethod2 ?
  get_Path comethod2 ?
  get_Visible comethod2 ?
  put_Visible comethod2 ?
  get_StatusBar comethod2 ?
  put_StatusBar comethod2 ?
  get_StatusText comethod2 ?
  put_StatusText comethod2 ?
  get_ToolBar comethod2 ?
  put_ToolBar comethod2 ?
  get_MenuBar comethod2 ?
  put_MenuBar comethod2 ?
  get_FullScreen comethod2 ?
  put_FullScreen comethod2 ?
  Navigate2 comethod6 ?
  QueryStatusWB comethod3 ?
  ExecWB comethod5 ?
  ShowBrowserBar comethod4 ?
  get_ReadyState comethod2 ?
  get_Offline comethod2 ?
  put_Offline comethod2 ?
  get_Silent comethod2 ?
  put_Silent comethod2 ?
  get_RegisterAsBrowser comethod2 ?
  put_RegisterAsBrowser comethod2 ?
  get_RegisterAsDropTarget comethod2 ?
  put_RegisterAsDropTarget comethod2 ?
  get_TheaterMode comethod2 ?
  put_TheaterMode comethod2 ?
  get_AddressBar comethod2 ?
  put_AddressBar comethod2 ?
  get_Resizable comethod2 ?
  put_Resizable comethod2 ?
IWebBrowser2	ENDS

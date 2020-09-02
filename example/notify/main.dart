import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

final hInstance = GetModuleHandle(nullptr);

final notifyIcon = NOTIFYICONDATA.allocate();

const WM_USER_SHELL_ICON = WM_USER + 1;

void main() {
  final szAppName = TEXT('NotifyIconExample');

  SetProcessDPIAware();

  final wc = WNDCLASS.allocate();
  wc.style = CS_HREDRAW | CS_VREDRAW | CS_OWNDC | CS_DROPSHADOW;
  wc.lpfnWndProc = Pointer.fromFunction<WindowProc>(mainWindowProc, 0);
  wc.hInstance = hInstance;
  wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
  wc.hCursor = LoadCursor(NULL, IDC_ARROW);
  wc.hbrBackground = GetStockObject(BLACK_BRUSH);
  wc.lpszClassName = szAppName;
  RegisterClass(wc.addressOf);

  final hWnd = CreateWindowEx(
    WS_EX_TOPMOST | WS_EX_TOOLWINDOW | WS_EX_WINDOWEDGE,
    szAppName,
    szAppName,
    WS_POPUPWINDOW,
    CW_USEDEFAULT,
    CW_USEDEFAULT,
    320,
    480,
    NULL,
    NULL,
    hInstance,
    nullptr,
  );

  if (hWnd == 0) {
    stderr.writeln('CreateWindowEx failed with error: ${GetLastError()}');
    exit(-1);
  }

  notifyIcon.hWnd = hWnd;
  notifyIcon.uID = 1234;
  notifyIcon.uFlags = NIF.NIF_MESSAGE | NIF.NIF_ICON | NIF.NIF_TIP | NIF.NIF_SHOWTIP;
  notifyIcon.uCallbackMessage = WM_USER_SHELL_ICON;
  notifyIcon.hIcon = LoadIcon(NULL, IDI_SHIELD);
  notifyIcon.tip = 'test';
  notifyIcon.uVersion = NOTIFYICON_VERSION_4;

  Shell_NotifyIcon(NIM.NIM_ADD, notifyIcon.addressOf);
  Shell_NotifyIcon(NIM.NIM_SETVERSION, notifyIcon.addressOf);

  // Run the message loop.

  final msg = MSG.allocate().addressOf;
  while (GetMessage(msg, NULL, 0, 0) != 0) {
    TranslateMessage(msg);
    DispatchMessage(msg);
  }

  Shell_NotifyIcon(NIM.NIM_DELETE, notifyIcon.addressOf);

  free(msg);
  free(wc.addressOf);
}

void animateOpen(int hWnd, int x, int y) {
  SetForegroundWindow(hWnd);
  SetWindowPos(hWnd, -1, x - 320, y - 480, 320, 480, 0);
  UpdateWindow(hWnd);
  AnimateWindow(hWnd, 200, 0x00080000); // AW_BLEND
  SendMessage(hWnd, WM_NULL, 0, 0);
}

void animateClose(int hWnd) {
  AnimateWindow(hWnd, 200, 0x00080000 | 0x00010000); // AW_BLEND | AW_HIDE
  //Shell_NotifyIcon(NIM.NIM_SETFOCUS, notifyIcon.addressOf);
}

int mainWindowProc(int hWnd, int uMsg, int wParam, int lParam) {
  switch (uMsg) {
    case WM_CREATE:
      break;

    case WM_USER_SHELL_ICON:
      {
        var nin = LOWORD(lParam);
        var iconId = HIWORD(lParam);
        var x = GET_X_LPARAM(wParam); // This is not a mistake
        var y = GET_Y_LPARAM(wParam); // This is not a mistake
        // print('WM_USER_SHELL_ICON:   NIN ${nin.toHexString(16)} '
        //     'NID ${iconId.toHexString(16)} ${x}x$y');
        if (iconId == 1234) {
          switch (nin) {
            case NIN.NIN_SELECT:
            case NIN.NIN_KEYSELECT:
              print('NIN_SELECT');
              break;
            case NIN.NIN_POPUPOPEN:
              print('NIN_POPUPOPEN');
              animateOpen(hWnd, x, y);
              break;
            case NIN.NIN_POPUPCLOSE:
              print('NIN_POPUPCLOSE');
              animateClose(hWnd);
              break;
            case WM_CONTEXTMENU:
              print('WM_CONTEXTMENU');
              DestroyWindow(hWnd);
              break;
          }
        }
      }
      break;

    case WM_SETFOCUS:
      print('WM_SETFOCUS');
      break;

    case WM_KILLFOCUS:
      print('WM_KILLFOCUS');
      break;

    case WM_CLOSE:
      DestroyWindow(hWnd);
      break;

    case WM_DESTROY:
      PostQuitMessage(0);
      break;

    default:
      return DefWindowProc(hWnd, uMsg, wParam, lParam);
  }
  return 0;
}

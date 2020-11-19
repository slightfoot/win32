// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Maps FFI prototypes onto the corresponding Win32 API function calls

// THIS FILE IS GENERATED AUTOMATICALLY AND SHOULD NOT BE EDITED DIRECTLY.

// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'com/combase.dart';
import 'structs.dart';

final _ole32 = DynamicLibrary.open('ole32.dll');

/// Converts a string generated by the StringFromCLSID function back into
/// the original CLSID.
///
/// ```c
/// HRESULT CLSIDFromString(
///   LPCOLESTR lpsz,
///   LPCLSID   pclsid
/// );
/// ```
/// {@category ole32}
final CLSIDFromString = _ole32.lookupFunction<
    Int32 Function(Pointer<Utf16> lpsz, Pointer<GUID> pclsid),
    int Function(Pointer<Utf16> lpsz, Pointer<GUID> pclsid)>('CLSIDFromString');

/// Creates a GUID, a unique 128-bit integer used for CLSIDs and interface
/// identifiers.
///
/// ```c
/// HRESULT CoCreateGuid(
///   GUID *pguid
/// );
/// ```
/// {@category ole32}
final CoCreateGuid = _ole32.lookupFunction<Int32 Function(Pointer<GUID> pguid),
    int Function(Pointer<GUID> pguid)>('CoCreateGuid');

/// Creates a single uninitialized object of the class associated with a
/// specified CLSID. Call CoCreateInstance when you want to create only one
/// object on the local system. To create a single object on a remote
/// system, call the CoCreateInstanceEx function. To create multiple
/// objects based on a single CLSID, call the CoGetClassObject function.
///
/// ```c
/// HRESULT CoCreateInstance(
///   REFCLSID  rclsid,
///   LPUNKNOWN pUnkOuter,
///   DWORD     dwClsContext,
///   REFIID    riid,
///   LPVOID    *ppv
/// );
/// ```
/// {@category ole32}
final CoCreateInstance = _ole32.lookupFunction<
    Int32 Function(Pointer<GUID> rclsid, Pointer<IntPtr> pUnkOuter,
        Uint32 dwClsContext, Pointer<GUID> riid, Pointer<COMObject> ppv),
    int Function(
        Pointer<GUID> rclsid,
        Pointer<IntPtr> pUnkOuter,
        int dwClsContext,
        Pointer<GUID> riid,
        Pointer<COMObject> ppv)>('CoCreateInstance');

/// Provides a pointer to an interface on a class object associated with a
/// specified CLSID. CoGetClassObject locates, and if necessary,
/// dynamically loads the executable code required to do this.
///
/// ```c
/// HRESULT CoGetClassObject(
///   REFCLSID rclsid,
///   DWORD    dwClsContext,
///   LPVOID   pvReserved,
///   REFIID   riid,
///   LPVOID   *ppv
/// );
/// ```
/// {@category ole32}
final CoGetClassObject = _ole32.lookupFunction<
    Int32 Function(Pointer<GUID> rclsid, Uint32 dwClsContext,
        Pointer pvReserved, Pointer<GUID> riid, Pointer<COMObject> ppv),
    int Function(Pointer<GUID> rclsid, int dwClsContext, Pointer pvReserved,
        Pointer<GUID> riid, Pointer<COMObject> ppv)>('CoGetClassObject');

/// Initializes the COM library for use by the calling thread, sets the
/// thread's concurrency model, and creates a new apartment for the thread
/// if one is required.
///
/// ```c
/// HRESULT CoInitializeEx(
///   LPVOID pvReserved,
///   DWORD  dwCoInit
/// );
/// ```
/// {@category ole32}
final CoInitializeEx = _ole32.lookupFunction<
    Int32 Function(Pointer<Void> pvReserved, Uint32 dwCoInit),
    int Function(Pointer<Void> pvReserved, int dwCoInit)>('CoInitializeEx');

/// Registers security and sets the default security values for the
/// process.
///
/// ```c
/// HRESULT CoInitializeSecurity(
///   PSECURITY_DESCRIPTOR        pSecDesc,
///   LONG                        cAuthSvc,
///   SOLE_AUTHENTICATION_SERVICE *asAuthSvc,
///   void                        *pReserved1,
///   DWORD                       dwAuthnLevel,
///   DWORD                       dwImpLevel,
///   void                        *pAuthList,
///   DWORD                       dwCapabilities,
///   void                        *pReserved3
/// );
/// ```
/// {@category ole32}
final CoInitializeSecurity = _ole32.lookupFunction<
    Int32 Function(
        Pointer<SECURITY_DESCRIPTOR> pSecDesc,
        Int32 cAuthSvc,
        Pointer<SOLE_AUTHENTICATION_SERVICE> asAuthSvc,
        Pointer<Void> pReserved1,
        Uint32 dwAuthnLevel,
        Uint32 dwImpLevel,
        Pointer<Void> pAuthList,
        Uint32 dwCapabilities,
        Pointer<Void> pReserved3),
    int Function(
        Pointer<SECURITY_DESCRIPTOR> pSecDesc,
        int cAuthSvc,
        Pointer<SOLE_AUTHENTICATION_SERVICE> asAuthSvc,
        Pointer<Void> pReserved1,
        int dwAuthnLevel,
        int dwImpLevel,
        Pointer<Void> pAuthList,
        int dwCapabilities,
        Pointer<Void> pReserved3)>('CoInitializeSecurity');

/// Sets the authentication information that will be used to make calls on
/// the specified proxy. This is a helper function for
/// IClientSecurity::SetBlanket.
///
/// ```c
/// HRESULT CoSetProxyBlanket(
///   IUnknown                 *pProxy,
///   DWORD                    dwAuthnSvc,
///   DWORD                    dwAuthzSvc,
///   OLECHAR                  *pServerPrincName,
///   DWORD                    dwAuthnLevel,
///   DWORD                    dwImpLevel,
///   RPC_AUTH_IDENTITY_HANDLE pAuthInfo,
///   DWORD                    dwCapabilities
/// );
/// ```
/// {@category ole32}
final CoSetProxyBlanket = _ole32.lookupFunction<
    Int32 Function(
        Pointer pProxy,
        Uint32 dwAuthnSvc,
        Uint32 dwAuthzSvc,
        Pointer<Utf16> pServerPrincName,
        Uint32 dwAuthnLevel,
        Uint32 dwImpLevel,
        Pointer<Void> pAuthInfo,
        Uint32 dwCapabilities),
    int Function(
        Pointer pProxy,
        int dwAuthnSvc,
        int dwAuthzSvc,
        Pointer<Utf16> pServerPrincName,
        int dwAuthnLevel,
        int dwImpLevel,
        Pointer<Void> pAuthInfo,
        int dwCapabilities)>('CoSetProxyBlanket');

/// Frees a block of task memory previously allocated through a call to the
/// CoTaskMemAlloc or CoTaskMemRealloc function.
///
/// ```c
/// void CoTaskMemFree(
///   _Frees_ptr_opt_ LPVOID pv
/// );
/// ```
/// {@category ole32}
final CoTaskMemFree =
    _ole32.lookupFunction<Void Function(Pointer pv), void Function(Pointer pv)>(
        'CoTaskMemFree');

/// Closes the COM library on the current thread, unloads all DLLs loaded
/// by the thread, frees any other resources that the thread maintains, and
/// forces all RPC connections on the thread to close.
///
/// ```c
/// void CoUninitialize();
/// ```
/// {@category ole32}
final CoUninitialize =
    _ole32.lookupFunction<Void Function(), void Function()>('CoUninitialize');

/// Converts a string generated by the StringFromIID function back into the
/// original interface identifier (IID).
///
/// ```c
/// HRESULT IIDFromString(
///   LPCOLESTR lpsz,
///   LPIID     lpiid
/// );
/// ```
/// {@category ole32}
final IIDFromString = _ole32.lookupFunction<
    Int32 Function(Pointer<Utf16> lpsz, Pointer<GUID> lpiid),
    int Function(Pointer<Utf16> lpsz, Pointer<GUID> lpiid)>('IIDFromString');
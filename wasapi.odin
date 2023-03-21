package wasapi
import "vendor:directx/dxgi"
import "core:sys/windows"

E_NOTFOUND :: 1168
E_UNSUPPORTED_TYPE :: 1630

CLSCTX_ALL :: windows.CLSCTX_INPROC_SERVER | windows.CLSCTX_INPROC_HANDLER | windows.CLSCTX_LOCAL_SERVER | windows.CLSCTX_REMOTE_SERVER
CLSID_MMDeviceEnumerator := windows.GUID{0xBCDE0395, 0xE52F, 0x467C, {0x8E, 0x3D, 0xC4, 0x57, 0x92, 0x91, 0x69, 0x2E}}

REFERENCE_TIME :: i64

DEVICE_STATE :: enum { ACTIVE, DISABLED, NOTPRESENT, UNPLUGGED, }

PROPVARIANT :: distinct rawptr

IPropertyStore_UUID_STRING :: "886d8eeb-8cf2-4446-8d02-cdba1dbdcf99"
IPropertyStore_UUID := &dxgi.IID{0x886d8eeb, 0x8cf2, 0x4446, {0x8d, 0x02, 0xcd, 0xba, 0x1d, 0xbd, 0xcf, 0x99}}
IPropertyStore :: struct #raw_union {
    #subtype iunknown: dxgi.IUnknown,
    using vtable: ^IPropertyStore_VTable,
}

PROPERTYKEY :: struct {
    fmtid: dxgi.GUID,
    pid: windows.DWORD,
}

IPropertyStore_VTable :: struct {
    using iunknown_vtable: dxgi.IUnknown_VTable,
    GetCount: proc "stdcall" (this: ^IPropertyStore, cProps: ^windows.DWORD) -> windows.HRESULT,
    GetAt: proc "stdcall" (this: ^IPropertyStore, iProp: windows.DWORD, pKey: ^PROPERTYKEY) -> windows.HRESULT,
    GetValue: proc "stdcall" (this: ^IPropertyStore, iProp: windows.DWORD, pValue: ^PROPVARIANT) -> windows.HRESULT,
    SetValue: proc "stdcall" (this: ^IPropertyStore, iProp: windows.DWORD, pValue: ^PROPVARIANT) -> windows.HRESULT,
    Commit: proc "stdcall" (this: ^IPropertyStore) -> windows.HRESULT,
}

IMMDevice_UUID_STRING :: "D666063F-1587-4E43-81F1-B948E807363F"
IMMDevice_UUID := &dxgi.IID{0xD666063F, 0x1587, 0x4E43, {0x81, 0xF1, 0xB9, 0x48, 0xE8, 0x07, 0x36, 0x3F}}
IMMDevice :: struct #raw_union {
    #subtype iunknown: dxgi.IUnknown,
    using vtable: ^IMMDevice_VTable,
}

IMMDevice_VTable :: struct {
    using iunknown_vtable: dxgi.IUnknown_VTable,
    Activate: proc "stdcall" (this: ^IMMDevice, iid: windows.REFIID, dwClsCtx: windows.DWORD, pActivateParams: ^PROPVARIANT, ppInterface: ^rawptr) -> windows.HRESULT,
    OpenPropertyStore: proc "stdcall" (this: ^IMMDevice, stgmAccess: windows.DWORD, ppProperties: ^IPropertyStore) -> windows.HRESULT,
    GetId: proc "stdcall" (this: ^IMMDevice, ppstrId: windows.LPWSTR) -> windows.HRESULT,
    GetState: proc "stdcall" (this: ^IMMDevice, pwState: ^DEVICE_STATE) -> windows.HRESULT,
}

IMMDeviceCollection_UUID_STRING :: "0BD7A1BE-7A1A-44DB-8397-CC5392387B5E"
IMMDeviceCollection_UUID := &dxgi.IID{0x0BD7A1BE, 0x7A1A, 0x44DB, {0x83, 0x97, 0xCC, 0x53, 0x92, 0x38, 0x7B, 0x5E}}
IMMDeviceCollection :: struct #raw_union {
    #subtype iunknown: dxgi.IUnknown,
    using vtable: ^IMMDeviceCollection_VTable,
}

IMMDeviceCollection_VTable :: struct {
    using iunknown_vtable: dxgi.IUnknown_VTable,
    GetCount: proc "stdcall" (this: ^IMMDeviceCollection, pcDevices: ^windows.UINT) -> windows.HRESULT,
    Item: proc "stdcall" (this: ^IMMDeviceCollection, nDevice: windows.UINT, device: ^^IMMDevice) -> windows.HRESULT,
}

IMMDeviceEnumerator_UUID_STRING :: "A95664D2-9614-4F35-A746-DE8DB63617E6"
IMMDeviceEnumerator_UUID := &dxgi.IID{0xA95664D2, 0x9614, 0x4F35, {0xA7, 0x46, 0xDE, 0x8D, 0xB6, 0x36, 0x17, 0xE6}}
IMMDeviceEnumerator :: struct #raw_union {
    #subtype iunknown: dxgi.IUnknown,
    using vtable: ^IMMDeviceEnumerator_VTable,
}

IMMDeviceEnumerator_VTable :: struct {
    using iunknown_vtable: dxgi.IUnknown_VTable,
    EnumAudioEndpoints: proc "stdcall" (this: ^IMMDeviceEnumerator, dataFlow: EDataFlow, dwStateMask: bit_set[DEVICE_STATE; windows.DWORD], ppDevices: ^^IMMDeviceCollection) -> windows.HRESULT,
    GetDefaultAudioEndpoint: proc "stdcall" (this: ^IMMDeviceEnumerator, dataFlow: EDataFlow, role: ERole, ppEndpoint: ^^IMMDevice) -> windows.HRESULT,
    GetDevice: proc "stdcall" (this: ^IMMDeviceEnumerator, pwstr: windows.LPWSTR, ppDevice: ^^IMMDevice) -> windows.HRESULT,
    RegisterEndpointNotificationCallback: proc "stdcall" (this: ^IMMDeviceEnumerator, pClient: rawptr) -> windows.HRESULT,
    UnregisterEndpointNotificationCallback: proc "stdcall" (pClient: rawptr) -> windows.HRESULT,
}

IAudioClient_UUID_STRING :: "1CB9AD4C-DBFA-4c32-B178-C2F568A703B2"
IAudioClient_UUID := &dxgi.IID{0x1CB9AD4C, 0xDBFA, 0x4c32, {0xB1, 0x78, 0xC2, 0xF5, 0x68, 0xA7, 0x03, 0xB2}}
IAudioClient :: struct #raw_union {
    #subtype iunknown: dxgi.IUnknown,
    using vtable: ^IAudioClient_VTable,
}

WAVEFORMATEX :: struct {
    wFormatTag: windows.WORD,
    nChannels: windows.WORD,      
    nSamplesPerSec: windows.DWORD,  
    nAvgBytesPerSec: windows.DWORD, 
    nBlockAlign: windows.WORD,     
    wBitsPerSample: windows.WORD,   
    cbSize: windows.WORD,            
}

IAudioClient_VTable :: struct {
    using iunknown_vtable: dxgi.IUnknown_VTable,
    Initialize: proc "stdcall" (this: ^IAudioClient, ShareMode: AUDCLNT_SHAREMODE, StreamFlags: Audio_Client_Stream_Flags, hnsBufferDuration: REFERENCE_TIME, hnsPeriodicity: REFERENCE_TIME, pFormat: ^WAVEFORMATEX, AudioSessionGuid: windows.LPCGUID) -> windows.HRESULT,
    GetBufferSize: proc "stdcall" (this: ^IAudioClient, pNumBufferFrames: ^windows.UINT32) -> windows.HRESULT,
    GetStreamLatency: proc "stdcall" (this: ^IAudioClient, phnsLatency: ^REFERENCE_TIME) -> windows.HRESULT,
    GetCurrentPadding: proc "stdcall" (this: ^IAudioClient, pNumPaddingFrames: ^windows.UINT32) -> windows.HRESULT,
    IsFormatSupported: proc "stdcall" (this: ^IAudioClient, ShareMode: AUDCLNT_SHAREMODE, pFormat: ^WAVEFORMATEX, ppClosestMatch: ^^WAVEFORMATEX) -> windows.HRESULT,
    GetMixFormat: proc "stdcall" (this: ^IAudioClient, ppDeviceFormat: ^^WAVEFORMATEX) -> windows.HRESULT,
    GetDevicePeriod: proc "stdcall" (this: ^IAudioClient, phnsDefaultDevicePeriod: ^REFERENCE_TIME, phnsMinimumDevicePeriod: ^REFERENCE_TIME) -> windows.HRESULT,
    Start: proc "stdcall" (this: ^IAudioClient) -> windows.HRESULT,
    Stop: proc "stdcall" (this: ^IAudioClient) -> windows.HRESULT,
    Reset: proc "stdcall" (this: ^IAudioClient) -> windows.HRESULT,
    SetEventHandle: proc "stdcall" (this: ^IAudioClient, eventHandle: windows.HANDLE) -> windows.HRESULT,
    GetService: proc "stdcall" (this: ^IAudioClient, riid: windows.REFIID, ppv: ^rawptr) -> windows.HRESULT,
}

IAudioClient2_UUID_STRING :: "726778CD-F60A-4eda-82DE-E47610CD78AA"
IAudioClient2_UUID := &dxgi.IID{0x726778CD, 0xF60A, 0x4eda, {0x82, 0xDE, 0xE4, 0x76, 0x10, 0xCD, 0x78, 0xAA}}
IAudioClient2 :: struct #raw_union {
    #subtype iaudioclient: IAudioClient,
    using vtable: ^IAudioClient2_VTable,
}

AudioClientProperties :: struct {
    cbSize: windows.UINT32,
    bIsOffload: windows.BOOL,
    eCategory: AUDIO_STREAM_CATEGORY,
    Options: AUDCLNT_STREAMOPTIONS,
}

IAudioClient2_VTable :: struct {
    using iaudioclient_vtable: IAudioClient_VTable,
    IsOffloadCapable: proc "stdcall" (this: ^IAudioClient2, Category: AUDIO_STREAM_CATEGORY, pbOffloadCapable: ^windows.BOOL) -> windows.HRESULT,
    SetClientProperties: proc "stdcall" (this: ^IAudioClient2, pProperties: ^AudioClientProperties) -> windows.HRESULT,
    GetBufferSizeLimits: proc "stdcall" (this: ^IAudioClient2, pFormat: ^WAVEFORMATEX, bEventDriven: windows.BOOL, phnsMinBufferDuration: ^REFERENCE_TIME, phnsMaxBufferDuration: ^REFERENCE_TIME) -> windows.HRESULT,
}

IAudioClient3_UUID_STRING :: "7ED4EE07-8E67-4CD4-8C1A-2B7A5987AD42"
IAudioClient3_UUID := &dxgi.IID{0x7ED4EE07, 0x8E67, 0x4CD4, {0x8C, 0x1A, 0x2B, 0x7A, 0x59, 0x87, 0xAD, 0x42}}
IAudioClient3 :: struct #raw_union {
    #subtype iaudioclient2: IAudioClient2,
    using vtable: ^IAudioClient3_VTable,
}

IAudioClient3_VTable :: struct {
    using iaudioclient2_vtable: IAudioClient2_VTable,
    GetSharedModeEnginePeriod: proc "stdcall" (this: ^IAudioClient3, pFormat: ^WAVEFORMATEX, pDefaultPeriodInFrames: ^windows.UINT32, pFundamentalPeriodInFrames: ^windows.UINT32, pMinPeriodInFrames: ^windows.UINT32, pMaxPeriodInFrames: ^windows.UINT32) -> windows.HRESULT,
    GetCurrentSharedModeEnginePeriod: proc "stdcall" (this: ^IAudioClient3, ppFormat: ^^WAVEFORMATEX, pCurrentPeriodInFrames: ^windows.UINT32) -> windows.HRESULT,
    InitializeSharedAudioStream: proc "stdcall" (this: ^IAudioClient3, StreamFlags: Audio_Client_Stream_Flags, PeriodInFrames: windows.UINT32, pFormat: ^WAVEFORMATEX, AudioSessionGuid: windows.LPCGUID) -> windows.HRESULT,
}

IAudioRenderClient_UUID_STRING :: "F294ACFC-3146-4483-A7BF-ADDCA7C260E2"
IAudioRenderClient_UUID := &dxgi.IID{0xF294ACFC, 0x3146, 0x4483, {0xA7, 0xBF, 0xAD, 0xDC, 0xA7, 0xC2, 0x60, 0xE2}}
IAudioRenderClient :: struct #raw_union {
    #subtype iunknown: dxgi.IUnknown,
    using vtable: ^IAudioRenderClient_VTable,
}

IAudioRenderClient_VTable :: struct {
    using iunknown_vtable: dxgi.IUnknown_VTable,
    GetBuffer: proc "stdcall" (this: ^IAudioRenderClient, NumFramesRequested: windows.UINT32, ppData: ^^byte) -> windows.HRESULT,
    ReleaseBuffer: proc "stdcall" (this: ^IAudioRenderClient, NumFramesWritten: windows.UINT32, dwFlags: AUDCLNT_BUFFERFLAGS) -> windows.HRESULT,
}

package wasapi
import "core:sys/windows"

AUDCLNT_BUFFERFLAGS :: bit_set[AUDCLNT_BUFFERFLAG; windows.DWORD]
AUDCLNT_BUFFERFLAG :: enum {
    DATA_DISCONTINUITY,
    SILENT,
    TIMESTAMP_ERROR,
}

EDataFlow :: enum i32 {
    eRender,
    eCapture,
    eAll,
}

ERole :: enum i32 {
    eConsole,
    eMultimedia,
    eCommunications,
}

AUDCLNT_SHAREMODE :: enum i32 { 
    SHARED, 
    EXCLUSIVE, 
}


AUDIO_STREAM_CATEGORY :: enum i32 {
    Other,
    ForegroundOnlyMedia,
    BackgroundCapableMedia,
    Communications,
    Alerts,
    SoundEffects,
    GameEffects,
    GameMedia,
    GameChat,
    Speech,
    Movie,
    Media,
}

AUDCLNT_STREAMOPTIONS :: bit_set[AUDCLNT_STREAMOPTION; u32]
AUDCLNT_STREAMOPTION :: enum {
    RAW,
    MATCH_FORMAT,
    AMBISONICS,
}

Audio_Client_Stream_Flags :: bit_set[Audio_Client_Stream_Flag; windows.DWORD]
Audio_Client_Stream_Flag :: enum {
    Cross_Process = 16,
    Loop_Back = 17,
    Event_Callback = 18,
    No_Persist = 19,
    Rate_Adjusted = 20,
    Source_Default_Quality = 27,
    Expire_When_Unowned = 28,
    Display_Hide = 29,
    Display_Hide_When_Expired = 30,
    Auto_Convert_PCM = 31,
}

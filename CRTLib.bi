'-----------------------------------------------------------------------------------------------------------------------
' C Runtime Library bindings + low level support functions
' Copyright (c) 2023 Samuel Gomes
'
' See https://en.cppreference.com/w/ for CRT documentation
'-----------------------------------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------------------------------
' HEADER FILES
'-----------------------------------------------------------------------------------------------------------------------
'$Include:'Common.bi'
'-----------------------------------------------------------------------------------------------------------------------

$If CRTLIB_BI = UNDEFINED Then
    $Let CRTLIB_BI = TRUE

    '-------------------------------------------------------------------------------------------------------------------
    ' EXTERNAL LIBRARIES
    '-------------------------------------------------------------------------------------------------------------------
    ' This only includes CRT library functions that makes sense in QB64
    Declare CustomType Library
        Function isalnum& (ByVal ch As Long)
        Function isalpha& (ByVal ch As Long)
        Function islower& (ByVal ch As Long)
        Function isupper& (ByVal ch As Long)
        Function isdigit& (ByVal ch As Long)
        Function isxdigit& (ByVal ch As Long)
        Function iscntrl& (ByVal ch As Long)
        Function isgraph& (ByVal ch As Long)
        Function isspace& (ByVal ch As Long)
        Function isblank& (ByVal ch As Long)
        Function isprint& (ByVal ch As Long)
        Function ispunct& (ByVal ch As Long)
        Function tolower& (ByVal ch As Long)
        Function toupper& (ByVal ch As Long)
        $If 32BIT Then
            Function strlen~& (ByVal str As _Unsigned _Offset)
        $Else
            Function strlen~&& (ByVal str As _Unsigned _Offset)
        $End If
        Sub strncpy (ByVal dst As _Unsigned _Offset, Byval src As _Unsigned _Offset, Byval count As _Unsigned _Offset)
        Function memcmp& (ByVal lhs As _Unsigned _Offset, Byval rhs As _Unsigned _Offset, Byval count As _Unsigned _Offset)
        Sub memset (ByVal dst As _Unsigned _Offset, Byval ch As Long, Byval count As _Unsigned _Offset)
        Sub memcpy (ByVal dst As _Unsigned _Offset, Byval src As _Unsigned _Offset, Byval count As _Unsigned _Offset)
        Sub memmove (ByVal dst As _Unsigned _Offset, Byval src As _Unsigned _Offset, Byval count As _Unsigned _Offset)
        Sub memccpy (ByVal dst As _Unsigned _Offset, Byval src As _Unsigned _Offset, Byval c As Long, Byval count As _Unsigned _Offset)
        Function rand&
        Sub srand (ByVal seed As _Unsigned Long)
        Function getchar&
        Sub putchar (ByVal ch As Long)
        Function GetTicks~&&
    End Declare

    Declare CustomType Library "CRTLib"
        Function ToQBBool%% (ByVal x As Long)
        Function ToCBool%% (ByVal x As Long)
        $If 32BIT Then
            Function CLngPtr~& (ByVal p As _Unsigned _Offset)
        $Else
            Function CLngPtr~&& (ByVal p As _Unsigned _Offset)
        $End If
        Function CStr$ (ByVal p As _Unsigned _Offset)
        Function PeekByte~%% (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset)
        Sub PokeByte (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval n As _Unsigned _Byte)
        Function PeekInteger~% (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset)
        Sub PokeInteger (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval n As _Unsigned Integer)
        Function PeekLong~& (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset)
        Sub PokeLong (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval n As _Unsigned Long)
        Function PeekInteger64~&& (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset)
        Sub PokeInteger64 (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval n As _Unsigned _Integer64)
        Function PeekSingle! (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset)
        Sub PokeSingle (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval n As Single)
        Function PeekDouble# (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset)
        Sub PokeDouble (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval n As Double)
        Function PeekOffset~%& (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset)
        Sub PokeOffset (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval n As _Unsigned _Offset)
        Sub PeekType (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval t As _Unsigned _Offset, Byval t_size As _Unsigned _Offset)
        Sub PokeType (ByVal p As _Unsigned _Offset, Byval o As _Unsigned _Offset, Byval t As _Unsigned _Offset, Byval t_size As _Unsigned _Offset)
        Function PeekString~%% (s As String, Byval o As _Unsigned _Offset)
        Sub PokeString (s As String, Byval o As _Unsigned _Offset, Byval n As _Unsigned _Byte)
        Function ToBGRA~& (ByVal r As _Unsigned _Byte, Byval g As _Unsigned _Byte, Byval b As _Unsigned _Byte, Byval a As _Unsigned _Byte)
        Function ToRGBA~& (ByVal r As _Unsigned _Byte, Byval g As _Unsigned _Byte, Byval b As _Unsigned _Byte, Byval a As _Unsigned _Byte)
        Function GetRedFromRGBA~%% (ByVal rgba As _Unsigned Long)
        Function GetGreenFromRGBA~%% (ByVal rgba As _Unsigned Long)
        Function GetBlueFromRGBA~%% (ByVal rgba As _Unsigned Long)
        Function GetAlphaFromRGBA~%% (ByVal rgba As _Unsigned Long)
        Function GetRGB~& (ByVal clr As _Unsigned Long)
        Function SwapRedBlue~& (ByVal clr As _Unsigned Long)
        Function RandomBetween& (ByVal lo As Long, Byval hi As Long)
        Function IsPowerOfTwo& (ByVal n As _Unsigned Long)
        Function RoundUpToPowerOf2~& (ByVal n As _Unsigned Long)
        Function RoundDownToPowerOf2~& (ByVal n As _Unsigned Long)
        Function LeftShiftOneCount~& (ByVal n As _Unsigned Long)
        Function ReverseBitsByte~%% (ByVal n As _Unsigned _Byte)
        Function ReverseBitsInteger~% (ByVal n As _Unsigned Integer)
        Function ReverseBitsLong~& (ByVal n As _Unsigned Long)
        Function ReverseBitsInteger64~&& (ByVal n As _Unsigned _Integer64)
        Sub ReverseBytes (ByVal ptr As _Unsigned _Offset, Byval size As _Unsigned _Offset)
        Function ClampLong& (ByVal n As Long, Byval lo As Long, Byval hi As Long)
        Function ClampInteger64&& (ByVal n As _Integer64, Byval lo As _Integer64, Byval hi As _Integer64)
        Function ClampSingle! (ByVal n As Single, Byval lo As Single, Byval hi As Single)
        Function ClampDouble# (ByVal n As Double, Byval lo As Double, Byval hi As Double)
        Function GetDigitFromLong& (ByVal n As _Unsigned Long, Byval p As _Unsigned Long)
        Function GetDigitFromInteger64& (ByVal n As _Unsigned _Integer64, Byval p As _Unsigned Long)
        Function AverageLong& (ByVal x As Long, Byval y As Long)
        Function AverageInteger64&& (ByVal x As _Integer64, Byval y As _Integer64)
        Function FindFirstBitSetLong& (ByVal x As _Unsigned Long)
        Function FindFirstBitSetInteger64& (ByVal x As _Unsigned _Integer64)
        Function CountLeadingZerosLong& (ByVal x As _Unsigned Long)
        Function CountLeadingZerosInteger64& (ByVal x As _Unsigned _Integer64)
        Function CountTrailingZerosLong& (ByVal x As _Unsigned Long)
        Function CountTrailingZerosInteger64& (ByVal x As _Unsigned _Integer64)
        Function PopulationCountLong& (ByVal x As _Unsigned Long)
        Function PopulationCountInteger64& (ByVal x As _Unsigned _Integer64)
        Function ByteSwapInteger~% (ByVal x As _Unsigned Integer)
        Function ByteSwapLong~& (ByVal x As _Unsigned Long)
        Function ByteSwapInteger64~&& (ByVal x As _Unsigned _Integer64)
        Function MakeFourCC~& (ByVal ch0 As _Unsigned _Byte, Byval ch1 As _Unsigned _Byte, Byval ch2 As _Unsigned _Byte, Byval ch3 As _Unsigned _Byte)
        Function MakeByte~%% (ByVal x As _Unsigned _Byte, Byval y As _Unsigned _Byte)
        Function MakeInteger~% (ByVal x As _Unsigned _Byte, Byval y As _Unsigned _Byte)
        Function MakeLong~& (ByVal x As _Unsigned Integer, Byval y As _Unsigned Integer)
        Function MakeInteger64~&& (ByVal x As _Unsigned Long, Byval y As _Unsigned Long)
        Function HiNibble~%% (ByVal x As _Unsigned _Byte)
        Function LoNibble~%% (ByVal x As _Unsigned _Byte)
        Function HiByte~%% (ByVal x As _Unsigned Integer)
        Function LoByte~%% (ByVal x As _Unsigned Integer)
        Function HiInteger~% (ByVal x As _Unsigned Long)
        Function LoInteger~% (ByVal x As _Unsigned Long)
        Function HiLong~& (ByVal x As _Unsigned _Integer64)
        Function LoLong~& (ByVal x As _Unsigned _Integer64)
        Function MaxLong& (ByVal a As Long, Byval b As Long)
        Function MinLong& (ByVal a As Long, Byval b As Long)
        Function MaxInteger64&& (ByVal a As _Integer64, Byval b As _Integer64)
        Function MinInteger64&& (ByVal a As _Integer64, Byval b As _Integer64)
        Function MaxSingle! (ByVal a As Single, Byval b As Single)
        Function MinSingle! (ByVal a As Single, Byval b As Single)
        Function MaxDouble# (ByVal a As Double, Byval b As Double)
        Function MinDouble# (ByVal a As Double, Byval b As Double)
    End Declare
    '-------------------------------------------------------------------------------------------------------------------
$End If
'-----------------------------------------------------------------------------------------------------------------------

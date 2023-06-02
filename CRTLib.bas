'-----------------------------------------------------------------------------------------------------------------------
' C Runtime Library bindings + low level support functions
' Copyright (c) 2023 Samuel Gomes
'-----------------------------------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------------------------------
' HEADER FILES
'-----------------------------------------------------------------------------------------------------------------------
'$Include:'CRTLib.bi'
'-----------------------------------------------------------------------------------------------------------------------

$If CRTLIB_BAS = UNDEFINED Then
    $Let CRTLIB_BAS = TRUE

    '-------------------------------------------------------------------------------------------------------------------
    ' FUNCTIONS & SUBROUTINES
    '-------------------------------------------------------------------------------------------------------------------
    ' Returns a BASIC string (bstring) from NULL terminated C string (cstring)
    Function ToBString$ (s As String)
        Dim zeroPos As Long: zeroPos = InStr(s, Chr$(NULL))
        If zeroPos > NULL Then ToBString = Left$(s, zeroPos - 1) Else ToBString = s
    End Function

    ' Just a convenience function for use when calling external libraries
    Function ToCString$ (s As String)
        ToCString = s + Chr$(NULL)
    End Function
    '-------------------------------------------------------------------------------------------------------------------
$End If
'-----------------------------------------------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Sesid
{
class ServiceID
{

    #region Constants
    public const int WTS_CURRENT_SESSION = -1;
    #endregion

    #region Dll Imports
    [DllImport("wtsapi32.dll")]
    static extern int WTSEnumerateSessions(
        IntPtr pServer,
        [MarshalAs(UnmanagedType.U4)] int iReserved,
        [MarshalAs(UnmanagedType.U4)] int iVersion,
        ref IntPtr pSessionInfo,
        [MarshalAs(UnmanagedType.U4)] ref int iCount);

    [DllImport("Wtsapi32.dll")]
    public static extern bool WTSQuerySessionInformation(
        System.IntPtr pServer,
        int iSessionID,
        WTS_INFO_CLASS oInfoClass,
        out System.IntPtr pBuffer,
        out uint iBytesReturned);

    [DllImport("wtsapi32.dll")]
    static extern void WTSFreeMemory(
        IntPtr pMemory);
    #endregion

    #region Structures
    //Structure for Terminal Service Client IP Address
    [StructLayout(LayoutKind.Sequential)]
    private struct WTS_CLIENT_ADDRESS
    {
        public int iAddressFamily;
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 20)]
        public byte[] bAddress;
    }

    //Structure for Terminal Service Session Info
    [StructLayout(LayoutKind.Sequential)]
    private struct WTS_SESSION_INFO
    {
        public int iSessionID;
        [MarshalAs(UnmanagedType.LPStr)]
        public string sWinsWorkstationName;
        public WTS_CONNECTSTATE_CLASS oState;
    }

    //Structure for Terminal Service Session Client Display
    [StructLayout(LayoutKind.Sequential)]
    private struct WTS_CLIENT_DISPLAY
    {
        public int iHorizontalResolution;
        public int iVerticalResolution;
        public int iColorDepth;
    }
    #endregion

    #region Enumurations
    public enum WTS_CONNECTSTATE_CLASS
    {
        WTSActive,
        WTSConnected,
        WTSConnectQuery,
        WTSShadow,
        WTSDisconnected,
        WTSIdle,
        WTSListen,
        WTSReset,
        WTSDown,
        WTSInit
    }

    public enum WTS_INFO_CLASS
    {
        WTSInitialProgram,
        WTSApplicationName,
        WTSWorkingDirectory,
        WTSOEMId,
        WTSSessionId,
        WTSUserName,
        WTSWinStationName,
        WTSDomainName,
        WTSConnectState,
        WTSClientBuildNumber,
        WTSClientName,
        WTSClientDirectory,
        WTSClientProductId,
        WTSClientHardwareId,
        WTSClientAddress,
        WTSClientDisplay,
        WTSClientProtocolType,
        WTSIdleTime,
        WTSLogonTime,
        WTSIncomingBytes,
        WTSOutgoingBytes,
        WTSIncomingFrames,
        WTSOutgoingFrames,
        WTSClientInfo,
        WTSSessionInfo,
        WTSConfigInfo,
        WTSValidationInfo,
        WTSSessionAddressV4,
        WTSIsRemoteSession
    }
    #endregion

    public static int sessid()
    {              
        System.IntPtr buffer = IntPtr.Zero;
        uint bytesReturned;
        int sessionID;
        bool sessionInfo = WTSQuerySessionInformation(System.IntPtr.Zero, WTS_CURRENT_SESSION, WTS_INFO_CLASS.WTSSessionId, out buffer, out bytesReturned);
        sessionID = Marshal.ReadInt32(buffer);
        return sessionID;
    }

}
}
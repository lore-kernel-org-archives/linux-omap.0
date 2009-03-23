From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH 1/3] DSPBRIDGE: cleaning up the irq mailbox
 functions and related stuff
Date: Mon, 23 Mar 2009 16:06:08 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2B12B@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37495 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbZCWVGQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 17:06:16 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2NL69VQ006997
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 16:06:14 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2NL69HJ029103
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 16:06:09 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 23 Mar 2009 13:18:46 -0500
Subject: [PATCH] DSPBRIDGE: cleaning up the irq mailbox functions and related stuff

This patch cleans up the irq mailbox functions and related stuff.
Among the sem-functional changes are:
 * Avoid udelay and use time_after
 * Print an error when timing out

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h |   42 -----
 arch/arm/plat-omap/include/dspbridge/io_sm.h   |    3 -
 arch/arm/plat-omap/include/dspbridge/util.h    |   51 ------
 drivers/dsp/bridge/hw/hw_mbox.c                |   23 +--
 drivers/dsp/bridge/hw/hw_mbox.h                |    8 +-
 drivers/dsp/bridge/wmd/_tiomap.h               |   23 ---
 drivers/dsp/bridge/wmd/_tiomap_pwr.h           |    4 -
 drivers/dsp/bridge/wmd/_tiomap_util.h          |    1 -
 drivers/dsp/bridge/wmd/io_sm.c                 |   79 +--------
 drivers/dsp/bridge/wmd/tiomap3430.c            |   20 +--
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   22 ++--
 drivers/dsp/bridge/wmd/tiomap_sm.c             |  220 ++++++------------------
 12 files changed, 88 insertions(+), 408 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/include/dspbridge/chnl_sm.h
 mode change 100644 => 100755 arch/arm/plat-omap/include/dspbridge/util.h
 mode change 100644 => 100755 drivers/dsp/bridge/hw/hw_mbox.c
 mode change 100644 => 100755 drivers/dsp/bridge/hw/hw_mbox.h
 mode change 100644 => 100755 drivers/dsp/bridge/wmd/io_sm.c
 mode change 100644 => 100755 drivers/dsp/bridge/wmd/tiomap3430.c
 mode change 100644 => 100755 drivers/dsp/bridge/wmd/tiomap_sm.c

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
old mode 100644
new mode 100755
index 80d8006..682f3bf
--- a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
@@ -23,9 +23,7 @@
  *
  *  Public Functions:
  *      CHNLSM_DisableInterrupt;
- *      CHNLSM_DPC;
  *      CHNLSM_EnableInterrupt;
- *      CHNLSM_InterruptDSP;
  *      CHNLSM_ISR;
  *      CHNLSM_Read;
  *      CHNLSM_UpdateSHMLength;
@@ -36,15 +34,6 @@
  *      Currently, CHNLSM_Read() and CHNLSM_Write() are not called, but must
  *      be defined to link.
  *
- *! Revision History:
- *! ================
- *! 06-Jan-2002 ag: Added CHNLSM_InterruptDSP2 to set Mailbox value.
- *! 05-Nov-2001 kc: Updated CHNLSM_ISR to read value returned by interrupt.
- *! 21-Jan-2000 ag: Updated comments per code review.
- *! 18-Dec-1997 gp: Added CDECL.
- *! 16-Jun-1997 gp: Added function UpdateSHMLength().
- *! 13-Nov-1996 gp: Renamed CHNL_ to CHNLSM_.
- *! 10-Jul-1996 gp: Created.
  */

 #ifndef CHNLSM_
@@ -66,22 +55,6 @@
                                                        hDevContext);

 /*
- *  ======== CHNLSM_DPC ========
- *  Purpose:
- *      This mini-driver's deferred processing routine.  Finishes processing
- *      deferred by the WMD's ISR.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *  Returns:
- *  Requires:
- *      Must not block.
- *      Must not acquire resources.
- *      All data objects touched must be locked in memory.
- *  Ensures:
- */
-       extern void CHNLSM_DPC(struct WMD_DEV_CONTEXT *hDevContext);
-
-/*
  *  ======== CHNLSM_EnableInterrupt ========
  *  Purpose:
  *      Enable interrupts from the DSP board to the PC.
@@ -95,21 +68,6 @@
                                                       hDevContext);

 /*
- *  ======== CHNLSM_InterruptDSP ========
- *  Purpose:
- *      Send an interrupt to the DSP processor(s).
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *  Returns:
- *      DSP_SOK:        Interrupt sent;
- *      else:           Unable to send interrupt.
- *  Requires:
- *  Ensures:
- */
-       extern DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT*
-                                                   hDevContext);
-
-/*
  *  ======== CHNLSM_InterruptDSP2 ========
  *  Purpose:
  *      Set interrupt value & send an interrupt to the DSP processor(s).
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index b29924c..ed87dd6 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -77,9 +77,6 @@

 #define IO_DisableInterrupt(h)  CHNLSM_DisableInterrupt(h)
 #define IO_EnableInterrupt(h)   CHNLSM_EnableInterrupt(h)
-#define IO_InterruptDSP(h)      CHNLSM_InterruptDSP(h)
-#define IO_InterruptDSP2(h, v)  CHNLSM_InterruptDSP2(h, v)
-#define IO_CALLDPC(h)           CHNLSM_DPC(h)
 #define IO_CALLISR(h, pFlag, pwMBRegVal)   CHNLSM_ISR(h, pFlag, pwMBRegVal)

 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/util.h b/arch/arm/plat-omap/include/dspbridge/util.h
old mode 100644
new mode 100755
index f7f2c24..e6815ca
--- a/arch/arm/plat-omap/include/dspbridge/util.h
+++ b/arch/arm/plat-omap/include/dspbridge/util.h
@@ -26,25 +26,6 @@
  *      UTIL_Exit
  *      UTIL_GetSysInfo
  *      UTIL_Init
- *      UTIL_Wait
- *
- *  Private Functions:
- *      isspace
- *
- *  Notes:
- *
- *! Revision History
- *! ================
- *! 12-Aug-2000 ag: Added UTIL_GetSysInfo().
- *! 31-Jan-2000 rr: Comments modifed for UTIL_Wait fxn.
- *! 17-Jan-2000 rr: UTIL_Wait fxn added. Busy waits x number of micro seconds.
- *! 12-Nov-1999 kc: Modified UTIL_CmdLineToArgs for use by different tests.
- *! 02-Nov-1999 kc: Removed parameter from UTIL_CDTestDll.
- *! 29-Oct-1999 kc: Cleaned up for code review.
- *! 08-Oct-1999 kc: Renamed UTIL_TestDllExec to UTIL_CDTestDll; added
- *!                 UTIL_CmdLineToArgs(); added isspace private func.
- *! 26-Dec-1996 cr: Created from misc pieces of wcd95.c, ktest.c.
- *
  */

 #ifndef _UTIL_H
@@ -138,36 +119,4 @@
                return true;
        }

-/*
- *  ======== UTIL_Wait ========
- *  Purpose:
- *      This fucntion busy waits given a certain number of micro seconds
- *      independent of the processor speed. This is acheived by the
- *      OEM functions QueryPerformanceCounter and QueryPerformanceFrequency.
- *  Parameters:
- *      u32   Number of Micro seconds to busy wait
- *  Returns:
- *          Nothing
- *  Requires:
- *          UTIL_Initalized.
- *  Ensures:
- *      Busy waits x Micro seconds or Sleeps X milli seconds; in that
- *      case, it is a blocking call there will be a context switching
- *      hence it may not represent the absolute busy wait time.
- */
-       extern inline void UTIL_Wait(IN u32 dwMicroSeconds)
-       {
-               if (dwMicroSeconds / 1000 <= 1) {
-                       /* <= 1 millisecond delay */
-                       udelay(dwMicroSeconds);
-               } else if (dwMicroSeconds * HZ / 1000000 <= 1) {
-                       /* <= 10 millisecond delay */
-                       mdelay(dwMicroSeconds / 1000);
-               } else {
-                       /* > 10 millisecond delay */
-                       set_current_state(TASK_INTERRUPTIBLE);
-                       schedule_timeout(dwMicroSeconds * HZ / 1000000);
-               }
-       }
-
 #endif                         /* _UTIL_H */
diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
old mode 100644
new mode 100755
index bc61d64..f880412
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -105,28 +105,11 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 }

 /* Reads the full status register for mailbox. */
-HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-                       u32 *const pIsFull)
+inline bool HW_MBOX_IsFull(const void __iomem *baseAddress,
+       const HW_MBOX_Id_t mailBoxId)
 {
-       HW_STATUS status = RET_OK;
-       u32 fullStatus;
-
-       /* Check input parameters */
-       CHECK_INPUT_PARAM(baseAddress, 0, RET_BAD_NULL_PARAM, RES_MBOX_BASE +
-                       RES_INVALID_INPUT_PARAM);
-       CHECK_INPUT_PARAM(pIsFull,  NULL, RET_BAD_NULL_PARAM, RES_MBOX_BASE +
-                       RES_INVALID_INPUT_PARAM);
-       CHECK_INPUT_RANGE_MIN0(mailBoxId, HW_MBOX_ID_MAX, RET_INVALID_ID,
-                       RES_MBOX_BASE + RES_INVALID_INPUT_PARAM);
-
-       /* read the is full status parameter for Mailbox */
-       fullStatus = MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress,
+       return MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress,
                                                        (u32)mailBoxId);
-
-       /* fill in return parameter */
-       *pIsFull = (fullStatus & 0xFF);
-
-       return status;
 }

 /* Gets number of messages in a specified mailbox. */
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
old mode 100644
new mode 100755
index 225fb40..89c323a
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -158,11 +158,9 @@ extern HW_STATUS HW_MBOX_MsgWrite(
 *
 * PURPOSE:      : this function reads the full status register for mailbox.
 */
-extern HW_STATUS HW_MBOX_IsFull(
-                     const u32  baseAddress,
-                     const HW_MBOX_Id_t   mailBoxId,
-                     u32 *const        pIsFull
-                 );
+extern inline bool HW_MBOX_IsFull(
+                     const void __iomem *baseAddress,
+                     const HW_MBOX_Id_t   mailBoxId);

 /*
 * FUNCTION      : HW_MBOX_NumMsgGet
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 5267eb2..815f695 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -19,28 +19,6 @@
  *  Description:
  *      Definitions and types private to this WMD.
  *
- *! Revision History
- *! ================
- *! 12-Apr-2004 hp:  Removed the L4 entry of Dsp DMA , not needed
- *! 08-Mar-2004 sb:  Added the Dynamic Memory Mapping feature - PgTableAttrs
- *! 21-Mar-2003 sb:  Added numTLBEntries to struct WMD_DEV_CONTEXT
- *! 20-Feb-2003 vp:  Ported to Linux platform.
- *! 30-Jul-2002 rr:  Modified TBC_ID_VALUE to 0xb47002f.
- *! 10-May-2002 sg:  Added ARM_SYSST_OFFSET and IDLE_DSP_MASK.
- *! 14-Mar-2002 rr:  Added Boot vector field to pDevContext.
- *!                  Added TBC Register defines and value for OMAP1510.
- *! 12-Jan-2002 ag:  wIntrVal2Dsp Added.
- *! 05-Nov-2001 kc:  Added MMU fault related definitions.
- *! 03-Aug-2001 ag   Added TLB table for OEM cofig of DSP-MMU.
- *! 23-Aug-2001 rr:  Added API_SIZE define.
- *! 16-Aug-2001 rr:  Added dwDspExtBaseAddr to access the Ext memory.
- *! 24-Jul-2001 ag:  Added Internal SRAM MMU table entry.
- *! 27-Jun-2001 rr:  Name changed to _tihelen.h.
- *! 27-Jun-2001 ag:  Added dwIntAddr in WMD_DEV_CONTEXT used for MB INTRs msk.
- *! 07-May-2001 ag:  Added DSP Clock Module CLKM2.
- *!                  Added TIHEL_SDRAMPHYSBASE used for DSP MMU init.
- *!                  Added ClearBit() MACRO.
- *! 18-Jan-2001 rr:  Created
  */

 #ifndef _TIOMAP_
@@ -383,7 +361,6 @@ struct WMD_DEV_CONTEXT {
        u32 dwBrdState; /* Last known board state.      */
        u32 ulIntMask;  /* int mask                     */
        u16 ioBase;     /* Board I/O base               */
-       u16 wIntrVal2Dsp;       /* MBX value to DSP. See mbx_sh.h */
        u32 numTLBEntries;      /* DSP MMU TLB entry counter    */
        u32 fixedTLBEntries;    /* Fixed DSPMMU TLB entry count */

diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
index 15ff2d3..8a7cf1b 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
@@ -28,10 +28,6 @@
 #ifndef _TIOMAP_PWR_
 #define _TIOMAP_PWR_

-/* Wait time between MBX and IDLE checks for PWR */
-#define PWR_WAIT_USECS          500
-#define PWR_WAIT_MSECS          50
-
 /*
  * ======== WakeDSP =========
  * Wakes up the DSP from DeepSleep
diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/wmd/_tiomap_util.h
index b655409..47e1e5d 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_util.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
@@ -30,7 +30,6 @@

 /* Time out Values in uSeconds*/
 #define TIHELEN_ACKTIMEOUT  10000
-#define TIHELEN_WRITE_DELAY 10

 /*  Time delay for HOM->SAM transition. */
 #define  WAIT_SAM   1000000    /* in usec (1000 millisec) */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
old mode 100644
new mode 100755
index 3fae1fc..bd936eb
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -43,70 +43,6 @@
  *      which may cause timeouts and/or failure of the WIN32_WaitSingleObject
  *      function (SYNC_WaitOnEvent).
  *
- *! Revision History:
- *! ================
- *! 28-Apr-2004 vp: Updated IVA MMU entries based on Aptix validation.
- *! 19-Apr-2004 sb: Clear MBX_DEH_RESET from hIOMgr->wIntrVal to prevent
-                   DEH when MPU invokes DPC before next DSP interrupt.
-                   Revert back GP timer mapping endianness to LE
- *! 22-Apr-2004 sb: Fixed SHM & peripherals endianness settings for 2420
-                   Optimized num. of SHM entries for any SHM size.
- *! 08-Mar-2004 sb: Updated HW_MMU page size macros
- *! 09-Feb-2004 vp: Updated for IVA link driver.
- *! 05-Jan-2004 vp: Updated for the 24xx platform.
- *! 23-Apr-2003 sb: Fixed mailbox deadlock
- *! 13-Apr-2003 vp: Updated to support TC Word Swap option.
- *! 21-Mar-2003 sb: OEM configuration updates
- *! 24-Feb-2003 vp: Code Review Updates.
- *! 18-Oct-2002 sb: Ported to Linux platform
- *! 28-Mar-2002 jeh Assume word addresses for SHM, MSG, ... symbol values.
- *! 25-Jan-2002 ag  bDspAck incorrectly set in IO_DDZCDispatchChnl()
- *! 05-Jan-2002 ag  Set MBX value to DSP using IO_InterruptDSP2().
- *!             Check for CHNL_STATECANCEL in ACK processing.
- *! 20-Dec-2001 ag  Removed #ifdef CHNL_NOIPCINTR & CHNL_PREOMAP for DSP-DMA.
- *!             Removed unused fxn GetDDMAChnl().
- *! 11-Dec-2001 ag  Fix in DDMA_Dispatch for multi-bufs.
- *! 06-Nov-2001 ag  DSP-DMA I/O processing support added.
- *! 05-Nov-2001 kc  Updated to support DEH module.
- *! 18-Sep-2001 ag  Using virtual cached addressing for SM.
- *! 29-Aug-2001 ag  User SM regions registered during prog load.
- *! 10-Aug-2001 ag  Removed dependency on platform\inc\Config.h.
- *!             MMU setup OnLoaded & per DEV context.
- *! 08-May-2001 ag  Don't SwapWord if TIHELEN.
- *! 31-May-2001 ag  Fixed bug in pInput calc.
- *! 21-May-2001 ag  Helen SM uses TICFG_BRIDGE_DATA_BASE[SIZE] in Config.h.
- *! 04-May-2001 jeh Replaced CHNL_PREOMAP with CHNL_OMAP, added CHNL_HELEN.
- *!             Cleaned up WMD_IO_OnLoaded a bit.
- *! 10-Apr-2001 rr: Replaced DBG_ENTER with DBG_LEVEL3.
- *! 28-Mar-2001 ag  Added CHNL_NOIPCINTR. Disables IPC INTR handling.
- *! 16-Feb-2001 jeh Messaging disabled for PREOMAP.
- *! 16-Dec-2000 ag  IO_DispatchMsg() enabled for PreOMAP.
- *!             SM must be in last 4 Meg region SDRAM for PreOMAP.
- *! 14-Dec-2000 jeh Now reads SM addresses from COFF for PreOMAP.
- *! 04-Dec-2000 jeh Bug fixes for messaging.
- *! 20-Nov-2000 jeh Updated to handle messaging.
- *! 23-Oct-2000 jeh Added notifications of IO complete and end of stream for
- *!             DSPStream support. Pass arg in SHM structure.
- *! 07-Jul-2000 rr: Changed Prefix proc to prcs for Process module.
- *! 03-Feb-2000 rr: DBG statements during fxn entry added.
- *! 21-Jan-2000 ag: Clean-up per code review.
- *! 10-Dev-1999 ag: Added critical section in IO_Dispatch() to protect IOCL/IOR.
- *!             Removed DBC_Asserts after cancelled/closed channels.
- *!             Replaced x86 specific __asm int 3 with DBC_Assert(false);
- *! 12-Nov-1999 ag: Removed some warnings when compiling for 16 bit targets.
- *!             (See #if _CHNL_WORDSIZE).
- *! 04-Nov-1999 ag: WinCE port.
- *! 25-May-1999 jg: Test that CHNL_IOCLASS boards have a loaded program with
- *!             a defined shared memory buffer.
- *! 09-Jul-1997 gp: Added some checks for validity of SHM control block values.
- *! 17-Jan-1997 db: Added capability to log shared memory header.
- *! 15-Jan-1997 gp: Code Review mods: moved static dwLastId to CHNL_MGR object.
- *! 03-Jan-1997 gp: Added call to CHNLSM_DPC from IO_DPC. Check for ISR failing
- *!             to process interrupt on a non-shared IRQ line.
- *! 10-Dec-1996 gp: Added EOS notification on input channel (CHNL_MODEFROMDSP).
- *! 27-Nov-1996 gp: Fixed bug in IO_Dispatch(), which fixed flushing.
- *! 23-Oct-1996 gp: Ensure client buffer bounds are not overrun on input.
- *! 12-Aug-1996 gp: Created.
  */

 /*  ----------------------------------- Host OS */
@@ -936,7 +872,7 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
        IO_AndValue(pIOMgr->hWmdContext, struct SHM, sm, hostFreeMask,
                   (~(1 << ulChnl)));

-       IO_InterruptDSP(pIOMgr->hWmdContext);
+       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 }

 /*
@@ -1064,8 +1000,6 @@ void IO_DPC(IN OUT void *pRefData)
                        WMD_DEH_Notify(hDehMgr, DSP_SYSERROR, pIOMgr->wIntrVal);

        }
-       /* Call WMD's DPC: */
-       IO_CALLDPC(pIOMgr->hWmdContext);
        IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
 #ifdef CHNL_MESSAGES
        if (pMsgMgr) {
@@ -1314,7 +1248,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
        if (fClearChnl) {
                /* Indicate to the DSP we have read the input: */
                IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, inputFull, 0);
-               IO_InterruptDSP(pIOMgr->hWmdContext);
+               CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
        }
        if (fNotifyClient) {
                /* Notify client with IO completion record:  */
@@ -1416,7 +1350,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                           true);
                IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, postSWI,
                           true);
-               IO_InterruptDSP(pIOMgr->hWmdContext);
+               CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
        }
 }

@@ -1519,7 +1453,7 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 #endif
        IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, outputFull, 1);
        /* Indicate to the DSP we have written the output: */
-       IO_InterruptDSP(pIOMgr->hWmdContext);
+       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
        /* Notify client with IO completion record (keep EOS) */
        pChirp->status &= CHNL_IOCSTATEOS;
        NotifyChnlComplete(pChnl, pChirp);
@@ -1606,7 +1540,8 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                        IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
                                   postSWI, true);
                        /* Tell the DSP we have written the output. */
-                       IO_InterruptDSP(pIOMgr->hWmdContext);
+                       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext,
+                                       MBX_PCPY_CLASS);
                }
        }
 }
@@ -1737,7 +1672,7 @@ static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
 /* ZCPY IO routines. */
 void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal)
 {
-       IO_InterruptDSP2(pIOMgr->hWmdContext, wMbVal);
+       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, wMbVal);
 }

 /*
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
old mode 100644
new mode 100755
index 730f9b5..aa71a98
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -459,9 +459,9 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                /* Reset and Unreset the RST2, so that BOOTADDR is copied to
                 * IVA2 SYSC register */
                HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
-               UTIL_Wait(100);
+               udelay(100);
                HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
-               UTIL_Wait(100);
+               udelay(100);
                DBG_Trace(DBG_LEVEL6, "WMD_BRD_Start 0 ****** \n");
                GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
                /* Disbale the DSP MMU */
@@ -734,11 +734,11 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
        HW_PWRST_IVA2RegGet(resources.dwPrmBase, &dspPwrState);
        if (dspPwrState != HW_PWR_STATE_OFF) {

-                       IO_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
+               CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);

-                       UTIL_Wait(10000);       /* 10 msec */
+               mdelay(10);

-                       GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
+               GetHWRegs(resources.dwPrmBase, resources.dwCmBase);

                run_IdleBoot(resources.dwPrmBase, resources.dwCmBase,
                             resources.dwSysCtrlBase);
@@ -1034,8 +1034,6 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,

        if (DSP_SUCCEEDED(status)) {
                /* Set the Endianism Register */ /* Need to set this */
-               /* default to Proc-copy */
-               pDevContext->wIntrVal2Dsp = MBX_PCPY_CLASS;
                /* Retrieve the TC u16 SWAP Option */
                status = REG_GetValue(NULL, CURRENTCONFIG, TCWORDSWAP,
                                     (u8 *)&tcWordSwap, &tcWordSwapSize);
@@ -1052,7 +1050,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
                                 "WMD_DEV_create:Reset mail box and "
                                 "enable the clock Fail\n");
                }
-               UTIL_Wait(5);
+               udelay(5);
                /* 24xx-Linux MMU address is obtained from the host
                 * resources struct */
                pDevContext->dwDSPMmuBase = resources.dwDmmuBase;
@@ -1578,7 +1576,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
         /* It is better to flush the TLB here, so that any stale old entries
         * get flushed */
 EXIT_LOOP:
-       IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+       CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
        HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
        DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
                  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
@@ -2063,7 +2061,7 @@ func_cont:
         * repetition while mapping non-contiguous physical regions of a virtual
         * region */
        /* Waking up DSP before calling TLB Flush */
-       IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+       CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
        HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
        DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap  at end status %x\n", status);
        return status;
@@ -2179,7 +2177,7 @@ bool WaitForStart(struct WMD_DEV_CONTEXT *pDevContext, u32 dwSyncAddr)

        /*  Wait for response from board */
        while (*((volatile u16 *)dwSyncAddr) && --usCount)
-               UTIL_Wait(TIHELEN_WRITE_DELAY);
+               udelay(10);

        /*  If timed out: return FALSE */
        if (!usCount) {
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 623cc9b..25ea6db 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -141,7 +141,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
        /* Wait for DSP to move into Off state,  how much time should
         * we wait? */
        while ((pwrState != HW_PWR_STATE_OFF) && --usCount) {
-               UTIL_Wait(PWR_WAIT_USECS);
+               udelay(500);
                HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
                                    &pwrState);
        }
@@ -239,23 +239,23 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
        case BRD_RUNNING:
                status = HW_MBOX_saveSettings(resources.dwMboxBase);
                if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
-                       IO_InterruptDSP2(pDevContext,
-                                        MBX_PM_DSPHIBERNATE);
+                       CHNLSM_InterruptDSP2(pDevContext,
+                                            MBX_PM_DSPHIBERNATE);
                        DBG_Trace(DBG_LEVEL7,
                                 "SleepDSP - Sent hibernate "
                                 "command to DSP\n");
                        targetPwrState = HW_PWR_STATE_OFF;
                } else {
-                       IO_InterruptDSP2(pDevContext,
-                                        MBX_PM_DSPRETENTION);
+                       CHNLSM_InterruptDSP2(pDevContext,
+                                            MBX_PM_DSPRETENTION);
                        targetPwrState = HW_PWR_STATE_RET;
                }
                break;
        case BRD_RETENTION:
                status = HW_MBOX_saveSettings(resources.dwMboxBase);
                if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
-                       IO_InterruptDSP2(pDevContext,
-                                        MBX_PM_DSPHIBERNATE);
+                       CHNLSM_InterruptDSP2(pDevContext,
+                                            MBX_PM_DSPHIBERNATE);
                        targetPwrState = HW_PWR_STATE_OFF;
                } else
                        return DSP_SOK;
@@ -281,7 +281,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
        /* Wait for DSP to move into Standby state,  how much time
         * should we wait?*/
        while ((pwrState != targetPwrState) && --usCount) {
-               UTIL_Wait(PWR_WAIT_USECS);
+               udelay(500);
                HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
                                    &pwrState);
        }
@@ -339,7 +339,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
        udelay(10);
        if (DSP_SUCCEEDED(status)) {
                /* Send a message to DSP to wake up */
-               IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+               CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
                HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
                                    &pwrState);
                DBG_Trace(DBG_LEVEL7,
@@ -464,7 +464,7 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                /* Send a prenotificatio to DSP */
                DBG_Trace(DBG_LEVEL7,
                         "PreScale_DSP: Sent notification to DSP\n");
-               IO_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
+               CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
                return DSP_SOK;
        } else {
                DBG_Trace(DBG_LEVEL7, "PreScale_DSP: Failed - DSP BRD"
@@ -510,7 +510,7 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                /* Update the OPP value in shared memory */
                IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
                /* Send a post notification to DSP */
-               IO_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
+               CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
                DBG_Trace(DBG_LEVEL7,
                         "PostScale_DSP: Wrote to shared memory Sent post"
                         " notification to DSP\n");
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
old mode 100644
new mode 100755
index edc3bcf..91930a8
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -1,10 +1,8 @@
 /*
- * tiomap_sm.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
+ * Implements lower edge channel class library functions.
+ *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -14,57 +12,16 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */

-/*
- *  ======== tiomap_sm.c ========
- *  Description:
- *      Implements lower edge channel class library functions.
- *
- *! Revision History:
- *! ================
- *! 05-Jan-2004 vp    Updated for the new HW library for 24xx platform.
- *! 12-Feb-2004 hp    use 'CFG_GetHostResources' to fetch virtual addresses of
- *!           PRCM, dMMU components.
- *! 08-Oct-2002 rr    Renamed to tiomap1510_sm.c
- *! 15-Feb-2002 ag    Remove #include <pkfuncs.h> & util.h.
- *! 07-Jan-2001 ag    Set DSP MBX val (to DSP) contained in DEV context.
- *! 05-Nov-2001 kc:   Modified CHNLSM_ISR to read mailbox1 interrupt values
- *! 26-Sep-2001 rr:   InterruptDSP does not spin forever for retail build.
- *! 29-Aug-2001 rr:   Cleaned up the non referenced variables.
- *! 26-Jul-2001 jeh   Enable interrupt to DSP.
- *! 28-Jun-2001 ag    Disable INTR gen to DSP in CHNLSM_InterruptDSP().
- *! 26-Jun-2001 ag    Added INTR support.
- *! 17-May-2000 ag    Initial. No INTR support.
- */
-
-/*  ----------------------------------- Host OS */
-#include <dspbridge/host_os.h>
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>

-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbg.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
-#include <dspbridge/util.h>
-
-/*  ----------------------------------- Mini Driver */
-#include <dspbridge/wmd.h>
-
-/*  ----------------------------------- Platform Manager */
-#include <dspbridge/wcd.h>
 #include <dspbridge/dev.h>

-/* ------------------------------------ Hardware Abstraction Layer */
-#include <hw_defs.h>
-#include <hw_mbox.h>
+#include <dspbridge/dbg.h>

-/*  ----------------------------------- This */
 #include "_tiomap.h"
-#include <dspbridge/chnl_sm.h>
 #include "_tiomap_pwr.h"

 #ifndef CONFIG_DISABLE_BRIDGE_PM
@@ -78,24 +35,11 @@ extern struct constraint_handle *dsp_constraint_handle;
 #endif
 #endif

-/*  ----------------------------------- Defines, Data Structures, Typedefs */
-#ifndef DEBUG
-#define TIHELEN_INT_TIMEOUT     1
-#define LOOP_COUNT              1000000
-#endif
-
 extern struct MAILBOX_CONTEXT mboxsetting;
-extern DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT
-                                            *pDevContext, IN void *pArgs);
-/*
- *  ======== CHNLSM_EnableInterrupt ========
- *      Enables interrupts from DSP.
- */
-DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
+
+DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 {
        DSP_STATUS status = DSP_SOK;
-       HW_STATUS hwStatus;
-       struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
        u32 numMbxMsg;
        u32 mbxValue;
        struct CFG_HOSTRES resources;
@@ -106,89 +50,72 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)

        /* Read the messages in the mailbox until the message queue is empty */

-       status = CFG_GetHostResources(
-                       (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-                       &resources);
-       status = DEV_GetDevType(pDevContext->hDevObject, &devType);
+       CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+                            &resources);
+       DEV_GetDevType(pDevContext->hDevObject, &devType);
        status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
        if (devType == DSP_UNIT) {
-               hwStatus = HW_MBOX_NumMsgGet(resources.dwMboxBase,
-                                              MBOX_DSP2ARM, &numMbxMsg);
+               HW_MBOX_NumMsgGet(resources.dwMboxBase,
+                                 MBOX_DSP2ARM, &numMbxMsg);
                while (numMbxMsg != 0) {
-                       hwStatus = HW_MBOX_MsgRead(resources.dwMboxBase,
-                                                    MBOX_DSP2ARM,
-                                                    &mbxValue);
+                       HW_MBOX_MsgRead(resources.dwMboxBase,
+                                       MBOX_DSP2ARM,
+                                       &mbxValue);
                        numMbxMsg--;
                }
                /* clear the DSP mailbox as well...*/
-               hwStatus = HW_MBOX_NumMsgGet(resources.dwMboxBase,
-                                              MBOX_ARM2DSP, &numMbxMsg);
+               HW_MBOX_NumMsgGet(resources.dwMboxBase,
+                                 MBOX_ARM2DSP, &numMbxMsg);
                while (numMbxMsg != 0) {
-                       hwStatus = HW_MBOX_MsgRead(resources.dwMboxBase,
-                                                   MBOX_ARM2DSP, &mbxValue);
+                       HW_MBOX_MsgRead(resources.dwMboxBase,
+                                       MBOX_ARM2DSP, &mbxValue);
                        numMbxMsg--;
-                       UTIL_Wait(10);
+                       udelay(10);

                        HW_MBOX_EventAck(resources.dwMboxBase, MBOX_ARM2DSP,
-                                         HW_MBOX_U1_DSP1,
-                                         HW_MBOX_INT_NEW_MSG);
+                                        HW_MBOX_U1_DSP1,
+                                        HW_MBOX_INT_NEW_MSG);
                }
                /* Enable the new message events on this IRQ line */
-               hwStatus = HW_MBOX_EventEnable(resources.dwMboxBase,
-                                                MBOX_DSP2ARM,
-                                                MBOX_ARM,
-                                                HW_MBOX_INT_NEW_MSG);
+               HW_MBOX_EventEnable(resources.dwMboxBase,
+                                   MBOX_DSP2ARM,
+                                   MBOX_ARM,
+                                   HW_MBOX_INT_NEW_MSG);
        }

        return status;
 }

-/*
- *  ======== CHNLSM_DisableInterrupt ========
- *      Disables interrupts from DSP.
- */
-DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
+DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 {
-       DSP_STATUS status = DSP_SOK;
-       HW_STATUS hwStatus;
        struct CFG_HOSTRES resources;

-       DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", hDevContext);
+       DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", pDevContext);

-       status = CFG_GetHostResources(
-                       (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-                       &resources);
-       hwStatus = HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
-                                         MBOX_ARM, HW_MBOX_INT_NEW_MSG);
-       return status;
+       CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+                            &resources);
+       HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
+                            MBOX_ARM, HW_MBOX_INT_NEW_MSG);
+       return DSP_SOK;
 }

-/*
- *  ======== CHNLSM_InterruptDSP ========
- *      Send an interrupt to the DSP processor(s).
- */
-DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
+DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
+                               u16 wMbVal)
 {
-       DSP_STATUS status = DSP_SOK;
-       struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 #ifndef CONFIG_DISABLE_BRIDGE_DVFS
        u32 opplevel;
 #endif
 #endif
-       HW_STATUS hwStatus;
-       u32 mbxFull;
        struct CFG_HOSTRES resources;
-       u16 cnt = 10;
+       unsigned long timeout;
        u32 temp;
        /* We are waiting indefinitely here. This needs to be fixed in the
         * second phase */
-       status = CFG_GetHostResources(
-                       (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+       CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
                        &resources);

-       if  (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
+       if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
            pDevContext->dwBrdState == BRD_HIBERNATION) {
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 #ifndef CONFIG_DISABLE_BRIDGE_DVFS
@@ -227,7 +154,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
                       (resources.dwDmmuBase) + 0x10));

                /* Restore mailbox settings */
-               status = HW_MBOX_restoreSettings(resources.dwMboxBase);
+               HW_MBOX_restoreSettings(resources.dwMboxBase);
                DBG_Trace(DBG_LEVEL6, "MailBoxSettings: SYSCONFIG = 0x%x\n",
                          mboxsetting.sysconfig);
                DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE0 = 0x%x\n",
@@ -237,73 +164,37 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
                /* Restart the peripheral clocks that were disabled only
                 * in DSP initiated Hibernation case.*/
                if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)
-                       DSP_PeripheralClocks_Enable(hDevContext, NULL);
+                       DSP_PeripheralClocks_Enable(pDevContext, NULL);

                pDevContext->dwBrdState = BRD_RUNNING;
        }
-       while (--cnt) {
-               hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
-                                          MBOX_ARM2DSP, &mbxFull);
-               if (mbxFull)
-                       UTIL_Wait(1000);        /* wait for 1 ms)      */
-               else
-                       break;
-       }
-       if (!cnt) {
-               DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
-               status = WMD_E_TIMEOUT;
-               return status;
+       timeout = jiffies + msecs_to_jiffies(10);
+       while (HW_MBOX_IsFull(resources.dwMboxBase, MBOX_ARM2DSP)) {
+               if (time_after(jiffies, timeout)) {
+                       printk(KERN_ERR "dspbridge: "
+                               "timed out waiting for mailbox\n");
+                       return WMD_E_TIMEOUT;
+               }
        }
        DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n",
-                pDevContext->wIntrVal2Dsp);
+                 wMbVal);

-       hwStatus = HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
-                                    pDevContext->wIntrVal2Dsp);
-       /* set the Mailbox interrupt to default value */
-       pDevContext->wIntrVal2Dsp = MBX_PCPY_CLASS;
-       return status;
+       HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
+                        wMbVal);
+       return DSP_SOK;
 }

-/*
- *  ======== CHNLSM_InterruptDSP2 ========
- *      Set MBX value & send an interrupt to the DSP processor(s).
- */
-DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *hDevContext,
-                               u16 wMbVal)
+bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
+               u16 *pwIntrVal)
 {
-       struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-
-       pDevContext->wIntrVal2Dsp = wMbVal;
-
-       return CHNLSM_InterruptDSP(hDevContext);
-}
-
-/*
- *  ======== CHNLSM_DPC ========
- */
-void CHNLSM_DPC(struct WMD_DEV_CONTEXT *hDevContext)
-{
-       DBG_Trace(DBG_ENTER, "CHNLSM_DPC(0x%x)\n", hDevContext);
-}
-
-/*
- *  ======== CHNLSM_ISR ========
- */
-bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
-               OUT u16 *pwIntrVal)
-{
-       bool fMyInterrupt = true;       /*
-                                        * We own the mbx and
-                                        * we're not sharing it
-                                        */
        struct CFG_HOSTRES resources;
        u32 numMbxMsg;
        u32 mbxValue;

-       DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", hDevContext);
+       DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", pDevContext);

-       CFG_GetHostResources(
-               (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+       CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+                               &resources);

        HW_MBOX_NumMsgGet(resources.dwMboxBase, MBOX_DSP2ARM, &numMbxMsg);

@@ -318,6 +209,5 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
        }
        /* Set *pfSchedDPC to true; */
        *pfSchedDPC = true;
-       return fMyInterrupt;
+       return true;
 }
-
--
1.5.6.4


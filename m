From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 01/15] tidspbridge: remove revision history
Date: Wed, 18 Mar 2009 03:22:57 +0200
Message-ID: <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56149 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbZCRBXs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:23:48 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so321490bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:23:46 -0700 (PDT)
In-Reply-To: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Felipe Contreras <felipe.contreras@nokia.com>

No need for that with git.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h |    9 ---
 arch/arm/plat-omap/include/dspbridge/util.h    |   18 -------
 drivers/dsp/bridge/wmd/_tiomap.h               |   22 --------
 drivers/dsp/bridge/wmd/io_sm.c                 |   64 ------------------------
 drivers/dsp/bridge/wmd/tiomap_sm.c             |   15 ------
 5 files changed, 0 insertions(+), 128 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
index fc67cc7..8a9553b 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
@@ -36,15 +36,6 @@
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
diff --git a/arch/arm/plat-omap/include/dspbridge/util.h b/arch/arm/plat-omap/include/dspbridge/util.h
index 3b3e9c0..9d8842a 100644
--- a/arch/arm/plat-omap/include/dspbridge/util.h
+++ b/arch/arm/plat-omap/include/dspbridge/util.h
@@ -27,24 +27,6 @@
  *      UTIL_GetSysInfo
  *      UTIL_Init
  *      UTIL_Wait
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
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 5267eb2..10fd9cd 100644
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
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 037f4f3..7fc4304 100644
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
-		    DEH when MPU invokes DPC before next DSP interrupt.
-		    Revert back GP timer mapping endianness to LE
- *! 22-Apr-2004 sb: Fixed SHM & peripherals endianness settings for 2420
-		    Optimized num. of SHM entries for any SHM size.
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
- *!		 Check for CHNL_STATECANCEL in ACK processing.
- *! 20-Dec-2001 ag  Removed #ifdef CHNL_NOIPCINTR & CHNL_PREOMAP for DSP-DMA.
- *!		 Removed unused fxn GetDDMAChnl().
- *! 11-Dec-2001 ag  Fix in DDMA_Dispatch for multi-bufs.
- *! 06-Nov-2001 ag  DSP-DMA I/O processing support added.
- *! 05-Nov-2001 kc  Updated to support DEH module.
- *! 18-Sep-2001 ag  Using virtual cached addressing for SM.
- *! 29-Aug-2001 ag  User SM regions registered during prog load.
- *! 10-Aug-2001 ag  Removed dependency on platform\inc\Config.h.
- *!		 MMU setup OnLoaded & per DEV context.
- *! 08-May-2001 ag  Don't SwapWord if TIHELEN.
- *! 31-May-2001 ag  Fixed bug in pInput calc.
- *! 21-May-2001 ag  Helen SM uses TICFG_BRIDGE_DATA_BASE[SIZE] in Config.h.
- *! 04-May-2001 jeh Replaced CHNL_PREOMAP with CHNL_OMAP, added CHNL_HELEN.
- *!		 Cleaned up WMD_IO_OnLoaded a bit.
- *! 10-Apr-2001 rr: Replaced DBG_ENTER with DBG_LEVEL3.
- *! 28-Mar-2001 ag  Added CHNL_NOIPCINTR. Disables IPC INTR handling.
- *! 16-Feb-2001 jeh Messaging disabled for PREOMAP.
- *! 16-Dec-2000 ag  IO_DispatchMsg() enabled for PreOMAP.
- *!		 SM must be in last 4 Meg region SDRAM for PreOMAP.
- *! 14-Dec-2000 jeh Now reads SM addresses from COFF for PreOMAP.
- *! 04-Dec-2000 jeh Bug fixes for messaging.
- *! 20-Nov-2000 jeh Updated to handle messaging.
- *! 23-Oct-2000 jeh Added notifications of IO complete and end of stream for
- *!		 DSPStream support. Pass arg in SHM structure.
- *! 07-Jul-2000 rr: Changed Prefix proc to prcs for Process module.
- *! 03-Feb-2000 rr: DBG statements during fxn entry added.
- *! 21-Jan-2000 ag: Clean-up per code review.
- *! 10-Dev-1999 ag: Added critical section in IO_Dispatch() to protect IOCL/IOR.
- *!		 Removed DBC_Asserts after cancelled/closed channels.
- *!		 Replaced x86 specific __asm int 3 with DBC_Assert(false);
- *! 12-Nov-1999 ag: Removed some warnings when compiling for 16 bit targets.
- *!		 (See #if _CHNL_WORDSIZE).
- *! 04-Nov-1999 ag: WinCE port.
- *! 25-May-1999 jg: Test that CHNL_IOCLASS boards have a loaded program with
- *!		 a defined shared memory buffer.
- *! 09-Jul-1997 gp: Added some checks for validity of SHM control block values.
- *! 17-Jan-1997 db: Added capability to log shared memory header.
- *! 15-Jan-1997 gp: Code Review mods: moved static dwLastId to CHNL_MGR object.
- *! 03-Jan-1997 gp: Added call to CHNLSM_DPC from IO_DPC. Check for ISR failing
- *!		 to process interrupt on a non-shared IRQ line.
- *! 10-Dec-1996 gp: Added EOS notification on input channel (CHNL_MODEFROMDSP).
- *! 27-Nov-1996 gp: Fixed bug in IO_Dispatch(), which fixed flushing.
- *! 23-Oct-1996 gp: Ensure client buffer bounds are not overrun on input.
- *! 12-Aug-1996 gp: Created.
  */
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 9bc5b54..6e258f4 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -19,21 +19,6 @@
  *  Description:
  *      Implements lower edge channel class library functions.
  *
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
  */
 
 /*  ----------------------------------- Host OS */
-- 
1.6.2.1.287.g9a8be


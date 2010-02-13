From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: Remove chnl_sm.h and tiomap_sm.c
Date: Fri, 12 Feb 2010 20:04:38 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18E3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49493 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0BMCEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 21:04:43 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

>From d287e11cdb126f2c9b4be8d6d6f958ffdf7ff716 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 22 Jan 2010 21:46:42 -0600
Subject: [PATCH] DSPBRIDGE: Remove chnl_sm.h and tiomap_sm.c

Because of mailbox migration all the functions in tiomap_sm.c except
one and their prototypes in chnl_sm.h are not needed anymore,
so that function was changed to tiomap_io.c and changed the name
to remove camelcasing

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h |  154 ------------------------
 drivers/dsp/bridge/Makefile                    |    2 +-
 drivers/dsp/bridge/wmd/_tiomap.h               |   18 +++
 drivers/dsp/bridge/wmd/io_sm.c                 |   13 +-
 drivers/dsp/bridge/wmd/tiomap3430.c            |    3 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   13 +-
 drivers/dsp/bridge/wmd/tiomap_io.c             |   71 +++++++++++
 drivers/dsp/bridge/wmd/tiomap_sm.c             |  101 ----------------
 8 files changed, 103 insertions(+), 272 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/chnl_sm.h
 delete mode 100644 drivers/dsp/bridge/wmd/tiomap_sm.c

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
deleted file mode 100644
index e1e3f06..0000000
--- a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * chnl_sm.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Prototypes for channel lower edge functions for a Bridge mini driver
- * implementing data transfer via shared memory.
- *
- * Notes:
- *   These lower edge functions must be implemented by the WMD writer.
- *   Currently, CHNLSM_Read() and CHNLSM_Write() are not called, but must
- *   be defined to link.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-#ifndef CHNLSM_
-#define CHNLSM_
-
-#include <dspbridge/wmd.h>
-
-/*
- *  ======== CHNLSM_DisableInterrupt ========
- *  Purpose:
- *      Disable interrupts from the DSP board to the PC.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *  Returns:
- *  Requires:
- *  Ensures:
- */
-       extern DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT*
-                                                       hDevContext);
-
-/*
- *  ======== CHNLSM_EnableInterrupt ========
- *  Purpose:
- *      Enable interrupts from the DSP board to the PC.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *  Returns:
- *  Requires:
- *  Ensures:
- */
-       extern DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT*
-                                                      hDevContext);
-
-/*
- *  ======== CHNLSM_InterruptDSP2 ========
- *  Purpose:
- *      Set interrupt value & send an interrupt to the DSP processor(s).
- *      This is typicaly used when mailbox interrupt mechanisms allow data
- *      to be associated with interrupt such as for OMAP's CMD/DATA regs.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *      wMbVal:         Value associated with interrupt(e.g. mailbox value).
- *  Returns:
- *      DSP_SOK:        Interrupt sent;
- *      else:           Unable to send interrupt.
- *  Requires:
- *  Ensures:
- */
-       extern DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT*
-                                                    hDevContext, u16 wMbVal);
-
-/*
- *  ======== CHNLSM_ISR ========
- *  Purpose:
- *      Mini-driver's ISR, called by WCD when the board interrupts the host.
- *  Parameters:
- *      hDevContext:    Handle to the mini-driver defined device info.
- *      pfSchedDPC:     Set to TRUE to schedule a deferred procedure call
- *                      to advance the channel protocol.  The channel class
- *                      library will call the WMD's CHNLSM_DPC routine during
- *                      its own DPC, before dispatching I/O.
- *                      The channel class library should ignore *pfSchedDPC when
- *                      CHNLSM_ISR returns FALSE.
- *      pwMBRegVal:     Value of mailbox register.
- *  Returns:
- *      TRUE if this interrupt is was generated by the DSP board.
- *      FALSE otherwise.
- *  Requires:
- *      Interrupts to the host processor are disabled on entry.
- *      Must only call functions which are in page locked memory.
- *      Must only call asynchronous OS services.
- *      The EOI for this interrupt has already been sent to the PIC.
- *  Ensures:
- *      If the interrupt is *not* shared, this routine must return TRUE.
- */
-       extern bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext,
-                                    OUT bool *pfSchedDPC,
-                                    OUT u16 *pwIntrVal);
-
-/*
- *  ======== CHNLSM_Read ========
- *  Purpose:
- *      Read data from DSP board memory into a Host buffer.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *      pHostBuf:       Pointer to host buffer (Destination).
- *      dwDSPAddr:      Address on DSP board (Source).
- *      ulNumBytes:     Number of bytes to transfer.
- *  Returns:
- *  Requires:
- *  Ensures:
- */
-       extern DSP_STATUS CHNLSM_Read(struct WMD_DEV_CONTEXT *hDevContext,
-                                           OUT u8 *pHostBuf,
-                                           u32 dwDSPAddr, u32 ulNumBytes);
-
-/*
- *  ======== CHNLSM_UpdateSHMLength ========
- *  Purpose:
- *      Allow the minidriver a chance to override the SHM length as reported
- *      to the mini driver (chnl_sm.lib) by Windows Plug and Play.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *      pSHMLength:     Pointer to size of SHM window (in DSP words).
- *  Returns:
- *      TRUE if pSHMLength updated; FALSE otherwise.
- *  Requires:
- *      pSHMLength != NULL.
- *  Ensures:
- *      No more than sizeof(u32) bytes written to *pSHMLength
- */
-       extern bool CHNLSM_UpdateSHMLength(struct WMD_DEV_CONTEXT *hDevContext,
-                                          IN OUT u32 *pSHMLength);
-
-/*
- *  ======== CHNLSM_Write ========
- *  Purpose:
- *      Write data from a Host buffer to DSP board memory.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *      pHostBuf:       Pointer to host buffer (Source).
- *      dwDSPAddr:      Address on DSP board (Destination).
- *      ulNumBytes:     Number of bytes to transfer.
- *  Returns:
- *  Requires:
- *  Ensures:
- */
-       extern DSP_STATUS CHNLSM_Write(struct WMD_DEV_CONTEXT *hDevContext,
-                                           IN u8 *pHostBuf,
-                                           u32 dwDSPAddr, u32 ulNumBytes);
-
-#endif                         /* CHNLSM_ */
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index b44a8f3..8ae4d21 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -6,7 +6,7 @@ libservices = services/mem.o services/sync.o \
                services/regsup.o services/ntfy.o \
                services/dbg.o services/services.o
 libwmd = wmd/chnl_sm.o wmd/msg_sm.o wmd/io_sm.o wmd/tiomap3430.o \
-               wmd/tiomap3430_pwr.o wmd/tiomap_sm.o wmd/tiomap_io.o \
+               wmd/tiomap3430_pwr.o wmd/tiomap_io.o \
                wmd/mmu_fault.o wmd/ue_deh.o
 libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/wcd.o \
                pmgr/dmm.o pmgr/cmm.o pmgr/dbll.o
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index c27269b..45ee7c0 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -356,5 +356,23 @@ extern DSP_STATUS WMD_TLB_DspVAToMpuPA(struct WMD_DEV_CONTEXT *pDevContext,
                                       OUT u32 *ulPhysAddr,
                                       OUT u32 *sizeTlb);

+/*
+ *  ======== sm_interrupt_dsp ========
+ *  Purpose:
+ *      Set interrupt value & send an interrupt to the DSP processor(s).
+ *      This is typicaly used when mailbox interrupt mechanisms allow data
+ *      to be associated with interrupt such as for OMAP's CMD/DATA regs.
+ *  Parameters:
+ *      hDevContext:    Handle to mini-driver defined device info.
+ *      wMbVal:         Value associated with interrupt(e.g. mailbox value).
+ *  Returns:
+ *      DSP_SOK:        Interrupt sent;
+ *      else:           Unable to send interrupt.
+ *  Requires:
+ *  Ensures:
+ */
+       extern DSP_STATUS sm_interrupt_dsp(struct WMD_DEV_CONTEXT*
+                                                    hDevContext, u16 wMbVal);
+
 #endif                         /* _TIOMAP_ */

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 037c841..e7776c8 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -59,7 +59,6 @@
 /* Platform Manager */
 #include <dspbridge/cod.h>
 #include <dspbridge/dev.h>
-#include <dspbridge/chnl_sm.h>

 /* Others */
 #include <dspbridge/rms_sh.h>
@@ -824,7 +823,7 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
        IO_AndValue(pIOMgr->hWmdContext, struct SHM, sm, hostFreeMask,
                   (~(1 << ulChnl)));

-       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+       sm_interrupt_dsp(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 func_end:
        return;
 }
@@ -1235,7 +1234,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
        if (fClearChnl) {
                /* Indicate to the DSP we have read the input */
                IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, inputFull, 0);
-               CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+               sm_interrupt_dsp(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
        }
        if (fNotifyClient) {
                /* Notify client with IO completion record */
@@ -1352,7 +1351,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                           true);
                IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, postSWI,
                           true);
-               CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+               sm_interrupt_dsp(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
        }
 func_end:
        return;
@@ -1466,7 +1465,7 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 #endif
        IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, outputFull, 1);
        /* Indicate to the DSP we have written the output */
-       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+       sm_interrupt_dsp(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
        /* Notify client with IO completion record (keep EOS) */
        pChirp->status &= CHNL_IOCSTATEOS;
        NotifyChnlComplete(pChnl, pChirp);
@@ -1560,7 +1559,7 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                        IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
                                   postSWI, true);
                        /* Tell the DSP we have written the output. */
-                       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext,
+                       sm_interrupt_dsp(pIOMgr->hWmdContext,
                                                MBX_PCPY_CLASS);
                }
        }
@@ -1722,7 +1721,7 @@ static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
 /* ZCPY IO routines. */
 void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal)
 {
-       CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, wMbVal);
+       sm_interrupt_dsp(pIOMgr->hWmdContext, wMbVal);
 }

 /*
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 3c08d19..d5d2449 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -55,7 +55,6 @@
 #include <dspbridge/wmdio.h>
 #include <dspbridge/wmdmsg.h>
 #include <dspbridge/pwr.h>
-#include <dspbridge/chnl_sm.h>
 #include <dspbridge/io_sm.h>

 /*  ----------------------------------- Platform Manager */
@@ -812,7 +811,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)

        HW_PWRST_IVA2RegGet(resources.dwPrmBase, &dspPwrState);
        if (dspPwrState != HW_PWR_STATE_OFF && hDevContext->mbox) {
-               CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
+               sm_interrupt_dsp(pDevContext, MBX_PM_DSPIDLE);
                mdelay(10);
                GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
                udelay(50);
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 9388880..bb18d6d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -22,7 +22,6 @@
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/io_sm.h>
-#include <dspbridge/chnl_sm.h>

 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbg.h>
@@ -192,14 +191,14 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
        case BRD_RUNNING:
                omap_mbox_save_ctx(pDevContext->mbox);
                if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
-                       CHNLSM_InterruptDSP2(pDevContext,
+                       sm_interrupt_dsp(pDevContext,
                                             MBX_PM_DSPHIBERNATE);
                        DBG_Trace(DBG_LEVEL7,
                                 "SleepDSP - Sent hibernate "
                                 "command to DSP\n");
                        targetPwrState = HW_PWR_STATE_OFF;
                } else {
-                       CHNLSM_InterruptDSP2(pDevContext,
+                       sm_interrupt_dsp(pDevContext,
                                             MBX_PM_DSPRETENTION);
                        targetPwrState = HW_PWR_STATE_RET;
                }
@@ -207,7 +206,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
        case BRD_RETENTION:
                omap_mbox_save_ctx(pDevContext->mbox);
                if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
-                       CHNLSM_InterruptDSP2(pDevContext,
+                       sm_interrupt_dsp(pDevContext,
                                             MBX_PM_DSPHIBERNATE);
                        targetPwrState = HW_PWR_STATE_OFF;
                } else
@@ -311,7 +310,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
        }

        /* Send a wakeup message to DSP */
-       CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+       sm_interrupt_dsp(pDevContext, MBX_PM_DSPWAKEUP);

 #ifdef CONFIG_BRIDGE_DEBUG
        HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
@@ -469,7 +468,7 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                /* Send a prenotificatio to DSP */
                DBG_Trace(DBG_LEVEL7,
                         "PreScale_DSP: Sent notification to DSP\n");
-               CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
+               sm_interrupt_dsp(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
                return DSP_SOK;
        } else {
                DBG_Trace(DBG_LEVEL7, "PreScale_DSP: Failed - DSP BRD"
@@ -514,7 +513,7 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                /* Update the OPP value in shared memory */
                IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
                /* Send a post notification to DSP */
-               CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
+               sm_interrupt_dsp(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
                DBG_Trace(DBG_LEVEL7,
                        "PostScale_DSP: Wrote to shared memory Sent post"
                        " notification to DSP\n");
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 4e85efd..f8a298b 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -412,3 +412,74 @@ DSP_STATUS WriteExtDspData(struct WMD_DEV_CONTEXT *pDevContext,
        return retVal;
 }

+DSP_STATUS sm_interrupt_dsp(struct WMD_DEV_CONTEXT *pDevContext,
+                               u16 wMbVal)
+{
+#ifdef CONFIG_BRIDGE_DVFS
+       struct dspbridge_platform_data *pdata =
+               omap_dspbridge_dev->dev.platform_data;
+       u32 opplevel = 0;
+#endif
+       struct CFG_HOSTRES resources;
+       DSP_STATUS status = DSP_SOK;
+       u32 temp;
+
+       if (!pDevContext->mbox)
+               return DSP_SOK;
+
+       status = CFG_GetHostResources((struct CFG_DEVNODE *)
+                       DRV_GetFirstDevExtension(), &resources);
+       if (DSP_FAILED(status))
+               return DSP_EFAIL;
+
+       if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
+           pDevContext->dwBrdState == BRD_HIBERNATION) {
+#ifdef CONFIG_BRIDGE_DVFS
+               if (pdata->dsp_get_opp)
+                       opplevel = (*pdata->dsp_get_opp)();
+               if (opplevel == VDD1_OPP1) {
+                       if (pdata->dsp_set_min_opp)
+                               (*pdata->dsp_set_min_opp)(VDD1_OPP2);
+               }
+#endif
+               /* Restart the peripheral clocks */
+               DSP_PeripheralClocks_Enable(pDevContext, NULL);
+
+               /*
+                * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
+                *     in CM_AUTOIDLE_PLL_IVA2 register
+                */
+               *(REG_UWORD32 *)(resources.dwCmBase + 0x34) = 0x1;
+
+               /*
+                * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
+                *     0.75 MHz - 1.0 MHz
+                * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
+                */
+               temp = *(REG_UWORD32 *)(resources.dwCmBase + 0x4);
+               temp = (temp & 0xFFFFFF08) | 0x37;
+               *(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;
+
+               /* Restore mailbox settings */
+               omap_mbox_restore_ctx(pDevContext->mbox);
+
+               /* Access MMU SYS CONFIG register to generate a short wakeup */
+               temp = *(REG_UWORD32 *)(resources.dwDmmuBase + 0x10);
+
+               pDevContext->dwBrdState = BRD_RUNNING;
+       } else if (pDevContext->dwBrdState == BRD_RETENTION) {
+               /* Restart the peripheral clocks */
+               DSP_PeripheralClocks_Enable(pDevContext, NULL);
+       }
+
+       status = omap_mbox_msg_send(pDevContext->mbox, wMbVal);
+
+       if (status) {
+               pr_err("omap_mbox_msg_send Fail and status = %d\n", status);
+               status = DSP_EFAIL;
+       }
+
+       DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n", wMbVal);
+       return DSP_SOK;
+}
+
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
deleted file mode 100644
index de8cb48..0000000
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * tiomap_sm.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-#include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
-
-#include <dspbridge/cfg.h>
-#include <dspbridge/drv.h>
-#include <dspbridge/dev.h>
-
-#include <dspbridge/dbg.h>
-
-#include "_tiomap.h"
-#include "_tiomap_pwr.h"
-
-
-
-DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
-                               u16 wMbVal)
-{
-#ifdef CONFIG_BRIDGE_DVFS
-       struct dspbridge_platform_data *pdata =
-               omap_dspbridge_dev->dev.platform_data;
-       u32 opplevel = 0;
-#endif
-       struct CFG_HOSTRES resources;
-       DSP_STATUS status = DSP_SOK;
-       u32 temp;
-
-       if (!pDevContext->mbox)
-               return DSP_SOK;
-
-       status = CFG_GetHostResources((struct CFG_DEVNODE *)
-                       DRV_GetFirstDevExtension(), &resources);
-       if (DSP_FAILED(status))
-               return DSP_EFAIL;
-
-       if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
-           pDevContext->dwBrdState == BRD_HIBERNATION) {
-#ifdef CONFIG_BRIDGE_DVFS
-               if (pdata->dsp_get_opp)
-                       opplevel = (*pdata->dsp_get_opp)();
-               if (opplevel == VDD1_OPP1) {
-                       if (pdata->dsp_set_min_opp)
-                               (*pdata->dsp_set_min_opp)(VDD1_OPP2);
-               }
-#endif
-               /* Restart the peripheral clocks */
-               DSP_PeripheralClocks_Enable(pDevContext, NULL);
-
-               /*
-                * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
-                *     in CM_AUTOIDLE_PLL_IVA2 register
-                */
-               *(REG_UWORD32 *)(resources.dwCmBase + 0x34) = 0x1;
-
-               /*
-                * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
-                *     0.75 MHz - 1.0 MHz
-                * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
-                */
-               temp = *(REG_UWORD32 *)(resources.dwCmBase + 0x4);
-               temp = (temp & 0xFFFFFF08) | 0x37;
-               *(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;
-
-               /* Restore mailbox settings */
-               omap_mbox_restore_ctx(pDevContext->mbox);
-
-               /* Access MMU SYS CONFIG register to generate a short wakeup */
-               temp = *(REG_UWORD32 *)(resources.dwDmmuBase + 0x10);
-
-               pDevContext->dwBrdState = BRD_RUNNING;
-       } else if (pDevContext->dwBrdState == BRD_RETENTION) {
-               /* Restart the peripheral clocks */
-               DSP_PeripheralClocks_Enable(pDevContext, NULL);
-       }
-
-       status = omap_mbox_msg_send(pDevContext->mbox, wMbVal);
-
-       if (status) {
-               pr_err("omap_mbox_msg_send Fail and status = %d\n", status);
-               status = DSP_EFAIL;
-       }
-
-       DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n", wMbVal);
-       return DSP_SOK;
-}
-
--
1.6.0.4


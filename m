From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 02/15] tidspbridge: trivial cleanup
Date: Wed, 18 Mar 2009 03:22:58 +0200
Message-ID: <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56149 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbZCRBX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:23:56 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so321490bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:23:54 -0700 (PDT)
In-Reply-To: <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Remove comments that introduce noise.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |   46 ++---------------------------------
 1 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 6e258f4..6755944 100644
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
@@ -14,40 +12,25 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-/*
- *  ======== tiomap_sm.c ========
- *  Description:
- *      Implements lower edge channel class library functions.
- *
- */
-
-/*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
-/*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
 
-/*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbg.h>
 
-/*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/util.h>
 
-/*  ----------------------------------- Mini Driver */
 #include <dspbridge/wmd.h>
 
-/*  ----------------------------------- Platform Manager */
 #include <dspbridge/wcd.h>
 #include <dspbridge/dev.h>
 
-/* ------------------------------------ Hardware Abstraction Layer */
 #include <hw_defs.h>
 #include <hw_mbox.h>
 
-/*  ----------------------------------- This */
 #include "_tiomap.h"
 #include <dspbridge/chnl_sm.h>
 #include "_tiomap_pwr.h"
@@ -56,7 +39,6 @@
 extern struct platform_device omap_dspbridge_dev;
 #endif
 
-/*  ----------------------------------- Defines, Data Structures, Typedefs */
 #ifndef DEBUG
 #define TIHELEN_INT_TIMEOUT     1
 #define LOOP_COUNT              1000000
@@ -65,10 +47,7 @@ extern struct platform_device omap_dspbridge_dev;
 extern struct MAILBOX_CONTEXT mboxsetting;
 extern DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT
 					     *pDevContext, IN void *pArgs);
-/*
- *  ======== CHNLSM_EnableInterrupt ========
- *      Enables interrupts from DSP.
- */
+
 DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
@@ -121,10 +100,6 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 	return status;
 }
 
-/*
- *  ======== CHNLSM_DisableInterrupt ========
- *      Disables interrupts from DSP.
- */
 DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
@@ -141,10 +116,6 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 	return status;
 }
 
-/*
- *  ======== CHNLSM_InterruptDSP ========
- *      Send an interrupt to the DSP processor(s).
- */
 DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
@@ -221,10 +192,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 	return status;
 }
 
-/*
- *  ======== CHNLSM_InterruptDSP2 ========
- *      Set MBX value & send an interrupt to the DSP processor(s).
- */
 DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *hDevContext,
 				u16 wMbVal)
 {
@@ -235,17 +202,11 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *hDevContext,
 	return CHNLSM_InterruptDSP(hDevContext);
 }
 
-/*
- *  ======== CHNLSM_DPC ========
- */
 void CHNLSM_DPC(struct WMD_DEV_CONTEXT *hDevContext)
 {
 	DBG_Trace(DBG_ENTER, "CHNLSM_DPC(0x%x)\n", hDevContext);
 }
 
-/*
- *  ======== CHNLSM_ISR ========
- */
 bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
 		OUT u16 *pwIntrVal)
 {
@@ -277,4 +238,3 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
 	*pfSchedDPC = true;
 	return fMyInterrupt;
 }
-
-- 
1.6.2.1.287.g9a8be


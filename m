From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 07/07][GIT 3/4+] Renaming CFG_GetC55Procs
Date: Mon, 4 Aug 2008 09:56:31 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530804B519@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:33988 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757829AbYHDO4i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:56:38 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m74EuWDK001296
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:56:37 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m74EuWYm026019
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:56:32 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Renaming CFG_GetC55Procs function for a more proper name (CFG_GetDSPProcs) and removed redundant initialization statements.

---
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h  2008-07-29 23:52:55.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h       2008-07-29 23:56:40.000000000 -0500
@@ -337,6 +337,6 @@
  */
        extern DSP_STATUS CFG_SetObject(IN u32 dwValue, IN u32 dwType);

-       extern DSP_STATUS CFG_GetC55Procs(OUT u32 *numProcs);
+       extern DSP_STATUS CFG_GetDSPProcs(OUT u32 *numProcs);

 #endif                         /* CFG_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c  2008-07-29 23:56:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c       2008-07-29 23:56:40.000000000 -0500
@@ -156,7 +156,7 @@
                goto func_cont;
        }               /* End DRV_Create */
        GT_0trace(curTrace, GT_5CLASS, "DSP_Init:DRV Created \r\n");
-       status = CFG_GetC55Procs(&numProcs);
+       status = CFG_GetDSPProcs(&numProcs);
        GT_1trace(curTrace, GT_5CLASS, "DSP_Init:C55 procs configured = %d\n",
                  numProcs);
        if (DSP_SUCCEEDED(status) & numProcs) {
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c 2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c      2008-07-29 23:56:40.000000000 -0500
@@ -485,16 +485,15 @@
 }

 /*
- * ===========CFG_GetC55Procs ============
+ * ===========CFG_GetDSPProcs ============
  * Purpose:
  * Get the number of configured C55 processors
  */

-DSP_STATUS CFG_GetC55Procs(OUT u32 *numProcs)
+DSP_STATUS CFG_GetDSPProcs(OUT u32 *numProcs)
 {
        DSP_STATUS status = DSP_SOK;

-       *numProcs = 0;
        *numProcs = 1;
        return status;
 }
---

Regards,

omar

From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM] [PATCH 2/6] DSPBRIDGE: Freeing allocated resources on
 rmmod
Date: Thu, 29 Jan 2009 18:14:44 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F7EA52BB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48406 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592AbZA3AOv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 19:14:51 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0U0Ej33016287
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:14:50 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0U0EjT2015996
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:14:45 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Omar Ramirez Luna <x00omar@ti.com>
Date: Wed, 28 Jan 2009 19:00:22 -0600
Subject: [PATCH] DSPBRIDGE: Freeing allocated resources on rmmod

This patch implements the cleanup of allocated resources whenever the
module is removed from the kernel.

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 126f5de..a756997 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -534,8 +534,28 @@ static void __exit bridge_exit(void)
 {
 	dev_t devno;
 	bool ret;
+	DSP_STATUS dsp_status = DSP_SOK;
+	HANDLE hDrvObject = NULL;
+	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
+
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
 
+
+	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
+	if (DSP_FAILED(dsp_status))
+		goto func_cont;
+
+	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
+	while (pCtxtclosed != NULL) {
+		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
+			 "process***%d\n", pCtxtclosed->pid);
+		DRV_RemoveAllResources(pCtxtclosed);
+		PROC_Detach(pCtxtclosed->hProcessor);
+		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
+				     pCtxtclosed, (void *)pCtxtclosed->pid);
+		pCtxtclosed = pCtxtclosed->next;;
+	}
+func_cont:
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 #ifndef CONFIG_DISABLE_BRIDGE_DVFS
 	/* remove the constraints */
-- 
1.5.4.3


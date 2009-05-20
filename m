From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 12/14] DSPBRIDGE: Remove all resources on driver exit
Date: Wed, 20 May 2009 00:02:18 -0500
Message-ID: <1242795740-21535-12-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
 <1242795740-21535-7-git-send-email-x00omar@ti.com>
 <1242795740-21535-8-git-send-email-x00omar@ti.com>
 <1242795740-21535-9-git-send-email-x00omar@ti.com>
 <1242795740-21535-10-git-send-email-x00omar@ti.com>
 <1242795740-21535-11-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59988 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbZETE6e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:34 -0400
In-Reply-To: <1242795740-21535-11-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Omar Ramirez Luna <omar.ramirez@ti.com>

There is no need to walk the process context list
on exit, remove all process instead without exception.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   32 +++++-------------------------
 1 files changed, 6 insertions(+), 26 deletions(-)
 mode change 100755 => 100644 drivers/dsp/bridge/rmgr/drv_interface.c

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
old mode 100755
new mode 100644
index e937766..d17d3cf
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -451,44 +451,24 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 	HANDLE	     hDrvObject = NULL;
 	struct PROCESS_CONTEXT	*pTmp = NULL;
 	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
-	struct PROCESS_CONTEXT    *pCtxttraverse = NULL;
 
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
 
 	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
+	if (DSP_FAILED(dsp_status))
+		goto func_cont;
 	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
 	while (pCtxtclosed != NULL) {
+		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
+			 "process***%d\n", pCtxtclosed->pid);
 		DRV_RemoveAllResources(pCtxtclosed);
-		if (pCtxtclosed->hProcessor != NULL) {
-			DRV_GetProcCtxtList(&pCtxttraverse,
-					    (struct DRV_OBJECT *)hDrvObject);
-			if (pCtxttraverse->next == NULL) {
-				PROC_Detach(pCtxtclosed->hProcessor);
-				goto func_cont;
-			}
-			if ((pCtxtclosed->pid == pCtxttraverse->pid) &&
-			   (pCtxttraverse->next != NULL)) {
-				pCtxttraverse =	pCtxttraverse->next;
-			}
-			while ((pCtxttraverse != NULL) &&
-			      (pCtxtclosed->hProcessor
-			      != pCtxttraverse->hProcessor)) {
-				pCtxttraverse =	pCtxttraverse->next;
-				if ((pCtxttraverse != NULL) &&
-				   (pCtxtclosed->pid == pCtxttraverse->pid)) {
-					pCtxttraverse = pCtxttraverse->next;
-				}
-			}
-			if (pCtxttraverse == NULL)
-				PROC_Detach(pCtxtclosed->hProcessor);
-		}
-func_cont:
+		PROC_Detach(pCtxtclosed->hProcessor);
 		pTmp = pCtxtclosed->next;
 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 				     pCtxtclosed, (void *)pCtxtclosed->pid);
 		pCtxtclosed = pTmp;
 	}
-
+func_cont:
 	/* unregister the clock notifier */
 #ifdef CONFIG_BRIDGE_DVFS
 	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
-- 
1.6.2.4


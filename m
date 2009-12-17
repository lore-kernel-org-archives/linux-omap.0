From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/7] DSPBRIDGE: less indentation for bridge_open and bridge_release
Date: Wed, 16 Dec 2009 21:45:55 -0600
Message-ID: <1261021558-19036-5-git-send-email-omar.ramirez@ti.com>
References: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-3-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45485 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934659AbZLQDim (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:38:42 -0500
In-Reply-To: <1261021558-19036-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Use goto statement to remove one indent level from
bridge_open and bridge_release.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   61 ++++++++++++++++---------------
 1 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 22e81bd..0452029 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -553,24 +553,25 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	GT_0trace(driverTrace, GT_ENTER, "-> bridge_open\n");
 
 	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(dsp_status)) {
-		/*
-		 * Allocate a new process context and insert it into global
-		 * process context list.
-		 */
-		DRV_InsertProcContext(hDrvObject, &pr_ctxt);
-		if (pr_ctxt) {
-			DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
-			DRV_ProcSetPID(pr_ctxt, current->tgid);
-		} else {
-			status = -ENOMEM;
-		}
-	} else {
+	if (DSP_FAILED(dsp_status)) {
 		status = -EIO;
+		goto err;
 	}
 
+	/*
+	 * Allocate a new process context and insert it into global
+	 * process context list.
+	 */
+	DRV_InsertProcContext(hDrvObject, &pr_ctxt);
+	if (pr_ctxt) {
+		DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
+		DRV_ProcSetPID(pr_ctxt, current->tgid);
+	} else {
+		status = -ENOMEM;
+	}
 	filp->private_data = pr_ctxt;
 
+err:
 	GT_0trace(driverTrace, GT_ENTER, "<- bridge_open\n");
 	return status;
 }
@@ -591,25 +592,27 @@ static int bridge_release(struct inode *ip, struct file *filp)
 
 	if (!filp->private_data) {
 		status = -EIO;
-	} else {
-		pr_ctxt = filp->private_data;
-		dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(dsp_status)) {
-			flush_signals(current);
-			DRV_RemoveAllResources(pr_ctxt);
-			list_for_each_entry_safe(proc_obj_ptr, temp,
-					&pr_ctxt->processor_list,
-					proc_object) {
-				PROC_Detach(proc_obj_ptr, pr_ctxt);
-			}
-			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
-					pr_ctxt);
-		} else {
-			status = -EIO;
+		goto err;
+	}
+
+	pr_ctxt = filp->private_data;
+	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
+	if (DSP_SUCCEEDED(dsp_status)) {
+		flush_signals(current);
+		DRV_RemoveAllResources(pr_ctxt);
+		list_for_each_entry_safe(proc_obj_ptr, temp,
+				&pr_ctxt->processor_list,
+				proc_object) {
+			PROC_Detach(proc_obj_ptr, pr_ctxt);
 		}
-		filp->private_data = NULL;
+		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
+				pr_ctxt);
+	} else {
+		status = -EIO;
 	}
+	filp->private_data = NULL;
 
+err:
 	GT_0trace(driverTrace, GT_ENTER, "<- bridge_release\n");
 	return status;
 }
-- 
1.6.2.4


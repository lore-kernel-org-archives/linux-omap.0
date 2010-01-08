From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/8] DSPBRIDGE: Remove unused hDrvObject in bridge_[open|release]
Date: Thu,  7 Jan 2010 19:00:40 -0600
Message-ID: <1262912440-30050-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481Ab0AHAvc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 19:51:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes an unused variable in bridge_open
and bridge_release functions, which reduces indentation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 3a4d058..e551840 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -540,18 +540,10 @@ static void __exit bridge_exit(void)
 static int bridge_open(struct inode *ip, struct file *filp)
 {
 	int status = 0;
-	DSP_STATUS dsp_status;
-	HANDLE hDrvObject;
 	struct PROCESS_CONTEXT *pr_ctxt = NULL;
 
 	GT_0trace(driverTrace, GT_ENTER, "-> bridge_open\n");
 
-	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(dsp_status)) {
-		status = -EIO;
-		goto err;
-	}
-
 	/*
 	 * Allocate a new process context and insert it into global
 	 * process context list.
@@ -564,7 +556,6 @@ static int bridge_open(struct inode *ip, struct file *filp)
 
 	filp->private_data = pr_ctxt;
 
-err:
 	GT_0trace(driverTrace, GT_ENTER, "<- bridge_open\n");
 	return status;
 }
@@ -576,8 +567,6 @@ err:
 static int bridge_release(struct inode *ip, struct file *filp)
 {
 	int status = 0;
-	DSP_STATUS dsp_status;
-	HANDLE hDrvObject;
 	struct PROCESS_CONTEXT *pr_ctxt;
 
 	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
@@ -588,15 +577,11 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	}
 
 	pr_ctxt = filp->private_data;
-	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(dsp_status)) {
-		flush_signals(current);
-		DRV_RemoveAllResources(pr_ctxt);
-		PROC_Detach(pr_ctxt);
-		MEM_Free(pr_ctxt);
-	} else {
-		status = -EIO;
-	}
+	flush_signals(current);
+	DRV_RemoveAllResources(pr_ctxt);
+	PROC_Detach(pr_ctxt);
+	MEM_Free(pr_ctxt);
+
 	filp->private_data = NULL;
 
 err:
-- 
1.6.2.4


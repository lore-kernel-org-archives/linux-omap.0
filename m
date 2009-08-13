From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 08/13] DSPBRIDGE: Use pr_ctxt in DRV_RemoveProcContext
Date: Thu, 13 Aug 2009 23:00:53 +0300
Message-ID: <1250193653-11634-1-git-send-email-ameya.palande@nokia.com>
References: <1249953714-20972-9-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54582 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbZHMUBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 16:01:07 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7DK0nLH029661
	for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 23:00:54 +0300
Received: from localhost.localdomain (esdhcp040105.research.nokia.com [172.21.40.105])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7DK0m2q007091
	for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 23:00:49 +0300
In-Reply-To: <1249953714-20972-9-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    2 +-
 drivers/dsp/bridge/rmgr/drv.c                      |   36 +++++++++++---------
 drivers/dsp/bridge/rmgr/drv_interface.c            |    4 +-
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index b43fa16..5592f38 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -43,7 +43,7 @@ extern DSP_STATUS DRV_GetProcContext(u32 phProcess,
 extern DSP_STATUS DRV_RemoveAllResources(HANDLE pPctxt);
 
 extern DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
-				     HANDLE hPCtxt, HANDLE hProcess);
+				     HANDLE hPCtxt);
 
 extern DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE nodeRes,
 					HANDLE pCtxt);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index e64b997..a13932c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -317,36 +317,40 @@ DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt)
 
 /* Delete a process context from process resource context list */
 DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
-				     HANDLE hPCtxt, HANDLE hProcess)
+		HANDLE pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
-	struct PROCESS_CONTEXT    *pCtxt2 = NULL;
-	struct PROCESS_CONTEXT    *pTmp = NULL;
-	struct PROCESS_CONTEXT    *pCtxtList = NULL;
+	struct PROCESS_CONTEXT *pr_ctxt_list = NULL;
+	struct PROCESS_CONTEXT *ptr_prev;
 
 	DBC_Assert(hDRVObject != NULL);
-	DRV_GetProcContext((u32)hProcess, hDRVObject, &pCtxt2, NULL, 0);
 
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 12");
-	DRV_GetProcCtxtList(&pCtxtList, hDRVObject);
+	DRV_GetProcCtxtList(&pr_ctxt_list, hDRVObject);
+
+	/* Special condition */
+	if (pr_ctxt_list == pr_ctxt) {
+		hDRVObject->procCtxtList = NULL;
+		goto func_cont;
+	}
+
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 13");
-	pTmp = pCtxtList;
-	while ((pCtxtList != NULL) && (pCtxtList != pCtxt2)) {
-		pTmp = pCtxtList;
-		pCtxtList = pCtxtList->next;
+	while (pr_ctxt_list && (pr_ctxt_list != pr_ctxt)) {
+		ptr_prev = pr_ctxt_list;
+		pr_ctxt_list = pr_ctxt_list->next;
 		GT_0trace(curTrace, GT_ENTER,
 			 "DRV_RemoveProcContext: 2");
 	}
+
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 3");
-	if (hDRVObject->procCtxtList == pCtxt2)
-		hDRVObject->procCtxtList = pCtxt2->next;
 
-	if (pCtxtList == NULL)
+	if (!pr_ctxt_list)
 		return DSP_ENOTFOUND;
-	else if (pTmp->next != NULL)
-		pTmp->next = pTmp->next->next;
+	else
+		ptr_prev->next = pr_ctxt_list->next;
 
-	MEM_Free(pCtxt2);
+func_cont:
+	MEM_Free(pr_ctxt);
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 7");
 
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 1cb3d74..fa79695 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -481,7 +481,7 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		}
 		pTmp = pCtxtclosed->next;
 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
-				     pCtxtclosed, (void *)pCtxtclosed->pid);
+				pCtxtclosed);
 		pCtxtclosed = pTmp;
 	}
 
@@ -630,7 +630,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 				PROC_Detach(proc_obj_ptr, pr_ctxt);
 			}
 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
-					pr_ctxt, (void *)pr_ctxt->pid);
+					pr_ctxt);
 		} else {
 			status = -EIO;
 		}
-- 
1.6.2.4


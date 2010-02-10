From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: Adding protection Resource cleanup linked lists
Date: Wed, 10 Feb 2010 02:29:17 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA725DC4@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892Ab0BJI3Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 03:29:24 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From bf2ca8fc8f02b94119efd69c0a4eb9621120f064 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 10 Feb 2010 02:26:13 -0600
Subject: [PATCH] DSPBRIDGE: Adding protection Resource cleanup linked lists

This patch protects the Resorce cleanup lists from
concurrent access

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c           |   16 ++++++-
 drivers/dsp/bridge/rmgr/drv.c           |   71 ++++++++++++++++++++++++++-----
 drivers/dsp/bridge/rmgr/drv_interface.c |    8 +++-
 3 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index b086c0f..bd2bfa3 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1121,17 +1121,23 @@ bool validate_node_handle(struct NODE_OBJECT *hNode, void *pr_ctxt)
 {
 	bool retVal = false;
 	struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
-	struct NODE_RES_OBJECT *pNode = pCtxt->pNodeList;
+	struct NODE_RES_OBJECT *pNode;
 
 	if (hNode == (struct NODE_OBJECT *) DSP_HGPPNODE)
 		retVal = true;
 
+	if (mutex_lock_interruptible(&pCtxt->node_mutex))
+		return DSP_EFAIL;
+
+	pNode = pCtxt->pNodeList;
 	while (pNode && !retVal) {
 		if (hNode == pNode->hNode)
 			retVal = true;
 		pNode = pNode->next;
 	}
 
+	mutex_unlock(&pCtxt->node_mutex);
+
 	return retVal;
 }
 
@@ -1570,14 +1576,20 @@ bool validate_strm_handle(struct STRM_OBJECT *hStrm, void *pr_ctxt)
 {
 	bool retVal = false;
 	struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
-	struct STRM_RES_OBJECT *pStrm = pCtxt->pSTRMList;
+	struct STRM_RES_OBJECT *pStrm;
 
+	if (mutex_lock_interruptible(&pCtxt->strm_mutex))
+		return DSP_EFAIL;
+
+	 pStrm = pCtxt->pSTRMList;
 	while (pStrm && !retVal) {
 		if (hStrm == pStrm->hStream)
 			retVal = true;
 		pStrm = pStrm->next;
 	}
 
+	mutex_unlock(&pCtxt->strm_mutex);
+
 	return retVal;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 36bab9f..3def337 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -97,6 +97,10 @@ DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
 		status = DSP_EHANDLE;
 	}
 	if (DSP_SUCCEEDED(status)) {
+		if (mutex_lock_interruptible(&pCtxt->node_mutex)) {
+			MEM_Free(*pNodeRes);
+			return DSP_EFAIL;
+		}
 		(*pNodeRes)->hNode = hNode;
 		if (pCtxt->pNodeList != NULL) {
 			pTempNodeRes = pCtxt->pNodeList;
@@ -111,6 +115,7 @@ DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
 			GT_0trace(curTrace, GT_ENTER,
 				 "DRV_InsertNodeResElement: 3");
 		}
+		mutex_unlock(&pCtxt->node_mutex);
 	}
 	GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 4");
 	return status;
@@ -123,7 +128,10 @@ DSP_STATUS DRV_RemoveNodeResElement(HANDLE hNodeRes, HANDLE hPCtxt)
 	struct NODE_RES_OBJECT *pNodeRes = (struct NODE_RES_OBJECT *)hNodeRes;
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	struct NODE_RES_OBJECT *pTempNode;
+	DSP_STATUS status = DSP_SOK;
 
+	if (mutex_lock_interruptible(&pCtxt->node_mutex))
+		return DSP_EFAIL;
 	pTempNode = pCtxt->pNodeList;
 	if (pTempNode == pNodeRes) {
 		pCtxt->pNodeList = pNodeRes->next;
@@ -131,11 +139,13 @@ DSP_STATUS DRV_RemoveNodeResElement(HANDLE hNodeRes, HANDLE hPCtxt)
 		while (pTempNode && pTempNode->next != pNodeRes)
 			pTempNode = pTempNode->next;
 		if (!pTempNode)
-			return DSP_ENOTFOUND;
-		pTempNode->next = pNodeRes->next;
+			status = DSP_ENOTFOUND;
+		else
+			pTempNode->next = pNodeRes->next;
 	}
+	mutex_unlock(&pCtxt->node_mutex);
 	kfree(pNodeRes);
-	return DSP_SOK;
+	return status;
 }
 
 /* Actual Node De-Allocation */
@@ -200,6 +210,11 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 		status = DSP_EHANDLE;
 	}
 	if (DSP_SUCCEEDED(status)) {
+		if (mutex_lock_interruptible(&pCtxt->dmm_mutex)) {
+			MEM_Free(*pDMMRes);
+			return DSP_EFAIL;
+		}
+
 		if (pCtxt->pDMMList != NULL) {
 			GT_0trace(curTrace, GT_5CLASS,
 				 "DRV_InsertDMMResElement: 3");
@@ -213,6 +228,7 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 			GT_0trace(curTrace, GT_5CLASS,
 				 "DRV_InsertDMMResElement: 4");
 		}
+		mutex_unlock(&pCtxt->dmm_mutex);
 	}
 	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 5");
 	return status;
@@ -225,7 +241,10 @@ DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	struct DMM_RES_OBJECT *pDMMRes = (struct DMM_RES_OBJECT *)hDMMRes;
 	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
+	DSP_STATUS status = DSP_SOK;
 
+	if (mutex_lock_interruptible(&pCtxt->dmm_mutex))
+		return DSP_EFAIL;
 	pTempDMMRes = pCtxt->pDMMList;
 	if (pCtxt->pDMMList == pDMMRes) {
 		pCtxt->pDMMList = pDMMRes->next;
@@ -233,11 +252,13 @@ DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 		while (pTempDMMRes && pTempDMMRes->next != pDMMRes)
 			pTempDMMRes = pTempDMMRes->next;
 		if (!pTempDMMRes)
-			return DSP_ENOTFOUND;
-		pTempDMMRes->next = pDMMRes->next;
+			status = DSP_ENOTFOUND;
+		else
+			pTempDMMRes->next = pDMMRes->next;
 	}
+	mutex_unlock(&pCtxt->dmm_mutex);
 	kfree(pDMMRes);
-	return DSP_SOK;
+	return status;
 }
 
 /* Update DMM resource status */
@@ -315,6 +336,9 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DMM_RES_OBJECT *pTempDMM = NULL;
 
+	if (mutex_lock_interruptible(&pCtxt->dmm_mutex))
+		return DSP_EFAIL;
+
 	pTempDMM = pCtxt->pDMMList;
 	while ((pTempDMM != NULL) && (pTempDMM->ulDSPAddr != pMapAddr)) {
 		GT_3trace(curTrace, GT_ENTER,
@@ -323,6 +347,9 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 			 pTempDMM->ulDSPAddr, pMapAddr);
 		pTempDMM = pTempDMM->next;
 	}
+
+	mutex_unlock(&pCtxt->dmm_mutex);
+
 	if (pTempDMM != NULL) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 3");
 		*pDMMRes = pTempDMM;
@@ -378,12 +405,18 @@ DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE hNodeRes, HANDLE hPCtxt)
 	struct NODE_RES_OBJECT *pTempNode2 = NULL;
 	struct NODE_RES_OBJECT *pTempNode = NULL;
 
+	if (mutex_lock_interruptible(&pCtxt->node_mutex))
+		return DSP_EFAIL;
+
 	pTempNode = pCtxt->pNodeList;
 	GT_0trace(curTrace, GT_ENTER, "DRV_GetNodeResElement: 1");
 	while ((pTempNode != NULL) && (pTempNode->hNode != hNode)) {
 		pTempNode2 = pTempNode;
 		pTempNode = pTempNode->next;
 	}
+
+	mutex_unlock(&pCtxt->node_mutex);
+
 	if (pTempNode != NULL)
 		*nodeRes = pTempNode;
 	else
@@ -410,6 +443,10 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,
 		status = DSP_EHANDLE;
 	}
 	if (DSP_SUCCEEDED(status)) {
+		if (mutex_lock_interruptible(&pCtxt->strm_mutex)) {
+			MEM_Free(*pSTRMRes);
+			return DSP_EFAIL;
+		}
 		(*pSTRMRes)->hStream = hStreamHandle;
 		if (pCtxt->pSTRMList != NULL) {
 			GT_0trace(curTrace, GT_ENTER,
@@ -424,6 +461,7 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,
 			GT_0trace(curTrace, GT_ENTER,
 				 "DRV_InsertSTRMResElement: 4");
 		}
+		mutex_unlock(&pCtxt->strm_mutex);
 	}
 	return status;
 }
@@ -436,7 +474,10 @@ DSP_STATUS 	DRV_ProcRemoveSTRMResElement(HANDLE hSTRMRes, HANDLE hPCtxt)
 	struct STRM_RES_OBJECT *pSTRMRes = (struct STRM_RES_OBJECT *)hSTRMRes;
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	struct STRM_RES_OBJECT *pTempSTRMRes;
+	DSP_STATUS status = DSP_SOK;
 
+	if (mutex_lock_interruptible(&pCtxt->strm_mutex))
+		return DSP_EFAIL;
 	pTempSTRMRes = pCtxt->pSTRMList;
 
 	if (pCtxt->pSTRMList == pSTRMRes) {
@@ -445,12 +486,13 @@ DSP_STATUS 	DRV_ProcRemoveSTRMResElement(HANDLE hSTRMRes, HANDLE hPCtxt)
 		while (pTempSTRMRes && pTempSTRMRes->next != pSTRMRes)
 			pTempSTRMRes = pTempSTRMRes->next;
 		if (pTempSTRMRes == NULL)
-			return DSP_ENOTFOUND;
-		pTempSTRMRes->next = pSTRMRes->next;
+			status = DSP_ENOTFOUND;
+		else
+			pTempSTRMRes->next = pSTRMRes->next;
 	}
-
+	mutex_unlock(&pCtxt->strm_mutex);
 	kfree(pSTRMRes);
-	return DSP_SOK;
+	return status;
 }
 
 /* Actual Stream De-Allocation */
@@ -522,13 +564,20 @@ DSP_STATUS DRV_GetSTRMResElement(HANDLE hStrm, HANDLE hSTRMRes, HANDLE hPCtxt)
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
 	struct STRM_RES_OBJECT *pTempSTRM2 = NULL;
-	struct STRM_RES_OBJECT *pTempSTRM = pCtxt->pSTRMList;
+	struct STRM_RES_OBJECT *pTempSTRM;
+
+	if (mutex_lock_interruptible(&pCtxt->strm_mutex))
+		return DSP_EFAIL;
 
+	pTempSTRM = pCtxt->pSTRMList;
 	while ((pTempSTRM != NULL) && (pTempSTRM->hStream != hStrm)) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 2");
 		pTempSTRM2 = pTempSTRM;
 		pTempSTRM = pTempSTRM->next;
 	}
+
+	mutex_unlock(&pCtxt->strm_mutex);
+
 	if (pTempSTRM != NULL) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 3");
 		*STRMRes = pTempSTRM;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 1676c78..3fd3665 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -492,10 +492,14 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 * process context list.
 	 */
 	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
-	if (pr_ctxt)
+	if (pr_ctxt) {
 		pr_ctxt->resState = PROC_RES_ALLOCATED;
-	else
+		mutex_init(&pr_ctxt->dmm_mutex);
+		mutex_init(&pr_ctxt->node_mutex);
+		mutex_init(&pr_ctxt->strm_mutex);
+	} else {
 		status = -ENOMEM;
+	}
 
 	filp->private_data = pr_ctxt;
 
-- 
1.6.0.4


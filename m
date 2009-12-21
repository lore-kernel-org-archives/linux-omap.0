From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 3/4] DSPBRIDGE: Optimize remove resource functions
Date: Mon, 21 Dec 2009 16:52:10 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A9F8ABD8@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43674 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485AbZLUWwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 17:52:12 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBLMqC8L024645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:52:12 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBLMqBoe001400
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:52:11 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBLMqB1r006492
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:52:11 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 30ff35b825462818158c03ee519820cb6580533e Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 2 Dec 2009 18:48:09 -0600
Subject: [PATCH] DSPBRIDGE: Optimize remove resource functions

This patch optimizes the remove resource functions, i.e DMM,
Stream and Nodes.
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   86 +++++++++++++++++------------------------
 1 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 946205c..a44916b 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -142,26 +142,21 @@ DSP_STATUS DRV_RemoveNodeResElement(HANDLE hNodeRes, HANDLE hPCtxt)
 {
 	struct NODE_RES_OBJECT *pNodeRes = (struct NODE_RES_OBJECT *)hNodeRes;
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	DSP_STATUS	status = DSP_SOK;
-	struct NODE_RES_OBJECT *pTempNode2 = pCtxt->pNodeList;
-	struct NODE_RES_OBJECT *pTempNode = pCtxt->pNodeList;
+	struct NODE_RES_OBJECT *pTempNode;
 
 	DBC_Assert(hPCtxt != NULL);
-	GT_0trace(curTrace, GT_ENTER, "\nDRV_RemoveNodeResElement: 1\n");
-	while ((pTempNode != NULL) && (pTempNode != pNodeRes)) {
-		pTempNode2 = pTempNode;
-		pTempNode = pTempNode->next;
-	}
-	if (pCtxt->pNodeList == pNodeRes)
+	pTempNode = pCtxt->pNodeList;
+	if (pTempNode == pNodeRes) {
 		pCtxt->pNodeList = pNodeRes->next;
-
-	if (pTempNode == NULL)
-		return DSP_ENOTFOUND;
-	else if (pTempNode2->next != NULL)
-		pTempNode2->next = pTempNode2->next->next;
-
-	MEM_Free(pTempNode);
-	return status;
+	} else {
+		while (pTempNode && pTempNode->next != pNodeRes)
+			pTempNode = pTempNode->next;
+		if (!pTempNode)
+			return DSP_ENOTFOUND;
+		pTempNode->next = pNodeRes->next;
+	}
+	MEM_Free(pNodeRes);
+	return DSP_SOK;
 }
 
 /* Actual Node De-Allocation */
@@ -248,35 +243,25 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 
 /* Release DMM resource element context
 * This is called from Proc_UnMap. after the actual resource is freed */
-DSP_STATUS 	DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
+DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	struct DMM_RES_OBJECT *pDMMRes = (struct DMM_RES_OBJECT *)hDMMRes;
-	DSP_STATUS status = DSP_SOK;
-	struct DMM_RES_OBJECT *pTempDMMRes2 = NULL;
 	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
 
 	DBC_Assert(hPCtxt != NULL);
-	pTempDMMRes2 = pCtxt->pDMMList;
 	pTempDMMRes = pCtxt->pDMMList;
-	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 1");
-	while ((pTempDMMRes != NULL) && (pTempDMMRes != pDMMRes)) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 2");
-		pTempDMMRes2 = pTempDMMRes;
-		pTempDMMRes = pTempDMMRes->next;
+	if (pCtxt->pDMMList == pDMMRes) {
+		pCtxt->pDMMList = pDMMRes->next;
+	} else {
+		while (pTempDMMRes && pTempDMMRes->next != pDMMRes)
+			pTempDMMRes = pTempDMMRes->next;
+		if (!pTempDMMRes)
+			return DSP_ENOTFOUND;
+		pTempDMMRes->next = pDMMRes->next;
 	}
-	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 3");
-	if (pCtxt->pDMMList == pTempDMMRes)
-		pCtxt->pDMMList = pTempDMMRes->next;
-
-	if (pTempDMMRes == NULL)
-		return DSP_ENOTFOUND;
-	else if (pTempDMMRes2->next != NULL)
-		pTempDMMRes2->next = pTempDMMRes2->next->next;
-
 	MEM_Free(pDMMRes);
-	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 4");
-	return status;
+	return DSP_SOK;
 }
 
 /* Update DMM resource status */
@@ -482,25 +467,24 @@ DSP_STATUS 	DRV_ProcRemoveSTRMResElement(HANDLE hSTRMRes, HANDLE hPCtxt)
 {
 	struct STRM_RES_OBJECT *pSTRMRes = (struct STRM_RES_OBJECT *)hSTRMRes;
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-	struct STRM_RES_OBJECT *pTempSTRMRes2 = pCtxt->pSTRMList;
-	struct STRM_RES_OBJECT *pTempSTRMRes = pCtxt->pSTRMList;
+	struct STRM_RES_OBJECT *pTempSTRMRes;
 
 	DBC_Assert(hPCtxt != NULL);
-	while ((pTempSTRMRes != NULL) && (pTempSTRMRes != pSTRMRes)) {
-		pTempSTRMRes2 = pTempSTRMRes;
-		pTempSTRMRes = pTempSTRMRes->next;
-	}
-	if (pCtxt->pSTRMList == pTempSTRMRes)
-		pCtxt->pSTRMList = pTempSTRMRes->next;
 
-	if (pTempSTRMRes == NULL)
-		status = DSP_ENOTFOUND;
-	else if (pTempSTRMRes2->next != NULL)
-		pTempSTRMRes2->next = pTempSTRMRes2->next->next;
+	pTempSTRMRes = pCtxt->pSTRMList;
+
+	if (pCtxt->pSTRMList == pSTRMRes) {
+		pCtxt->pSTRMList = pSTRMRes->next;
+	} else {
+		while (pTempSTRMRes && pTempSTRMRes->next != pSTRMRes)
+			pTempSTRMRes = pTempSTRMRes->next;
+		if (pTempSTRMRes == NULL)
+			return DSP_ENOTFOUND;
+		pTempSTRMRes->next = pSTRMRes->next;
+	}
 
 	MEM_Free(pSTRMRes);
-	return status;
+	return DSP_SOK;
 }
 
 /* Actual Stream De-Allocation */
-- 
1.6.0.4


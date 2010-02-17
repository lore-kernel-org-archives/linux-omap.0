From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: cleanup patch for
 DRV_RemoveAllSTRMResElements function
Date: Tue, 16 Feb 2010 18:39:20 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9605@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46983 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933749Ab0BQAjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 19:39:24 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 718174a6ed1b54ce0120080a953d7f0a5ebb8d6d Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Tue, 16 Feb 2010 18:14:26 -0600
Subject: [PATCH] DSPBRIDGE: cleanup patch for DRV_RemoveAllSTRMResElements function

This patches clenaups the function DRV_RemoveAllSTRMResElements and
DRV_ProcFreeSTRMRes and it turns them into one function.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   66 ++++++++++++----------------------------
 1 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 36bab9f..505f2b0 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -77,7 +77,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 fRequest);
 /* GPP PROCESS CLEANUP CODE */
 
 static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt);
-static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt);
 extern enum NODE_STATE NODE_GetState(HANDLE hNode);
 
 /* Allocate and add a node resource element
@@ -453,65 +452,40 @@ DSP_STATUS 	DRV_ProcRemoveSTRMResElement(HANDLE hSTRMRes, HANDLE hPCtxt)
 	return DSP_SOK;
 }
 
-/* Actual Stream De-Allocation */
-static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt)
+/* Release all Stream resources and its context
+* This is called from .bridge_release.
+*/
+DSP_STATUS DRV_RemoveAllSTRMResElements(HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
-	DSP_STATUS status1 = DSP_SOK;
+	struct STRM_RES_OBJECT *strm_res = NULL;
+	struct STRM_RES_OBJECT *strm_tmp = NULL;
 	u8 **apBuffer = NULL;
-	struct STRM_RES_OBJECT *pSTRMList = NULL;
-	struct STRM_RES_OBJECT *pSTRMRes = NULL;
 	u8 *pBufPtr;
 	u32 ulBytes;
 	u32 dwArg;
 	s32 ulBufSize;
 
-	pSTRMList = pCtxt->pSTRMList;
-	while (pSTRMList != NULL) {
-		pSTRMRes = pSTRMList;
-		pSTRMList = pSTRMList->next;
-		if (pSTRMRes->uNumBufs != 0) {
-			apBuffer = MEM_Alloc((pSTRMRes->uNumBufs *
+	strm_tmp = pCtxt->pSTRMList;
+	while (strm_tmp) {
+		strm_res = strm_tmp;
+		strm_tmp = strm_tmp->next;
+		if (strm_res->uNumBufs) {
+			apBuffer = MEM_Alloc((strm_res->uNumBufs *
 					    sizeof(u8 *)), MEM_NONPAGED);
-			status = STRM_FreeBuffer(pSTRMRes->hStream, apBuffer,
-						pSTRMRes->uNumBufs, pCtxt);
+			status = STRM_FreeBuffer(strm_res->hStream, apBuffer,
+						strm_res->uNumBufs, pCtxt);
 			kfree(apBuffer);
 		}
-		status = STRM_Close(pSTRMRes->hStream, pCtxt);
-		if (DSP_FAILED(status)) {
-			if (status == DSP_EPENDING) {
-				status = STRM_Reclaim(pSTRMRes->hStream,
-						     &pBufPtr, &ulBytes,
-						     (u32 *)&ulBufSize, &dwArg);
-				if (DSP_SUCCEEDED(status))
-					status = STRM_Close(pSTRMRes->hStream,
-							pCtxt);
-
-			}
+		status = STRM_Close(strm_res->hStream, pCtxt);
+		if (status == DSP_EPENDING) {
+			status = STRM_Reclaim(strm_res->hStream,
+				&pBufPtr, &ulBytes, (u32 *)&ulBufSize, &dwArg);
+			if (DSP_SUCCEEDED(status))
+				status = STRM_Close(strm_res->hStream, pCtxt);
 		}
 	}
-	return status1;
-}
-
-/* Release all Stream resources and its context
-* This is called from .bridge_release.
-*/
-DSP_STATUS	DRV_RemoveAllSTRMResElements(HANDLE hPCtxt)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-	struct STRM_RES_OBJECT *pTempSTRMRes2 = NULL;
-	struct STRM_RES_OBJECT *pTempSTRMRes = NULL;
-
-	DRV_ProcFreeSTRMRes(pCtxt);
-	pTempSTRMRes = pCtxt->pSTRMList;
-	while (pTempSTRMRes != NULL) {
-		pTempSTRMRes2 = pTempSTRMRes;
-		pTempSTRMRes = pTempSTRMRes->next;
-		kfree(pTempSTRMRes2);
-	}
-	pCtxt->pSTRMList = NULL;
 	return status;
 }
 
-- 
1.6.0.4


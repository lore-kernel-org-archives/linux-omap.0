From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Validate stream handle from user
Date: Tue, 9 Feb 2010 11:09:28 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008C89E962@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53819 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927Ab0BIRJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 12:09:34 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>

>From 991bd676e160a5500cb511a78afcac838ff003e4 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Fri, 29 Jan 2010 20:00:26 -0600
Subject: [PATCH] DSPBRIDGE: Validate stream handle from user.

Add checks to verify strm handle from user.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c  |   42 +++++++++++++
 drivers/dsp/bridge/rmgr/strm.c |  134 ++++++++++++++++-----------------------
 2 files changed, 97 insertions(+), 79 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 2e6eeb0..78c7acd 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1517,6 +1517,22 @@ func_cont:
 	return status;
 }
 
+
+bool validate_strm_handle(struct STRM_OBJECT *hStrm, void *pr_ctxt)
+{
+	bool retVal = false;
+	struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+	struct STRM_RES_OBJECT *pStrm = pCtxt->pSTRMList;
+
+	while (pStrm && !retVal) {
+		if (hStrm == pStrm->hStream)
+			retVal = true;
+		pStrm = pStrm->next;
+	}
+
+	return retVal;
+}
+
 /*
  * ======== STRMWRAP_AllocateBuffer ========
  */
@@ -1526,6 +1542,10 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 	u8 **apBuffer = NULL;
 	u32 uNumBufs = args->ARGS_STRM_ALLOCATEBUFFER.uNumBufs;
 
+	if (!validate_strm_handle(args->ARGS_STRM_ALLOCATEBUFFER.hStream,
+		pr_ctxt))
+		return DSP_EHANDLE;
+
 	if (uNumBufs > MAX_BUFS)
 		return DSP_EINVALIDARG;
 
@@ -1555,6 +1575,9 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
  */
 u32 STRMWRAP_Close(union Trapped_Args *args, void *pr_ctxt)
 {
+	if (!validate_strm_handle(args->ARGS_STRM_CLOSE.hStream, pr_ctxt))
+		return DSP_EHANDLE;
+
 	return STRM_Close(args->ARGS_STRM_CLOSE.hStream, pr_ctxt);
 }
 
@@ -1567,6 +1590,9 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 	u8 **apBuffer = NULL;
 	u32 uNumBufs = args->ARGS_STRM_FREEBUFFER.uNumBufs;
 
+	if (!validate_strm_handle(args->ARGS_STRM_FREEBUFFER.hStream, pr_ctxt))
+		return DSP_EHANDLE;
+
 	if (uNumBufs > MAX_BUFS)
 		return DSP_EINVALIDARG;
 
@@ -1605,6 +1631,9 @@ u32 STRMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt)
 	struct DSP_STREAMINFO user;
 	struct DSP_STREAMINFO *temp;
 
+	if (!validate_strm_handle(args->ARGS_STRM_GETINFO.hStream, pr_ctxt))
+		return DSP_EHANDLE;
+
 	cp_fm_usr(&strmInfo, args->ARGS_STRM_GETINFO.pStreamInfo, status, 1);
 	temp = strmInfo.pUser;
 
@@ -1627,6 +1656,9 @@ u32 STRMWRAP_Idle(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
+	if (!validate_strm_handle(args->ARGS_STRM_IDLE.hStream, pr_ctxt))
+		return DSP_EHANDLE;
+
 	retVal = STRM_Idle(args->ARGS_STRM_IDLE.hStream,
 			args->ARGS_STRM_IDLE.bFlush);
 
@@ -1640,6 +1672,9 @@ u32 STRMWRAP_Issue(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 
+	if (!validate_strm_handle(args->ARGS_STRM_ISSUE.hStream, pr_ctxt))
+		return DSP_EHANDLE;
+
 	if (!args->ARGS_STRM_ISSUE.pBuffer)
 		return DSP_EPOINTER;
 
@@ -1699,6 +1734,9 @@ u32 STRMWRAP_Reclaim(union Trapped_Args *args, void *pr_ctxt)
 	u32 dwArg;
 	u32 ulBufSize;
 
+	if (!validate_strm_handle(args->ARGS_STRM_RECLAIM.hStream, pr_ctxt))
+		return DSP_EHANDLE;
+
 	status = STRM_Reclaim(args->ARGS_STRM_RECLAIM.hStream, &pBufPtr,
 			     &ulBytes, &ulBufSize, &dwArg);
 	cp_to_usr(args->ARGS_STRM_RECLAIM.pBufPtr, &pBufPtr, status, 1);
@@ -1724,6 +1762,10 @@ u32 STRMWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 	GT_0trace(WCD_debugMask, GT_ENTER,
 		 "NODEWRAP_RegisterNotify: entered\n");
 
+	if (!validate_strm_handle(args->ARGS_STRM_REGISTERNOTIFY.hStream,
+		pr_ctxt))
+		return DSP_EHANDLE;
+
 	/* Initialize the notification data structure  */
 	notification.psName = NULL;
 	notification.handle = NULL;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 6be8083..2da6bf0 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -121,16 +121,11 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	GT_4trace(STRM_debugMask, GT_ENTER, "STRM_AllocateBuffer: hStrm: 0x%x\t"
 		 "uSize: 0x%x\tapBuffer: 0x%x\tuNumBufs: 0x%x\n",
 		 hStrm, uSize, apBuffer, uNumBufs);
-	if (MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
-		/*
-		 * Allocate from segment specified at time of stream open.
-		 */
-		if (uSize == 0)
-			status = DSP_ESIZE;
-
-	} else {
-		status = DSP_EHANDLE;
-	}
+	/*
+	 * Allocate from segment specified at time of stream open.
+	 */
+	if (uSize == 0)
+		status = DSP_ESIZE;
 
 	if (DSP_FAILED(status))
 		goto func_end;
@@ -179,20 +174,17 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 
 	GT_1trace(STRM_debugMask, GT_ENTER, "STRM_Close: hStrm: 0x%x\n", hStrm);
 
-	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
-		status = DSP_EHANDLE;
-	} else {
-		/* Have all buffers been reclaimed? If not, return
-		 * DSP_EPENDING */
-		pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
-		status = (*pIntfFxns->pfnChnlGetInfo) (hStrm->hChnl, &chnlInfo);
-		DBC_Assert(DSP_SUCCEEDED(status));
 
-		if (chnlInfo.cIOCs > 0 || chnlInfo.cIOReqs > 0)
-			status = DSP_EPENDING;
-		else
-			status = DeleteStrm(hStrm);
-	}
+	/* Have all buffers been reclaimed? If not, return
+	 * DSP_EPENDING */
+	pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
+	status = (*pIntfFxns->pfnChnlGetInfo) (hStrm->hChnl, &chnlInfo);
+	DBC_Assert(DSP_SUCCEEDED(status));
+
+	if (chnlInfo.cIOCs > 0 || chnlInfo.cIOReqs > 0)
+		status = DSP_EPENDING;
+	else
+		status = DeleteStrm(hStrm);
 
 	if (DSP_FAILED(status))
 		goto func_end;
@@ -314,26 +306,23 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 	GT_3trace(STRM_debugMask, GT_ENTER, "STRM_FreeBuffer: hStrm: 0x%x\t"
 		 "apBuffer: 0x%x\tuNumBufs: 0x%x\n", hStrm, apBuffer, uNumBufs);
 
-	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE))
-		status = DSP_EHANDLE;
-
-	if (DSP_SUCCEEDED(status)) {
-		for (i = 0; i < uNumBufs; i++) {
-			DBC_Assert(hStrm->hXlator != NULL);
-			status = CMM_XlatorFreeBuf(hStrm->hXlator, apBuffer[i]);
-			if (DSP_FAILED(status)) {
-				GT_0trace(STRM_debugMask, GT_7CLASS,
-					 "STRM_FreeBuffer: DSP_FAILED"
-					 " to free shared memory.\n");
-				break;
-			}
-			apBuffer[i] = NULL;
+	for (i = 0; i < uNumBufs; i++) {
+		DBC_Assert(hStrm->hXlator != NULL);
+		status = CMM_XlatorFreeBuf(hStrm->hXlator, apBuffer[i]);
+		if (DSP_FAILED(status)) {
+			GT_0trace(STRM_debugMask, GT_7CLASS,
+				 "STRM_FreeBuffer: DSP_FAILED"
+				 " to free shared memory.\n");
+			break;
 		}
+		apBuffer[i] = NULL;
 	}
-	if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pr_ctxt) !=
-			DSP_ENOTFOUND)
-		DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes);
 
+	if (DSP_SUCCEEDED(status)) {
+		if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pr_ctxt) !=
+				DSP_ENOTFOUND)
+			DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes);
+	}
 	return status;
 }
 
@@ -358,14 +347,12 @@ DSP_STATUS STRM_GetInfo(struct STRM_OBJECT *hStrm,
 	GT_3trace(STRM_debugMask, GT_ENTER, "STRM_GetInfo: hStrm: 0x%x\t"
 		 "pStreamInfo: 0x%x\tuStreamInfoSize: 0x%x\n", hStrm,
 		 pStreamInfo, uStreamInfoSize);
-	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
-		status = DSP_EHANDLE;
-	} else {
-		if (uStreamInfoSize < sizeof(struct STRM_INFO)) {
-			/* size of users info */
-			status = DSP_ESIZE;
-		}
+
+	if (uStreamInfoSize < sizeof(struct STRM_INFO)) {
+		/* size of users info */
+		status = DSP_ESIZE;
 	}
+
 	if (DSP_FAILED(status))
 		goto func_end;
 
@@ -420,14 +407,11 @@ DSP_STATUS STRM_Idle(struct STRM_OBJECT *hStrm, bool fFlush)
 	GT_2trace(STRM_debugMask, GT_ENTER, "STRM_Idle: hStrm: 0x%x\t"
 		 "fFlush: 0x%x\n", hStrm, fFlush);
 
-	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
-		status = DSP_EHANDLE;
-	} else {
-		pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
+	pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
+
+	status = (*pIntfFxns->pfnChnlIdle) (hStrm->hChnl,
+		 hStrm->uTimeout, fFlush);
 
-		status = (*pIntfFxns->pfnChnlIdle) (hStrm->hChnl,
-			 hStrm->uTimeout, fFlush);
-	}
 	return status;
 }
 
@@ -478,26 +462,24 @@ DSP_STATUS STRM_Issue(struct STRM_OBJECT *hStrm, IN u8 *pBuf, u32 ulBytes,
 	GT_4trace(STRM_debugMask, GT_ENTER, "STRM_Issue: hStrm: 0x%x\tpBuf: "
 		 "0x%x\tulBytes: 0x%x\tdwArg: 0x%x\n", hStrm, pBuf, ulBytes,
 		 dwArg);
-	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
-		status = DSP_EHANDLE;
-	} else {
-		pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
 
-		if (hStrm->uSegment != 0) {
-			pTmpBuf = CMM_XlatorTranslate(hStrm->hXlator,
-					(void *)pBuf, CMM_VA2DSPPA);
-			if (pTmpBuf == NULL)
-				status = DSP_ETRANSLATE;
+	pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
 
-		}
-		if (DSP_SUCCEEDED(status)) {
-			status = (*pIntfFxns->pfnChnlAddIOReq)
-				 (hStrm->hChnl, pBuf, ulBytes, ulBufSize,
-				 (u32) pTmpBuf, dwArg);
-		}
-		if (status == CHNL_E_NOIORPS)
-			status = DSP_ESTREAMFULL;
+	if (hStrm->uSegment != 0) {
+		pTmpBuf = CMM_XlatorTranslate(hStrm->hXlator,
+				(void *)pBuf, CMM_VA2DSPPA);
+		if (pTmpBuf == NULL)
+			status = DSP_ETRANSLATE;
+
+	}
+	if (DSP_SUCCEEDED(status)) {
+		status = (*pIntfFxns->pfnChnlAddIOReq)
+			 (hStrm->hChnl, pBuf, ulBytes, ulBufSize,
+			 (u32) pTmpBuf, dwArg);
 	}
+	if (status == CHNL_E_NOIORPS)
+		status = DSP_ESTREAMFULL;
+
 	return status;
 }
 
@@ -691,10 +673,6 @@ DSP_STATUS STRM_Reclaim(struct STRM_OBJECT *hStrm, OUT u8 **pBufPtr,
 		 "\tpulBytes: 0x%x\tpdwArg: 0x%x\n", hStrm, pBufPtr, pulBytes,
 		 pdwArg);
 
-	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
-		status = DSP_EHANDLE;
-		goto func_end;
-	}
 	pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
 
 	status = (*pIntfFxns->pfnChnlGetIOC)(hStrm->hChnl, hStrm->uTimeout,
@@ -746,7 +724,6 @@ DSP_STATUS STRM_Reclaim(struct STRM_OBJECT *hStrm, OUT u8 **pBufPtr,
 		}
 		*pBufPtr = chnlIOC.pBuf;
 	}
-func_end:
 	/* ensure we return a documented return code */
 	DBC_Ensure(DSP_SUCCEEDED(status) || status == DSP_EHANDLE ||
 		  status == DSP_ETIMEOUT || status == DSP_ETRANSLATE ||
@@ -773,9 +750,8 @@ DSP_STATUS STRM_RegisterNotify(struct STRM_OBJECT *hStrm, u32 uEventMask,
 		 "STRM_RegisterNotify: hStrm: 0x%x\t"
 		 "uEventMask: 0x%x\tuNotifyType: 0x%x\thNotification: 0x%x\n",
 		 hStrm, uEventMask, uNotifyType, hNotification);
-	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
-		status = DSP_EHANDLE;
-	} else if ((uEventMask & ~((DSP_STREAMIOCOMPLETION) |
+
+	if ((uEventMask & ~((DSP_STREAMIOCOMPLETION) |
 		 DSP_STREAMDONE)) != 0) {
 		status = DSP_EVALUE;
 	} else {
-- 
1.5.4.5


From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 5/5][omapzoom] BRIDGE Handle Node messaging when DSP crashed
Date: Thu, 13 Nov 2008 20:14:43 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303E11EBF40@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54510 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYKNCOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 21:14:50 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAE2EiQx016864
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:14:49 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAE2Eimc002773
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:14:44 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Fri, 31 Oct 2008 21:50:41 -0500
Subject: [PATCH] BRIDGE Handle Node messaging when DSP crashed

Handle Node messages differently when the DSP is in crashed state.
Do not send anymore messages once DSP crashed

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c  |   77 +++++++++++++++++++++++++++++++++++++++
 drivers/dsp/bridge/wmd/ue_deh.c |    6 ++--
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 0ae09bc..61f5d14 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1324,10 +1324,25 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 	bool bJustWokeDSP = false;
 	struct DSP_CBDATA cbData;
 	u32 procId = 255;
+	struct DSP_PROCESSORSTATE procStatus;
+	struct PROC_OBJECT *hProcessor;
 
 	DBC_Require(cRefs > 0);
 	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Create: hNode: 0x%x\n",
 		 hNode);
+	hProcessor = hNode->hProcessor;
+	status = PROC_GetState(hProcessor, &procStatus,
+					sizeof(struct DSP_PROCESSORSTATE));
+	if (DSP_FAILED(status))
+		goto func_end;
+	/* If processor is in error state then don't attempt to create
+	    new node */
+	if (procStatus.iState == PROC_ERROR) {
+		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Create:"
+			"		proc Status 0x%x\n", procStatus.iState);
+		status = DSP_EFAIL;
+		goto func_end;
+	}
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -2061,11 +2076,27 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
 	struct WMD_DRV_INTERFACE *pIntfFxns;
 	DSP_STATUS status = DSP_SOK;
 	void *pTmpBuf;
+	struct DSP_PROCESSORSTATE procStatus;
+	struct PROC_OBJECT *hProcessor;
+
 	DBC_Require(cRefs > 0);
 	DBC_Require(pMsg != NULL);
 	GT_3trace(NODE_debugMask, GT_ENTER,
 		 "NODE_GetMessage: hNode: 0x%x\tpMsg: "
 		 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
+	hProcessor = hNode->hProcessor;
+	status = PROC_GetState(hProcessor, &procStatus,
+					sizeof(struct DSP_PROCESSORSTATE));
+	if (DSP_FAILED(status))
+		goto func_end;
+	/* If processor is in error state then don't attempt to get the
+	    message */
+	if (procStatus.iState == PROC_ERROR) {
+		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_GetMessage:"
+			"		proc Status 0x%x\n", procStatus.iState);
+		status = DSP_EFAIL;
+		goto func_end;
+	}
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -2263,6 +2294,8 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 	struct NODE_MGR *hNodeMgr;
 	DSP_STATUS status = DSP_SOK;
 	u32 procId;
+	struct DSP_PROCESSORSTATE procStatus;
+	struct PROC_OBJECT *hProcessor;
 
 	DBC_Require(cRefs > 0);
 
@@ -2294,6 +2327,20 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 			if (state != NODE_RUNNING)
 				status = DSP_EWRONGSTATE;
 
+			hProcessor = hNode->hProcessor;
+			status = PROC_GetState(hProcessor, &procStatus,
+					sizeof(struct DSP_PROCESSORSTATE));
+			if (DSP_FAILED(status))
+				goto func_end;
+			/* If processor is in error state then don't attempt
+			    to send the message */
+			if (procStatus.iState == PROC_ERROR) {
+				GT_1trace(NODE_debugMask, GT_4CLASS,
+					"NODE_Pause: proc Status 0x%x\n",
+					procStatus.iState);
+				status = DSP_EFAIL;
+				goto func_end;
+			}
 			if (DSP_SUCCEEDED(status)) {
 				status = DISP_NodeChangePriority(hNodeMgr->
 				   hDisp, hNode,
@@ -2319,6 +2366,7 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 			NTFY_Notify(hNode->hNtfy, DSP_NODESTATECHANGE);
 		}
 	}
+func_end:
 	return status;
 }
 
@@ -2339,12 +2387,27 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 	DSP_STATUS status = DSP_SOK;
 	void *pTmpBuf;
 	struct DSP_MSG newMsg;
+	struct DSP_PROCESSORSTATE procStatus;
+	struct PROC_OBJECT *hProcessor;
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(pMsg != NULL);
 	GT_3trace(NODE_debugMask, GT_ENTER,
 		 "NODE_PutMessage: hNode: 0x%x\tpMsg: "
 		 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
+	hProcessor = hNode->hProcessor;
+	status = PROC_GetState(hProcessor, &procStatus,
+					sizeof(struct DSP_PROCESSORSTATE));
+	if (DSP_FAILED(status))
+		goto func_end;
+	/* If processor is in bad state then don't attempt sending the
+	    message */
+	if (procStatus.iState == PROC_ERROR) {
+		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_PutMessage:"
+			"		proc Status 0x%x\n", procStatus.iState);
+		status = DSP_EFAIL;
+		goto func_end;
+	}
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
 		status = DSP_EHANDLE;
 	else {
@@ -2485,9 +2548,23 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)
 	DSP_STATUS status = DSP_SOK;
 	u32 procId;
 	struct WMD_DRV_INTERFACE *pIntfFxns;
+	struct DSP_PROCESSORSTATE procStatus;
+	struct PROC_OBJECT *hProcessor;
 
 	DBC_Require(cRefs > 0);
 	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Run: hNode: 0x%x\n", hNode);
+	hProcessor = hNode->hProcessor;
+	status = PROC_GetState(hProcessor, &procStatus,
+					sizeof(struct DSP_PROCESSORSTATE));
+	if (DSP_FAILED(status))
+		goto func_end;
+	/* If processor is in error state then don't attempt to run the node */
+	if (procStatus.iState == PROC_ERROR) {
+		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Run:"
+			"		proc Status 0x%x\n", procStatus.iState);
+		status = DSP_EFAIL;
+		goto func_end;
+	}
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index f8d6ec6..141146a 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -285,13 +285,13 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 				 "0x%x\n", dwErrInfo);
 			break;
 		}
-		/* Call DSP Trace Buffer */
-		PrintDspTraceBuffer(hDehMgr->hWmdContext);
-
 		/* Set the Board state as ERROR */
 		pDevContext->dwBrdState = BRD_ERROR;
 		/* Disable all the clocks that were enabled by DSP */
 		(void)DSP_PeripheralClocks_Disable(pDevContext, NULL);
+		/* Call DSP Trace Buffer */
+		PrintDspTraceBuffer(hDehMgr->hWmdContext);
+
 		/* Signal DSP error/exception event. */
 		NTFY_Notify(pDehMgr->hNtfy, ulEventMask);
 	}
-- 
1.6.0

From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 4/4] [OMAPZOOM] DSPBRIDGE: Handle Node operations when DSP
 is in error state
Date: Thu, 26 Mar 2009 20:17:42 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2BC66@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48487 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934464AbZC0BRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 21:17:50 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2R1Hiuc028783
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 20:17:49 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2R1HiG6006543
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 20:17:44 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 65f3a829ceb76793e2fd067758878aa82985ecb7 Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Thu, 26 Mar 2009 16:50:04 -0500
Subject: [PATCH] DSPBRIDGE: Handle Node operations when DSP is in error state

Handle Node operations when DSP is in error state.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c |   45 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 1fae5d9..5d58e68 100755
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -429,6 +429,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	struct CFG_HOSTRES hostRes;
 	u32 pMappedAddr = 0;
 	u32 mapAttrs = 0x0;
+	struct DSP_PROCESSORSTATE procStatus;
 #ifdef DSP_DMM_DEBUG
 	struct DMM_OBJECT *hDmmMgr;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
@@ -471,6 +472,20 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	if (DSP_FAILED(status))
 		goto func_cont;
 
+	status = PROC_GetState(hProcessor, &procStatus,
+			sizeof(struct DSP_PROCESSORSTATE));
+	if (DSP_FAILED(status))
+		goto func_end;
+	/* If processor is in error state then don't attempt
+	    to send the message */
+	if (procStatus.iState == PROC_ERROR) {
+		GT_1trace(NODE_debugMask, GT_5CLASS,
+			"NODE_Allocate: proc Status 0x%x\n",
+			procStatus.iState);
+		status = DSP_EFAIL;
+		goto func_end;
+	}
+
 	/* Assuming that 0 is not a valid function address */
 	if (hNodeMgr->ulFxnAddrs[0] == 0) {
 		/* No RMS on target - we currently can't handle this */
@@ -839,6 +854,7 @@ func_cont2:
 	DBC_Ensure((DSP_FAILED(status) && (*phNode == NULL)) ||
 		  (DSP_SUCCEEDED(status)
 		    && MEM_IsValidHandle((*phNode), NODE_SIGNATURE)));
+func_end:
 	return status;
 }
 
@@ -3374,21 +3390,42 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 	struct DEV_OBJECT *hDevObject;
 	DSP_STATUS status = DSP_SOK;
 	struct DCD_NODEPROPS   dcdNodeProps;
+	struct DSP_PROCESSORSTATE procStatus;
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(hProcessor != NULL);
 	DBC_Require(pNodeId != NULL);
 
+	if (hProcessor == NULL || pNodeId == NULL) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
+	status = PROC_GetState(hProcessor, &procStatus,
+			sizeof(struct DSP_PROCESSORSTATE));
+	if (DSP_FAILED(status))
+		goto func_end;
+	/* If processor is in error state then don't attempt
+	    to send the message */
+	if (procStatus.iState == PROC_ERROR) {
+		GT_1trace(NODE_debugMask, GT_5CLASS,
+			"NODE_GetUUIDProps: proc Status 0x%x\n",
+			procStatus.iState);
+		status = DSP_EFAIL;
+		goto func_end;
+	}
+
 	GT_3trace(NODE_debugMask, GT_ENTER,
 		 "NODE_GetUUIDProps: " "\thProcessor: "
 		 "0x%x\tpNodeId: 0x%x" "\tpNodeProps: 0x%x\n", hProcessor,
 		 pNodeId, pNodeProps);
 
 	status = PROC_GetDevObject(hProcessor, &hDevObject);
-	if (DSP_SUCCEEDED(status)) {
+	if (DSP_SUCCEEDED(status) && hDevObject != NULL) {
 		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
-		if (hNodeMgr == NULL)
-			status = DSP_EFAIL;
+		if (hNodeMgr == NULL) {
+			status = DSP_EHANDLE;
+			goto func_end;
+		}
 	}
 
 	/*  Enter the critical section.  This is needed because
@@ -3425,7 +3462,7 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 		(void)SYNC_LeaveCS(hNodeMgr->hSync);
 
 	}
-
+func_end:
 	return status;
 }
 
-- 
1.5.6.4


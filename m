From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH 5/6] DSPBRIDGE: Fixed race condition with DBLL
 target list
Date: Thu, 29 Jan 2009 18:24:48 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F7EA52CB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48848 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbZA3AY4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 19:24:56 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0U0OoAe021779
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:24:55 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0U0Oorc020919
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:24:50 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 28 Jan 2009 19:29:25 -0600
Subject: [PATCH] DSPBRIDGE: Fixed race condition with DBLL target list

Fixed race condition with DBLL target list

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 31d8de9..3242325 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -234,7 +234,6 @@ struct NODE_MGR {
 	struct GB_TMap *zChnlMap;	/* Zero-Copy Channel alloc bit map */
 	struct NTFY_OBJECT *hNtfy;	/* Manages registered notifications */
 	struct SYNC_CSOBJECT *hSync;	/* For critical sections */
-	struct SYNC_CSOBJECT *hAllocSync; /* For NODE_Alloc critical sections */
 	u32 ulFxnAddrs[NUMRMSFXNS];	/* RMS function addresses */
 	struct MSG_MGR *hMsg;
 
@@ -485,7 +484,7 @@ func_cont:
 	}
 	pNode->hNodeMgr = hNodeMgr;
 	/* This critical section protects GetNodeProps */
-	status = SYNC_EnterCS(hNodeMgr->hAllocSync);
+	status = SYNC_EnterCS(hNodeMgr->hSync);
 	if (procId != DSP_UNIT)
 		goto func_cont3;
 
@@ -565,7 +564,7 @@ func_cont:
 	}
 
 func_cont3:
-	(void)SYNC_LeaveCS(hNodeMgr->hAllocSync);
+	(void)SYNC_LeaveCS(hNodeMgr->hSync);
 func_cont1:
 	if (pAttrIn != NULL) {
 		/* Overrides of NBD properties */
@@ -1586,13 +1585,6 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 		status = SYNC_InitializeCS(&pNodeMgr->hSync);
 		if (DSP_FAILED(status))
 			status = DSP_EMEMORY;
-
-		if (DSP_SUCCEEDED(status)) {
-			status = SYNC_InitializeCS(&pNodeMgr->hAllocSync);
-			if (DSP_FAILED(status))
-				status = DSP_EMEMORY;
-
-		}
 	}
 	if (DSP_SUCCEEDED(status)) {
 		pNodeMgr->chnlMap = GB_create(pNodeMgr->ulNumChnls);
@@ -2982,9 +2974,6 @@ static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr)
 		if (hNodeMgr->hSync)
 			SYNC_DeleteCS(hNodeMgr->hSync);
 
-		if (hNodeMgr->hSync)
-			SYNC_DeleteCS(hNodeMgr->hAllocSync);
-
 		if (hNodeMgr->hStrmMgr)
 			STRM_Delete(hNodeMgr->hStrmMgr);
 
@@ -3342,6 +3331,12 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 			status = DSP_EFAIL;
 	}
 
+	/*  Enter the critical section.  This is needed because
+	* DCD_GetObjectDef will ultimately end up calling DBLL_open/close,
+	* which needs to be protected in order to not corrupt the zlib manager
+	* (COD). */
+	status = SYNC_EnterCS(hNodeMgr->hSync);
+
 	if (DSP_SUCCEEDED(status)) {
 		dcdNodeProps.pstrCreatePhaseFxn = NULL;
 		dcdNodeProps.pstrExecutePhaseFxn = NULL;
@@ -3366,6 +3361,9 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 			if (dcdNodeProps.pstrIAlgName)
 				MEM_Free(dcdNodeProps.pstrIAlgName);
 		}
+		/*  Leave the critical section, we're done.  */
+		(void)SYNC_LeaveCS(hNodeMgr->hSync);
+
 	}
 
 	return status;
-- 
1.5.4.3


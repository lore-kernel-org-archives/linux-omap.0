From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: NULL Pointer Dereference fix
Date: Wed, 13 Jan 2010 19:11:16 -0600
Message-ID: <1263431476-19206-4-git-send-email-omar.ramirez@ti.com>
References: <1263431476-19206-1-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-2-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38134 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0ANBUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 20:20:20 -0500
In-Reply-To: <1263431476-19206-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ernesto Ramos <ernesto@ti.com>, Nishanth Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

From: Ernesto Ramos <ernesto@ti.com>

This patch takes care of the possible null pointers
dereferenced within dsp bridge driver.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/nldr.c   |    3 ++-
 drivers/dsp/bridge/rmgr/node.c   |    6 +++---
 drivers/dsp/bridge/rmgr/proc.c   |    9 ++++-----
 drivers/dsp/bridge/wmd/chnl_sm.c |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 24eb9c6..e977a94 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1007,7 +1007,8 @@ DSP_STATUS NLDR_Unload(struct NLDR_NODEOBJECT *hNldrNode, enum NLDR_PHASE phase)
 				/* Unload main library */
 				pRootLib = &hNldrNode->root;
 			}
-			UnloadLib(hNldrNode, pRootLib);
+			if (pRootLib)
+				UnloadLib(hNldrNode, pRootLib);
 		} else {
 			if (hNldrNode->fOverlay)
 				UnloadOvly(hNldrNode, phase);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 9127751..fd9e7cf 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -906,7 +906,7 @@ DSP_STATUS NODE_ChangePriority(struct NODE_OBJECT *hNode, s32 nPriority)
 	GT_2trace(NODE_debugMask, GT_ENTER, "NODE_ChangePriority: "
 		 "hNode: 0x%x\tnPriority: %d\n", hNode, nPriority);
 
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE) || !hNode->hNodeMgr) {
 		GT_1trace(NODE_debugMask, GT_7CLASS,
 			 "Invalid NODE Handle: 0x%x\n", hNode);
 		status = DSP_EHANDLE;
@@ -2612,7 +2612,7 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 
 	GT_1trace(NODE_debugMask, GT_ENTER,
 		 "NODE_Terminate: hNode: 0x%x\n", hNode);
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE) || !hNode->hNodeMgr) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
@@ -3329,7 +3329,7 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 		 pNodeId, pNodeProps);
 
 	status = PROC_GetDevObject(hProcessor, &hDevObject);
-	if (DSP_SUCCEEDED(status) && hDevObject != NULL) {
+	if (!hDevObject) {
 		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
 		if (hNodeMgr == NULL) {
 			status = DSP_EHANDLE;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f88128e..6693651 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -573,12 +573,11 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = NULL;
 
-	if (pr_ctxt && pr_ctxt->hProcessor)
-		pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;
-
 	DBC_Require(cRefs > 0);
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach, args:\n\t"
-		"pr_ctxt->phProcessor:  0x%x\n", *pProcObject);
+	GT_0trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach\n");
+
+	if (pr_ctxt)
+		pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		/* Notify the Client */
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index f0bd986..7c1d7f7 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -326,7 +326,7 @@ DSP_STATUS WMD_CHNL_CancelIO(struct CHNL_OBJECT *hChnl)
 	struct CHNL_MGR *pChnlMgr = NULL;
 
 	/* Check args: */
-	if (MEM_IsValidHandle(pChnl, CHNL_SIGNATURE)) {
+	if (MEM_IsValidHandle(pChnl, CHNL_SIGNATURE) && pChnl->pChnlMgr) {
 		iChnl = pChnl->uId;
 		uMode = pChnl->uMode;
 		pChnlMgr = pChnl->pChnlMgr;
-- 
1.6.2.4


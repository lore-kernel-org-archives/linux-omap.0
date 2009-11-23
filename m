From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: PATCH] DSPBRIDGE: NULL Pointer Dereference fix
Date: Mon, 23 Nov 2009 14:58:24 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA060084FBDDDE@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47375 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbZKWU6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 15:58:17 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nANKwNHG021857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 14:58:23 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nANKwNXx006945
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 14:58:23 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nANKwNKE008839
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 14:58:23 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From f51da1af78be289c9b101154c16e615d135c62c2 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 18 Nov 2009 16:03:42 -0600
Subject: [PATCH] DSPBRIDGE: NULL Pointer Dereference fix

This patch takes care of the possible null pointers dereferenced within dsp bridge driver.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/nldr.c   |    3 ++-
 drivers/dsp/bridge/rmgr/node.c   |    6 +++---
 drivers/dsp/bridge/rmgr/proc.c   |    9 ++++-----
 drivers/dsp/bridge/wmd/chnl_sm.c |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c index 24eb9c6..e977a94 100644
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
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c index 9127751..3f3934c 100644
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
+	if (hDevObject != NULL) {
 		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
 		if (hNodeMgr == NULL) {
 			status = DSP_EHANDLE;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c index bf89ad0..7b3317f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -580,12 +580,11 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
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
1.5.4.5


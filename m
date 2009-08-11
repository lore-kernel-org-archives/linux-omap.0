From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 02/13] DSPBRIDGE: Use pr_ctxt in NODE_Allocate
Date: Tue, 11 Aug 2009 04:21:43 +0300
Message-ID: <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49882 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZHKBWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 21:22:07 -0400
In-Reply-To: <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, suyog@ti.com, roman.tereshonkov@nokia.com, ernesto@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/node.h |    4 ++-
 drivers/dsp/bridge/pmgr/wcd.c               |    2 +-
 drivers/dsp/bridge/rmgr/node.c              |   49 +++------------------------
 3 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index d253962..db3be05 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -68,6 +68,7 @@
 #include <dspbridge/nodedefs.h>
 #include <dspbridge/dispdefs.h>
 #include <dspbridge/nldrdefs.h>
+#include <dspbridge/drv.h>
 
 /*
  *  ======== NODE_Allocate ========
@@ -104,7 +105,8 @@
 					*pArgs,
 					OPTIONAL IN CONST struct DSP_NODEATTRIN
 					*pAttrIn,
-					OUT struct NODE_OBJECT **phNode);
+					OUT struct NODE_OBJECT **phNode,
+					struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== NODE_AllocMsgBuf ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 23ed3a7..05afb2c 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1170,7 +1170,7 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 	if (DSP_SUCCEEDED(status)) {
 		status = NODE_Allocate(args->ARGS_NODE_ALLOCATE.hProcessor,
 				      &nodeId, (struct DSP_CBDATA *)pArgs,
-				      pAttrIn, &hNode);
+				      pAttrIn, &hNode, pr_ctxt);
 	}
 	cp_to_usr(args->ARGS_NODE_ALLOCATE.phNode, &hNode, status, 1);
 func_cont:
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 5ff87e9..b7bdf08 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -389,7 +389,8 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 			IN CONST struct DSP_UUID *pNodeId,
 			OPTIONAL IN CONST struct DSP_CBDATA *pArgs,
 			OPTIONAL IN CONST struct DSP_NODEATTRIN *pAttrIn,
-			OUT struct NODE_OBJECT **phNode)
+			OUT struct NODE_OBJECT **phNode,
+			struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct NODE_MGR *hNodeMgr;
 	struct DEV_OBJECT *hDevObject;
@@ -418,11 +419,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 #endif
 
 #ifndef RES_CLEANUP_DISABLE
-	HANDLE	     hDrvObject;
 	HANDLE	     nodeRes;
-       u32                  hProcess;
-	struct PROCESS_CONTEXT   *pPctxt = NULL;
-	DSP_STATUS res_status = DSP_SOK;
 #endif
 
 	DBC_Require(cRefs > 0);
@@ -789,45 +786,9 @@ func_cont2:
 
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
-		/* Return TGID instead of process handle */
-		hProcess = current->tgid;
-
-		res_status = CFG_GetObject((u32 *)&hDrvObject,
-					  REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
-					 (struct DRV_OBJECT *)hDrvObject,
-					 &pPctxt, *phNode, 0);
-			if (pPctxt == NULL) {
-				DRV_InsertProcContext(
-					(struct DRV_OBJECT *)hDrvObject,
-					&pPctxt);
-				if (pPctxt != NULL) {
-					DRV_ProcUpdatestate(pPctxt,
-							PROC_RES_ALLOCATED);
-                                       DRV_ProcSetPID(pPctxt, hProcess);
-					pPctxt->hProcessor =
-						 (DSP_HPROCESSOR)hProcessor;
-				}
-			}
-		}
-	}
-	if (DSP_SUCCEEDED(status)) {
-		/* Return TGID instead of process handle */
-		hProcess = current->tgid;
-		res_status = CFG_GetObject((u32 *)&hDrvObject,
-					REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
-					 (struct DRV_OBJECT *)hDrvObject,
-					 &pPctxt, *phNode, 0);
-			if (pPctxt != NULL) {
-				DRV_InsertNodeResElement(*phNode, &nodeRes,
-							 pPctxt);
-				DRV_ProcNodeUpdateHeapStatus(nodeRes, true);
-				DRV_ProcNodeUpdateStatus(nodeRes, true);
-			}
-		}
+		DRV_InsertNodeResElement(*phNode, &nodeRes, pr_ctxt);
+		DRV_ProcNodeUpdateHeapStatus(nodeRes, true);
+		DRV_ProcNodeUpdateStatus(nodeRes, true);
 	}
 #endif
 	DBC_Ensure((DSP_FAILED(status) && (*phNode == NULL)) ||
-- 
1.6.2.4


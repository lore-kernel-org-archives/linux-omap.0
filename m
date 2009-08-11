From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 09/13] DSPBRIDGE: Use pr_ctxt in STRM_Open
Date: Tue, 11 Aug 2009 04:21:50 +0300
Message-ID: <1249953714-20972-10-git-send-email-ameya.palande@nokia.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-7-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-8-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-9-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28874 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZHKBWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 21:22:17 -0400
In-Reply-To: <1249953714-20972-9-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, suyog@ti.com, roman.tereshonkov@nokia.com, ernesto@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/strm.h |    4 ++-
 drivers/dsp/bridge/pmgr/wcd.c               |    3 +-
 drivers/dsp/bridge/rmgr/strm.c              |   28 +++++++-------------------
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 5825615..36b128d 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -59,6 +59,7 @@
 #include <dspbridge/dev.h>
 
 #include <dspbridge/strmdefs.h>
+#include <dspbridge/proc.h>
 
 /*
  *  ======== STRM_AllocateBuffer ========
@@ -307,7 +308,8 @@
  */
 	extern DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir,
 				    u32 uIndex, IN struct STRM_ATTR *pAttr,
-				    OUT struct STRM_OBJECT **phStrm);
+				    OUT struct STRM_OBJECT **phStrm,
+				    struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_PrepareBuffer ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 4f902a3..cf3fc2d 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1626,7 +1626,8 @@ u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt)
 	}
 	status = STRM_Open(args->ARGS_STRM_OPEN.hNode,
 			  args->ARGS_STRM_OPEN.uDirection,
-			  args->ARGS_STRM_OPEN.uIndex, &attr, &pStrm);
+			  args->ARGS_STRM_OPEN.uIndex, &attr, &pStrm,
+			  pr_ctxt);
 	cp_to_usr(args->ARGS_STRM_OPEN.phStream, &pStrm, status, 1);
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index b6dbe46..4a05ed4 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -626,7 +626,9 @@ DSP_STATUS STRM_Issue(struct STRM_OBJECT *hStrm, IN u8 *pBuf, u32 ulBytes,
  *      XDAIS socket node on the DSP.
  */
 DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
-		    IN struct STRM_ATTR *pAttr, OUT struct STRM_OBJECT **phStrm)
+		    IN struct STRM_ATTR *pAttr,
+		    OUT struct STRM_OBJECT **phStrm,
+		    struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct STRM_MGR *hStrmMgr;
 	struct WMD_DRV_INTERFACE *pIntfFxns;
@@ -637,13 +639,10 @@ DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
 	DSP_STATUS status = DSP_SOK;
 	struct CMM_OBJECT *hCmmMgr = NULL;	/* Shared memory manager hndl */
 
-	#ifndef RES_CLEANUP_DISABLE
-	DSP_STATUS res_status = DSP_SOK;
-       u32                  hProcess;
-	HANDLE	     pCtxt = NULL;
-	HANDLE	     hDrvObject;
-	HANDLE 		    hSTRMRes;
-	#endif
+#ifndef RES_CLEANUP_DISABLE
+	HANDLE              hSTRMRes;
+#endif
+
 	DBC_Require(cRefs > 0);
 	DBC_Require(phStrm != NULL);
 	DBC_Require(pAttr != NULL);
@@ -779,18 +778,7 @@ func_cont:
 		(void)DeleteStrm(pStrm);
 
 #ifndef RES_CLEANUP_DISABLE
-	/* Return TGID instead of process handle */
-	hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext(hProcess,
-				 (struct DRV_OBJECT *)hDrvObject, &pCtxt,
-				 hNode, 0);
-		if (pCtxt != NULL)
-			DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pCtxt);
-
-	}
+	DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pr_ctxt);
 #endif
 
 	 /* ensure we return a documented error code */
-- 
1.6.2.4


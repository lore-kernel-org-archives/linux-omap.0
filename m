From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 11/13] DSPBRIDGE: Use pr_ctxt in STRM_AllocateBuffer
Date: Tue, 11 Aug 2009 04:21:52 +0300
Message-ID: <1249953714-20972-12-git-send-email-ameya.palande@nokia.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-7-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-8-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-9-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-10-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-11-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49894 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbZHKBWP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 21:22:15 -0400
In-Reply-To: <1249953714-20972-11-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, suyog@ti.com, roman.tereshonkov@nokia.com, ernesto@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/strm.h |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c               |    2 +-
 drivers/dsp/bridge/rmgr/strm.c              |   28 ++++++--------------------
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 23a9f17..9929210 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -84,7 +84,8 @@
 	extern DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm,
 					      u32 uSize,
 					      OUT u8 **apBuffer,
-					      u32 uNumBufs);
+					      u32 uNumBufs,
+					      struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_Close ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index c9b29ea..4fdcb18 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1493,7 +1493,7 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 
 	status = STRM_AllocateBuffer(args->ARGS_STRM_ALLOCATEBUFFER.hStream,
 				     args->ARGS_STRM_ALLOCATEBUFFER.uSize,
-				     apBuffer, uNumBufs);
+				     apBuffer, uNumBufs, pr_ctxt);
 	cp_to_usr(args->ARGS_STRM_ALLOCATEBUFFER.apBuffer, apBuffer, status,
 		 uNumBufs);
 	if (apBuffer)
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index e25818f..d68251f 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -154,18 +154,15 @@ static void DeleteStrmMgr(struct STRM_MGR *hStrmMgr);
  *      Allocates buffers for a stream.
  */
 DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
-				OUT u8 **apBuffer, u32 uNumBufs)
+				OUT u8 **apBuffer, u32 uNumBufs,
+				struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 uAllocated = 0;
 	u32 i;
-	#ifndef RES_CLEANUP_DISABLE
-	DSP_STATUS res_status = DSP_SOK;
-       u32                  hProcess;
-	HANDLE	     pCtxt = NULL;
-	HANDLE	     hDrvObject;
+#ifndef RES_CLEANUP_DISABLE
 	HANDLE hSTRMRes;
-	#endif
+#endif
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
@@ -203,20 +200,9 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	/* Return TGID instead of process handle */
-	hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
-		goto func_end;
-
-       DRV_GetProcContext(hProcess, (struct DRV_OBJECT *)hDrvObject,
-			 &pCtxt, NULL, 0);
-	if (pCtxt != NULL) {
-		if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pCtxt) !=
-		   DSP_ENOTFOUND) {
-			DRV_ProcUpdateSTRMRes(uNumBufs, hSTRMRes, pCtxt);
-		}
+	if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pr_ctxt) !=
+			DSP_ENOTFOUND) {
+		DRV_ProcUpdateSTRMRes(uNumBufs, hSTRMRes, pr_ctxt);
 	}
 #endif
 func_end:
-- 
1.6.2.4


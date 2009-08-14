From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 10/13] DSPBRIDGE: Use pr_ctxt in STRM_Close
Date: Fri, 14 Aug 2009 14:28:54 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D3F@dlee06.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57416 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498AbZHNT3D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:29:03 -0400
In-Reply-To: <1249953714-20972-11-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Moogi, Suyog" <suyog@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>


Acked-by: Fernando Guzman Lugo <x0095840@ti.com>

Regards,
Fernando.

-----Original Message-----
From: Ameya Palande [mailto:ameya.palande@nokia.com] 
Sent: Monday, August 10, 2009 8:22 PM
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando; Moogi, Suyog; roman.tereshonkov@nokia.com; Ramos Falcon, Ernesto
Subject: [PATCH 10/13] DSPBRIDGE: Use pr_ctxt in STRM_Close

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/strm.h |    3 ++-
 drivers/dsp/bridge/pmgr/wcd.c               |    6 +-----
 drivers/dsp/bridge/rmgr/drv.c               |    5 +++--
 drivers/dsp/bridge/rmgr/strm.c              |   27 +++++----------------------
 4 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 36b128d..23a9f17 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -102,7 +102,8 @@
  *      STRM_Init(void) called.
  *  Ensures:
  */
-	extern DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm);
+	extern DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
+			struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_Create ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index cf3fc2d..c9b29ea 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1507,11 +1507,7 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
  */
 u32 STRMWRAP_Close(union Trapped_Args *args, void *pr_ctxt)
 {
-	u32 retVal;
-
-	retVal = STRM_Close(args->ARGS_STRM_CLOSE.hStream);
-
-	return retVal;
+	return STRM_Close(args->ARGS_STRM_CLOSE.hStream, pr_ctxt);
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 6cfd349..bf7d0b2 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -801,14 +801,15 @@ static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt)
 						pSTRMRes->uNumBufs);
 			MEM_Free(apBuffer);
 		}
-		status = STRM_Close(pSTRMRes->hStream);
+		status = STRM_Close(pSTRMRes->hStream, pCtxt);
 		if (DSP_FAILED(status)) {
 			if (status == DSP_EPENDING) {
 				status = STRM_Reclaim(pSTRMRes->hStream,
 						     &pBufPtr, &ulBytes,
 						     (u32 *)&ulBufSize, &dwArg);
 				if (DSP_SUCCEEDED(status))
-					status = STRM_Close(pSTRMRes->hStream);
+					status = STRM_Close(pSTRMRes->hStream,
+							pCtxt);
 
 			}
 		}
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 4a05ed4..e25818f 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -228,22 +228,17 @@ func_end:
  *  Purpose:
  *      Close a stream opened with STRM_Open().
  */
-DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm)
+DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct WMD_DRV_INTERFACE *pIntfFxns;
 	struct CHNL_INFO chnlInfo;
 	DSP_STATUS status = DSP_SOK;
 
-
 #ifndef RES_CLEANUP_DISABLE
-    u32                      hProcess;
-    HANDLE	      pCtxt = NULL;
-    HANDLE	      hDrvObject;
     HANDLE	      hSTRMRes;
-    DSP_STATUS	  res_status = DSP_SOK;
 #endif
 
-
 	DBC_Require(cRefs > 0);
 
 	GT_1trace(STRM_debugMask, GT_ENTER, "STRM_Close: hStrm: 0x%x\n", hStrm);
@@ -276,21 +271,9 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm)
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	/* Update the node and stream resource status */
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
-			DRV_ProcRemoveSTRMResElement(hSTRMRes, pCtxt);
-		}
+	if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pr_ctxt) !=
+			DSP_ENOTFOUND) {
+		DRV_ProcRemoveSTRMResElement(hSTRMRes, pr_ctxt);
 	}
 func_end:
 #endif
-- 
1.6.2.4



From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 12/13] DSPBRIDGE: Use pr_ctxt in STRM_FreeBuffer_
Date: Fri, 14 Aug 2009 14:33:01 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D44@dlee06.ent.ti.com>
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
 <1249953714-20972-12-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-13-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757012AbZHNTdJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:33:09 -0400
In-Reply-To: <1249953714-20972-13-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Moogi, Suyog" <suyog@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>


Hi,

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


-----Original Message-----
From: Ameya Palande [mailto:ameya.palande@nokia.com] 
Sent: Monday, August 10, 2009 8:22 PM
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando; Moogi, Suyog; roman.tereshonkov@nokia.com; Ramos Falcon, Ernesto
Subject: [PATCH 12/13] DSPBRIDGE: Use pr_ctxt in STRM_FreeBuffer_

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/strm.h |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c               |    2 +-
 drivers/dsp/bridge/rmgr/drv.c               |    2 +-
 drivers/dsp/bridge/rmgr/strm.c              |   33 ++++++--------------------
 4 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 9929210..71ea2a6 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -175,7 +175,8 @@
  *  Ensures:
  */
 	extern DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm,
-					  u8 **apBuffer, u32 uNumBufs);
+					  u8 **apBuffer, u32 uNumBufs,
+					  struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_GetEventHandle ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 4fdcb18..8ba6895 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1528,7 +1528,7 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 
 	if (DSP_SUCCEEDED(status)) {
 		status = STRM_FreeBuffer(args->ARGS_STRM_FREEBUFFER.hStream,
-					 apBuffer, uNumBufs);
+					 apBuffer, uNumBufs, pr_ctxt);
 	}
 	cp_to_usr(args->ARGS_STRM_FREEBUFFER.apBuffer, apBuffer, status,
 		 uNumBufs);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index bf7d0b2..e880ea8 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -798,7 +798,7 @@ static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt)
 			apBuffer = MEM_Alloc((pSTRMRes->uNumBufs *
 					    sizeof(u8 *)), MEM_NONPAGED);
 			status = STRM_FreeBuffer(pSTRMRes->hStream, apBuffer,
-						pSTRMRes->uNumBufs);
+						pSTRMRes->uNumBufs, pCtxt);
 			MEM_Free(apBuffer);
 		}
 		status = STRM_Close(pSTRMRes->hStream, pCtxt);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index d68251f..0ef43ea 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -194,7 +194,7 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 		}
 	}
 	if (DSP_FAILED(status))
-		STRM_FreeBuffer(hStrm, apBuffer, uAllocated);
+		STRM_FreeBuffer(hStrm, apBuffer, uAllocated, pr_ctxt);
 
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_FAILED(status))
@@ -363,18 +363,14 @@ void STRM_Exit(void)
  *      Frees the buffers allocated for a stream.
  */
 DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
-			  u32 uNumBufs)
+		u32 uNumBufs, struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 i = 0;
 
-	#ifndef RES_CLEANUP_DISABLE
-	DSP_STATUS res_status = DSP_SOK;
-       u32                  hProcess;
-	HANDLE	     pCtxt = NULL;
-	HANDLE	     hDrvObject;
-	HANDLE 		    hSTRMRes = NULL;
-	#endif
+#ifndef RES_CLEANUP_DISABLE
+	HANDLE hSTRMRes = NULL;
+#endif
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
@@ -398,22 +394,9 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 		}
 	}
 #ifndef RES_CLEANUP_DISABLE
-	/* Update the node and stream resource status */
-	/* Return TGID instead of process handle */
-	hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext(hProcess,
-				 (struct DRV_OBJECT *)hDrvObject, &pCtxt,
-				 NULL, 0);
-		if (pCtxt != NULL) {
-			if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pCtxt) !=
-			   DSP_ENOTFOUND) {
-				DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes,
-						     pCtxt);
-			}
-		}
+	if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pr_ctxt) !=
+			DSP_ENOTFOUND) {
+		DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes, pr_ctxt);
 	}
 #endif
 	return status;
-- 
1.6.2.4



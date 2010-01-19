From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/6] DSPBRIDGE: Remove unused variables from resource cleanup
Date: Tue, 19 Jan 2010 14:54:07 -0600
Message-ID: <1263934449-16891-5-git-send-email-omar.ramirez@ti.com>
References: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-2-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-3-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43595 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755496Ab0ASUoF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 15:44:05 -0500
In-Reply-To: <1263934449-16891-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch removes an unused variable parameter from
resource cleanup code.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    3 +--
 drivers/dsp/bridge/rmgr/drv.c                      |    5 +----
 drivers/dsp/bridge/rmgr/strm.c                     |    4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index a6f4397..4ded5aa 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -63,8 +63,7 @@ extern DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE dmmRes,
 
 extern DSP_STATUS DRV_RemoveDMMResElement(HANDLE dmmRes, HANDLE pCtxt);
 
-extern DSP_STATUS DRV_ProcUpdateSTRMRes(u32 uNumBufs, HANDLE STRMRes,
-					HANDLE pCtxt);
+extern DSP_STATUS DRV_ProcUpdateSTRMRes(u32 uNumBufs, HANDLE STRMRes);
 
 extern DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStrm, HANDLE STRMRes,
 						HANDLE pPctxt);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 7e85095..56ceb6c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -339,7 +339,6 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	struct DMM_RES_OBJECT **pDMMRes = (struct DMM_RES_OBJECT **)hDMMRes;
 	DSP_STATUS status = DSP_SOK;
-	struct DMM_RES_OBJECT *pTempDMM2 = NULL;
 	struct DMM_RES_OBJECT *pTempDMM = NULL;
 
 	DBC_Assert(hPCtxt != NULL);
@@ -349,7 +348,6 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 			 "DRV_GetDMMResElement: 2 pTempDMM:%x "
 			 "pTempDMM->ulDSPAddr:%x pMapAddr:%x\n", pTempDMM,
 			 pTempDMM->ulDSPAddr, pMapAddr);
-		pTempDMM2 = pTempDMM;
 		pTempDMM = pTempDMM->next;
 	}
 	if (pTempDMM != NULL) {
@@ -579,12 +577,11 @@ DSP_STATUS DRV_GetSTRMResElement(HANDLE hStrm, HANDLE hSTRMRes, HANDLE hPCtxt)
 }
 
 /* Updating the stream resource element */
-DSP_STATUS DRV_ProcUpdateSTRMRes(u32 uNumBufs, HANDLE hSTRMRes, HANDLE hPCtxt)
+DSP_STATUS DRV_ProcUpdateSTRMRes(u32 uNumBufs, HANDLE hSTRMRes)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct STRM_RES_OBJECT **STRMRes = (struct STRM_RES_OBJECT **)hSTRMRes;
 
-	DBC_Assert(hPCtxt != NULL);
 	(*STRMRes)->uNumBufs = uNumBufs;
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index b0b4d32..febb6c2 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -158,7 +158,7 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 
 	if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pr_ctxt) !=
 			DSP_ENOTFOUND)
-		DRV_ProcUpdateSTRMRes(uNumBufs, hSTRMRes, pr_ctxt);
+		DRV_ProcUpdateSTRMRes(uNumBufs, hSTRMRes);
 #endif
 func_end:
 	return status;
@@ -340,7 +340,7 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 #ifndef RES_CLEANUP_DISABLE
 	if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pr_ctxt) !=
 			DSP_ENOTFOUND)
-		DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes, pr_ctxt);
+		DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes);
 #endif
 	return status;
 }
-- 
1.6.2.4


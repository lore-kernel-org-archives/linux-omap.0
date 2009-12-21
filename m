From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 4/4] DSPBRIDGE: Remove unused variables.
Date: Mon, 21 Dec 2009 16:52:46 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A9F8ABDC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43699 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755599AbZLUWws convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 17:52:48 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBLMqmAW024956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:52:48 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBLMqlVq001581
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:52:47 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBLMqlqp006730
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:52:47 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From b2090120a5f816a788113edceb753caec25de0b2 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 18 Dec 2009 21:06:07 -0600
Subject: [PATCH] DSPBRIDGE: Remove unused variables.

This patch removes an unused variable and an unused
parameter and also a false comment.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    3 +--
 drivers/dsp/bridge/rmgr/drv.c                      |   12 ++++--------
 drivers/dsp/bridge/rmgr/strm.c                     |    4 ++--
 3 files changed, 7 insertions(+), 12 deletions(-)

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
index a44916b..a5a9552 100644
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
@@ -1141,11 +1138,9 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 				iounmap((void *)pResources->dwPerPmBase);
 			if (pResources->dwCorePmBase)
 				iounmap((void *)pResources->dwCorePmBase);
-			if (pResources->dwSysCtrlBase) {
+			if (pResources->dwSysCtrlBase)
 				iounmap(pResources->dwSysCtrlBase);
-				/* don't set pResources->dwSysCtrlBase to null
-				 * as it is used in BOARD_Stop */
-			}
+
 			pResources->dwPrmBase = NULL;
 			pResources->dwCmBase = NULL;
 			pResources->dwMboxBase = NULL;
@@ -1155,6 +1150,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 			pResources->dwMemBase[4] = (u32) NULL;
 			pResources->dwWdTimerDspBase = NULL;
 			pResources->dwDmmuBase = NULL;
+			pResources->dwSysCtrlBase = NULL;
 
 			dwBuffSize = sizeof(struct CFG_HOSTRES);
 			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
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
1.6.0.4


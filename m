From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 3/4] DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
Date: Thu, 18 Feb 2010 16:40:52 +0200
Message-ID: <9fb63d8737768758ac367ff242c4142f38ce7427.1266503387.git.ameya.palande@nokia.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>
 <a04c367d97579eefc30bc1d2c4dd98a53bc468ac.1266503387.git.ameya.palande@nokia.com>
 <0fd274366a6ad4fda3d20103f52a314bb6ebef57.1266503387.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36534 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab0BROly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 09:41:54 -0500
In-Reply-To: <0fd274366a6ad4fda3d20103f52a314bb6ebef57.1266503387.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1266503387.git.ameya.palande@nokia.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, x0095840@ti.com, omar.ramirez@ti.com

This patch fixes following issues:

1. pDMMRes was dereferenced and modified when it was already freed by
   PROC_Ummap(). This results in memory corruption.

2. Instead of passing ulDSPAddr, ulDSPResAddr was passed to PROC_UnMap()
   which will not retrieve correct DMMRes element.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 12ba7e0..b88b5a3 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -293,12 +293,12 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 		pDMMRes = pDMMList;
 		pDMMList = pDMMList->next;
 		if (pDMMRes->dmmAllocated) {
+			/* PROC_UnMap will free pDMMRes pointer */
 			status = PROC_UnMap(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
+				 (void *)pDMMRes->ulDSPAddr, pCtxt);
 			if (DSP_FAILED(status))
 				pr_debug("%s: PROC_UnMap failed! status ="
 						" 0x%xn", __func__, status);
-			pDMMRes->dmmAllocated = 0;
 		}
 	}
 	return status;
@@ -309,17 +309,9 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
-	struct DMM_MAP_OBJECT *pTempDMMRes2 = NULL;
-	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
 	struct DMM_RSV_OBJECT *temp, *rsv_obj;
 
 	DRV_ProcFreeDMMRes(pCtxt);
-	pTempDMMRes = pCtxt->dmm_map_list;
-	while (pTempDMMRes != NULL) {
-		pTempDMMRes2 = pTempDMMRes;
-		pTempDMMRes = pTempDMMRes->next;
-		kfree(pTempDMMRes2);
-	}
 	pCtxt->dmm_map_list = NULL;
 
 	/* Free DMM reserved memory resources */
-- 
1.6.3.3


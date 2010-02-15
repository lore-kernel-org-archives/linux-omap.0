From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
Date: Mon, 15 Feb 2010 17:36:31 +0200
Message-ID: <018f9cad9a346b7a841268f4520a73a98c9cf7c9.1266246072.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29865 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0BOPhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 10:37:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, deepak.chitriki@ti.com, linux-omap@vger.kernel.org, felipe.contreras@nokia.com, x0095840@ti.com

This patch fixes following issues:

1. pDMMRes was dereferenced and modified when it was already freed by
PROC_Ummap(). This results in memory corruption.

2.Instead of passing ulDSPAddr, ulDSPResAddr was passed to PROC_UnMap()
which will not retrieve correct DMMRes element.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 9d5c077..747b34c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -273,11 +273,14 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 		pDMMList = pDMMList->next;
 		if (pDMMRes->dmmAllocated) {
 			status = PROC_UnMap(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
+				 (void *)pDMMRes->ulDSPAddr, pCtxt);
+			/*
+			 * PROC_UnMap has freed pDMMRes pointer, so don't access
+			 * it now
+			 */
 			if (DSP_FAILED(status))
 				pr_debug("%s: PROC_UnMap failed! status ="
 						" 0x%xn", __func__, status);
-			pDMMRes->dmmAllocated = 0;
 		}
 	}
 	return status;
@@ -288,17 +291,9 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
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


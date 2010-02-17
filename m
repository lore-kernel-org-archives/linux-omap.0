From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv4 3/4] DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
Date: Wed, 17 Feb 2010 20:05:40 +0200
Message-ID: <5403b3fb5b4b426d50151571d68f332da03491be.1266429437.git.ameya.palande@nokia.com>
References: <cover.1266429436.git.ameya.palande@nokia.com>
 <ebee89889a45310eb63a19b133eba29801e9a519.1266429436.git.ameya.palande@nokia.com>
 <7b2296a1856ed89b24b63b978a15acfe675e12ce.1266429437.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43172 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0BQSGj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 13:06:39 -0500
In-Reply-To: <7b2296a1856ed89b24b63b978a15acfe675e12ce.1266429437.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1266429436.git.ameya.palande@nokia.com>
References: <cover.1266429436.git.ameya.palande@nokia.com>
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


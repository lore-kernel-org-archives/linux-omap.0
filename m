From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 13/13] DSPBRIDGE: Removal of DRV_GetProcContext
Date: Fri, 14 Aug 2009 14:34:04 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D45@dlee06.ent.ti.com>
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
 <1249953714-20972-14-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36187 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167AbZHNTeM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:34:12 -0400
In-Reply-To: <1249953714-20972-14-git-send-email-ameya.palande@nokia.com>
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
Subject: [PATCH 13/13] DSPBRIDGE: Removal of DRV_GetProcContext

Use filp->private_data instead of DRV_GetProcContext

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    5 --
 drivers/dsp/bridge/rmgr/drv.c                      |   71 --------------------
 2 files changed, 0 insertions(+), 76 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index 5592f38..9ddf1b3 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -35,11 +35,6 @@ extern DSP_STATUS DRV_ProcUpdatestate(HANDLE pCtxt,
 
 extern DSP_STATUS DRV_ProcSetPID(HANDLE pCtxt, s32 hProcess);
 
-extern DSP_STATUS DRV_GetProcContext(u32 phProcess,
-				struct DRV_OBJECT *hDrvObject,
-				HANDLE hPCtxt, DSP_HNODE hNode,
-				u32 pMapAddr);
-
 extern DSP_STATUS DRV_RemoveAllResources(HANDLE pPctxt);
 
 extern DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index e880ea8..0432a4b 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -198,77 +198,6 @@ DSP_STATUS DRV_GetProcCtxtList(struct PROCESS_CONTEXT **pPctxt,
 	return status;
 }
 
-
-
-/* Get a particular process context based on process handle (phProcess) */
-DSP_STATUS DRV_GetProcContext(u32 phProcess,
-				struct DRV_OBJECT *hDrvObject,
-				HANDLE hPCtxt, DSP_HNODE hNode,
-				u32 pMapAddr)
-{
-	struct PROCESS_CONTEXT **pCtxt = (struct PROCESS_CONTEXT **)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-	struct PROCESS_CONTEXT *pCtxtList = NULL;
-	struct DRV_OBJECT *pDrvObject = (struct DRV_OBJECT *)hDrvObject;
-	struct NODE_RES_OBJECT *pTempNode2 = NULL;
-	struct NODE_RES_OBJECT *pTempNode = NULL;
-	struct DMM_RES_OBJECT *pTempDMM2 = NULL;
-	struct DMM_RES_OBJECT *pTempDMM = NULL;
-	s32 pCtxtFound = 0;
-
-	DBC_Assert(pDrvObject != NULL);
-	pCtxtList = pDrvObject->procCtxtList;
-	GT_0trace(curTrace, GT_ENTER, "2DRV_GetProcContext: 2");
-	while ((pCtxtList != NULL) && (pCtxtList->pid != phProcess)) {
-		pCtxtList = pCtxtList->next;
-		GT_0trace(curTrace, GT_ENTER, "2DRV_GetProcContext: 3");
-	}
-	if (pCtxtList == NULL) {
-		if (hNode != NULL) {
-			pCtxtList = pDrvObject->procCtxtList;
-			while ((pCtxtList != NULL) && (pCtxtFound == 0)) {
-				pTempNode = pCtxtList->pNodeList;
-				while ((pTempNode != NULL) &&
-				      (pTempNode->hNode != hNode)) {
-					pTempNode2 = pTempNode;
-					pTempNode = pTempNode->next;
-				}
-				if (pTempNode != NULL) {
-					pCtxtFound = 1;
-					status = DSP_SOK;
-				} else {
-					pCtxtList = pCtxtList->next;
-				}
-			}
-		} else if ((pMapAddr != 0) && (pCtxtFound == 0)) {
-			pCtxtList = pDrvObject->procCtxtList;
-			while ((pCtxtList != NULL) && (pCtxtFound == 0)) {
-				pTempDMM = pCtxtList->pDMMList;
-				while ((pTempDMM != NULL) &&
-				     (pTempDMM->ulDSPAddr != pMapAddr)) {
-					pTempDMM2 = pTempDMM;
-					pTempDMM = pTempDMM->next;
-				}
-				if (pTempDMM != NULL) {
-					pCtxtFound = 1;
-					status = DSP_SOK;
-				} else {
-					pCtxtList = pCtxtList->next;
-				}
-			}
-			if (pCtxtList == NULL)
-				status = DSP_ENOTFOUND;
-
-		}
-	} else{
-		status = DSP_SOK;
-	}
-	GT_0trace(curTrace, GT_ENTER, "2DRV_GetProcContext: 4");
-	*pCtxt = pCtxtList;
-	return status;
-}
-
-
 /* Add a new process context to process context list */
 DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt)
 {
-- 
1.6.2.4



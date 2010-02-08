From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Prevent memory corruption in DRV_ProcFreeDMMRes
Date: Mon,  8 Feb 2010 22:25:40 +0200
Message-ID: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41987 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0BHU0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 15:26:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com, felipe.contreras@nokia.com, ext-phil.2.carmody@nokia.com

Background: bridge_close() has the responsibility to cleanup all the
resources allocated by user space process. One of those resources is
DMMRes which is used for tracking DMM resource allocation done in
PROC_Map() and PROC_UnMap().

DRV_ProcFreeDMMRes() function was used for cleaning up DMMRes has following
problems which are fixed by this patch:

1. It access and modifies pDMMRes pointer when it is already freed by
PROC_UnMap()
2. Instead of passing ulDSPAddr it passes ulDSPResAddr to PROC_UnMap() which
will not retrive correct DMMRes element.

CC: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Deepak Chitriki Rudramuni <deepak.chitriki@ti.com>
CC: Felipe Contreras <felipe.contreras@nokia.com>
CC: Phil Carmody <ext-phil.2.carmody@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h         |   14 ----
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    4 +-
 drivers/dsp/bridge/rmgr/drv.c                      |   63 ++++++++------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |    7 +-
 4 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index b6a5fd2..ba11359 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -384,18 +384,4 @@ struct PROCESS_CONTEXT{
  */
 	extern DSP_STATUS DRV_ReleaseResources(IN u32 dwContext,
 					       struct DRV_OBJECT *hDrvObject);
-
-/*
- *  ======== DRV_ProcFreeDMMRes ========
- *  Purpose:
- *       Actual DMM De-Allocation.
- *  Parameters:
- *      hPCtxt:      Path to the driver Registry Key.
- *  Returns:
- *      DSP_SOK if success;
- */
-
-
-	extern DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt);
-
 #endif				/* DRV_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index ffbcf5e..d399a2e 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -25,13 +25,13 @@ extern DSP_STATUS DRV_GetProcCtxtList(struct PROCESS_CONTEXT **pPctxt,
 extern DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject,
 					HANDLE hPCtxt);
 
-extern DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE pCtxt);
+extern DSP_STATUS DRV_Remove_All_DMM_Res_Elements(HANDLE hPCtxt);
 
 extern DSP_STATUS DRV_RemoveAllNodeResElements(HANDLE pCtxt);
 
 extern DSP_STATUS DRV_ProcSetPID(HANDLE pCtxt, s32 hProcess);
 
-extern DSP_STATUS DRV_RemoveAllResources(HANDLE pPctxt);
+extern void DRV_RemoveAllResources(HANDLE pPctxt);
 
 extern DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
 				     HANDLE pr_ctxt);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index eca46ca..570f8a4 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -259,52 +259,39 @@ DSP_STATUS DRV_UpdateDMMResElement(HANDLE hDMMRes, u32 pMpuAddr, u32 ulSize,
 	return status;
 }
 
-/* Actual DMM De-Allocation */
-DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
+/* Release all DMM resources and its context */
+DSP_STATUS DRV_Remove_All_DMM_Res_Elements(HANDLE hPCtxt)
 {
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
+	struct PROCESS_CONTEXT *p_ctxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
-	struct DMM_RES_OBJECT *pDMMList = pCtxt->pDMMList;
-	struct DMM_RES_OBJECT *pDMMRes = NULL;
-
-	GT_0trace(curTrace, GT_ENTER, "\nDRV_ProcFreeDMMRes: 1\n");
-	while (pDMMList != NULL) {
-		pDMMRes = pDMMList;
-		pDMMList = pDMMList->next;
-		if (pDMMRes->dmmAllocated) {
-			status = PROC_UnMap(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
+	struct DMM_RES_OBJECT *p_dmm_list = p_ctxt->pDMMList;
+	struct DMM_RES_OBJECT *p_cur_res;
+
+	while (p_dmm_list) {
+		p_cur_res = p_dmm_list;
+		p_dmm_list = p_dmm_list->next;
+		if (p_cur_res->dmmAllocated) {
+			/*
+			 * PROC_UnMap will free memory allocated to p_cur_res
+			 * pointer. So we need to save following data for the
+			 * execution of PROC_UnReserveMemory()
+			 */
+			void *h_processor = p_cur_res->hProcessor;
+			u32 dsp_res_addr = p_cur_res->ulDSPResAddr;
+
+			status = PROC_UnMap(p_cur_res->hProcessor,
+				 (void *)p_cur_res->ulDSPAddr, p_ctxt);
 			if (DSP_FAILED(status))
 				pr_debug("%s: PROC_UnMap failed! status ="
-						" 0x%xn", __func__, status);
-			status = PROC_UnReserveMemory(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPResAddr);
+						" 0x%x\n", __func__, status);
+			status = PROC_UnReserveMemory(h_processor,
+				 (void *)dsp_res_addr);
 			if (DSP_FAILED(status))
 				pr_debug("%s: PROC_UnReserveMemory failed!"
-					" status = 0x%xn", __func__, status);
-			pDMMRes->dmmAllocated = 0;
+					" status = 0x%x\n", __func__, status);
 		}
 	}
-	return status;
-}
-
-/* Release all DMM resources and its context
-* This is called from .bridge_release. */
-DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-	struct DMM_RES_OBJECT *pTempDMMRes2 = NULL;
-	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
-
-	DRV_ProcFreeDMMRes(pCtxt);
-	pTempDMMRes = pCtxt->pDMMList;
-	while (pTempDMMRes != NULL) {
-		pTempDMMRes2 = pTempDMMRes;
-		pTempDMMRes = pTempDMMRes->next;
-		MEM_Free(pTempDMMRes2);
-	}
-	pCtxt->pDMMList = NULL;
+	p_ctxt->pDMMList = NULL;
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 625f88e..2e56704 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -604,15 +604,14 @@ static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
 
 /* To remove all process resources before removing the process from the
  * process context list*/
-DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
+void DRV_RemoveAllResources(HANDLE hPCtxt)
 {
-	DSP_STATUS status = DSP_SOK;
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DRV_RemoveAllSTRMResElements(pCtxt);
 	DRV_RemoveAllNodeResElements(pCtxt);
-	DRV_RemoveAllDMMResElements(pCtxt);
+	DRV_Remove_All_DMM_Res_Elements(pCtxt);
 	pCtxt->resState = PROC_RES_FREED;
-	return status;
+	return;
 }
 
 /* Bridge driver initialization and de-initialization functions */
-- 
1.6.3.3


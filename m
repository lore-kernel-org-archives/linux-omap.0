From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 1/4] DSPBRIDGE: Rename DMM_RES_OBJECT to DMM_MAP_OBJECT
Date: Thu, 18 Feb 2010 16:40:50 +0200
Message-ID: <a04c367d97579eefc30bc1d2c4dd98a53bc468ac.1266503387.git.ameya.palande@nokia.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17332 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757593Ab0BROlw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 09:41:52 -0500
In-Reply-To: <cover.1266503387.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1266503387.git.ameya.palande@nokia.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, x0095840@ti.com, omar.ramirez@ti.com

In its current state DMM_RES_OBJECT is not correctly tracking reserve and
unreserve but only map and unmap. So lets rename it to DMM_MAP_OBJECT to
clarify what it is really doing!

In addition to this, this patch also does some trivial code cleanup.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Reviewed-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h |   14 +++---
 drivers/dsp/bridge/rmgr/drv.c              |   69 ++++++++++++++--------------
 drivers/dsp/bridge/rmgr/drv_interface.c    |    2 +-
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index b044291..d5f5277 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -90,15 +90,15 @@ struct NODE_RES_OBJECT {
 	struct NODE_RES_OBJECT         *next;
 } ;
 
-/* New structure (member of process context) abstracts DMM resource info */
-struct DMM_RES_OBJECT {
+/* Abstracts DMM resource info */
+struct DMM_MAP_OBJECT {
 	s32            dmmAllocated; /* DMM status */
 	u32           ulMpuAddr;
 	u32           ulDSPAddr;
 	u32           ulDSPResAddr;
-	u32           dmmSize;
+	u32           size;
 	HANDLE          hProcessor;
-	struct DMM_RES_OBJECT  *next;
+	struct DMM_MAP_OBJECT  *next;
 } ;
 
 /* New structure (member of process context) abstracts DMM resource info */
@@ -139,9 +139,9 @@ struct PROCESS_CONTEXT{
 	struct NODE_RES_OBJECT *pNodeList;
 	struct mutex node_mutex;
 
-	/* DMM resources */
-	struct DMM_RES_OBJECT *pDMMList;
-	struct mutex dmm_mutex;
+	/* DMM mapped memory resources */
+	struct DMM_MAP_OBJECT *dmm_map_list;
+	struct mutex dmm_map_mutex;
 
 	/* DSP Heap resources */
 	struct DSPHEAP_RES_OBJECT *pDSPHEAPList;
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index e8b2c58..9b513e2 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -198,37 +198,37 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	struct DMM_RES_OBJECT **pDMMRes = (struct DMM_RES_OBJECT **)hDMMRes;
+	struct DMM_MAP_OBJECT **pDMMRes = (struct DMM_MAP_OBJECT **)hDMMRes;
 	DSP_STATUS	status = DSP_SOK;
-	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
+	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
 
-	*pDMMRes = (struct DMM_RES_OBJECT *)
-		    MEM_Calloc(1 * sizeof(struct DMM_RES_OBJECT), MEM_PAGED);
+	*pDMMRes = (struct DMM_MAP_OBJECT *)
+		    MEM_Calloc(1 * sizeof(struct DMM_MAP_OBJECT), MEM_PAGED);
 	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 1");
 	if (*pDMMRes == NULL) {
 		GT_0trace(curTrace, GT_5CLASS, "DRV_InsertDMMResElement: 2");
 		status = DSP_EHANDLE;
 	}
 	if (DSP_SUCCEEDED(status)) {
-		if (mutex_lock_interruptible(&pCtxt->dmm_mutex)) {
+		if (mutex_lock_interruptible(&pCtxt->dmm_map_mutex)) {
 			kfree(*pDMMRes);
 			return DSP_EFAIL;
 		}
 
-		if (pCtxt->pDMMList != NULL) {
+		if (pCtxt->dmm_map_list) {
 			GT_0trace(curTrace, GT_5CLASS,
 				 "DRV_InsertDMMResElement: 3");
-			pTempDMMRes = pCtxt->pDMMList;
-			while (pTempDMMRes->next != NULL)
+			pTempDMMRes = pCtxt->dmm_map_list;
+			while (pTempDMMRes->next)
 				pTempDMMRes = pTempDMMRes->next;
 
 			pTempDMMRes->next = *pDMMRes;
 		} else {
-			pCtxt->pDMMList = *pDMMRes;
+			pCtxt->dmm_map_list = *pDMMRes;
 			GT_0trace(curTrace, GT_5CLASS,
 				 "DRV_InsertDMMResElement: 4");
 		}
-		mutex_unlock(&pCtxt->dmm_mutex);
+		mutex_unlock(&pCtxt->dmm_map_mutex);
 	}
 	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 5");
 	return status;
@@ -239,15 +239,15 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	struct DMM_RES_OBJECT *pDMMRes = (struct DMM_RES_OBJECT *)hDMMRes;
-	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
+	struct DMM_MAP_OBJECT *pDMMRes = (struct DMM_MAP_OBJECT *)hDMMRes;
+	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
 	DSP_STATUS status = DSP_SOK;
 
-	if (mutex_lock_interruptible(&pCtxt->dmm_mutex))
+	if (mutex_lock_interruptible(&pCtxt->dmm_map_mutex))
 		return DSP_EFAIL;
-	pTempDMMRes = pCtxt->pDMMList;
-	if (pCtxt->pDMMList == pDMMRes) {
-		pCtxt->pDMMList = pDMMRes->next;
+	pTempDMMRes = pCtxt->dmm_map_list;
+	if (pCtxt->dmm_map_list == pDMMRes) {
+		pCtxt->dmm_map_list = pDMMRes->next;
 	} else {
 		while (pTempDMMRes && pTempDMMRes->next != pDMMRes)
 			pTempDMMRes = pTempDMMRes->next;
@@ -256,7 +256,7 @@ DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 		else
 			pTempDMMRes->next = pDMMRes->next;
 	}
-	mutex_unlock(&pCtxt->dmm_mutex);
+	mutex_unlock(&pCtxt->dmm_map_mutex);
 	kfree(pDMMRes);
 	return status;
 }
@@ -266,14 +266,14 @@ DSP_STATUS DRV_UpdateDMMResElement(HANDLE hDMMRes, u32 pMpuAddr, u32 ulSize,
 				  u32 pReqAddr, u32 pMapAddr,
 				  HANDLE hProcessor)
 {
-	struct DMM_RES_OBJECT *pDMMRes = (struct DMM_RES_OBJECT *)hDMMRes;
+	struct DMM_MAP_OBJECT *pDMMRes = (struct DMM_MAP_OBJECT *)hDMMRes;
 	DSP_STATUS status = DSP_SOK;
 
 	DBC_Assert(hDMMRes != NULL);
 	pDMMRes->ulMpuAddr = pMpuAddr;
 	pDMMRes->ulDSPAddr = pMapAddr;
 	pDMMRes->ulDSPResAddr = pReqAddr;
-	pDMMRes->dmmSize = ulSize;
+	pDMMRes->size = ulSize;
 	pDMMRes->hProcessor = hProcessor;
 	pDMMRes->dmmAllocated = 1;
 
@@ -285,11 +285,11 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
-	struct DMM_RES_OBJECT *pDMMList = pCtxt->pDMMList;
-	struct DMM_RES_OBJECT *pDMMRes = NULL;
+	struct DMM_MAP_OBJECT *pDMMList = pCtxt->dmm_map_list;
+	struct DMM_MAP_OBJECT *pDMMRes = NULL;
 
 	GT_0trace(curTrace, GT_ENTER, "\nDRV_ProcFreeDMMRes: 1\n");
-	while (pDMMList != NULL) {
+	while (pDMMList) {
 		pDMMRes = pDMMList;
 		pDMMList = pDMMList->next;
 		if (pDMMRes->dmmAllocated) {
@@ -315,32 +315,32 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
-	struct DMM_RES_OBJECT *pTempDMMRes2 = NULL;
-	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
+	struct DMM_MAP_OBJECT *pTempDMMRes2 = NULL;
+	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
 
 	DRV_ProcFreeDMMRes(pCtxt);
-	pTempDMMRes = pCtxt->pDMMList;
+	pTempDMMRes = pCtxt->dmm_map_list;
 	while (pTempDMMRes != NULL) {
 		pTempDMMRes2 = pTempDMMRes;
 		pTempDMMRes = pTempDMMRes->next;
 		kfree(pTempDMMRes2);
 	}
-	pCtxt->pDMMList = NULL;
+	pCtxt->dmm_map_list = NULL;
 	return status;
 }
 
 DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	struct DMM_RES_OBJECT **pDMMRes = (struct DMM_RES_OBJECT **)hDMMRes;
+	struct DMM_MAP_OBJECT **pDMMRes = (struct DMM_MAP_OBJECT **)hDMMRes;
 	DSP_STATUS status = DSP_SOK;
-	struct DMM_RES_OBJECT *pTempDMM = NULL;
+	struct DMM_MAP_OBJECT *pTempDMM = NULL;
 
-	if (mutex_lock_interruptible(&pCtxt->dmm_mutex))
+	if (mutex_lock_interruptible(&pCtxt->dmm_map_mutex))
 		return DSP_EFAIL;
 
-	pTempDMM = pCtxt->pDMMList;
-	while ((pTempDMM != NULL) && (pTempDMM->ulDSPAddr != pMapAddr)) {
+	pTempDMM = pCtxt->dmm_map_list;
+	while (pTempDMM && (pTempDMM->ulDSPAddr != pMapAddr)) {
 		GT_3trace(curTrace, GT_ENTER,
 			 "DRV_GetDMMResElement: 2 pTempDMM:%x "
 			 "pTempDMM->ulDSPAddr:%x pMapAddr:%x\n", pTempDMM,
@@ -348,14 +348,15 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 		pTempDMM = pTempDMM->next;
 	}
 
-	mutex_unlock(&pCtxt->dmm_mutex);
+	mutex_unlock(&pCtxt->dmm_map_mutex);
 
-	if (pTempDMM != NULL) {
+	if (pTempDMM) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 3");
 		*pDMMRes = pTempDMM;
 	} else {
 		status = DSP_ENOTFOUND;
-	} GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 4");
+		GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 4");
+	}
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index f083ba7..e6a7eb7 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -499,7 +499,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
 	if (pr_ctxt) {
 		pr_ctxt->resState = PROC_RES_ALLOCATED;
-		mutex_init(&pr_ctxt->dmm_mutex);
+		mutex_init(&pr_ctxt->dmm_map_mutex);
 		mutex_init(&pr_ctxt->node_mutex);
 		mutex_init(&pr_ctxt->strm_mutex);
 	} else {
-- 
1.6.3.3


From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 2/2] DSPBRIDGE: Remove DRV_ProcUpdatestate function
Date: Tue,  2 Feb 2010 13:31:56 -0600
Message-ID: <1265139116-5923-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33709 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932191Ab0BBTUj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 14:20:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>

From: Gomez Castellanos, Ivan <ivan.gomez@ti.com>

The DRV_ProcUpdatestate function was only used in two places and
it only assigned a value.

Signed-off-by: Ivan Gomez <ivan.gomez@ti.com>
Acked-by: Ameya Palande <ameya.palande@nokia.com>
---
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    3 ---
 drivers/dsp/bridge/rmgr/drv.c                      |    9 ---------
 drivers/dsp/bridge/rmgr/drv_interface.c            |    4 ++--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index 4ded5aa..9e78170 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -30,9 +30,6 @@ extern DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE pCtxt);
 
 extern DSP_STATUS DRV_RemoveAllNodeResElements(HANDLE pCtxt);
 
-extern DSP_STATUS DRV_ProcUpdatestate(HANDLE pCtxt,
-				      enum GPP_PROC_RES_STATE resState);
-
 extern DSP_STATUS DRV_ProcSetPID(HANDLE pCtxt, s32 hProcess);
 
 extern DSP_STATUS DRV_RemoveAllResources(HANDLE pPctxt);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index efab833..ca14908 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -83,15 +83,6 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt);
 static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt);
 extern enum NODE_STATE NODE_GetState(HANDLE hNode);
 
-/* Update the state of process context */
-DSP_STATUS DRV_ProcUpdatestate(HANDLE hPCtxt, enum GPP_PROC_RES_STATE status)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	DSP_STATUS status1 = DSP_SOK;
-	pCtxt->resState = status;
-	return status1;
-}
-
 /* Allocate and add a node resource element
 * This function is called from .Node_Allocate.  */
 DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index e748b1d..ce6a340 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -512,7 +512,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 */
 	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
 	if (pr_ctxt)
-		DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
+		pr_ctxt->resState = PROC_RES_ALLOCATED;
 	else
 		status = -ENOMEM;
 
@@ -631,7 +631,7 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 	DRV_RemoveAllSTRMResElements(pCtxt);
 	DRV_RemoveAllNodeResElements(pCtxt);
 	DRV_RemoveAllDMMResElements(pCtxt);
-	DRV_ProcUpdatestate(pCtxt, PROC_RES_FREED);
+	pCtxt->resState = PROC_RES_FREED;
 	return status;
 }
 #endif
-- 
1.6.2.4


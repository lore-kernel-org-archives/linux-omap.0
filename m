From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH v2 2/2] DSPBRIDGE: Remove DRV_ProcUpdatestate function
Date: Thu, 28 Jan 2010 19:18:56 -0600
Message-ID: <818EF96F5A7CC84789DD014773DB095484859F64@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51467 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253Ab0A2BTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 20:19:03 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

In the previous patch, the function prototype was not removed.

>From 22a3646710806c9390a48556ded889e19178db9e Mon Sep 17 00:00:00 2001
From: Ivan Gomez <ivan.gomez@ti.com>
Date: Thu, 28 Jan 2010 18:53:45 -0600
Subject: [PATCH] DSPBRIDGE: Remove DRV_ProcUpdatestate function

The DRV_ProcUpdatestate function was only used in two places and
it only assigned a value.

Signed-off-by: Ivan Gomez <ivan.gomez@ti.com>
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
index fd09a83..b7817aa 100644
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
index f3a67e2..09365bc 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -503,7 +503,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 */
 	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
 	if (pr_ctxt)
-		DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
+		pr_ctxt->resSatate = PROC_RES_ALLOCATED;
 	else
 		status = -ENOMEM;
 
@@ -622,7 +622,7 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 	DRV_RemoveAllSTRMResElements(pCtxt);
 	DRV_RemoveAllNodeResElements(pCtxt);
 	DRV_RemoveAllDMMResElements(pCtxt);
-	DRV_ProcUpdatestate(pCtxt, PROC_RES_FREED);
+	pCtxt->resState = PROC_RES_FREED;
 	return status;
 }
 #endif
-- 
1.5.4.3

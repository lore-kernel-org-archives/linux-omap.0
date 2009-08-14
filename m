From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 03/13] DSPBRIDGE: Use pr_ctxt in PROC_Map
Date: Fri, 14 Aug 2009 14:09:04 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D1E@dlee06.ent.ti.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50063 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914AbZHNTJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:09:13 -0400
In-Reply-To: <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
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
Subject: [PATCH 03/13] DSPBRIDGE: Use pr_ctxt in PROC_Map

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/proc.h |    4 +++-
 drivers/dsp/bridge/pmgr/wcd.c               |    2 +-
 drivers/dsp/bridge/rmgr/node.c              |    2 +-
 drivers/dsp/bridge/rmgr/proc.c              |   26 +++++---------------------
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 486652e..ff1573f 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -64,6 +64,7 @@
 
 #include <dspbridge/cfgdefs.h>
 #include <dspbridge/devdefs.h>
+#include <dspbridge/drv.h>
 
 /*
  *  ======== PROC_Attach ========
@@ -578,7 +579,8 @@
 				   void *pMpuAddr,
 				   u32 ulSize,
 				   void *pReqAddr,
-				   void **ppMapAddr, u32 ulMapAttr);
+				   void **ppMapAddr, u32 ulMapAttr,
+				   struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_ReserveMemory ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 05afb2c..bf8f672 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1023,7 +1023,7 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 			 args->ARGS_PROC_MAPMEM.pMpuAddr,
 			 args->ARGS_PROC_MAPMEM.ulSize,
 			 args->ARGS_PROC_MAPMEM.pReqAddr, &pMapAddr,
-			 args->ARGS_PROC_MAPMEM.ulMapAttr);
+			 args->ARGS_PROC_MAPMEM.ulMapAttr, pr_ctxt);
 	if (DSP_SUCCEEDED(status)) {
 		if (put_user(pMapAddr, args->ARGS_PROC_MAPMEM.ppMapAddr))
 			status = DSP_EINVALIDARG;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index b7bdf08..a6d4d25 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -561,7 +561,7 @@ func_cont:
 	status = PROC_Map(hProcessor, (void *)pAttrIn->pGPPVirtAddr,
 			pNode->createArgs.asa.taskArgs.uHeapSize,
 			(void *)pNode->createArgs.asa.taskArgs.uDSPHeapResAddr,
-			(void **)&pMappedAddr, mapAttrs);
+			(void **)&pMappedAddr, mapAttrs, pr_ctxt);
 	if (DSP_FAILED(status)) {
 		GT_1trace(NODE_debugMask, GT_5CLASS,
 			 "NODE_Allocate: Failed to map memory"
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index c6bfda1..0ee0656 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1412,7 +1412,8 @@ func_end:
  *      Maps a MPU buffer to DSP address space.
  */
 DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
-		   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr)
+		   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr,
+		   struct PROCESS_CONTEXT *pr_ctxt)
 {
 	u32 vaAlign;
 	u32 paAlign;
@@ -1422,11 +1423,7 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 
 #ifndef RES_CLEANUP_DISABLE
-       u32               hProcess;
-       HANDLE        pCtxt = NULL;
-       HANDLE        hDrvObject;
        HANDLE        dmmRes;
-       DSP_STATUS res_status = DSP_SOK;
 #endif
 
 	GT_6trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Map, args:\n\t"
@@ -1476,22 +1473,9 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
-		/* Update the node and stream resource status */
-		/* Return TGID instead of process handle */
-		hProcess = current->tgid;
-
-		res_status = CFG_GetObject((u32 *)&hDrvObject,
-					  REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-                       if (DRV_GetProcContext(hProcess,
-                               (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL,
-                                       (u32)pMpuAddr) != DSP_ENOTFOUND) {
-				DRV_InsertDMMResElement(&dmmRes, pCtxt);
-				DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr,
-						ulSize, (u32)pReqAddr,
-						(u32)*ppMapAddr, hProcessor);
-			}
-		}
+		DRV_InsertDMMResElement(&dmmRes, pr_ctxt);
+		DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr, ulSize,
+				(u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
 	}
 #endif
 func_end:
-- 
1.6.2.4



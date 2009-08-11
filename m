From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 05/13] DSPBRIDGE: Use pr_ctxt in PROC_Attach
Date: Tue, 11 Aug 2009 04:21:46 +0300
Message-ID: <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49885 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbZHKBWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 21:22:09 -0400
In-Reply-To: <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, suyog@ti.com, roman.tereshonkov@nokia.com, ernesto@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/proc.h |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c               |    2 +-
 drivers/dsp/bridge/rmgr/proc.c              |   51 +++++---------------------
 3 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 832b518..1737761 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -95,7 +95,8 @@
 	extern DSP_STATUS PROC_Attach(u32 uProcessor,
 				      OPTIONAL CONST struct DSP_PROCESSORATTRIN
 				      *pAttrIn,
-				      OUT DSP_HPROCESSOR *phProcessor);
+				      OUT DSP_HPROCESSOR *phProcessor,
+				      struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_AutoStart =========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index a574278..ddb2aea 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -681,7 +681,7 @@ u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt)
 
 	}
 	status = PROC_Attach(args->ARGS_PROC_ATTACH.uProcessor, pAttrIn,
-			    &processor);
+			    &processor, pr_ctxt);
 	cp_to_usr(args->ARGS_PROC_ATTACH.phProcessor, &processor, status, 1);
 func_end:
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 4ab4a88..c475436 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -237,7 +237,7 @@ func_end:
  */
 DSP_STATUS
 PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
-       OUT DSP_HPROCESSOR *phProcessor)
+       OUT DSP_HPROCESSOR *phProcessor, struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DEV_OBJECT *hDevObject;
@@ -246,19 +246,19 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	struct DRV_OBJECT *hDrvObject = NULL;
 	u32 devType;
 
-#ifndef RES_CLEANUP_DISABLE
-	HANDLE	     hDRVObject;
-       u32                  hProcess;
-	DSP_STATUS res_status = DSP_SOK;
-	struct PROCESS_CONTEXT   *pPctxt = NULL;
-#endif
-
 	DBC_Require(cRefs > 0);
 	DBC_Require(phProcessor != NULL);
 
 	GT_3trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Attach, args:\n\t"
 		 "uProcessor:  0x%x\n\tpAttrIn:  0x%x\n\tphProcessor:"
 		 "0x%x\n", uProcessor, pAttrIn, phProcessor);
+
+	if (pr_ctxt->hProcessor) {
+		pr_err("DSP: PROC_Attach() on same file handle is "
+				"not supported!\n");
+		goto func_end;
+	}
+
 	/* Get the Driver and Manager Object Handles */
 	status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(status)) {
@@ -380,41 +380,10 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 			 "storage for notification \n");
 		MEM_FreeObject(pProcObject);
 	}
-func_end:
 #ifndef RES_CLEANUP_DISABLE
-	if (DSP_FAILED(status))
-		goto func_cont;
-
-	/* Return TGID instead of process handle */
-	hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
-		goto func_cont;
-
-       DRV_GetProcContext(hProcess, (struct DRV_OBJECT *)hDRVObject,
-			 &pPctxt, NULL, 0);
-	if (pPctxt == NULL) {
-		DRV_InsertProcContext((struct DRV_OBJECT *)hDRVObject, &pPctxt);
-		if (pPctxt != NULL) {
-			DRV_ProcUpdatestate(pPctxt, PROC_RES_ALLOCATED);
-                       DRV_ProcSetPID(pPctxt, hProcess);
-		}
-	}
-func_cont:
-	/* Return TGID instead of process handle */
-	hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
-				 (struct DRV_OBJECT *)hDRVObject, &pPctxt,
-				 NULL, 0);
-		if (pPctxt != NULL)
-			pPctxt->hProcessor = (DSP_HPROCESSOR)*phProcessor;
-
-	}
+	pr_ctxt->hProcessor = pProcObject;
 #endif
+func_end:
 	DBC_Ensure((status == DSP_EFAIL && *phProcessor == NULL) ||
 		  (DSP_SUCCEEDED(status) &&
 		  MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) ||
-- 
1.6.2.4


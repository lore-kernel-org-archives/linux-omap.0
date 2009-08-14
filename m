From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 05/13] DSPBRIDGE: Use pr_ctxt in PROC_Attach
Date: Fri, 14 Aug 2009 14:09:59 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D20@dlee06.ent.ti.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34835 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754185AbZHNTKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:10:08 -0400
In-Reply-To: <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
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
Subject: [PATCH 05/13] DSPBRIDGE: Use pr_ctxt in PROC_Attach

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



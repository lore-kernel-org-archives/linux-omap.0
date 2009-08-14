From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 07/13] DSPBRIDGE: Support multiple processor objects per
 process context
Date: Fri, 14 Aug 2009 14:10:06 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D22@dlee06.ent.ti.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-7-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-8-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50124 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756924AbZHNTKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:10:16 -0400
In-Reply-To: <1249953714-20972-8-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Moogi, Suyog" <suyog@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>


Hi,

	Please see my comments below.

Regards,
Fernando.

>-----Original Message-----
>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Sent: Monday, August 10, 2009 8:22 PM
>To: linux-omap@vger.kernel.org
>Cc: hiroshi.doyu@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando;
>Moogi, Suyog; roman.tereshonkov@nokia.com; Ramos Falcon, Ernesto
>Subject: [PATCH 07/13] DSPBRIDGE: Support multiple processor objects per
>process context
>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>---
> arch/arm/plat-omap/include/dspbridge/drv.h  |    5 +-
> arch/arm/plat-omap/include/dspbridge/proc.h |   23 ++++++++++
> drivers/dsp/bridge/rmgr/drv.c               |   23 ++++++++--
> drivers/dsp/bridge/rmgr/drv_interface.c     |   13 +++++-
> drivers/dsp/bridge/rmgr/proc.c              |   61 ++++++++++-------------
>---
> 5 files changed, 79 insertions(+), 46 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-
>omap/include/dspbridge/drv.h
>index c468461..efc3a92 100644
>--- a/arch/arm/plat-omap/include/dspbridge/drv.h
>+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
>@@ -180,8 +180,9 @@ struct PROCESS_CONTEXT{
> 	* (To maintain a linked list of process contexts) */
> 	struct PROCESS_CONTEXT *next;
>
>-	/* Processor info to which the process is related */
>-	DSP_HPROCESSOR hProcessor;
>+	/* List of Processors */
>+	struct list_head processor_list;
>+	spinlock_t proc_list_lock;
>
> 	/* DSP Node resources */
> 	struct NODE_RES_OBJECT *pNodeList;
>diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-
>omap/include/dspbridge/proc.h
>index f5b0c50..1936a4e 100644
>--- a/arch/arm/plat-omap/include/dspbridge/proc.h
>+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
>@@ -66,6 +66,29 @@
> #include <dspbridge/devdefs.h>
> #include <dspbridge/drv.h>
>
>+/* The PROC_OBJECT structure.   */
>+struct PROC_OBJECT {
>+	struct LST_ELEM link;		/* Link to next PROC_OBJECT */
>+	u32 dwSignature;		/* Used for object validation */
>+	struct DEV_OBJECT *hDevObject;	/* Device this PROC represents */
>+	u32 hProcess;			/* Process owning this Processor */
>+	struct MGR_OBJECT *hMgrObject;	/* Manager Object Handle */
>+	u32 uAttachCount;		/* Processor attach count */
>+	u32 uProcessor;			/* Processor number */
>+	u32 uTimeout;			/* Time out count */
>+	enum DSP_PROCSTATE sState;	/* Processor state */
>+	u32 ulUnit;			/* DDSP unit number */
>+	bool bIsAlreadyAttached;	/*
>+					 * True if the Device below has
>+					 * GPP Client attached
>+					 */
>+	struct NTFY_OBJECT *hNtfy;	/* Manages  notifications */
>+	struct WMD_DEV_CONTEXT *hWmdContext;	/* WMD Context Handle */
>+	struct WMD_DRV_INTERFACE *pIntfFxns;	/* Function interface to
>WMD */
>+	char *g_pszLastCoff;
>+	struct list_head proc_object;
>+};
>+
> /*
>  *  ======== PROC_Attach ========
>  *  Purpose:
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index 4a4ebfa..e64b997 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -278,9 +278,19 @@ DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT
>*hDrVObject, HANDLE hPCtxt)
> 	struct DRV_OBJECT	     *hDRVObject;
>
> 	GT_0trace(curTrace, GT_ENTER, "\n In DRV_InsertProcContext\n");
>+
> 	status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
> 	DBC_Assert(hDRVObject != NULL);
>+
> 	*pCtxt = MEM_Calloc(1 * sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
>+	if (!*pCtxt) {
>+		pr_err("DSP: MEM_Calloc failed in DRV_InsertProcContext\n");
>+		return DSP_EMEMORY;
>+	}
>+
>+	spin_lock_init(&(*pCtxt)->proc_list_lock);
>+	INIT_LIST_HEAD(&(*pCtxt)->processor_list);
>+
> 	GT_0trace(curTrace, GT_ENTER,
> 		 "\n In DRV_InsertProcContext Calling "
> 		 "DRV_GetProcCtxtList\n");
>@@ -1005,6 +1015,7 @@ static DSP_STATUS PrintProcessInformation(void)
> 	struct DMM_RES_OBJECT *pDMMRes = NULL;
> 	struct STRM_RES_OBJECT *pSTRMRes = NULL;
> 	struct DSPHEAP_RES_OBJECT *pDSPHEAPRes = NULL;
>+	struct PROC_OBJECT *proc_obj_ptr;
> 	DSP_STATUS status = DSP_SOK;
> 	u32 tempCount;
> 	u32  procID;
>@@ -1031,11 +1042,11 @@ static DSP_STATUS PrintProcessInformation(void)
> 			GT_0trace(curTrace, GT_4CLASS, "\nThe Process"
> 					" is in DeAllocated state\n");
> 		}
>-		GT_1trace(curTrace, GT_4CLASS, "\nThe  hProcessor"
>-				" handle is: 0X%x\n",
>-				(u32)pCtxtList->hProcessor);
>-		if (pCtxtList->hProcessor != NULL) {
>-			PROC_GetProcessorId(pCtxtList->hProcessor, &procID);
>+
>+		spin_lock(&pCtxtList->proc_list_lock);
>+		list_for_each_entry(proc_obj_ptr, &pCtxtList->processor_list,
>+				proc_object) {
>+			PROC_GetProcessorId(proc_obj_ptr, &procID);
> 			if (procID == DSP_UNIT) {
> 				GT_0trace(curTrace, GT_4CLASS,
> 					"\nProcess connected to"
>@@ -1049,6 +1060,8 @@ static DSP_STATUS PrintProcessInformation(void)
> 					"\n***ERROR:Invalid Processor Id***\n");
> 			}
> 		}
>+		spin_unlock(&pCtxtList->proc_list_lock);
>+
> 		pNodeRes = pCtxtList->pNodeList;
> 		tempCount = 1;
> 		while (pNodeRes != NULL) {
>diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
>b/drivers/dsp/bridge/rmgr/drv_interface.c
>index 7d4a6ea..1cb3d74 100644
>--- a/drivers/dsp/bridge/rmgr/drv_interface.c
>+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
>@@ -452,6 +452,7 @@ static int __devexit omap34xx_bridge_remove(struct
>platform_device *pdev)
> 	HANDLE	     hDrvObject = NULL;
> 	struct PROCESS_CONTEXT	*pTmp = NULL;
> 	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
>+	struct PROC_OBJECT *proc_obj_ptr, *temp;
>
> 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
>
>@@ -474,7 +475,10 @@ static int __devexit omap34xx_bridge_remove(struct
>platform_device *pdev)
> 		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
> 			 "process***%d\n", pCtxtclosed->pid);
> 		DRV_RemoveAllResources(pCtxtclosed);
>-		PROC_Detach(pCtxtclosed->hProcessor, pCtxtclosed);
>+		list_for_each_entry_safe(proc_obj_ptr, temp,
>+				&pCtxtclosed->processor_list, proc_object) {
>+			PROC_Detach(proc_obj_ptr, pCtxtclosed);
>+		}
> 		pTmp = pCtxtclosed->next;
> 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
> 				     pCtxtclosed, (void *)pCtxtclosed->pid);

I don't think that a resource cleanup be needed in omap34xx_bridge_remove, because there is not way that omap34xx_bridge_remove be called before all the handles to DSPBridge were released and then all process context have been freed. I think also we can delete the process context list at all because each process is in charge of his our resource cleanup. Please let me know your comments.


>@@ -608,6 +612,7 @@ static int bridge_release(struct inode *ip, struct file
>*filp)
> 	DSP_STATUS dsp_status;
> 	HANDLE hDrvObject;
> 	struct PROCESS_CONTEXT *pr_ctxt;
>+	struct PROC_OBJECT *proc_obj_ptr, *temp;
>
> 	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
>
>@@ -619,7 +624,11 @@ static int bridge_release(struct inode *ip, struct
>file *filp)
> 		if (DSP_SUCCEEDED(dsp_status)) {
> 			flush_signals(current);
> 			DRV_RemoveAllResources(pr_ctxt);
>-			PROC_Detach(pr_ctxt->hProcessor, pr_ctxt);
>+			list_for_each_entry_safe(proc_obj_ptr, temp,
>+					&pr_ctxt->processor_list,
>+					proc_object) {
>+				PROC_Detach(proc_obj_ptr, pr_ctxt);
>+			}
> 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
> 					pr_ctxt, (void *)pr_ctxt->pid);
> 		} else {
>diff --git a/drivers/dsp/bridge/rmgr/proc.c
>b/drivers/dsp/bridge/rmgr/proc.c
>index 323054f..4a76f24 100644
>--- a/drivers/dsp/bridge/rmgr/proc.c
>+++ b/drivers/dsp/bridge/rmgr/proc.c
>@@ -160,27 +160,6 @@
> #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary */
>
> extern char *iva_img;
>-/* The PROC_OBJECT structure.   */
>-struct PROC_OBJECT {
>-	struct LST_ELEM link;		/* Link to next PROC_OBJECT */
>-	u32 dwSignature;	/* Used for object validation */
>-	struct DEV_OBJECT *hDevObject;	/* Device this PROC represents */
>-	u32 hProcess;   /* Process owning this Processor */
>-	struct MGR_OBJECT *hMgrObject;	/* Manager Object Handle */
>-	u32 uAttachCount;	/* Processor attach count */
>-	u32 uProcessor;	/* Processor number */
>-	u32 uTimeout;		/* Time out count */
>-	enum DSP_PROCSTATE sState;	/* Processor state */
>-	u32 ulUnit;		/* DDSP unit number */
>-	bool bIsAlreadyAttached;	/*
>-					 * True if the Device below has
>-					 * GPP Client attached
>-					 */
>-	struct NTFY_OBJECT *hNtfy;	/* Manages  notifications */
>-	struct WMD_DEV_CONTEXT *hWmdContext;	/* WMD Context Handle */
>-	struct WMD_DRV_INTERFACE *pIntfFxns;	/* Function interface to
>WMD */
>-	char *g_pszLastCoff;
>-} ;
>
> /*  ----------------------------------- Globals */
> #if GT_TRACE
>@@ -207,24 +186,32 @@ static char **PrependEnvp(char **newEnvp, char
>**envp, s32 cEnvp, s32 cNewEnvp,
> DSP_STATUS PROC_CleanupAllResources(void)
> {
> 	DSP_STATUS dsp_status = DSP_SOK;
>-	HANDLE	     hDrvObject = NULL;
>-	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
>+	HANDLE hDrvObject = NULL;
>+	struct PROCESS_CONTEXT *pCtxtclosed = NULL;
>+	struct PROC_OBJECT *proc_obj_ptr, *temp;
>+
> 	GT_0trace(PROC_DebugMask, GT_ENTER, "PROC_CleanupAllResources\n");
>+
> 	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> 	if (DSP_FAILED(dsp_status))
> 		goto func_end;
>+
> 	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
>+
> 	while (pCtxtclosed != NULL) {
> 		if (current->tgid != pCtxtclosed->pid) {
> 			GT_1trace(PROC_DebugMask, GT_5CLASS,
> 				 "***Cleanup of "
> 				 "process***%d\n", pCtxtclosed->pid);
>-			if (pCtxtclosed->hProcessor)
>-				PROC_Detach(pCtxtclosed->hProcessor,
>-						pCtxtclosed);
>+			list_for_each_entry_safe(proc_obj_ptr, temp,
>+					&pCtxtclosed->processor_list,
>+					proc_object) {
>+				PROC_Detach(proc_obj_ptr, pCtxtclosed);
>+			}
> 		}
> 		pCtxtclosed = pCtxtclosed->next;
> 	}

PROC_CleanupAllResources is not needed anymore with the changes to bridge_realse we can delete that and process context list too.


>+
> 	WMD_DEH_ReleaseDummyMem();
> func_end:
> 	return dsp_status;
>@@ -254,12 +241,6 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct
>DSP_PROCESSORATTRIN *pAttrIn,
> 		 "uProcessor:  0x%x\n\tpAttrIn:  0x%x\n\tphProcessor:"
> 		 "0x%x\n", uProcessor, pAttrIn, phProcessor);
>
>-	if (pr_ctxt->hProcessor) {
>-		pr_err("DSP: PROC_Attach() on same file handle is "
>-				"not supported!\n");
>-		goto func_end;
>-	}
>-
> 	/* Get the Driver and Manager Object Handles */
> 	status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> 	if (DSP_SUCCEEDED(status)) {
>@@ -308,10 +289,11 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct
>DSP_PROCESSORATTRIN *pAttrIn,
> 	pProcObject->hDevObject = hDevObject;
> 	pProcObject->hMgrObject = hMgrObject;
> 	pProcObject->uProcessor = devType;
>-	/* Get Caller Process and store it */
>-	/* Return TGID instead of process handle */
>+	/* Store TGID of Caller Process */
> 	pProcObject->hProcess = current->tgid;
>
>+	INIT_LIST_HEAD(&pProcObject->proc_object);
>+
> 	if (pAttrIn)
> 		pProcObject->uTimeout = pAttrIn->uTimeout;
> 	else
>@@ -382,7 +364,9 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct
>DSP_PROCESSORATTRIN *pAttrIn,
> 		MEM_FreeObject(pProcObject);
> 	}
> #ifndef RES_CLEANUP_DISABLE
>-	pr_ctxt->hProcessor = pProcObject;
>+	spin_lock(&pr_ctxt->proc_list_lock);
>+	list_add(&pProcObject->proc_object, &pr_ctxt->processor_list);
>+	spin_unlock(&pr_ctxt->proc_list_lock);
> #endif
> func_end:
> 	DBC_Ensure((status == DSP_EFAIL && *phProcessor == NULL) ||
>@@ -616,8 +600,11 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
>
> 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
> #ifndef RES_CLEANUP_DISABLE
>-		if (pr_ctxt != NULL)
>-			pr_ctxt->hProcessor = NULL;
>+		if (pr_ctxt) {
>+			spin_lock(&pr_ctxt->proc_list_lock);
>+			list_del(&pProcObject->proc_object);
>+			spin_unlock(&pr_ctxt->proc_list_lock);
>+		}
> #endif
> 		/* Notify the Client */
> 		NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
>--
>1.6.2.4
>


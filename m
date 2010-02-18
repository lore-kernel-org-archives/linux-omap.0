From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCHv4 2/4] DSPBRIDGE: New reserved memory accounting
 framework
Date: Wed, 17 Feb 2010 19:40:03 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9AD0@dlee06.ent.ti.com>
References: <cover.1266429436.git.ameya.palande@nokia.com>
 <7b2296a1856ed89b24b63b978a15acfe675e12ce.1266429437.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42109 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755998Ab0BRBkK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:40:10 -0500
In-Reply-To: <7b2296a1856ed89b24b63b978a15acfe675e12ce.1266429437.git.ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>


Hi,

>-----Original Message-----
>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Sent: Wednesday, February 17, 2010 12:06 PM
>To: linux-omap@vger.kernel.org
>Cc: felipe.contreras@nokia.com; Menon, Nishanth; Chitriki Rudramuni,
>Deepak; Guzman Lugo, Fernando; Ramirez Luna, Omar
>Subject: [PATCHv4 2/4] DSPBRIDGE: New reserved memory accounting framework
>
>DSP_RSV_OBJECT is introduced to track reserved memory accounting
>information.
>This will allow us to do proper cleanup for memory reserved using
>PROC_ReserveMemory().
>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>---
> arch/arm/plat-omap/include/dspbridge/drv.h  |   10 +++++
> arch/arm/plat-omap/include/dspbridge/proc.h |    4 +-
> drivers/dsp/bridge/pmgr/wcd.c               |    7 ++--
> drivers/dsp/bridge/rmgr/drv.c               |   18 ++++++----
> drivers/dsp/bridge/rmgr/drv_interface.c     |    2 +
> drivers/dsp/bridge/rmgr/node.c              |    5 ++-
> drivers/dsp/bridge/rmgr/proc.c              |   52 +++++++++++++++++++++--
>----
> 7 files changed, 73 insertions(+), 25 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-
>omap/include/dspbridge/drv.h
>index d5f5277..f7d0e3e 100644
>--- a/arch/arm/plat-omap/include/dspbridge/drv.h
>+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
>@@ -101,6 +101,12 @@ struct DMM_MAP_OBJECT {
> 	struct DMM_MAP_OBJECT  *next;
> } ;
>
>+/* Used for DMM reserved memory accounting */
>+struct DMM_RSV_OBJECT {
>+	struct	list_head	link;
>+	u32	dsp_reserved_addr;
>+};
>+
> /* New structure (member of process context) abstracts DMM resource info
>*/
> struct DSPHEAP_RES_OBJECT {
> 	s32            heapAllocated; /* DMM status */
>@@ -143,6 +149,10 @@ struct PROCESS_CONTEXT{
> 	struct DMM_MAP_OBJECT *dmm_map_list;
> 	struct mutex dmm_map_mutex;
>
>+	/* DMM reserved memory resources */
>+	struct list_head dmm_rsv_list;
>+	spinlock_t dmm_rsv_lock;
>+
> 	/* DSP Heap resources */
> 	struct DSPHEAP_RES_OBJECT *pDSPHEAPList;
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-
>omap/include/dspbridge/proc.h
>index 8dbdaac..1ffe763 100644
>--- a/arch/arm/plat-omap/include/dspbridge/proc.h
>+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
>@@ -560,7 +560,7 @@
>  *  Details:
>  */
> 	extern DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor,
>-					     u32 ulSize, void **ppRsvAddr);
>+		u32 ulSize, void **ppRsvAddr, struct PROCESS_CONTEXT *pr_ctxt);
>
> /*
>  *  ======== PROC_UnMap ========
>@@ -604,6 +604,6 @@
>  *  Details:
>  */
> 	extern DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor,
>-					       void *pRsvAddr);
>+			void *pRsvAddr, struct PROCESS_CONTEXT *pr_ctxt);
>
> #endif				/* PROC_ */
>diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
>index beea23b..1ef606e 100644
>--- a/drivers/dsp/bridge/pmgr/wcd.c
>+++ b/drivers/dsp/bridge/pmgr/wcd.c
>@@ -1054,12 +1054,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args
>*args, void *pr_ctxt)
>
> 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory:
>entered\n");
> 	status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
>-				   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
>+				   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr,
>+				   pr_ctxt);
> 	if (DSP_SUCCEEDED(status)) {
> 		if (put_user(pRsvAddr, args->ARGS_PROC_RSVMEM.ppRsvAddr)) {
> 			status = DSP_EINVALIDARG;
> 			PROC_UnReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
>-				pRsvAddr);
>+				pRsvAddr, pr_ctxt);
> 		}
> 	}
> 	return status;
>@@ -1100,7 +1101,7 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args
>*args, void *pr_ctxt)
> 	GT_0trace(WCD_debugMask, GT_ENTER,
> 		 "PROCWRAP_UnReserveMemory: entered\n");
> 	status = PROC_UnReserveMemory(args->ARGS_PROC_UNRSVMEM.hProcessor,
>-				     args->ARGS_PROC_UNRSVMEM.pRsvAddr);
>+			     args->ARGS_PROC_UNRSVMEM.pRsvAddr, pr_ctxt);
> 	return status;
> }
>
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index 9b513e2..12ba7e0 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -298,25 +298,20 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
> 			if (DSP_FAILED(status))
> 				pr_debug("%s: PROC_UnMap failed! status ="
> 						" 0x%xn", __func__, status);
>-			status = PROC_UnReserveMemory(pDMMRes->hProcessor,
>-				 (void *)pDMMRes->ulDSPResAddr);
>-			if (DSP_FAILED(status))
>-				pr_debug("%s: PROC_UnReserveMemory failed!"
>-					" status = 0x%xn", __func__, status);
> 			pDMMRes->dmmAllocated = 0;
> 		}
> 	}
> 	return status;
> }
>
>-/* Release all DMM resources and its context
>-* This is called from .bridge_release. */
>+/* Release all Mapped and Reserved DMM resources */
> DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
> {
> 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
> 	DSP_STATUS status = DSP_SOK;
> 	struct DMM_MAP_OBJECT *pTempDMMRes2 = NULL;
> 	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
>+	struct DMM_RSV_OBJECT *temp, *rsv_obj;
>
> 	DRV_ProcFreeDMMRes(pCtxt);
> 	pTempDMMRes = pCtxt->dmm_map_list;
>@@ -326,6 +321,15 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
> 		kfree(pTempDMMRes2);
> 	}
> 	pCtxt->dmm_map_list = NULL;
>+
>+	/* Free DMM reserved memory resources */
>+	list_for_each_entry_safe(rsv_obj, temp, &pCtxt->dmm_rsv_list, link) {
>+		status = PROC_UnReserveMemory(pCtxt->hProcessor,
>+				(void *)rsv_obj->dsp_reserved_addr, pCtxt);
>+		if (DSP_FAILED(status))
>+			pr_err("%s: PROC_UnReserveMemory failed!"
>+					" status = 0x%xn", __func__, status);
>+	}
> 	return status;
> }
>
>diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
>b/drivers/dsp/bridge/rmgr/drv_interface.c
>index e6a7eb7..80b8c7e 100644
>--- a/drivers/dsp/bridge/rmgr/drv_interface.c
>+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
>@@ -500,6 +500,8 @@ static int bridge_open(struct inode *ip, struct file
>*filp)
> 	if (pr_ctxt) {
> 		pr_ctxt->resState = PROC_RES_ALLOCATED;
> 		mutex_init(&pr_ctxt->dmm_map_mutex);
>+		spin_lock_init(&pr_ctxt->dmm_rsv_lock);
>+		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
> 		mutex_init(&pr_ctxt->node_mutex);
> 		mutex_init(&pr_ctxt->strm_mutex);
> 	} else {
>diff --git a/drivers/dsp/bridge/rmgr/node.c
>b/drivers/dsp/bridge/rmgr/node.c
>index b60d1ed..17b07ed 100644
>--- a/drivers/dsp/bridge/rmgr/node.c
>+++ b/drivers/dsp/bridge/rmgr/node.c
>@@ -454,7 +454,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT
>*hProcessor,
> 	status = PROC_ReserveMemory(hProcessor,
> 			pNode->createArgs.asa.taskArgs.uHeapSize + PAGE_SIZE,
> 			(void **)&(pNode->createArgs.asa.taskArgs.
>-				uDSPHeapResAddr));
>+				uDSPHeapResAddr), pr_ctxt);
> 	if (DSP_FAILED(status)) {
> 		GT_1trace(NODE_debugMask, GT_5CLASS,
> 			 "NODE_Allocate:Failed to reserve "
>@@ -2726,7 +2726,8 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
> 					 " Status = 0x%x\n", (u32)status);
> 			}
> 			status = PROC_UnReserveMemory(hNode->hProcessor,
>-					(void *)taskArgs.uDSPHeapResAddr);
>+					(void *)taskArgs.uDSPHeapResAddr,
>+					pr_ctxt);
> 			if (DSP_SUCCEEDED(status)) {
> 				GT_0trace(NODE_debugMask, GT_5CLASS,
> 					 "DSPProcessor_UnReserveMemory "
>diff --git a/drivers/dsp/bridge/rmgr/proc.c
>b/drivers/dsp/bridge/rmgr/proc.c
>index 6c0173a..6ce76cb 100644
>--- a/drivers/dsp/bridge/rmgr/proc.c
>+++ b/drivers/dsp/bridge/rmgr/proc.c
>@@ -1431,11 +1431,12 @@ func_end:
>  *      Reserve a virtually contiguous region of DSP address space.
>  */
> DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
>-			     void **ppRsvAddr)
>+		     void **ppRsvAddr, struct PROCESS_CONTEXT *pr_ctxt)
> {
> 	struct DMM_OBJECT *hDmmMgr;
> 	DSP_STATUS status = DSP_SOK;
> 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
>+	struct DMM_RSV_OBJECT *rsv_obj;
>
> 	GT_3trace(PROC_DebugMask, GT_ENTER,
> 		 "Entered PROC_ReserveMemory, args:\n\t"
>@@ -1447,16 +1448,29 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR
>hProcessor, u32 ulSize,
> 			 "InValid Processor Handle \n");
> 		goto func_end;
> 	}
>+
> 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
> 	if (DSP_FAILED(status)) {
> 		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_ReserveMemory: "
> 			 "Failed to get DMM Mgr handle: 0x%x\n", status);
>-	} else
>-		status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
>+		goto func_end;
>+	}
>+
>+	status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
>+	if (status != DSP_SOK)
>+		goto func_end;
>+
>+	rsv_obj = kmalloc(sizeof(struct DMM_RSV_OBJECT), GFP_KERNEL);
>+	if (rsv_obj) {
>+		rsv_obj->dsp_reserved_addr = (u32) *ppRsvAddr;
>+		spin_lock(&pr_ctxt->dmm_rsv_lock);
>+		list_add(&rsv_obj->link, &pr_ctxt->dmm_rsv_list);
>+		spin_unlock(&pr_ctxt->dmm_rsv_lock);
>+	}
>
>+func_end:
> 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory
>[0x%x]",
> 		 status);
>-func_end:
> 	return status;
> }
>
>@@ -1705,11 +1719,13 @@ func_end:
>  *  Purpose:
>  *      Frees a previously reserved region of DSP address space.
>  */
>-DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
>+DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr,
>+		struct PROCESS_CONTEXT *pr_ctxt)
> {
> 	struct DMM_OBJECT *hDmmMgr;
> 	DSP_STATUS status = DSP_SOK;
> 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
>+	struct DMM_RSV_OBJECT *temp, *rsv_obj;
>
> 	GT_2trace(PROC_DebugMask, GT_ENTER,
> 		 "Entered PROC_UnReserveMemory, args:\n\t"
>@@ -1720,18 +1736,32 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR
>hProcessor, void *pRsvAddr)
> 			 "InValid Processor Handle \n");
> 		goto func_end;
> 	}
>+
> 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
>-	if (DSP_FAILED(status))
>+	if (DSP_FAILED(status)) {
> 		GT_1trace(PROC_DebugMask, GT_7CLASS,
> 			 "PROC_UnReserveMemory: Failed to get DMM Mgr "
> 			 "handle: 0x%x\n", status);
>-	else
>-		status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
>+		goto func_end;
>+	}
>+
>+	status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
>+	if (status != DSP_SOK)
>+		goto func_end;
>+
>+	spin_lock(&pr_ctxt->dmm_rsv_lock);
>+	list_for_each_entry_safe(rsv_obj, temp, &pr_ctxt->dmm_rsv_list, link)

list_for_each_entry_safe is used when you delete a element from the list and continue but this is not the case. You should use list_for_each_entry instead, which has simpler logic and we can get ride of temp variable.

Regards,
Fernando.

>{
>+		if (rsv_obj->dsp_reserved_addr == (u32)pRsvAddr) {
>+			list_del(&rsv_obj->link);
>+			kfree(rsv_obj);
>+			break;
>+		}
>+	}
>+	spin_unlock(&pr_ctxt->dmm_rsv_lock);
>
>-	GT_1trace(PROC_DebugMask, GT_ENTER,
>-		 "Leaving PROC_UnReserveMemory [0x%x]",
>-		 status);
> func_end:
>+	GT_1trace(PROC_DebugMask, GT_ENTER,
>+		 "Leaving PROC_UnReserveMemory [0x%x]", status);
> 	return status;
> }
>
>--
>1.6.3.3


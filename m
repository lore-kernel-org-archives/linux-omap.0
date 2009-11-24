From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/9] DSPBRIDGE: Remove DPC, create, destroy and schedule wrappers
Date: Mon, 23 Nov 2009 18:50:27 -0600
Message-ID: <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50028 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757343AbZKXApK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 19:45:10 -0500
In-Reply-To: <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove DPC wrappers and replace with direct Linux calls.

These changes apply to IO DPC and MMUfault DPC

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dpc.h |   90 +++--------------
 drivers/dsp/bridge/services/dpc.c          |  144 +---------------------------
 drivers/dsp/bridge/wmd/io_sm.c             |   73 +++++++++++++-
 drivers/dsp/bridge/wmd/mmu_fault.c         |   24 ++++-
 drivers/dsp/bridge/wmd/ue_deh.c            |   31 ++++++-
 5 files changed, 132 insertions(+), 230 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
index 870a1b2..0c60342 100644
--- a/arch/arm/plat-omap/include/dspbridge/dpc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dpc.h
@@ -19,8 +19,6 @@
 #ifndef DPC_
 #define DPC_
 
-	struct DPC_OBJECT;
-
 /*
  *  ======== DPC_PROC ========
  *  Purpose:
@@ -40,64 +38,22 @@
  */
        typedef void(*DPC_PROC) (void *pRefData);
 
-/*
- *  ======== DPC_Cancel ========
- *  Purpose:
- *      Cancel a DPC previously scheduled by DPC_Schedule.
- *  Parameters:
- *      hDPC:           A DPC object handle created in DPC_Create().
- *  Returns:
- *      DSP_SOK:        Scheduled DPC, if any, is cancelled.
- *      DSP_SFALSE:     No DPC is currently scheduled for execution.
- *      DSP_EHANDLE:    Invalid hDPC.
- *  Requires:
- *  Ensures:
- *      If the DPC has already executed, is executing, or was not yet
- *      scheduled, this function will have no effect.
- */
-       extern DSP_STATUS DPC_Cancel(IN struct DPC_OBJECT *hDPC);
+/* The DPC object, passed to our priority event callback routine: */
+struct DPC_OBJECT {
+	u32 dwSignature;	/* Used for object validation.   */
+	void *pRefData;		/* Argument for client's DPC.    */
+	DPC_PROC pfnDPC;	/* Client's DPC.                 */
+	u32 numRequested;	/* Number of requested DPC's.      */
+	u32 numScheduled;	/* Number of executed DPC's.      */
+	struct tasklet_struct dpc_tasklet;
 
-/*
- *  ======== DPC_Create ========
- *  Purpose:
- *      Create a DPC object, allowing a client's own DPC procedure to be
- *      scheduled for a call with client reference data.
- *  Parameters:
- *      phDPC:          Pointer to location to store DPC object.
- *      pfnDPC:         Client's DPC procedure.
- *      pRefData:       Pointer to user-defined reference data.
- *  Returns:
- *      DSP_SOK:        DPC object created.
- *      DSP_EPOINTER:   phDPC == NULL or pfnDPC == NULL.
- *      DSP_EMEMORY:    Insufficient memory.
- *  Requires:
- *      Must not be called at interrupt time.
- *  Ensures:
- *      DSP_SOK: DPC object is created;
- *      else: *phDPC is set to NULL.
- */
-       extern DSP_STATUS DPC_Create(OUT struct DPC_OBJECT **phDPC,
-					   IN DPC_PROC pfnDPC,
-					   IN void *pRefData);
+#ifdef DEBUG
+	u32 cEntryCount;	/* Number of times DPC reentered. */
+	u32 numRequestedMax;	/* Keep track of max pending DPC's. */
+#endif
 
-/*
- *  ======== DPC_Destroy ========
- *  Purpose:
- *      Cancel the last scheduled DPC, and deallocate a DPC object previously
- *      allocated with DPC_Create().Frees the Object only if the thread and
- *      the events are terminated successfuly.
- *  Parameters:
- *      hDPC:           A DPC object handle created in DPC_Create().
- *  Returns:
- *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hDPC.
- *  Requires:
- *      All DPC's scheduled for the DPC object must have completed their
- *      processing.
- *  Ensures:
- *      (SUCCESS && hDPC is NULL) or DSP_EFAILED status
- */
-       extern DSP_STATUS DPC_Destroy(IN struct DPC_OBJECT *hDPC);
+	spinlock_t dpc_lock;
+};
 
 /*
  *  ======== DPC_Exit ========
@@ -125,21 +81,7 @@
  */
        extern bool DPC_Init(void);
 
-/*
- *  ======== DPC_Schedule ========
- *  Purpose:
- *      Schedule a deferred procedure call to be executed at a later time.
- *      Latency and order of DPC execution is platform specific.
- *  Parameters:
- *      hDPC:           A DPC object handle created in DPC_Create().
- *  Returns:
- *      DSP_SOK:        An event is scheduled for deferred processing.
- *      DSP_EHANDLE:    Invalid hDPC.
- *  Requires:
- *      See requirements for DPC_PROC.
- *  Ensures:
- *      DSP_SOK:        The DPC will not be called before this function returns.
- */
-       extern DSP_STATUS DPC_Schedule(IN struct DPC_OBJECT *hDPC);
+/*  ----------------------------------- Function Prototypes */
+ void DPC_DeferredProcedure(IN unsigned long pDeferredContext);
 
 #endif				/* DPC_ */
diff --git a/drivers/dsp/bridge/services/dpc.c b/drivers/dsp/bridge/services/dpc.c
index a6d453c..10bd792 100644
--- a/drivers/dsp/bridge/services/dpc.c
+++ b/drivers/dsp/bridge/services/dpc.c
@@ -37,111 +37,11 @@
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 #define SIGNATURE       0x5f435044	/* "DPC_" (in reverse). */
 
-/* The DPC object, passed to our priority event callback routine: */
-struct DPC_OBJECT {
-	u32 dwSignature;	/* Used for object validation.   */
-	void *pRefData;		/* Argument for client's DPC.    */
-	DPC_PROC pfnDPC;	/* Client's DPC.                 */
-	u32 numRequested;	/* Number of requested DPC's.      */
-	u32 numScheduled;	/* Number of executed DPC's.      */
-	struct tasklet_struct dpc_tasklet;
-
-#ifdef DEBUG
-	u32 cEntryCount;	/* Number of times DPC reentered. */
-	u32 numRequestedMax;	/* Keep track of max pending DPC's. */
-#endif
-
-	spinlock_t dpc_lock;
-};
-
 /*  ----------------------------------- Globals */
 #if GT_TRACE
 static struct GT_Mask DPC_DebugMask = { NULL, NULL };	/* DPC Debug Mask */
 #endif
 
-/*  ----------------------------------- Function Prototypes */
-static void DPC_DeferredProcedure(IN unsigned long pDeferredContext);
-
-/*
- *  ======== DPC_Create ========
- *  Purpose:
- *      Create a DPC object, allowing a client's own DPC procedure to be
- *      scheduled for a call with client reference data.
- */
-DSP_STATUS DPC_Create(OUT struct DPC_OBJECT **phDPC, DPC_PROC pfnDPC,
-		      void *pRefData)
-{
-	DSP_STATUS status = DSP_SOK;
-	struct DPC_OBJECT *pDPCObject = NULL;
-
-	if ((phDPC != NULL) && (pfnDPC != NULL)) {
-		/*
-		 *  Allocate a DPC object to store information allowing our DPC
-		 *  callback to dispatch to the client's DPC.
-		 */
-		MEM_AllocObject(pDPCObject, struct DPC_OBJECT, SIGNATURE);
-		if (pDPCObject != NULL) {
-			tasklet_init(&pDPCObject->dpc_tasklet,
-				     DPC_DeferredProcedure,
-				     (u32) pDPCObject);
-			/* Fill out our DPC Object: */
-			pDPCObject->pRefData = pRefData;
-			pDPCObject->pfnDPC = pfnDPC;
-			pDPCObject->numRequested = 0;
-			pDPCObject->numScheduled = 0;
-#ifdef DEBUG
-			pDPCObject->numRequestedMax = 0;
-			pDPCObject->cEntryCount = 0;
-#endif
-			spin_lock_init(&pDPCObject->dpc_lock);
-			*phDPC = pDPCObject;
-		} else {
-			GT_0trace(DPC_DebugMask, GT_6CLASS,
-				  "DPC_Create: DSP_EMEMORY\n");
-			status = DSP_EMEMORY;
-		}
-	} else {
-		GT_0trace(DPC_DebugMask, GT_6CLASS,
-			  "DPC_Create: DSP_EPOINTER\n");
-		status = DSP_EPOINTER;
-	}
-	DBC_Ensure((DSP_FAILED(status) && (!phDPC || (phDPC && *phDPC == NULL)))
-		   || DSP_SUCCEEDED(status));
-	return status;
-}
-
-/*
- *  ======== DPC_Destroy ========
- *  Purpose:
- *      Cancel the last scheduled DPC, and deallocate a DPC object previously
- *      allocated with DPC_Create(). Frees the Object only if the thread
- *      and the event terminated successfuly.
- */
-DSP_STATUS DPC_Destroy(struct DPC_OBJECT *hDPC)
-{
-	DSP_STATUS status = DSP_SOK;
-	struct DPC_OBJECT *pDPCObject = (struct DPC_OBJECT *)hDPC;
-
-	if (MEM_IsValidHandle(hDPC, SIGNATURE)) {
-
-		/* Free our DPC object: */
-		if (DSP_SUCCEEDED(status)) {
-			tasklet_kill(&pDPCObject->dpc_tasklet);
-			MEM_FreeObject(pDPCObject);
-			pDPCObject = NULL;
-			GT_0trace(DPC_DebugMask, GT_2CLASS,
-				  "DPC_Destroy: SUCCESS\n");
-		}
-	} else {
-		GT_0trace(DPC_DebugMask, GT_6CLASS,
-			  "DPC_Destroy: DSP_EHANDLE\n");
-		status = DSP_EHANDLE;
-	}
-	DBC_Ensure((DSP_SUCCEEDED(status) && pDPCObject == NULL)
-		   || DSP_FAILED(status));
-	return status;
-}
-
 /*
  *  ======== DPC_Exit ========
  *  Purpose:
@@ -167,54 +67,12 @@ bool DPC_Init(void)
 }
 
 /*
- *  ======== DPC_Schedule ========
- *  Purpose:
- *      Schedule a deferred procedure call to be executed at a later time.
- *      Latency and order of DPC execution is platform specific.
- */
-DSP_STATUS DPC_Schedule(struct DPC_OBJECT *hDPC)
-{
-	DSP_STATUS status = DSP_SOK;
-	struct DPC_OBJECT *pDPCObject = (struct DPC_OBJECT *)hDPC;
-	unsigned long flags;
-
-	GT_1trace(DPC_DebugMask, GT_ENTER, "DPC_Schedule hDPC %x\n", hDPC);
-	if (MEM_IsValidHandle(hDPC, SIGNATURE)) {
-		/* Increment count of DPC's pending. Needs to be protected
-		 * from ISRs since this function is called from process
-		 * context also. */
-		spin_lock_irqsave(&hDPC->dpc_lock, flags);
-		pDPCObject->numRequested++;
-		spin_unlock_irqrestore(&hDPC->dpc_lock, flags);
-		tasklet_schedule(&(hDPC->dpc_tasklet));
-#ifdef DEBUG
-		if (pDPCObject->numRequested > pDPCObject->numScheduled +
-						pDPCObject->numRequestedMax) {
-			pDPCObject->numRequestedMax = pDPCObject->numRequested -
-						pDPCObject->numScheduled;
-		}
-#endif
-	/*  If an interrupt occurs between incrementing numRequested and the
-	 *  assertion below, then DPC will get executed while returning from
-	 *  ISR, which will complete all requests and make numRequested equal
-	 * to numScheduled, firing this assertion. This happens only when
-	 * DPC is being scheduled in process context */
-	} else {
-		GT_0trace(DPC_DebugMask, GT_6CLASS,
-			  "DPC_Schedule: DSP_EHANDLE\n");
-		status = DSP_EHANDLE;
-	}
-	GT_1trace(DPC_DebugMask, GT_ENTER, "DPC_Schedule status %x\n", status);
-	return status;
-}
-
-/*
  *  ======== DeferredProcedure ========
  *  Purpose:
  *      Main DPC routine.  This is called by host OS DPC callback
  *      mechanism with interrupts enabled.
  */
-static void DPC_DeferredProcedure(IN unsigned long pDeferredContext)
+void DPC_DeferredProcedure(IN unsigned long pDeferredContext)
 {
 	struct DPC_OBJECT *pDPCObject = (struct DPC_OBJECT *)pDeferredContext;
 	/* read numRequested in local variable */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 96a5aa6..60dbc62 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -251,7 +251,26 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 
 	if (devType == DSP_UNIT) {
 		/* Create a DPC object: */
-		status = DPC_Create(&pIOMgr->hDPC, IO_DPC, (void *)pIOMgr);
+		MEM_AllocObject(pIOMgr->hDPC, struct DPC_OBJECT,
+				IO_MGRSIGNATURE);
+		if (pIOMgr->hDPC) {
+			tasklet_init(&pIOMgr->hDPC->dpc_tasklet,
+				DPC_DeferredProcedure, (u32)pIOMgr->hDPC);
+			/* Fill out our DPC Object: */
+			pIOMgr->hDPC->pRefData = (void *)pIOMgr;
+			pIOMgr->hDPC->pfnDPC = IO_DPC;
+			pIOMgr->hDPC->numRequested = 0;
+			pIOMgr->hDPC->numScheduled = 0;
+#ifdef DEBUG
+			pIOMgr->hDPC->numRequestedMax = 0;
+			pIOMgr->hDPC->cEntryCount = 0;
+#endif
+			spin_lock_init(&pIOMgr->hDPC->dpc_lock);
+		} else {
+			DBG_Trace(GT_6CLASS, "IO DPC Create: DSP_EMEMORY\n");
+			status = DSP_EMEMORY;
+		}
+
 		if (DSP_SUCCEEDED(status))
 			status = DEV_GetDevNode(hDevObject, &hDevNode);
 
@@ -312,8 +331,13 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 		destroy_workqueue(bridge_workqueue);
 		/* Linux function to uninstall ISR */
 		free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
-		if (hIOMgr->hDPC)
-			(void)DPC_Destroy(hIOMgr->hDPC);
+
+		/* Free DPC object */
+		tasklet_kill(&hIOMgr->hDPC->dpc_tasklet);
+		MEM_FreeObject(hIOMgr->hDPC);
+		hIOMgr->hDPC = NULL;
+		DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
+
 #ifndef DSP_TRACEBUF_DISABLED
 		if (hIOMgr->pMsg)
 			MEM_Free(hIOMgr->pMsg);
@@ -1009,6 +1033,8 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 {
 	struct IO_MGR *hIOMgr = (struct IO_MGR *)pRefData;
 	bool fSchedDPC;
+	unsigned long flags;
+
 	if (irq != INT_MAIL_MPU_IRQ ||
 	   !MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE))
 		return IRQ_NONE;
@@ -1030,8 +1056,26 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 			DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
 			hIOMgr->wIntrVal = 0;
 		} else if (fSchedDPC) {
-			/* PROC-COPY defer i/o  */
-			DPC_Schedule(hIOMgr->hDPC);
+			/*
+			 * PROC-COPY defer i/o.
+			 * Increment count of DPC's pending.
+			 */
+			spin_lock_irqsave(&hIOMgr->hDPC->dpc_lock, flags);
+			hIOMgr->hDPC->numRequested++;
+			spin_unlock_irqrestore(&hIOMgr->hDPC->dpc_lock, flags);
+
+			/* Schedule DPC */
+			tasklet_schedule(&hIOMgr->hDPC->dpc_tasklet);
+#ifdef DEBUG
+			if (hIOMgr->hDPC->numRequested >
+			   hIOMgr->hDPC->numScheduled +
+			   hIOMgr->hDPC->numRequestedMax) {
+				hIOMgr->hDPC->numRequestedMax =
+					hIOMgr->hDPC->numRequested -
+					hIOMgr->hDPC->numScheduled;
+			}
+#endif
+
 		}
 	} else
 		/* Ensure that, if WMD didn't claim it, the IRQ is shared. */
@@ -1086,10 +1130,27 @@ func_end:
  */
 void IO_Schedule(struct IO_MGR *pIOMgr)
 {
+	unsigned long flags;
+
 	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		return;
 	tiomap3430_bump_dsp_opp_level();
-	DPC_Schedule(pIOMgr->hDPC);
+
+	/* Increment count of DPC's pending. */
+	spin_lock_irqsave(&pIOMgr->hDPC->dpc_lock, flags);
+	pIOMgr->hDPC->numRequested++;
+	spin_unlock_irqrestore(&pIOMgr->hDPC->dpc_lock, flags);
+
+	/* Schedule DPC */
+	tasklet_schedule(&pIOMgr->hDPC->dpc_tasklet);
+#ifdef DEBUG
+	if (pIOMgr->hDPC->numRequested > pIOMgr->hDPC->numScheduled +
+	   pIOMgr->hDPC->numRequestedMax) {
+		pIOMgr->hDPC->numRequestedMax =	pIOMgr->hDPC->numRequested -
+				pIOMgr->hDPC->numScheduled;
+	}
+#endif
+
 }
 
 /*
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index bb98e56..0e03cd1 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -76,7 +76,7 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)pRefData;
 	struct WMD_DEV_CONTEXT *pDevContext;
 	DSP_STATUS status = DSP_SOK;
-
+	unsigned long flags;
 
 	DBG_Trace(DBG_LEVEL1, "Entering DEH_DspMmuIsr: 0x%x\n", pRefData);
        DBC_Require(irq == INT_DSP_MMU_IRQ);
@@ -94,14 +94,30 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 				"0x%x\n", dmmuEventMask);
 			printk(KERN_INFO "***** DSPMMU FAULT ***** faultAddr "
 				"0x%x\n", faultAddr);
-			/* Disable the MMU events, else once we clear it will
-			 * start to raise INTs again */
 			/*
 			 * Schedule a DPC directly. In the future, it may be
 			 * necessary to check if DSP MMU fault is intended for
 			 * Bridge.
 			 */
-			DPC_Schedule(pDehMgr->hMmuFaultDpc);
+			/* Increment count of DPC's pending. */
+			spin_lock_irqsave(&pDehMgr->hMmuFaultDpc->dpc_lock,
+						flags);
+			pDehMgr->hMmuFaultDpc->numRequested++;
+			spin_unlock_irqrestore(&pDehMgr->hMmuFaultDpc->dpc_lock,
+						flags);
+
+			/* Schedule DPC */
+			tasklet_schedule(&pDehMgr->hMmuFaultDpc->dpc_tasklet);
+#ifdef DEBUG
+			if (pDehMgr->hMmuFaultDpc->numRequested >
+			   pDehMgr->hMmuFaultDpc->numScheduled +
+			   pDehMgr->hMmuFaultDpc->numRequestedMax) {
+				pDehMgr->hMmuFaultDpc->numRequestedMax =
+					pDehMgr->hMmuFaultDpc->numRequested -
+					pDehMgr->hMmuFaultDpc->numScheduled;
+			}
+#endif
+
 			/* Reset errInfo structure before use. */
 			pDehMgr->errInfo.dwErrMask = DSP_MMUFAULT;
 			pDehMgr->errInfo.dwVal1 = faultAddr >> 16;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 6d6c76b..12f73e7 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -91,8 +91,27 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 			status = NTFY_Create(&pDehMgr->hNtfy);
 
 		/* Create a DPC object. */
-		status = DPC_Create(&pDehMgr->hMmuFaultDpc, MMU_FaultDpc,
-				   (void *)pDehMgr);
+		MEM_AllocObject(pDehMgr->hMmuFaultDpc, struct DPC_OBJECT,
+				SIGNATURE);
+		if (pDehMgr->hMmuFaultDpc) {
+			tasklet_init(&pDehMgr->hMmuFaultDpc->dpc_tasklet,
+				DPC_DeferredProcedure,
+				(u32)pDehMgr->hMmuFaultDpc);
+			/* Fill out DPC Object */
+			pDehMgr->hMmuFaultDpc->pRefData = (void *)pDehMgr;
+			pDehMgr->hMmuFaultDpc->pfnDPC = MMU_FaultDpc;
+			pDehMgr->hMmuFaultDpc->numRequested = 0;
+			pDehMgr->hMmuFaultDpc->numScheduled = 0;
+#ifdef DEBUG
+			pDehMgr->hMmuFaultDpc->numRequestedMax = 0;
+			pDehMgr->hMmuFaultDpc->cEntryCount = 0;
+#endif
+			spin_lock_init(&pDehMgr->hMmuFaultDpc->dpc_lock);
+		} else {
+			DBG_Trace(GT_6CLASS, "DEH DPC Create: DSP_EMEMORY\n");
+			status = DSP_EMEMORY;
+		}
+
 		if (DSP_SUCCEEDED(status))
 			status = DEV_GetDevNode(hDevObject, &hDevNode);
 
@@ -144,7 +163,13 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
 			(void)NTFY_Delete(pDehMgr->hNtfy);
 		/* Disable DSP MMU fault */
 		free_irq(INT_DSP_MMU_IRQ, pDehMgr);
-		(void)DPC_Destroy(pDehMgr->hMmuFaultDpc);
+
+		/* Free DPC object */
+		tasklet_kill(&pDehMgr->hMmuFaultDpc->dpc_tasklet);
+		MEM_FreeObject(pDehMgr->hMmuFaultDpc);
+		pDehMgr->hMmuFaultDpc = NULL;
+		DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
+
 		/* Deallocate the DEH manager object */
 		MEM_FreeObject(pDehMgr);
 	}
-- 
1.6.2.4


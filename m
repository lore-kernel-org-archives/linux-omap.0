From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/4] DSPBRIDGE: Remove main DPC wrapper for IO and MMUfault
Date: Fri, 15 Jan 2010 17:35:02 -0600
Message-ID: <1263598504-2353-3-git-send-email-omar.ramirez@ti.com>
References: <1263598504-2353-1-git-send-email-omar.ramirez@ti.com>
 <1263598504-2353-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42854 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247Ab0AOXZR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 18:25:17 -0500
In-Reply-To: <1263598504-2353-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove DeferredProcedure which is used as a wrapper to call
either IO or MMUfault DPCs. This also removes a custom typedef.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dpc.h   |   23 ---------------
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    2 +-
 drivers/dsp/bridge/services/dpc.c            |   36 -----------------------
 drivers/dsp/bridge/wmd/io_sm.c               |   40 +++++++++++++++++--------
 drivers/dsp/bridge/wmd/mmu_fault.c           |    2 +-
 drivers/dsp/bridge/wmd/mmu_fault.h           |    2 +-
 drivers/dsp/bridge/wmd/ue_deh.c              |    5 +--
 7 files changed, 31 insertions(+), 79 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
index 0c60342..b22140f 100644
--- a/arch/arm/plat-omap/include/dspbridge/dpc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dpc.h
@@ -19,30 +19,10 @@
 #ifndef DPC_
 #define DPC_
 
-/*
- *  ======== DPC_PROC ========
- *  Purpose:
- *      Deferred processing routine.  Typically scheduled from an ISR to
- *      complete I/O processing.
- *  Parameters:
- *      pRefData:   Ptr to user data: passed in via ISR_ScheduleDPC.
- *  Returns:
- *  Requires:
- *      The DPC should not block, or otherwise acquire resources.
- *      Interrupts to the processor are enabled.
- *      DPC_PROC executes in a critical section.
- *  Ensures:
- *      This DPC will not be reenterred on the same thread.
- *      However, the DPC may take hardware interrupts during execution.
- *      Interrupts to the processor are enabled.
- */
-       typedef void(*DPC_PROC) (void *pRefData);
-
 /* The DPC object, passed to our priority event callback routine: */
 struct DPC_OBJECT {
 	u32 dwSignature;	/* Used for object validation.   */
 	void *pRefData;		/* Argument for client's DPC.    */
-	DPC_PROC pfnDPC;	/* Client's DPC.                 */
 	u32 numRequested;	/* Number of requested DPC's.      */
 	u32 numScheduled;	/* Number of executed DPC's.      */
 	struct tasklet_struct dpc_tasklet;
@@ -81,7 +61,4 @@ struct DPC_OBJECT {
  */
        extern bool DPC_Init(void);
 
-/*  ----------------------------------- Function Prototypes */
- void DPC_DeferredProcedure(IN unsigned long pDeferredContext);
-
 #endif				/* DPC_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 77f9e25..67e3834 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -77,7 +77,7 @@
  *  Ensures:
  *      Non-preemptible (but interruptible).
  */
-	extern void IO_DPC(IN OUT void *pRefData);
+	extern void IO_DPC(IN OUT unsigned long pRefData);
 
 /*
  *  ======== IO_ISR ========
diff --git a/drivers/dsp/bridge/services/dpc.c b/drivers/dsp/bridge/services/dpc.c
index 10bd792..bbb2d47 100644
--- a/drivers/dsp/bridge/services/dpc.c
+++ b/drivers/dsp/bridge/services/dpc.c
@@ -66,39 +66,3 @@ bool DPC_Init(void)
 	return true;
 }
 
-/*
- *  ======== DeferredProcedure ========
- *  Purpose:
- *      Main DPC routine.  This is called by host OS DPC callback
- *      mechanism with interrupts enabled.
- */
-void DPC_DeferredProcedure(IN unsigned long pDeferredContext)
-{
-	struct DPC_OBJECT *pDPCObject = (struct DPC_OBJECT *)pDeferredContext;
-	/* read numRequested in local variable */
-	u32 requested;
-	u32 serviced;
-
-	DBC_Require(pDPCObject != NULL);
-	requested = pDPCObject->numRequested;
-	serviced = pDPCObject->numScheduled;
-
-	GT_1trace(DPC_DebugMask, GT_ENTER, "> DPC_DeferredProcedure "
-		  "pDeferredContext=%x\n", pDeferredContext);
-	/* Rollover taken care of using != instead of < */
-	if (serviced != requested) {
-		if (pDPCObject->pfnDPC != NULL) {
-			/* Process pending DPC's: */
-			do {
-				/* Call client's DPC: */
-				(*(pDPCObject->pfnDPC))(pDPCObject->pRefData);
-				serviced++;
-			} while (serviced != requested);
-		}
-		pDPCObject->numScheduled = requested;
-	}
-	GT_2trace(DPC_DebugMask, GT_ENTER,
-		  "< DPC_DeferredProcedure requested %d"
-		  " serviced %d\n", requested, serviced);
-}
-
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index b7b7bd9..470c83b 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -252,10 +252,8 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 				IO_MGRSIGNATURE);
 		if (pIOMgr->hDPC) {
 			tasklet_init(&pIOMgr->hDPC->dpc_tasklet,
-				DPC_DeferredProcedure, (u32)pIOMgr->hDPC);
+				IO_DPC, (u32)pIOMgr);
 			/* Fill out our DPC Object */
-			pIOMgr->hDPC->pRefData = (void *)pIOMgr;
-			pIOMgr->hDPC->pfnDPC = IO_DPC;
 			pIOMgr->hDPC->numRequested = 0;
 			pIOMgr->hDPC->numScheduled = 0;
 #ifdef DEBUG
@@ -1010,12 +1008,14 @@ static void IO_DispatchPM(struct work_struct *work)
  *      out the dispatch of I/O as a non-preemptible event.It can only be
  *      pre-empted      by an ISR.
  */
-void IO_DPC(IN OUT void *pRefData)
+void IO_DPC(IN OUT unsigned long pRefData)
 {
 	struct IO_MGR *pIOMgr = (struct IO_MGR *)pRefData;
 	struct CHNL_MGR *pChnlMgr;
 	struct MSG_MGR *pMsgMgr;
 	struct DEH_MGR *hDehMgr;
+	u32 requested;
+	u32 serviced;
 
 	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		goto func_end;
@@ -1025,16 +1025,27 @@ void IO_DPC(IN OUT void *pRefData)
 	if (!MEM_IsValidHandle(pChnlMgr, CHNL_MGRSIGNATURE))
 		goto func_end;
 	DBG_Trace(DBG_LEVEL7, "Entering IO_DPC(0x%x)\n", pRefData);
-	/* Check value of interrupt register to ensure it is a valid error */
-	if ((pIOMgr->wIntrVal > DEH_BASE) && (pIOMgr->wIntrVal < DEH_LIMIT)) {
-		/* Notify DSP/BIOS exception */
-		if (hDehMgr)
-			WMD_DEH_Notify(hDehMgr, DSP_SYSERROR, pIOMgr->wIntrVal);
-	}
-	IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
+
+	requested = pIOMgr->hDPC->numRequested;
+	serviced = pIOMgr->hDPC->numScheduled;
+
+	if (serviced == requested)
+		goto func_end;
+
+	/* Process pending DPC's */
+	do {
+		/* Check value of interrupt reg to ensure it's a valid error */
+		if ((pIOMgr->wIntrVal > DEH_BASE) &&
+		   (pIOMgr->wIntrVal < DEH_LIMIT)) {
+			/* Notify DSP/BIOS exception */
+			if (hDehMgr)
+				WMD_DEH_Notify(hDehMgr, DSP_SYSERROR,
+						pIOMgr->wIntrVal);
+		}
+		IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
 #ifdef CHNL_MESSAGES
-	if (MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE))
-		IO_DispatchMsg(pIOMgr, pMsgMgr);
+		if (MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE))
+			IO_DispatchMsg(pIOMgr, pMsgMgr);
 #endif
 #ifndef DSP_TRACEBUF_DISABLED
 	if (pIOMgr->wIntrVal & MBX_DBG_SYSPRINTF) {
@@ -1042,6 +1053,9 @@ void IO_DPC(IN OUT void *pRefData)
 		PrintDSPDebugTrace(pIOMgr);
 	}
 #endif
+		serviced++;
+	} while (serviced != requested);
+	pIOMgr->hDPC->numScheduled = requested;
 func_end:
 	return;
 }
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 057fe65..d3807ac 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -54,7 +54,7 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext);
  *  ======== MMU_FaultDpc ========
  *      Deferred procedure call to handle DSP MMU fault.
  */
-void MMU_FaultDpc(IN void *pRefData)
+void MMU_FaultDpc(IN unsigned long pRefData)
 {
 	struct DEH_MGR *hDehMgr = (struct DEH_MGR *)pRefData;
 	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)hDehMgr;
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.h b/drivers/dsp/bridge/wmd/mmu_fault.h
index bed466c..d3849b5 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.h
+++ b/drivers/dsp/bridge/wmd/mmu_fault.h
@@ -23,7 +23,7 @@
  *  ======== MMU_FaultDpc ========
  *      Deferred procedure call to handle DSP MMU fault.
  */
-	void MMU_FaultDpc(IN void *pRefData);
+	void MMU_FaultDpc(IN unsigned long pRefData);
 
 /*
  *  ======== MMU_FaultIsr ========
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index d4d45d4..cd2d220 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -95,11 +95,8 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 				SIGNATURE);
 		if (pDehMgr->hMmuFaultDpc) {
 			tasklet_init(&pDehMgr->hMmuFaultDpc->dpc_tasklet,
-				DPC_DeferredProcedure,
-				(u32)pDehMgr->hMmuFaultDpc);
+				MMU_FaultDpc, (u32)pDehMgr);
 			/* Fill out DPC Object */
-			pDehMgr->hMmuFaultDpc->pRefData = (void *)pDehMgr;
-			pDehMgr->hMmuFaultDpc->pfnDPC = MMU_FaultDpc;
 			pDehMgr->hMmuFaultDpc->numRequested = 0;
 			pDehMgr->hMmuFaultDpc->numScheduled = 0;
 #ifdef DEBUG
-- 
1.6.2.4


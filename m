From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 20/20] DSPBRIDGE: Remove DPC object structure
Date: Mon, 30 Nov 2009 15:55:01 -0600
Message-ID: <1259618101-8972-21-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-12-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-13-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-14-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-15-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-16-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-17-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-18-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-19-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-20-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45934 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZK3VtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 16:49:01 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn70s013337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:07 -0600
In-Reply-To: <1259618101-8972-20-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Remove DPC object structure and declare required members
for each tasklet inside their correspondent modules.

Remove dpc header file.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    1 -
 arch/arm/plat-omap/include/dspbridge/dpc.h      |   38 ------------
 drivers/dsp/bridge/pmgr/chnl.c                  |    1 -
 drivers/dsp/bridge/services/services.c          |    1 -
 drivers/dsp/bridge/wmd/_deh.h                   |    5 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |   72 +++++++++-------------
 drivers/dsp/bridge/wmd/mmu_fault.c              |   24 +-------
 drivers/dsp/bridge/wmd/ue_deh.c                 |   25 +-------
 8 files changed, 38 insertions(+), 129 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/dpc.h

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index f22b2cb..eb5adc2 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -25,7 +25,6 @@
 
 #include <dspbridge/wcd.h>
 #include <dspbridge/wmd.h>
-#include <dspbridge/dpc.h>
 
 #include <dspbridge/list.h>
 #include <dspbridge/ntfy.h>
diff --git a/arch/arm/plat-omap/include/dspbridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
deleted file mode 100644
index aee910d..0000000
--- a/arch/arm/plat-omap/include/dspbridge/dpc.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * dpc.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Deferred Procedure Call(DPC) Services.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-#ifndef DPC_
-#define DPC_
-
-/* The DPC object, passed to our priority event callback routine: */
-struct DPC_OBJECT {
-	u32 dwSignature;	/* Used for object validation.   */
-	void *pRefData;		/* Argument for client's DPC.    */
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
-#endif				/* DPC_ */
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index f4d0fc1..fd487f0 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -31,7 +31,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/dpc.h>
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 0b7d623..5590634 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -29,7 +29,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/dbg.h>
-#include <dspbridge/dpc.h>
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
diff --git a/drivers/dsp/bridge/wmd/_deh.h b/drivers/dsp/bridge/wmd/_deh.h
index 2b364b5..aadb9fa 100644
--- a/drivers/dsp/bridge/wmd/_deh.h
+++ b/drivers/dsp/bridge/wmd/_deh.h
@@ -19,7 +19,6 @@
 #ifndef _DEH_
 #define _DEH_
 
-#include <dspbridge/dpc.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/wmd.h>
 
@@ -30,8 +29,10 @@ struct DEH_MGR {
 	u32 dwSignature;	/* Used for object validation.  */
 	struct WMD_DEV_CONTEXT *hWmdContext;	/* WMD device context. */
 	struct NTFY_OBJECT *hNtfy;	/* NTFY object                  */
-	struct DPC_OBJECT *hMmuFaultDpc;	/* DPC object handle.  */
 	struct DSP_ERRORINFO errInfo;	/* DSP exception info.          */
+
+	/* MMU Fault DPC */
+	struct tasklet_struct dpc_tasklet;
 } ;
 
 #endif				/* _DEH_ */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 177dbbc..a1c028a 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -43,7 +43,6 @@
 
 /* Services Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/dpc.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/sync.h>
@@ -108,7 +107,6 @@ struct IO_MGR {
 	u8 *pMsgOutput; 	/* Address of output messages */
 	u32 uSMBufSize; 	/* Size of a shared memory I/O channel */
 	bool fSharedIRQ; 	/* Is this IRQ shared? */
-	struct DPC_OBJECT *hDPC; 	/* DPC object handle */
 	struct SYNC_CSOBJECT *hCSObj; 	/* Critical section object handle */
 	u32 uWordSize; 	/* Size in bytes of DSP word */
 	u16 wIntrVal; 		/* Interrupt value */
@@ -128,6 +126,12 @@ struct IO_MGR {
 	u32 ulGppVa;
 	u32 ulDspVa;
 #endif
+	/* IO Dpc */
+	u32 dpc_req;				/* Number of requested DPC's. */
+	u32 dpc_sched;				/* Number of executed DPC's. */
+	struct tasklet_struct dpc_tasklet;
+	spinlock_t dpc_lock;
+
 } ;
 
 /* Function Prototypes */
@@ -250,24 +254,14 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		status = SYNC_InitializeCS(&pIOMgr->hCSObj);
 
 	if (devType == DSP_UNIT) {
-		/* Create a DPC object */
-		MEM_AllocObject(pIOMgr->hDPC, struct DPC_OBJECT,
-				IO_MGRSIGNATURE);
-		if (pIOMgr->hDPC) {
-			tasklet_init(&pIOMgr->hDPC->dpc_tasklet,
-				IO_DPC, (u32)pIOMgr);
-			/* Fill out our DPC Object */
-			pIOMgr->hDPC->numRequested = 0;
-			pIOMgr->hDPC->numScheduled = 0;
-#ifdef DEBUG
-			pIOMgr->hDPC->numRequestedMax = 0;
-			pIOMgr->hDPC->cEntryCount = 0;
-#endif
-			spin_lock_init(&pIOMgr->hDPC->dpc_lock);
-		} else {
-			DBG_Trace(GT_6CLASS, "IO DPC Create: DSP_EMEMORY\n");
-			status = DSP_EMEMORY;
-		}
+		/* Create an IO DPC */
+		tasklet_init(&pIOMgr->dpc_tasklet, IO_DPC, (u32)pIOMgr);
+
+		/* Initialize DPC counters */
+		pIOMgr->dpc_req = 0;
+		pIOMgr->dpc_sched = 0;
+
+		spin_lock_init(&pIOMgr->dpc_lock);
 
 		if (DSP_SUCCEEDED(status))
 			status = DEV_GetDevNode(hDevObject, &hDevNode);
@@ -330,10 +324,8 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 		/* Linux function to uninstall ISR */
 		free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
 
-		/* Free DPC object */
-		tasklet_kill(&hIOMgr->hDPC->dpc_tasklet);
-		MEM_FreeObject(hIOMgr->hDPC);
-		hIOMgr->hDPC = NULL;
+		/* Free IO DPC object */
+		tasklet_kill(&hIOMgr->dpc_tasklet);
 		DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
 
 #ifndef DSP_TRACEBUF_DISABLED
@@ -1026,8 +1018,8 @@ void IO_DPC(IN OUT unsigned long pRefData)
 		goto func_end;
 	DBG_Trace(DBG_LEVEL7, "Entering IO_DPC(0x%x)\n", pRefData);
 
-	requested = pIOMgr->hDPC->numRequested;
-	serviced = pIOMgr->hDPC->numScheduled;
+	requested = pIOMgr->dpc_req;
+	serviced = pIOMgr->dpc_sched;
 
 	if (serviced == requested)
 		goto func_end;
@@ -1056,7 +1048,7 @@ void IO_DPC(IN OUT unsigned long pRefData)
 #endif
 		serviced++;
 	} while (serviced != requested);
-	pIOMgr->hDPC->numScheduled = requested;
+	pIOMgr->dpc_sched = requested;
 func_end:
 	return;
 }
@@ -1098,11 +1090,12 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 			 * PROC-COPY defer i/o.
 			 * Increment count of DPC's pending.
 			 */
-			spin_lock_irqsave(&hIOMgr->hDPC->dpc_lock, flags);
-			hIOMgr->hDPC->numRequested++;
-			spin_unlock_irqrestore(&hIOMgr->hDPC->dpc_lock, flags);
+			spin_lock_irqsave(&hIOMgr->dpc_lock, flags);
+			hIOMgr->dpc_req++;
+			spin_unlock_irqrestore(&hIOMgr->dpc_lock, flags);
 
 			/* Schedule DPC */
+<<<<<<< HEAD:drivers/dsp/bridge/wmd/io_sm.c
 			tasklet_schedule(&hIOMgr->hDPC->dpc_tasklet);
 #ifdef DEBUG
 			if (hIOMgr->hDPC->numRequested >
@@ -1113,6 +1106,9 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 					hIOMgr->hDPC->numScheduled;
 			}
 #endif
+=======
+			tasklet_schedule(&hIOMgr->dpc_tasklet);
+>>>>>>> b7df160... DSPBRIDGE: Remove DPC object structure:drivers/dsp/bridge/wmd/io_sm.c
 		}
 	} else
 		/* Ensure that, if WMD didn't claim it, the IRQ is shared. */
@@ -1180,20 +1176,12 @@ void IO_Schedule(struct IO_MGR *pIOMgr)
 	tiomap3430_bump_dsp_opp_level();
 
 	/* Increment count of DPC's pending. */
-	spin_lock_irqsave(&pIOMgr->hDPC->dpc_lock, flags);
-	pIOMgr->hDPC->numRequested++;
-	spin_unlock_irqrestore(&pIOMgr->hDPC->dpc_lock, flags);
+	spin_lock_irqsave(&pIOMgr->dpc_lock, flags);
+	pIOMgr->dpc_req++;
+	spin_unlock_irqrestore(&pIOMgr->dpc_lock, flags);
 
 	/* Schedule DPC */
-	tasklet_schedule(&pIOMgr->hDPC->dpc_tasklet);
-#ifdef DEBUG
-	if (pIOMgr->hDPC->numRequested > pIOMgr->hDPC->numScheduled +
-	   pIOMgr->hDPC->numRequestedMax) {
-		pIOMgr->hDPC->numRequestedMax =	pIOMgr->hDPC->numRequested -
-				pIOMgr->hDPC->numScheduled;
-	}
-#endif
-
+	tasklet_schedule(&pIOMgr->dpc_tasklet);
 }
 
 /*
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index b3f0719..b184250 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -27,7 +27,6 @@
 #include <dspbridge/dbg.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/dpc.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/drv.h>
 
@@ -57,11 +56,10 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext);
 void MMU_FaultDpc(IN unsigned long pRefData)
 {
 	struct DEH_MGR *hDehMgr = (struct DEH_MGR *)pRefData;
-	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)hDehMgr;
 
 	DBG_Trace(DBG_LEVEL1, "MMU_FaultDpc Enter: 0x%x\n", pRefData);
 
-	if (pDehMgr)
+	if (hDehMgr)
 		WMD_DEH_Notify(hDehMgr, DSP_MMUFAULT, 0L);
 
 	DBG_Trace(DBG_LEVEL1, "MMU_FaultDpc Exit: 0x%x\n", pRefData);
@@ -76,7 +74,6 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)pRefData;
 	struct WMD_DEV_CONTEXT *pDevContext;
 	DSP_STATUS status = DSP_SOK;
-	unsigned long flags;
 
 	DBG_Trace(DBG_LEVEL1, "Entering DEH_DspMmuIsr: 0x%x\n", pRefData);
        DBC_Require(irq == INT_DSP_MMU_IRQ);
@@ -99,24 +96,7 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 			 * necessary to check if DSP MMU fault is intended for
 			 * Bridge.
 			 */
-			/* Increment count of DPC's pending. */
-			spin_lock_irqsave(&pDehMgr->hMmuFaultDpc->dpc_lock,
-						flags);
-			pDehMgr->hMmuFaultDpc->numRequested++;
-			spin_unlock_irqrestore(&pDehMgr->hMmuFaultDpc->dpc_lock,
-						flags);
-
-			/* Schedule DPC */
-			tasklet_schedule(&pDehMgr->hMmuFaultDpc->dpc_tasklet);
-#ifdef DEBUG
-			if (pDehMgr->hMmuFaultDpc->numRequested >
-			   pDehMgr->hMmuFaultDpc->numScheduled +
-			   pDehMgr->hMmuFaultDpc->numRequestedMax) {
-				pDehMgr->hMmuFaultDpc->numRequestedMax =
-					pDehMgr->hMmuFaultDpc->numRequested -
-					pDehMgr->hMmuFaultDpc->numScheduled;
-			}
-#endif
+			tasklet_schedule(&pDehMgr->dpc_tasklet);
 
 			/* Reset errInfo structure before use. */
 			pDehMgr->errInfo.dwErrMask = DSP_MMUFAULT;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 4d0bcf2..6a1314f 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -30,7 +30,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/dpc.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/drv.h>
@@ -90,24 +89,8 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 		if (DSP_SUCCEEDED(status))
 			status = NTFY_Create(&pDehMgr->hNtfy);
 
-		/* Create a DPC object. */
-		MEM_AllocObject(pDehMgr->hMmuFaultDpc, struct DPC_OBJECT,
-				SIGNATURE);
-		if (pDehMgr->hMmuFaultDpc) {
-			tasklet_init(&pDehMgr->hMmuFaultDpc->dpc_tasklet,
-				MMU_FaultDpc, (u32)pDehMgr);
-			/* Fill out DPC Object */
-			pDehMgr->hMmuFaultDpc->numRequested = 0;
-			pDehMgr->hMmuFaultDpc->numScheduled = 0;
-#ifdef DEBUG
-			pDehMgr->hMmuFaultDpc->numRequestedMax = 0;
-			pDehMgr->hMmuFaultDpc->cEntryCount = 0;
-#endif
-			spin_lock_init(&pDehMgr->hMmuFaultDpc->dpc_lock);
-		} else {
-			DBG_Trace(GT_6CLASS, "DEH DPC Create: DSP_EMEMORY\n");
-			status = DSP_EMEMORY;
-		}
+		/* Create a MMUfault DPC */
+		tasklet_init(&pDehMgr->dpc_tasklet, MMU_FaultDpc, (u32)pDehMgr);
 
 		if (DSP_SUCCEEDED(status))
 			status = DEV_GetDevNode(hDevObject, &hDevNode);
@@ -162,9 +145,7 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
 		free_irq(INT_DSP_MMU_IRQ, pDehMgr);
 
 		/* Free DPC object */
-		tasklet_kill(&pDehMgr->hMmuFaultDpc->dpc_tasklet);
-		MEM_FreeObject(pDehMgr->hMmuFaultDpc);
-		pDehMgr->hMmuFaultDpc = NULL;
+		tasklet_kill(&pDehMgr->dpc_tasklet);
 		DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
 
 		/* Deallocate the DEH manager object */
-- 
1.6.2.4


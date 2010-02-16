From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 12/18] DSPBRIDGE: Remove excessive debug statements for services
Date: Tue, 16 Feb 2010 02:42:22 -0600
Message-ID: <1266309748-11714-13-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59998 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755605Ab0BPIaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:06 -0500
In-Reply-To: <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Removed debug statements that print redundant errors where
returned statuses should be enough in case of failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/cfg.c  |   15 +-----
 drivers/dsp/bridge/services/mem.c  |   13 -----
 drivers/dsp/bridge/services/sync.c |   94 +++++++-----------------------------
 3 files changed, 19 insertions(+), 103 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index de2a7ab..f8c958a 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -73,11 +73,7 @@ DSP_STATUS CFG_GetAutoStart(struct CFG_DEVNODE *hDevNode,
 		if (DSP_FAILED(status))
 			status = CFG_E_RESOURCENOTAVAIL;
 	}
-#ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_FAILED(status))
-		GT_0trace(CFG_debugMask, GT_6CLASS,
-		"CFG_GetAutoStart Failed \n");
-#endif
+
 	DBC_Ensure((status == DSP_SOK &&
 		(*pdwAutoStart == 0 || *pdwAutoStart == 1))
 		|| status != DSP_SOK);
@@ -105,13 +101,9 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 
 		/* check the device string and then call the REG_SetValue*/
 		if (!(strcmp((char *)((struct DRV_EXT *)hDevNode)->szString,
-							"TIOMAP1510"))) {
+							"TIOMAP1510")))
 			status = REG_GetValue("DEVICE_DSP", (u8 *)pdwValue,
 					      &dwBufSize);
-		} else {
-			GT_0trace(CFG_debugMask, GT_6CLASS,
-				  "Failed to Identify the Device to Fetch \n");
-		}
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
@@ -302,9 +294,6 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 		if (!(strcmp((char *)hDevNode, "TIOMAP1510"))) {
 			status = REG_SetValue("DEVICE_DSP", (u8 *)&dwValue,
 						dwBuffSize);
-		} else {
-			GT_0trace(CFG_debugMask, GT_6CLASS,
-				  "Failed to Register Device \n");
 		}
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 189ebfc..65d268a 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -97,10 +97,6 @@ static void *MEM_ExtPhysMemAlloc(u32 bytes, u32 align, OUT u32 *pPhysAddr)
 
 	if (bytes > ((extMemPool.physMemBase + extMemPool.physMemSize)
 	    - extMemPool.nextPhysAllocPtr)) {
-		GT_1trace(MEM_debugMask, GT_7CLASS,
-			  "ExtPhysical Memory Allocation "
-			  "unable to allocate memory for bytes = 0x%x \n",
-			  bytes);
 		pPhysAddr = NULL;
 		return NULL;
 	} else {
@@ -147,9 +143,6 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 			break;
 
 		default:
-			GT_0trace(MEM_debugMask, GT_6CLASS,
-				  "MEM_Alloc: unexpected "
-				  "MEM_POOLATTRS value\n");
 			break;
 		}
 	}
@@ -176,9 +169,6 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32 *pPhysicalAddress)
 				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
 		if (pVaMem == NULL) {
 			*pPhysicalAddress = 0;
-			GT_1trace(MEM_debugMask, GT_6CLASS,
-				  "MEM_AllocPhysMem failed: "
-				  "0x%x\n", pVaMem);
 		} else {
 			*pPhysicalAddress = paMem;
 		}
@@ -212,9 +202,6 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 				memset(pMem, 0, cBytes);
 			break;
 		default:
-			GT_1trace(MEM_debugMask, GT_6CLASS,
-				  "MEM_Calloc: unexpected "
-				  "MEM_POOLATTRS value 0x%x\n", type);
 			break;
 		}
 	}
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index 9be4d8c..f9cd360 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -94,18 +94,13 @@ DSP_STATUS SYNC_CloseEvent(struct SYNC_OBJECT *hEvent)
 	DBC_Require(pEvent != NULL && pEvent->pWaitObj == NULL);
 
 	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
-		if (pEvent->pWaitObj) {
+		if (pEvent->pWaitObj)
 			status = DSP_EFAIL;
-			GT_0trace(SYNC_debugMask, GT_6CLASS,
-				  "SYNC_CloseEvent: Wait object not NULL\n");
-		}
+
 		MEM_FreeObject(pEvent);
 
 	} else {
 		status = DSP_EHANDLE;
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_CloseEvent: invalid "
-			  "hEvent handle 0x%x\n", hEvent);
 	}
 
 	return status;
@@ -154,8 +149,6 @@ DSP_STATUS SYNC_OpenEvent(OUT struct SYNC_OBJECT **phEvent,
 		spin_lock_init(&pEvent->sync_lock);
 	} else {
 		status = DSP_EMEMORY;
-		GT_0trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_OpenEvent: MEM_AllocObject failed\n");
 	}
 
 	*phEvent = pEvent;
@@ -173,14 +166,10 @@ DSP_STATUS SYNC_ResetEvent(struct SYNC_OBJECT *hEvent)
 	DSP_STATUS status = DSP_SOK;
 	struct SYNC_OBJECT *pEvent = (struct SYNC_OBJECT *)hEvent;
 
-	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
+	if (MEM_IsValidHandle(hEvent, SIGNATURE))
 		pEvent->state = so_reset;
-	} else {
+	else
 		status = DSP_EHANDLE;
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_ResetEvent: invalid hEvent "
-			  "handle 0x%x\n", hEvent);
-	}
 
 	return status;
 }
@@ -215,9 +204,6 @@ DSP_STATUS SYNC_SetEvent(struct SYNC_OBJECT *hEvent)
 		spin_unlock_irqrestore(&hEvent->sync_lock, flags);
 	} else {
 		status = DSP_EHANDLE;
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_SetEvent: invalid hEvent "
-			  "handle 0x%x\n", hEvent);
 	}
 	return status;
 }
@@ -234,15 +220,12 @@ DSP_STATUS SYNC_WaitOnEvent(struct SYNC_OBJECT *hEvent, u32 dwTimeout)
 	struct SYNC_OBJECT *pEvent = (struct SYNC_OBJECT *)hEvent;
 	u32 temp;
 
-	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
+	if (MEM_IsValidHandle(hEvent, SIGNATURE))
 		status = SYNC_WaitOnMultipleEvents(&pEvent, 1, dwTimeout,
 						  &temp);
-	} else {
+	else
 		status = DSP_EHANDLE;
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_WaitOnEvent: invalid hEvent"
-			  "handle 0x%x\n", hEvent);
-	}
+
 	return status;
 }
 
@@ -310,15 +293,9 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
 		}
 		if (dwTimeout != SYNC_INFINITE) {
 			if (in_interrupt()) {
-				if (!del_timer(&timeout)) {
-					GT_0trace(SYNC_debugMask, GT_7CLASS,
-						  "SYNC: Timer expired\n");
-				}
+				del_timer(&timeout);
 			} else {
-				if (!del_timer_sync(&timeout)) {
-					GT_0trace(SYNC_debugMask, GT_7CLASS,
-						  "SYNC: Timer expired\n");
-				}
+				del_timer_sync(&timeout);
 			}
 		}
 	}
@@ -332,11 +309,8 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
 			*puIndex = i;
 
 	}
-	if (Wp->signalling_event == NULL && DSP_SUCCEEDED(status)) {
-		GT_0trace(SYNC_debugMask, GT_7CLASS,
-			  "SYNC:Signaling Event NULL!!!(:-\n");
+	if (Wp->signalling_event == NULL && DSP_SUCCEEDED(status))
 		status = DSP_ETIMEOUT;
-	}
 	kfree(Wp);
 	return status;
 }
@@ -358,28 +332,19 @@ DSP_STATUS SYNC_DeleteCS(struct SYNC_CSOBJECT *hCSObj)
 	struct SYNC_CSOBJECT *pCSObj = (struct SYNC_CSOBJECT *)hCSObj;
 
 	if (MEM_IsValidHandle(hCSObj, SIGNATURECS)) {
-		if (down_trylock(&pCSObj->sem) != 0) {
-			GT_1trace(SYNC_debugMask, GT_7CLASS,
-				  "CS in use (locked) while "
-				  "deleting! pCSObj=0x%X", pCSObj);
+		if (down_trylock(&pCSObj->sem) != 0)
 			DBC_Assert(0);
-		}
+
 		MEM_FreeObject(hCSObj);
 	} else if (MEM_IsValidHandle(hCSObj, SIGNATUREDPCCS)) {
 		struct SYNC_DPCCSOBJECT *pDPCCSObj =
 					 (struct SYNC_DPCCSOBJECT *)hCSObj;
-		if (pDPCCSObj->count != 1) {
-			GT_1trace(SYNC_debugMask, GT_7CLASS,
-				  "DPC CS in use (locked) while "
-				  "deleting! pCSObj=0x%X", pCSObj);
+		if (pDPCCSObj->count != 1)
 			DBC_Assert(0);
-		}
+
 		MEM_FreeObject(pDPCCSObj);
 	} else {
 		status = DSP_EHANDLE;
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_DeleteCS: invalid hCSObj "
-			  "handle 0x%x\n", hCSObj);
 	}
 
 	return status;
@@ -396,14 +361,8 @@ DSP_STATUS SYNC_EnterCS(struct SYNC_CSOBJECT *hCSObj)
 	if (MEM_IsValidHandle(hCSObj, SIGNATURECS)) {
 		if (in_interrupt()) {
 			status = DSP_EFAIL;
-			GT_0trace(SYNC_debugMask, GT_7CLASS,
-				 "SYNC_EnterCS called from "
-				 "ISR/DPC or with ISR/DPC disabled!");
 			DBC_Assert(0);
 		} else if (down_interruptible(&pCSObj->sem)) {
-			GT_1trace(SYNC_debugMask, GT_7CLASS,
-				 "CS interrupted by signal! "
-				 "pCSObj=0x%X", pCSObj);
 			status = DSP_EFAIL;
 		}
 	} else if (MEM_IsValidHandle(hCSObj, SIGNATUREDPCCS)) {
@@ -413,17 +372,11 @@ DSP_STATUS SYNC_EnterCS(struct SYNC_CSOBJECT *hCSObj)
 		pDPCCSObj->count--;
 		if (pDPCCSObj->count != 0) {
 			/* FATAL ERROR : Failed to acquire DPC CS */
-			GT_2trace(SYNC_debugMask, GT_7CLASS,
-				  "SYNC_EnterCS DPCCS %x locked,"
-				  "count %d", pDPCCSObj, pDPCCSObj->count);
 			spin_unlock_bh(&pDPCCSObj->sync_dpccs_lock);
 			DBC_Assert(0);
 		}
 	} else {
 		status = DSP_EHANDLE;
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_EnterCS: invalid hCSObj "
-			  "handle 0x%x\n", hCSObj);
 	}
 
 	return status;
@@ -439,14 +392,11 @@ DSP_STATUS SYNC_InitializeCS(OUT struct SYNC_CSOBJECT **phCSObj)
 
 	/* Allocate memory for sync CS object */
 	MEM_AllocObject(pCSObj, struct SYNC_CSOBJECT, SIGNATURECS);
-	if (pCSObj != NULL) {
+	if (pCSObj != NULL)
 		init_MUTEX(&pCSObj->sem);
-	} else {
+	else
 		status = DSP_EMEMORY;
-		GT_0trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_InitializeCS: MEM_AllocObject"
-			  "failed\n");
-	}
+
 	/* return CS object */
 	*phCSObj = pCSObj;
 	DBC_Assert(DSP_FAILED(status) || (pCSObj));
@@ -469,9 +419,6 @@ DSP_STATUS SYNC_InitializeDPCCS(OUT struct SYNC_CSOBJECT **phCSObj)
 			spin_lock_init(&pCSObj->sync_dpccs_lock);
 		} else {
 			status = DSP_EMEMORY;
-			GT_0trace(SYNC_debugMask, GT_6CLASS,
-				  "SYNC_InitializeDPCCS: "
-				  "MEM_AllocObject failed\n");
 		}
 
 		/* return CS object */
@@ -501,10 +448,6 @@ DSP_STATUS SYNC_LeaveCS(struct SYNC_CSOBJECT *hCSObj)
 		pDPCCSObj->count++;
 		if (pDPCCSObj->count != 1) {
 			/* FATAL ERROR : Invalid DPC CS count */
-			GT_2trace(SYNC_debugMask, GT_7CLASS,
-				  "SYNC_LeaveCS DPCCS %x, "
-				  "Invalid count %d", pDPCCSObj,
-				  pDPCCSObj->count);
 			spin_unlock_bh(&pDPCCSObj->sync_dpccs_lock);
 			DBC_Assert(0);
 			spin_lock_bh(&pDPCCSObj->sync_dpccs_lock);
@@ -512,9 +455,6 @@ DSP_STATUS SYNC_LeaveCS(struct SYNC_CSOBJECT *hCSObj)
 		spin_unlock_bh(&pDPCCSObj->sync_dpccs_lock);
 	} else {
 		status = DSP_EHANDLE;
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			  "SYNC_LeaveCS: invalid hCSObj "
-			  "handle 0x%x\n", hCSObj);
 	}
 
 	return status;
-- 
1.6.2.4


From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 08/18] DSPBRIDGE: Remove debug statements for success in services
Date: Tue, 16 Feb 2010 02:42:18 -0600
Message-ID: <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41202 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483Ab0BPIaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:06 -0500
In-Reply-To: <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes debug statements used to print a successful
status or printed during normal execution, as they just polute
the logs if trying to look for a failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/cfg.c  |   62 ++++++------------------------------
 drivers/dsp/bridge/services/clk.c  |   10 ------
 drivers/dsp/bridge/services/mem.c  |   21 +-----------
 drivers/dsp/bridge/services/sync.c |   20 +-----------
 4 files changed, 13 insertions(+), 100 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 7b2a896..de2a7ab 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -74,13 +74,9 @@ DSP_STATUS CFG_GetAutoStart(struct CFG_DEVNODE *hDevNode,
 			status = CFG_E_RESOURCENOTAVAIL;
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_SUCCEEDED(status)) {
-		GT_0trace(CFG_debugMask, GT_1CLASS,
-			 "CFG_GetAutoStart SUCCESS \n");
-	} else {
+	if (DSP_FAILED(status))
 		GT_0trace(CFG_debugMask, GT_6CLASS,
 		"CFG_GetAutoStart Failed \n");
-	}
 #endif
 	DBC_Ensure((status == DSP_SOK &&
 		(*pdwAutoStart == 0 || *pdwAutoStart == 1))
@@ -110,9 +106,6 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 		/* check the device string and then call the REG_SetValue*/
 		if (!(strcmp((char *)((struct DRV_EXT *)hDevNode)->szString,
 							"TIOMAP1510"))) {
-			GT_0trace(CFG_debugMask, GT_1CLASS,
-				  "Fetching DSP Device from "
-				  "Registry \n");
 			status = REG_GetValue("DEVICE_DSP", (u8 *)pdwValue,
 					      &dwBufSize);
 		} else {
@@ -121,14 +114,9 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 		}
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_SUCCEEDED(status)) {
-		GT_1trace(CFG_debugMask, GT_1CLASS,
-			  "CFG_GetDevObject SUCCESS DevObject"
-			  ": 0x%x\n ", *pdwValue);
-	} else {
+	if (DSP_FAILED(status))
 		GT_0trace(CFG_debugMask, GT_6CLASS,
 			  "CFG_GetDevObject Failed \n");
-	}
 #endif
 	return status;
 }
@@ -152,10 +140,7 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 		status = REG_GetValue(DSPRESOURCES, (u8 *)pDSPResTable,
 				     &dwResSize);
 	}
-	if (DSP_SUCCEEDED(status)) {
-		GT_0trace(CFG_debugMask, GT_1CLASS,
-			  "CFG_GetDSPResources SUCCESS\n");
-	} else {
+	if (DSP_FAILED(status)) {
 		status = CFG_E_RESOURCENOTAVAIL;
 		GT_0trace(CFG_debugMask, GT_6CLASS,
 			  "CFG_GetDSPResources Failed \n");
@@ -196,14 +181,9 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_SUCCEEDED(status)) {
-		GT_1trace(CFG_debugMask, GT_1CLASS,
-			  "CFG_GetExecFile SUCCESS Exec File"
-			  "name : %s\n ", pstrExecFile);
-	} else {
+	if (DSP_FAILED(status))
 		GT_0trace(CFG_debugMask, GT_6CLASS,
 			  "CFG_GetExecFile Failed \n");
-	}
 #endif
 	DBC_Ensure(((status == DSP_SOK) &&
 		(strlen(pstrExecFile) <= ulBufSize)) || (status != DSP_SOK));
@@ -235,13 +215,9 @@ DSP_STATUS CFG_GetHostResources(struct CFG_DEVNODE *hDevNode,
 		}
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_SUCCEEDED(status)) {
-		GT_0trace(CFG_debugMask, GT_1CLASS,
-			  "CFG_GetHostResources SUCCESS \n");
-	} else {
+	if (DSP_FAILED(status))
 		GT_0trace(CFG_debugMask, GT_6CLASS,
 			  "CFG_GetHostResources Failed \n");
-	}
 #endif
 	return status;
 }
@@ -272,11 +248,7 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 	default:
 		break;
 	}
-	if (DSP_SUCCEEDED(status)) {
-		GT_1trace(CFG_debugMask, GT_1CLASS,
-			  "CFG_GetObject SUCCESS DrvObject: "
-			  "0x%x\n ", *pdwValue);
-	} else {
+	if (DSP_FAILED(status)) {
 		*pdwValue = 0;
 		GT_0trace(CFG_debugMask, GT_6CLASS, "CFG_GetObject Failed \n");
 	}
@@ -294,7 +266,6 @@ bool CFG_Init(void)
 {
 	struct CFG_DSPRES dspResources;
 	GT_create(&CFG_debugMask, "CF");	/* CF for ConFig */
-	GT_0trace(CFG_debugMask, GT_5CLASS, "Intializing DSP Registry Info \n");
 
 	dspResources.uChipType = DSPTYPE_64;
 	dspResources.cChips = 1;
@@ -303,12 +274,8 @@ bool CFG_Init(void)
 	dspResources.aMemDesc[0].uMemType = 0;
 	dspResources.aMemDesc[0].ulMin = 0;
 	dspResources.aMemDesc[0].ulMax = 0;
-	if (DSP_SUCCEEDED(REG_SetValue(DSPRESOURCES, (u8 *)&dspResources,
-				       sizeof(struct CFG_DSPRES)))) {
-		GT_0trace(CFG_debugMask, GT_5CLASS,
-			  "Initialized DSP resources in "
-			  "Registry \n");
-	} else
+	if (DSP_FAILED(REG_SetValue(DSPRESOURCES, (u8 *)&dspResources,
+				       sizeof(struct CFG_DSPRES))))
 		GT_0trace(CFG_debugMask, GT_5CLASS,
 			  "Failed to Initialize DSP resources"
 			  " in Registry \n");
@@ -333,8 +300,6 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 		/* Store the WCD device object in the Registry */
 
 		if (!(strcmp((char *)hDevNode, "TIOMAP1510"))) {
-			GT_0trace(CFG_debugMask, GT_1CLASS,
-				  "Registering the DSP Device \n");
 			status = REG_SetValue("DEVICE_DSP", (u8 *)&dwValue,
 						dwBuffSize);
 		} else {
@@ -343,13 +308,9 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 		}
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_SUCCEEDED(status)) {
-		GT_0trace(CFG_debugMask, GT_1CLASS,
-			  "CFG_SetDevObject SUCCESS \n");
-	} else {
+	if (DSP_FAILED(status))
 		GT_0trace(CFG_debugMask, GT_6CLASS,
 			  "CFG_SetDevObject Failed \n");
-	}
 #endif
 	return status;
 }
@@ -376,11 +337,8 @@ DSP_STATUS CFG_SetObject(u32 dwValue, u32 dwType)
 		break;
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_SUCCEEDED(status))
-		GT_0trace(CFG_debugMask, GT_1CLASS, "CFG_SetObject SUCCESS \n");
-	else
+	if (DSP_FAILED(status))
 		GT_0trace(CFG_debugMask, GT_6CLASS, "CFG_SetObject Failed \n");
-
 #endif
 	return status;
 }
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 041e789..1e8fe45 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -144,12 +144,6 @@ bool CLK_Init(void)
 				  SERVICES_Clks[i].clk_name,
 				  SERVICES_Clks[i].id);
 			/* should we fail here?? */
-		} else {
-			GT_2trace(CLK_debugMask, GT_7CLASS,
-				  "CLK_Init: PASS and Clk handle %s, "
-				  "CLK dev id = %d\n",
-				  SERVICES_Clks[i].clk_name,
-				  SERVICES_Clks[i].id);
 		}
 		SERVICES_Clks[i].clk_handle = clk_handle;
 		i++;
@@ -247,10 +241,6 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId clk_id)
 				SERVICES_Clks[clk_id].clk_name,
 				SERVICES_Clks[clk_id].id);
 	} else if (clkUseCnt == 0) {
-		GT_2trace(CLK_debugMask, GT_4CLASS, "CLK_Disable: CLK %s,"
-				"CLK dev id= %d is already disabled\n",
-				SERVICES_Clks[clk_id].clk_name,
-				SERVICES_Clks[clk_id].id);
 		return status;
 	}
 	if (clk_id == SERVICESCLK_ssi_ick)
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 852f9d3..189ebfc 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -69,18 +69,11 @@ void MEM_ExtPhysPoolInit(u32 poolPhysBase, u32 poolSize)
 		extMemPool.virtMemBase = poolVirtBase;
 		extMemPool.nextPhysAllocPtr = poolPhysBase;
 		extPhysMemPoolEnabled = true;
-		GT_3trace(MEM_debugMask, GT_1CLASS,
-			  "ExtMemory Pool details " "Pool"
-			  "Physical mem base = %0x " "Pool Physical mem size "
-			  "= %0x" "Pool Virtual mem base = %0x \n",
-			  poolPhysBase, poolSize, poolVirtBase);
 	}
 }
 
 void MEM_ExtPhysPoolRelease(void)
 {
-	GT_0trace(MEM_debugMask, GT_1CLASS,
-		  "Releasing External memory pool \n");
 	if (extPhysMemPoolEnabled) {
 		iounmap((void *)(extMemPool.virtMemBase));
 		extPhysMemPoolEnabled = false;
@@ -99,15 +92,9 @@ static void *MEM_ExtPhysMemAlloc(u32 bytes, u32 align, OUT u32 *pPhysAddr)
 	u32 offset;
 	u32 virtAddr;
 
-	GT_2trace(MEM_debugMask, GT_1CLASS,
-		  "Ext Memory Allocation" "bytes=0x%x , "
-		  "align=0x%x \n", bytes, align);
-	if (align == 0) {
-		GT_0trace(MEM_debugMask, GT_7CLASS,
-			  "ExtPhysical Memory Allocation "
-			  "No alignment request in allocation call !! \n");
+	if (align == 0)
 		align = 1;
-	}
+
 	if (bytes > ((extMemPool.physMemBase + extMemPool.physMemSize)
 	    - extMemPool.nextPhysAllocPtr)) {
 		GT_1trace(MEM_debugMask, GT_7CLASS,
@@ -130,10 +117,6 @@ static void *MEM_ExtPhysMemAlloc(u32 bytes, u32 align, OUT u32 *pPhysAddr)
 			extMemPool.nextPhysAllocPtr = newAllocPtr + bytes;
 			virtAddr = extMemPool.virtMemBase + (newAllocPtr -
 				   extMemPool.physMemBase);
-			GT_2trace(MEM_debugMask, GT_1CLASS,
-				  "Ext Memory Allocation succedded "
-				  "phys address=0x%x , virtaddress=0x%x \n",
-				  newAllocPtr, virtAddr);
 			return (void *)virtAddr;
 		} else {
 			*pPhysAddr = 0;
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index 3ba97ca..9be4d8c 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -202,23 +202,13 @@ DSP_STATUS SYNC_SetEvent(struct SYNC_OBJECT *hEvent)
 
 	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
 		spin_lock_irqsave(&hEvent->sync_lock, flags);
-		GT_1trace(SYNC_debugMask, GT_6CLASS,
-			"SYNC_SetEvent: pEvent->pWaitObj "
-			"= 0x%x \n", pEvent->pWaitObj);
-	if (pEvent->pWaitObj)
-		GT_1trace(SYNC_debugMask, GT_6CLASS, "SYNC_SetEvent: "
-			"pEvent->pWaitObj->state = 0x%x \n",
-			pEvent->pWaitObj->state);
+
 		if (pEvent->pWaitObj != NULL &&
 		   test_and_set(&pEvent->pWaitObj->state,
 		   wo_signalled) == wo_waiting) {
-
 			pEvent->state = so_reset;
 			pEvent->pWaitObj->signalling_event = pEvent;
 			up(&pEvent->pWaitObj->sem);
-			GT_1trace(SYNC_debugMask, GT_6CLASS,
-				  "SYNC_SetEvent: Unlock "
-				  "Semaphore for hEvent 0x%x\n", hEvent);
 		} else {
 			pEvent->state = so_signalled;
 		}
@@ -289,12 +279,8 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
 	for (curr = 0; curr < uCount; curr++) {
 		hSyncEvents[curr]->pWaitObj = Wp;
 		if (hSyncEvents[curr]->state == so_signalled) {
-			GT_0trace(SYNC_debugMask, GT_6CLASS,
-				 "Detected signaled Event !!!\n");
 			if (test_and_set(&(Wp->state), wo_signalled) ==
 			   wo_waiting) {
-				GT_0trace(SYNC_debugMask, GT_6CLASS,
-					 "Setting Signal Event!!!\n");
 				hSyncEvents[curr]->state = so_reset;
 				Wp->signalling_event = hSyncEvents[curr];
 			}
@@ -314,8 +300,6 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
 			add_timer(&timeout);
 		}
 		if (down_interruptible(&(Wp->sem))) {
-			GT_0trace(SYNC_debugMask, GT_7CLASS, "SYNC: "
-				"WaitOnMultipleEvents Interrupted by signal\n");
 			/*
 			 * Most probably we are interrupted by a fake signal
 			 * from freezer. Return -ERESTARTSYS so that this
@@ -425,7 +409,6 @@ DSP_STATUS SYNC_EnterCS(struct SYNC_CSOBJECT *hCSObj)
 	} else if (MEM_IsValidHandle(hCSObj, SIGNATUREDPCCS)) {
 		struct SYNC_DPCCSOBJECT *pDPCCSObj =
 					(struct SYNC_DPCCSOBJECT *)hCSObj;
-		GT_0trace(SYNC_debugMask, GT_ENTER, "SYNC_EnterCS DPC\n");
 		spin_lock_bh(&pDPCCSObj->sync_dpccs_lock);
 		pDPCCSObj->count--;
 		if (pDPCCSObj->count != 0) {
@@ -527,7 +510,6 @@ DSP_STATUS SYNC_LeaveCS(struct SYNC_CSOBJECT *hCSObj)
 			spin_lock_bh(&pDPCCSObj->sync_dpccs_lock);
 		}
 		spin_unlock_bh(&pDPCCSObj->sync_dpccs_lock);
-		GT_0trace(SYNC_debugMask, GT_ENTER, "SYNC_LeaveCS DPC\n");
 	} else {
 		status = DSP_EHANDLE;
 		GT_1trace(SYNC_debugMask, GT_6CLASS,
-- 
1.6.2.4


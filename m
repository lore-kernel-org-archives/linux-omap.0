From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 03/12] DSPBRIDGE: Change custom GT_trace for dev_dbg in wmd
Date: Thu, 18 Feb 2010 15:37:54 -0600
Message-ID: <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43581 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab0BRVZ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 16:25:28 -0500
In-Reply-To: <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove GT_Trace custom debugging mechanism and use dev_dbg.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/chnl_sm.c        |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c          |  106 +++++++++++--------------
 drivers/dsp/bridge/wmd/mmu_fault.c      |    9 +-
 drivers/dsp/bridge/wmd/tiomap3430.c     |  133 ++++++++++++++-----------------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   47 +++++-------
 drivers/dsp/bridge/wmd/tiomap_sm.c      |    4 +-
 drivers/dsp/bridge/wmd/ue_deh.c         |    5 +-
 7 files changed, 136 insertions(+), 172 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 5020e37..e681303 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -446,8 +446,8 @@ DSP_STATUS WMD_CHNL_Destroy(struct CHNL_MGR *hChnlMgr)
 		for (iChnl = 0; iChnl < pChnlMgr->cChannels; iChnl++) {
 			status = WMD_CHNL_Close(pChnlMgr->apChannel[iChnl]);
 			if (DSP_FAILED(status))
-				DBG_Trace(DBG_LEVEL7, "Error in CHNL_Close "
-						"status 0x%x\n", status);
+				dev_dbg(bridge, "%s: Error status 0x%x\n",
+							__func__, status);
 		}
 		/* release critical section */
 		if (pChnlMgr->hCSObj)
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index e9de3fc..00262db 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -221,8 +221,8 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		bridge_workqueue = create_workqueue("bridge_work-queue");
 
 	if (bridge_workqueue <= 0)
-		DBG_Trace(DBG_LEVEL1, "Workque Create failed 0x%d \n",
-						bridge_workqueue);
+		dev_dbg(bridge, "%s: Workque Create failed %p\n", __func__,
+							bridge_workqueue);
 
 	/* Allocate IO manager object */
 	MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
@@ -411,9 +411,8 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	/* Get total length in bytes */
 	ulShmLength = (ulShmLimit - ulShmBase + 1) * hIOMgr->uWordSize;
 	/* Calculate size of a PROCCOPY shared memory region */
-	DBG_Trace(DBG_LEVEL7,
-		 "**(proc)PROCCOPY SHMMEM SIZE: 0x%x bytes\n",
-		  (ulShmLength - sizeof(struct SHM)));
+	dev_dbg(bridge, "%s: (proc)proccopy shmmem size: 0x%x bytes\n",
+				__func__, (ulShmLength - sizeof(struct SHM)));
 
 	if (DSP_SUCCEEDED(status)) {
 		/* Get start and length of message part of shared memory */
@@ -489,11 +488,11 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 			if (ulPadSize == ulPageAlignSize)
 				ulPadSize = 0x0;
 
-		 DBG_Trace(DBG_LEVEL7, "ulGppPa %x, ulGppVa %x, ulDspVa %x, "
-			  "ulShm0End %x, ulDynExtBase %x, ulExtEnd %x, "
-			  "ulSegSize %x ulSeg1Size %x \n", ulGppPa, ulGppVa,
-			  ulDspVa, ulShm0End, ulDynExtBase, ulExtEnd, ulSegSize,
-			  ulSeg1Size);
+		 dev_dbg(bridge, "%s: ulGppPa %x, ulGppVa %x, ulDspVa %x, "
+				"ulShm0End %x, ulDynExtBase %x, ulExtEnd %x, "
+				"ulSegSize %x ulSeg1Size %x \n", __func__,
+				ulGppPa, ulGppVa, ulDspVa, ulShm0End,
+				ulDynExtBase, ulExtEnd, ulSegSize, ulSeg1Size);
 
 		if ((ulSegSize + ulSeg1Size + ulPadSize) >
 		   hostRes.dwMemLength[1]) {
@@ -529,7 +528,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 		 * aligned.
 		 */
 		allBits = paCurr | vaCurr;
-		DBG_Trace(DBG_LEVEL1, "allBits %x, paCurr %x, vaCurr %x, "
+		dev_dbg(bridge, "allBits %x, paCurr %x, vaCurr %x, "
 			 "numBytes %x\n", allBits, paCurr, vaCurr, numBytes);
 		for (i = 0; i < 4; i++) {
 			if ((numBytes >= pgSize[i]) && ((allBits &
@@ -565,7 +564,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 		 * aligned.
 		 */
 		allBits = paCurr | vaCurr;
-		DBG_Trace(DBG_LEVEL1, "allBits for Seg1 %x, paCurr %x, "
+		dev_dbg(bridge, "allBits for Seg1 %x, paCurr %x, "
 			 "vaCurr %x, numBytes %x\n", allBits, paCurr, vaCurr,
 			 numBytes);
 		for (i = 0; i < 4; i++) {
@@ -589,8 +588,8 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 				aEProc[ndx].endianism = HW_LITTLE_ENDIAN;
 				aEProc[ndx].elemSize = HW_ELEM_SIZE_16BIT;
 				aEProc[ndx].mixedMode = HW_MMU_CPUES;
-				DBG_Trace(DBG_LEVEL1, "SHM MMU TLB entry PA %lx"
-					 " VA %lx DSP_VA %lx Size %lx\n",
+				dev_dbg(bridge, "SHM MMU TLB entry PA %x"
+					 " VA %x DSP_VA %x Size %x\n",
 					 aEProc[ndx].ulGppPa,
 					 aEProc[ndx].ulGppVa,
 					 aEProc[ndx].ulDspVa *
@@ -600,8 +599,8 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 				status = hIOMgr->pIntfFxns->pfnBrdMemMap(
 				hIOMgr->hWmdContext, paCurr, vaCurr, pgSize[i],
 					mapAttrs);
-				DBG_Trace(DBG_LEVEL1, "SHM MMU PTE entry PA %lx"
-					 " VA %lx DSP_VA %lx Size %lx\n",
+				dev_dbg(bridge, "SHM MMU PTE entry PA %x"
+					 " VA %x DSP_VA %x Size %x\n",
 					 aEProc[ndx].ulGppPa,
 					 aEProc[ndx].ulGppVa,
 					 aEProc[ndx].ulDspVa *
@@ -637,7 +636,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 				0x100000 / hIOMgr->uWordSize && hIOMgr->
 				extProcInfo.tyTlb[i].ulDspVirt
 				<= ulDspVa + ulSegSize / hIOMgr->uWordSize)) {
-			DBG_Trace(DBG_LEVEL7, "CDB MMU entry %d conflicts with "
+			dev_dbg(bridge, "CDB MMU entry %d conflicts with "
 				 "SHM.\n\tCDB: GppPa %x, DspVa %x.\n\tSHM: "
 				 "GppPa %x, DspVa %x, Bytes %x.\n", i,
 				 hIOMgr->extProcInfo.tyTlb[i].ulGppPhys,
@@ -653,7 +652,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 				aEProc[ndx].ulGppVa = 0;
 				/* Can't convert, so set to zero */
 				aEProc[ndx].ulSize = 0x100000; 	/* 1 MB */
-				DBG_Trace(DBG_LEVEL1, "SHM MMU entry PA %x "
+				dev_dbg(bridge, "SHM MMU entry PA %x "
 					 "DSP_VA 0x%x\n", aEProc[ndx].ulGppPa,
 					aEProc[ndx].ulDspVa);
 				ndx++;
@@ -755,15 +754,15 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	hIOMgr->pMsgOutput = (u8 *)hIOMgr->pMsgOutputCtrl + sizeof(struct MSG);
 	hMsgMgr->uMaxMsgs = ((u8 *)hIOMgr->pMsgOutputCtrl - hIOMgr->pMsgInput)
 						/ sizeof(struct MSG_DSPMSG);
-	DBG_Trace(DBG_LEVEL7, "IO MGR SHM details : pSharedMem 0x%x, "
-		"pInput 0x%x, pOutput 0x%x, pMsgInputCtrl 0x%x, "
-		"pMsgInput 0x%x, pMsgOutputCtrl 0x%x, pMsgOutput "
-		"0x%x \n", (u8 *)hIOMgr->pSharedMem, (u8 *)hIOMgr->pInput,
-		(u8 *)hIOMgr->pOutput, (u8 *)hIOMgr->pMsgInputCtrl,
-		(u8 *)hIOMgr->pMsgInput, (u8 *)hIOMgr->pMsgOutputCtrl,
-		(u8 *)hIOMgr->pMsgOutput);
-	DBG_Trace(DBG_LEVEL7, "** (proc) MAX MSGS IN SHARED MEMORY: "
-					"0x%x\n", hMsgMgr->uMaxMsgs);
+	dev_dbg(bridge, "IO MGR SHM details: pSharedMem %p, pInput %p, "
+			"pOutput %p, pMsgInputCtrl %p, pMsgInput %p, "
+			"pMsgOutputCtrl %p, pMsgOutput %p\n",
+			(u8 *)hIOMgr->pSharedMem, hIOMgr->pInput,
+			hIOMgr->pOutput, (u8 *)hIOMgr->pMsgInputCtrl,
+			hIOMgr->pMsgInput, (u8 *)hIOMgr->pMsgOutputCtrl,
+			hIOMgr->pMsgOutput);
+	dev_dbg(bridge, "(proc) Mas msgs in shared memory: 0x%x\n",
+							hMsgMgr->uMaxMsgs);
 	memset((void *) hIOMgr->pSharedMem, 0, sizeof(struct SHM));
 
 #ifndef DSP_TRACEBUF_DISABLED
@@ -901,8 +900,7 @@ static void IO_DispatchPM(struct work_struct *work)
 
 		/* Send the command to the WMD clk/pwr manager to handle */
 		if (pArg[0] ==  MBX_PM_HIBERNATE_EN) {
-			DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Hibernate "
-				 "command\n");
+			dev_dbg(bridge, "PM: Hibernate command\n");
 			status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
 				 hWmdContext, WMDIOCTL_PWR_HIBERNATE, pArg);
 			if (DSP_FAILED(status))
@@ -910,27 +908,23 @@ static void IO_DispatchPM(struct work_struct *work)
 							__func__, status);
 		} else if (pArg[0] == MBX_PM_OPP_REQ) {
 			pArg[1] = pIOMgr->pSharedMem->oppRequest.rqstOppPt;
-			DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Value of OPP "
-				 "value =0x%x \n", pArg[1]);
+			dev_dbg(bridge, "PM: Requested OPP = 0x%x\n", pArg[1]);
 			status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
 				 hWmdContext, WMDIOCTL_CONSTRAINT_REQUEST,
 				 pArg);
 			if (DSP_FAILED(status)) {
-				DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
-					 "to set constraint = 0x%x \n",
-					 pArg[1]);
+				dev_dbg(bridge, "PM: Failed to set constraint "
+							"= 0x%x \n", pArg[1]);
 			}
 
 		} else {
-			DBG_Trace(DBG_LEVEL7, "IO_DispatchPM - clock control - "
-				 "value of msg = 0x%x: \n", pArg[0]);
+			dev_dbg(bridge, "PM: clk control value of msg = 0x%x\n",
+								pArg[0]);
 			status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
 				 hWmdContext, WMDIOCTL_CLK_CTRL, pArg);
-			if (DSP_FAILED(status)) {
-				DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
-					 "to control the DSP clk = 0x%x \n",
-					 *pArg);
-			}
+			if (DSP_FAILED(status))
+				dev_dbg(bridge, "PM: Failed to ctrl the DSP clk"
+							"= 0x%x\n", *pArg);
 		}
 		/* Increment the tail count here */
 		pIOMgr->iQuePowerTail++;
@@ -1309,7 +1303,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 
 		/* Determine which queue to put the message in */
 		hMsgQueue = (struct MSG_QUEUE *)LST_First(hMsgMgr->queueList);
-		DBG_Trace(DBG_LEVEL7, "InputMsg RECVD: dwCmd=0x%x dwArg1=0x%x "
+		dev_dbg(bridge, "input msg: dwCmd=0x%x dwArg1=0x%x "
 			 "dwArg2=0x%x dwId=0x%x \n", msg.msg.dwCmd,
 			 msg.msg.dwArg1, msg.msg.dwArg2, msg.dwId);
 		/*
@@ -1759,34 +1753,28 @@ DSP_STATUS IO_SHMsetting(struct IO_MGR *hIOMgr, u8 desc, void *pArgs)
 		for (i = 0; i <= dsp_max_opps; i++) {
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].voltage =
 				vdd1_dsp_freq[i][0];
-			DBG_Trace(DBG_LEVEL5, "OPP shared memory -voltage: "
-				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
-				 oppPoint[i].voltage);
+			dev_dbg(bridge, "OPP-SHM: voltage: %d\n",
+							vdd1_dsp_freq[i][0]);
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].
 				frequency = vdd1_dsp_freq[i][1];
-			DBG_Trace(DBG_LEVEL5, "OPP shared memory -frequency: "
-				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
-				 oppPoint[i].frequency);
+			dev_dbg(bridge, "OPP-SHM: frequency: %d\n",
+							vdd1_dsp_freq[i][1]);
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].minFreq =
 				vdd1_dsp_freq[i][2];
-			DBG_Trace(DBG_LEVEL5, "OPP shared memory -min value: "
-				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
-				  oppPoint[i].minFreq);
+			dev_dbg(bridge, "OPP-SHM: min freq: %d\n",
+							vdd1_dsp_freq[i][2]);
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].maxFreq =
 				vdd1_dsp_freq[i][3];
-			DBG_Trace(DBG_LEVEL5, "OPP shared memory -max value: "
-				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
-				 oppPoint[i].maxFreq);
+			dev_dbg(bridge, "OPP-SHM: max freq: %d\n",
+							vdd1_dsp_freq[i][3]);
 		}
 		hIOMgr->pSharedMem->oppTableStruct.numOppPts = dsp_max_opps;
-		DBG_Trace(DBG_LEVEL5, "OPP shared memory - max OPP number: "
-			 "%d\n", hIOMgr->pSharedMem->oppTableStruct.numOppPts);
+		dev_dbg(bridge, "OPP-SHM: max OPP number: %d\n", dsp_max_opps);
 		/* Update the current OPP number */
 		if (pdata->dsp_get_opp)
 			i = (*pdata->dsp_get_opp)();
 		hIOMgr->pSharedMem->oppTableStruct.currOppPt = i;
-		DBG_Trace(DBG_LEVEL7, "OPP value programmed to shared memory: "
-			 "%d\n", i);
+		dev_dbg(bridge, "OPP-SHM: value programmed = %d\n", i);
 		break;
 	case SHM_GETOPP:
 		/* Get the OPP that DSP has requested */
@@ -1811,7 +1799,7 @@ DSP_STATUS WMD_IO_GetProcLoad(IN struct IO_MGR *hIOMgr,
 	pProcStat->uCurrDspFreq = hIOMgr->pSharedMem->loadMonInfo.currDspFreq;
 	pProcStat->uPredictedFreq = hIOMgr->pSharedMem->loadMonInfo.predDspFreq;
 
-	DBG_Trace(DBG_LEVEL4, "Curr Load =%d, Pred Load = %d, Curr Freq = %d, "
+	dev_dbg(bridge, "Curr Load = %d, Pred Load = %d, Curr Freq = %d, "
 			     "Pred Freq = %d\n", pProcStat->uCurrLoad,
 			     pProcStat->uPredictedLoad, pProcStat->uCurrDspFreq,
 			     pProcStat->uPredictedFreq);
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 14cfd62..1a9137d 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -83,9 +83,8 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 			 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
 			 &resources);
 		if (DSP_FAILED(status))
-			DBG_Trace(DBG_LEVEL7,
-				 "**Failed to get Host Resources "
-				 "in MMU ISR **\n");
+			dev_dbg(bridge, "%s: Failed to get Host Resources\n",
+								__func__);
 		if (MMU_CheckIfFault(pDevContext)) {
 			printk(KERN_INFO "***** DSPMMU FAULT ***** IRQStatus "
 				"0x%x\n", dmmuEventMask);
@@ -132,8 +131,8 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext)
 	status = CFG_GetHostResources(
 		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 	if (DSP_FAILED(status))
-		DBG_Trace(DBG_LEVEL7, "**Failed to get Host Resources in "
-			 "MMU_CheckIfFault **\n");
+		dev_dbg(bridge, "%s: Failed to get Host Resources in\n",
+								__func__);
 
 	hwStatus = HW_MMU_EventStatus(resources.dwDmmuBase, &dmmuEventMask);
 	if (dmmuEventMask  ==  HW_MMU_TRANSLATION_FAULT) {
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 4563ca4..c91f919 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -134,25 +134,25 @@ static void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
 {
 	u32 temp;
 	temp = __raw_readl((cm_base) + 0x00);
-	DBG_Trace(DBG_LEVEL6, "CM_FCLKEN_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "CM_FCLKEN_IVA2 = 0x%x\n", temp);
 	temp = __raw_readl((cm_base) + 0x10);
-	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((cm_base) + 0x20);
-	DBG_Trace(DBG_LEVEL6, "CM_IDLEST_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "CM_IDLEST_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((cm_base) + 0x48);
-	DBG_Trace(DBG_LEVEL6, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((cm_base) + 0x4c);
-	DBG_Trace(DBG_LEVEL6, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((prm_base) + 0x50);
-	DBG_Trace(DBG_LEVEL6, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((prm_base) + 0x58);
-	DBG_Trace(DBG_LEVEL6, "RM_RSTST_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "RM_RSTST_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((prm_base) + 0xE0);
-	DBG_Trace(DBG_LEVEL6, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((prm_base) + 0xE4);
-	DBG_Trace(DBG_LEVEL6, "PM_PWSTST_IVA2 = 0x%x \n", temp);
+	dev_dbg(bridge, "PM_PWSTST_IVA2 = 0x%x \n", temp);
 	temp = __raw_readl((cm_base) + 0xA10);
-	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_CORE = 0x%x \n", temp);
+	dev_dbg(bridge, "CM_ICLKEN1_CORE = 0x%x \n", temp);
 }
 #else
 static inline void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
@@ -300,7 +300,7 @@ void WMD_DRV_Entry(OUT struct WMD_DRV_INTERFACE **ppDrvInterface,
 	if (strcmp(pstrWMDFileName, "UMA") == 0)
 		*ppDrvInterface = &drvInterfaceFxns;
 	else
-		DBG_Trace(DBG_LEVEL7, "WMD_DRV_Entry Unknown WMD file name");
+		dev_dbg(bridge, "%s Unknown WMD file name", __func__);
 
 }
 
@@ -473,16 +473,14 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
 			if (dsp_debug) {
 				/* Set the bootmode to self loop  */
-				DBG_Trace(DBG_LEVEL7,
-						"Set boot mode to self loop"
+				dev_dbg(bridge, "Set boot mode to self loop"
 						" for IVA2 Device\n");
 				HW_DSPSS_BootModeSet(resources.dwSysCtrlBase,
 					HW_DSPSYSC_SELFLOOPBOOT, dwDSPAddr);
 			} else {
 				/* Set the bootmode to '0' - direct boot */
-				DBG_Trace(DBG_LEVEL7,
-						"Set boot mode to direct"
-						" boot for IVA2 Device \n");
+				dev_dbg(bridge, "Set boot mode to direct boot"
+						" for IVA2 Device\n");
 				HW_DSPSS_BootModeSet(resources.dwSysCtrlBase,
 					HW_DSPSYSC_DIRECTBOOT, dwDSPAddr);
 			}
@@ -507,7 +505,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			iEntryNdx++) {
 			if ((pDevContext->aTLBEntry[iEntryNdx].ulGppPa != 0) &&
 			   (pDevContext->aTLBEntry[iEntryNdx].ulDspVa != 0)) {
-				DBG_Trace(DBG_LEVEL4, "** (proc) MMU %d GppPa:"
+				dev_dbg(bridge, "(proc) MMU %d GppPa:"
 				    " 0x%x DspVa 0x%x Size 0x%x\n",
 				    itmpEntryNdx,
 				    pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
@@ -582,8 +580,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 		} else {
-			DBG_Trace(DBG_LEVEL7,
-				  "Not able to get the symbol for Load "
+			dev_dbg(bridge, "Not able to get the symbol for Load "
 				  "Monitor Timer\n");
 		}
 	}
@@ -618,8 +615,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 		} else {
-		DBG_Trace(DBG_LEVEL7,
-			       "Not able to get the symbol for BIOS Timer\n");
+		dev_dbg(bridge, "Not able to get the symbol for BIOS Timer\n");
 		}
 	}
 
@@ -637,9 +633,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			/* Get the clock rate */
 			status = CLK_GetRate(SERVICESCLK_iva2_ck,
 				 &ulDspClkRate);
-			DBG_Trace(DBG_LEVEL5,
-				 "WMD_BRD_Start: DSP clock rate (KHZ): 0x%x \n",
-				 ulDspClkRate);
+			dev_dbg(bridge, "%s: DSP clock rate (KHZ): 0x%x \n",
+							__func__, ulDspClkRate);
 			(void)WMD_BRD_Write(pDevContext, (u8 *)&ulDspClkRate,
 				 ulDspClkAddr, sizeof(u32), 0);
 		}
@@ -675,17 +670,15 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		(void)CHNLSM_EnableInterrupt(pDevContext);
 
 		/* Let DSP go */
-		DBG_Trace(DBG_LEVEL7, "Unreset, WMD_BRD_Start\n");
+		dev_dbg(bridge, "%s Unreset\n", __func__);
 		/* Enable DSP MMU Interrupts */
 		HW_MMU_EventEnable(resources.dwDmmuBase,
 				HW_MMU_ALL_INTERRUPTS);
 		/* release the RST1, DSP starts executing now .. */
 		HW_RST_UnReset(resources.dwPrmBase, HW_RST1_IVA2);
 
-		DBG_Trace(DBG_LEVEL7, "Driver waiting for Sync @ 0x%x \n",
-				dwSyncAddr);
-		DBG_Trace(DBG_LEVEL7, "DSP c_int00 Address =  0x%x \n",
-				dwDSPAddr);
+		dev_dbg(bridge, "Waiting for Sync @ 0x%x\n", dwSyncAddr);
+		dev_dbg(bridge, "DSP c_int00 Address =  0x%x\n", dwDSPAddr);
 		if (dsp_debug)
 			while (*((volatile u16 *)dwSyncAddr))
 				;
@@ -997,12 +990,12 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 
 		pPtAttrs->pgInfo = MEM_Calloc(pPtAttrs->L2NumPages *
 				sizeof(struct PageInfo), MEM_NONPAGED);
-		DBG_Trace(DBG_LEVEL1, "L1 pa %x, va %x, size %x\n L2 pa %x, va "
+		dev_dbg(bridge, "L1 pa %x, va %x, size %x\n L2 pa %x, va "
 			 "%x, size %x\n", pPtAttrs->L1BasePa,
 			 pPtAttrs->L1BaseVa, pPtAttrs->L1size,
 			 pPtAttrs->L2BasePa, pPtAttrs->L2BaseVa,
 			 pPtAttrs->L2size);
-		DBG_Trace(DBG_LEVEL1, "pPtAttrs %x L2 NumPages %x pgInfo %x\n",
+		dev_dbg(bridge, "pPtAttrs %p L2 NumPages %x pgInfo %p\n",
 			 pPtAttrs, pPtAttrs->L2NumPages, pPtAttrs->pgInfo);
 	}
 	if ((pPtAttrs != NULL) && (pPtAttrs->L1BaseVa != 0) &&
@@ -1249,9 +1242,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 pgI = 0;
 	u32 mpuAddr, pa;
 
-	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x, "
-		 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr, ulVirtAddr,
-		 ulNumBytes, ulMapAttr);
+	dev_dbg(bridge, "%s hDevCtxt %p, pa %x, va %x, size %x, ulMapAttr %x\n",
+				__func__, hDevContext, ulMpuAddr, ulVirtAddr,
+				ulNumBytes, ulMapAttr);
 	if (ulNumBytes == 0)
 		return DSP_EINVALIDARG;
 
@@ -1319,10 +1312,10 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, ulMpuAddr);
 	if (vma)
-		DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf: ulMpuAddr=%x, "
-			"ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x \n",
-			ulMpuAddr, ulNumBytes, vma->vm_start,
-			vma->vm_end, vma->vm_flags);
+		dev_dbg(bridge, "VMAfor UserBuf: ulMpuAddr=%x, ulNumBytes=%x, "
+				"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n",
+				ulMpuAddr, ulNumBytes, vma->vm_start,
+				vma->vm_end, vma->vm_flags);
 
 	/*
 	 * It is observed that under some circumstances, the user buffer is
@@ -1332,10 +1325,10 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	while ((vma) && (ulMpuAddr + ulNumBytes > vma->vm_end)) {
 		/* jump to the next VMA region */
 		vma = find_vma(mm, vma->vm_end + 1);
-		DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf ulMpuAddr=%x, "
-		       "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x\n",
-		       ulMpuAddr, ulNumBytes, vma->vm_start,
-		       vma->vm_end, vma->vm_flags);
+		dev_dbg(bridge, "VMA for UserBuf ulMpuAddr=%x ulNumBytes=%x, "
+				"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n",
+				ulMpuAddr, ulNumBytes, vma->vm_start,
+				vma->vm_end, vma->vm_flags);
 	}
 	if (!vma) {
 		pr_err("%s: Failed to get VMA region for 0x%x (%d)\n",
@@ -1436,7 +1429,7 @@ func_cont:
 	 * region
 	 */
 	flush_all(pDevContext);
-	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
+	dev_dbg(bridge, "%s status %x\n", __func__, status);
 	return status;
 }
 
@@ -1471,16 +1464,15 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 pAddr;
 	u32 numof4KPages = 0;
 
-	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemUnMap hDevContext %x, va %x, "
-		  "NumBytes %x\n", hDevContext, ulVirtAddr, ulNumBytes);
 	vaCurr = ulVirtAddr;
 	remBytes = ulNumBytes;
 	remBytesL2 = 0;
 	L1BaseVa = pt->L1BaseVa;
 	pteAddrL1 = HW_MMU_PteAddrL1(L1BaseVa, vaCurr);
-	DBG_Trace(DBG_ENTER, "WMD_BRD_MemUnMap L1BaseVa %x, pteAddrL1 %x "
-		  "vaCurr %x remBytes %x\n", L1BaseVa, pteAddrL1,
-		  vaCurr, remBytes);
+	dev_dbg(bridge, "%s hDevContext %p, va %x, NumBytes %x L1BaseVa %x, "
+			"pteAddrL1 %x\n", __func__, hDevContext, ulVirtAddr,
+			ulNumBytes, L1BaseVa, pteAddrL1);
+
 	while (remBytes && (DSP_SUCCEEDED(status))) {
 		u32 vaCurrOrig = vaCurr;
 		/* Find whether the L1 PTE points to a valid L2 PT */
@@ -1632,10 +1624,9 @@ skip_coarse_page:
 	 */
 EXIT_LOOP:
 	flush_all(pDevContext);
-	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
-		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
-	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemUnMap status %x remBytes %x, "
-		  "remBytesL2 %x\n", status, remBytes, remBytesL2);
+	dev_dbg(bridge, "%s: vaCurr %x, pteAddrL1 %x pteAddrL2 %x remBytes %x,"
+		" remBytesL2 %x status %x\n", __func__, vaCurr, pteAddrL1,
+		pteAddrL2, remBytes, remBytesL2, status);
 	return status;
 }
 
@@ -1783,19 +1774,19 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 				pt->pgInfo[L2PageNum].numEntries += 16;
 			else
 				pt->pgInfo[L2PageNum].numEntries++;
-			DBG_Trace(DBG_LEVEL1, "L2 BaseVa %x, BasePa %x, "
-				 "PageNum %x numEntries %x\n", L2BaseVa,
-				 L2BasePa, L2PageNum,
-				 pt->pgInfo[L2PageNum].numEntries);
+			dev_dbg(bridge, "PTE: L2 BaseVa %x, BasePa %x, PageNum "
+					"%x, numEntries %x\n", L2BaseVa,
+					L2BasePa, L2PageNum,
+					pt->pgInfo[L2PageNum].numEntries);
 		}
 		SYNC_LeaveCS(pt->hCSObj);
 	}
 	if (DSP_SUCCEEDED(status)) {
-		DBG_Trace(DBG_LEVEL1, "PTE pgTblVa %x, pa %x, va %x, size %x\n",
-			 pgTblVa, pa, va, size);
-		DBG_Trace(DBG_LEVEL1, "PTE endianism %x, elementSize %x, "
-			  "mixedSize %x\n", attrs->endianism,
-			  attrs->elementSize, attrs->mixedSize);
+		dev_dbg(bridge, "PTE: pgTblVa %x, pa %x, va %x, size %x\n",
+							pgTblVa, pa, va, size);
+		dev_dbg(bridge, "PTE: endianism %x, elementSize %x, "
+					"mixedSize %x\n", attrs->endianism,
+					attrs->elementSize, attrs->mixedSize);
 		status = HW_MMU_PteSet(pgTblVa, pa, va, size, attrs);
 	}
 
@@ -1866,14 +1857,11 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 		vaCurr += sizeCurr;
 	}
 	/* Don't propogate Linux or HW status to upper layers */
-	if (DSP_SUCCEEDED(status)) {
+	if (DSP_SUCCEEDED(status))
 		status = DSP_SOK;
-		DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap succeeded %x\n",
-			 status);
-	} else {
-		DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap status %x\n", status);
+	else
 		status = DSP_EFAIL;
-	}
+
 	/*
 	 * In any case, flush the TLB
 	 * This is called from here instead from PteUpdate to avoid unnecessary
@@ -1881,6 +1869,7 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 	 * region
 	 */
 	flush_all(pDevContext);
+	dev_dbg(bridge, "%s status %x\n", __func__, status);
 	return status;
 }
 
@@ -1897,12 +1886,10 @@ void configureDspMmu(struct WMD_DEV_CONTEXT *pDevContext, u32 dataBasePhys,
 	struct HW_MMUMapAttrs_t mapAttrs = { endianism, elemSize, mixedSize };
 
 	DBC_Require(sizeInBytes > 0);
-	DBG_Trace(DBG_LEVEL1,
-		 "configureDspMmu entry %x pa %x, va %x, bytes %x ",
-		 nEntryStart, dataBasePhys, dspBaseVirt, sizeInBytes);
-
-	DBG_Trace(DBG_LEVEL1, "endianism %x, elemSize %x, mixedSize %x\n",
-		 endianism, elemSize, mixedSize);
+	dev_dbg(bridge, "%s: entry %x pa %x, va %x, bytes %x endianism %x, "
+			"elemSize %x, mixedSize %x", __func__, nEntryStart,
+			dataBasePhys, dspBaseVirt, sizeInBytes, endianism,
+			elemSize, mixedSize);
 
 	HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase, dataBasePhys,
 				dspBaseVirt, sizeInBytes, nEntryStart,
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 9469c5e..bdff0a7 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -72,8 +72,8 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 
 	pConstraintVal = (u32 *)(pArgs);
 	/* Read the target value requested by DSP  */
-	DBG_Trace(DBG_LEVEL7, "handle_constraints_set:"
-		"opp requested = 0x%x\n", (u32)*(pConstraintVal+1));
+	dev_dbg(bridge, "OPP: %s opp requested = 0x%x\n", __func__,
+						(u32)*(pConstraintVal+1));
 
 	/* Set the new opp value */
 	if (pdata->dsp_set_min_opp)
@@ -182,9 +182,8 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
 			CHNLSM_InterruptDSP2(pDevContext,
 					     MBX_PM_DSPHIBERNATE);
-			DBG_Trace(DBG_LEVEL7,
-				 "SleepDSP - Sent hibernate "
-				 "command to DSP\n");
+			dev_dbg(bridge, "PM: %s - sent hibernate cmd to DSP\n",
+								__func__);
 			targetPwrState = HW_PWR_STATE_OFF;
 		} else {
 			CHNLSM_InterruptDSP2(pDevContext,
@@ -204,16 +203,14 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	case BRD_HIBERNATION:
 	case BRD_DSP_HIBERNATION:
 		/* Already in Hibernation, so just return */
-		DBG_Trace(DBG_LEVEL7, "SleepDSP- DSP already in "
-			 "hibernation\n");
+		dev_dbg(bridge, "PM: %s - DSP already in hibernation\n",
+								__func__);
 		return DSP_SOK;
 	case BRD_STOPPED:
-		DBG_Trace(DBG_LEVEL7,
-			 "SleepDSP- Board in STOP state \n");
+		dev_dbg(bridge, "PM: %s - Board in STOP state\n", __func__);
 		return DSP_SALREADYASLEEP;
 	default:
-		DBG_Trace(DBG_LEVEL7,
-			 "SleepDSP- Bridge in Illegal state\n");
+		dev_dbg(bridge, "PM: %s - Bridge in Illegal state\n", __func__);
 			return DSP_EFAIL;
 	}
 
@@ -396,8 +393,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 		}
 		break;
 	default:
-		DBG_Trace(DBG_LEVEL3,
-			 "DSPPeripheralClkCtrl : Unsupported CMD \n");
+		dev_dbg(bridge, "%s: Unsupported CMD\n", __func__);
 		/* unsupported cmd */
 		/* TODO -- provide support for AUTOIDLE Enable/Disable
 		 * commands */
@@ -419,18 +415,16 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 	voltage_domain = *((u32 *)pArgs);
 	level = *((u32 *)pArgs + 1);
 
-	DBG_Trace(DBG_LEVEL7, "PreScale_DSP: voltage_domain = %x, level = "
-		 "0x%x\n", voltage_domain, level);
+	dev_dbg(bridge, "OPP: %s voltage_domain = %x, level = 0x%x\n",
+					__func__, voltage_domain, level);
 	if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
 			(pDevContext->dwBrdState == BRD_RETENTION) ||
 			(pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
-		DBG_Trace(DBG_LEVEL7, "PreScale_DSP: IVA in sleep. "
-			 "No notification to DSP\n");
+		dev_dbg(bridge, "OPP: %s IVA in sleep. No message to DSP\n");
 		return DSP_SOK;
 	} else if ((pDevContext->dwBrdState == BRD_RUNNING)) {
 		/* Send a prenotificatio to DSP */
-		DBG_Trace(DBG_LEVEL7,
-			 "PreScale_DSP: Sent notification to DSP\n");
+		dev_dbg(bridge, "OPP: %s sent notification to DSP\n", __func__);
 		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
 		return DSP_SOK;
 	} else {
@@ -459,25 +453,22 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 
 	voltage_domain = *((u32 *)pArgs);
 	level = *((u32 *)pArgs + 1);
-	DBG_Trace(DBG_LEVEL7,
-		"PostScale_DSP: voltage_domain = %x, level = 0x%x\n",
-		voltage_domain, level);
+	dev_dbg(bridge, "OPP: %s voltage_domain = %x, level = 0x%x\n",
+					__func__, voltage_domain, level);
 	if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
 			(pDevContext->dwBrdState == BRD_RETENTION) ||
 			(pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
 		/* Update the OPP value in shared memory */
 		IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
-		DBG_Trace(DBG_LEVEL7,
-			 "PostScale_DSP: IVA in sleep. Wrote to shared "
-			 "memory \n");
+		dev_dbg(bridge, "OPP: %s IVA in sleep. Wrote to SHM\n",
+								__func__);
 	} else  if ((pDevContext->dwBrdState == BRD_RUNNING)) {
 		/* Update the OPP value in shared memory */
 		IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
 		/* Send a post notification to DSP */
 		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
-		DBG_Trace(DBG_LEVEL7,
-			"PostScale_DSP: Wrote to shared memory Sent post"
-			" notification to DSP\n");
+		dev_dbg(bridge, "OPP: %s wrote to SHM. Sent post notification "
+							"to DSP\n", __func__);
 	} else {
 		status = DSP_EFAIL;
 	}
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 50f54c2..3fa24cd 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -155,7 +155,7 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		}
 	}
 
-	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n", wMbVal);
+	dev_dbg(bridge, "MBX: writing %x to Mailbox\n", wMbVal);
 	HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP, wMbVal);
 	return DSP_SOK;
 }
@@ -177,7 +177,7 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
 		HW_MBOX_EventAck(resources.dwMboxBase, MBOX_DSP2ARM,
 				 HW_MBOX_U0_ARM, HW_MBOX_INT_NEW_MSG);
 
-		DBG_Trace(DBG_LEVEL3, "Read %x from Mailbox\n", mbxValue);
+		dev_dbg(bridge, "MBX: Read %x from Mailbox\n", mbxValue);
 		*pwIntrVal = (u16) mbxValue;
 	}
 	/* Set *pfSchedDPC to true; */
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 031a1c8..618d6e2 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -261,9 +261,8 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 			break;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 		default:
-			DBG_Trace(DBG_LEVEL6,
-				 "WMD_DEH_Notify: Unknown Error, errInfo = "
-				 "0x%x\n", dwErrInfo);
+			dev_dbg(bridge, "%s: Unknown Error, errInfo = 0x%x\n",
+							__func__, dwErrInfo);
 			break;
 		}
 
-- 
1.6.2.4


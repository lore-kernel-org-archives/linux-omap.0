From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 06/18] DSPBRIDGE: Remove debug statements for success in wmd
Date: Tue, 16 Feb 2010 02:42:16 -0600
Message-ID: <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54406 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755600Ab0BPIaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:06 -0500
In-Reply-To: <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes debug statements used to print a successful
status or printed during normal execution, as they just polute
the logs if trying to look for a failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/chnl_sm.c        |    4 --
 drivers/dsp/bridge/wmd/io_sm.c          |   46 ++-----------------
 drivers/dsp/bridge/wmd/mmu_fault.c      |    5 --
 drivers/dsp/bridge/wmd/tiomap3430.c     |   74 +++++-------------------------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   27 +----------
 drivers/dsp/bridge/wmd/tiomap_io.c      |   22 +--------
 drivers/dsp/bridge/wmd/ue_deh.c         |    7 ---
 7 files changed, 23 insertions(+), 162 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 11e3930..08bd09d 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -681,10 +681,6 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
 		status = copy_to_user(ioc.pBuf, pHostSysBuf, ioc.cBytes);
 		if (status) {
 			if (current->flags & PF_EXITING) {
-				DBG_Trace(DBG_LEVEL7,
-					 "\n2current->flags ==  PF_EXITING, "
-					 " current->flags;0x%x\n",
-					 current->flags);
 				status = 0;
 			} else {
 				DBG_Trace(DBG_LEVEL7,
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 046300b..55ec6ef 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -276,10 +276,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 			HW_MBOX_initSettings(hostRes.dwMboxBase);
 			/* Plug the channel ISR */
 			if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-			  "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-				DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
-						pIOMgr);
-			else
+			  "DspBridge\tmailbox", (void *)pIOMgr)) != 0)
 				status = CHNL_E_ISR;
 		}
 	} else {
@@ -320,7 +317,6 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 
 		/* Free IO DPC object */
 		tasklet_kill(&hIOMgr->dpc_tasklet);
-		DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
 
 #ifndef DSP_TRACEBUF_DISABLED
 		kfree(hIOMgr->pMsg);
@@ -452,12 +448,9 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	if (DSP_SUCCEEDED(status)) {
 #ifndef DSP_TRACEBUF_DISABLED
 		status = COD_GetSymValue(hCodMan, DSP_TRACESEC_END, &ulShm0End);
-		DBG_Trace(DBG_LEVEL7, "_BRIDGE_TRACE_END value = %x \n",
-			 ulShm0End);
 #else
 		status = COD_GetSymValue(hCodMan, SHM0_SHARED_END_SYM,
 					 &ulShm0End);
-		DBG_Trace(DBG_LEVEL7, "_SHM0_END = %x \n", ulShm0End);
 #endif
 		if (DSP_FAILED(status))
 			status = CHNL_E_NOMEMMAP;
@@ -713,8 +706,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	 */
 	hIOMgr->extProcInfo.tyTlb[0].ulGppPhys = (ulGppVa + ulSeg1Size +
 						 ulPadSize);
-	DBG_Trace(DBG_LEVEL1, "*********extProcInfo *********%x \n",
-		  hIOMgr->extProcInfo.tyTlb[0].ulGppPhys);
+
 	/*
 	 * Need SHM Phys addr. IO supports only one DSP for now:
 	 * uNumProcs = 1.
@@ -742,8 +734,6 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 		if (DSP_FAILED(status))
 			goto func_end;
 		ulShmBase = hIOMgr->extProcInfo.tyTlb[0].ulGppPhys;
-		DBG_Trace(DBG_LEVEL1, "extProcInfo.tyTlb[0].ulGppPhys %x \n ",
-				hIOMgr->extProcInfo.tyTlb[0].ulGppPhys);
 		ulShmBase += ulShmBaseOffset;
 		ulShmBase = (u32)MEM_LinearAddress((void *)ulShmBase,
 				    ulMemLength);
@@ -760,10 +750,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	hIOMgr->pOutput = hIOMgr->pInput + (ulShmLength -
 						sizeof(struct SHM)) / 2;
 	hIOMgr->uSMBufSize = hIOMgr->pOutput - hIOMgr->pInput;
-	DBG_Trace(DBG_LEVEL3, "hIOMgr: pInput %p pOutput %p ulShmLength %x\n",
-				 hIOMgr->pInput, hIOMgr->pOutput, ulShmLength);
-	DBG_Trace(DBG_LEVEL3, "pSharedMem %p uSMBufSize %x sizeof(SHM) %x\n",
-		 hIOMgr->pSharedMem, hIOMgr->uSMBufSize, sizeof(struct SHM));
+
 	 /*  Set up Shared memory addresses for messaging. */
 	hIOMgr->pMsgInputCtrl = (struct MSG *)((u8 *)hIOMgr->pSharedMem
 							+ ulShmLength);
@@ -822,7 +809,6 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	if (!hIOMgr->pMsg)
 		status = DSP_EMEMORY;
 
-	DBG_Trace(DBG_LEVEL1, "** hIOMgr->pMsg: 0x%x\n", hIOMgr->pMsg);
 	hIOMgr->ulDspVa = ulDspVa;
 	hIOMgr->ulGppVa = (ulGppVa + ulSeg1Size + ulPadSize);
 
@@ -917,8 +903,7 @@ static void IO_DispatchPM(struct work_struct *work)
 	while (pIOMgr->iQuePowerHead != pIOMgr->iQuePowerTail) {
 		pArg[0] = *(u32 *)&(pIOMgr->dQuePowerMbxVal[pIOMgr->
 			  iQuePowerTail]);
-		DBG_Trace(DBG_LEVEL7, "IO_DispatchPM - pArg[0] - 0x%x: \n",
-			 pArg[0]);
+
 		/* Send the command to the WMD clk/pwr manager to handle */
 		if (pArg[0] ==  MBX_PM_HIBERNATE_EN) {
 			DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Hibernate "
@@ -1035,7 +1020,6 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 
 	/* Call WMD's CHNLSM_ISR() to see if interrupt is ours, and process. */
 	if (IO_CALLISR(hIOMgr->hWmdContext, &fSchedDPC, &hIOMgr->wIntrVal)) {
-		DBG_Trace(DBG_LEVEL3, "IO_ISR %x\n", hIOMgr->wIntrVal);
 		if (hIOMgr->wIntrVal & MBX_PM_CLASS) {
 			hIOMgr->dQuePowerMbxVal[hIOMgr->iQuePowerHead] =
 				hIOMgr->wIntrVal;
@@ -1046,7 +1030,6 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 			queue_work(bridge_workqueue, &hIOMgr->io_workq);
 		}
 		if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
-			DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
 			hIOMgr->wIntrVal = 0;
 		} else if (fSchedDPC) {
 			/*
@@ -1228,9 +1211,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 				pChirp->cBytes = uBytes;
 				pChirp->dwArg = dwArg;
 				pChirp->status = CHNL_IOCSTATCOMPLETE;
-				DBG_Trace(DBG_LEVEL7, "Input Chnl:status= 0x%x "
-					 "\n", *((RMS_WORD *)(pChirp->
-					 pHostSysBuf)));
+
 				if (uBytes == 0) {
 					/*
 					 * This assertion fails if the DSP
@@ -1252,8 +1233,6 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 					 */
 					NTFY_Notify(pChnl->hNtfy,
 						   DSP_STREAMDONE);
-					DBG_Trace(DBG_LEVEL7, "Input Chnl NTFY "
-						 "chnl = 0x%x\n", pChnl);
 				}
 				/* Tell DSP if no more I/O buffers available */
 				if (!pChnl->pIORequests)
@@ -1660,8 +1639,6 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 		/* Get start and length of message part of shared memory */
 		status = COD_GetSymValue(hCodMan, SHM0_SHARED_RESERVED_BASE_SYM,
 					&ulShm0_RsrvdStart);
-		DBG_Trace(DBG_LEVEL1, "***ulShm0_RsrvdStart  0x%x \n",
-			 ulShm0_RsrvdStart);
 		if (ulShm0_RsrvdStart == 0) {
 			status = DSP_EFAIL;
 			goto func_end;
@@ -2027,9 +2004,6 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 	if (DSP_SUCCEEDED(status)) {
 		/* Look for SYS_PUTCBEG/SYS_PUTCEND */
 		status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
-		GT_1trace(dsp_trace_mask, GT_2CLASS,
-			"PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
-			ulTraceBegin);
 		if (DSP_FAILED(status))
 			GT_0trace(dsp_trace_mask, GT_2CLASS,
 				"PrintDspTraceBuffer: Failed on "
@@ -2037,9 +2011,6 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 	}
 	if (DSP_SUCCEEDED(status)) {
 		status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
-		GT_1trace(dsp_trace_mask, GT_2CLASS,
-			"PrintDspTraceBuffer: ulTraceEnd Value 0x%x\n",
-			ulTraceEnd);
 		 if (DSP_FAILED(status))
 			GT_0trace(dsp_trace_mask, GT_2CLASS,
 				"PrintDspTraceBuffer: Failed on "
@@ -2056,11 +2027,7 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 
 		/* Make sure the data we request fits evenly */
 		ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
-		GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
-			"ulNumBytes 0x%x\n", ulNumBytes);
 		ulNumWords = ulNumBytes * ulWordSize;
-		GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
-			"ulNumWords 0x%x\n", ulNumWords);
 		status = DEV_GetIntfFxns(pDevObject, &pIntfFxns);
 	}
 
@@ -2079,9 +2046,6 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 
 			if (DSP_SUCCEEDED(status)) {
 				/* Pack and do newline conversion */
-				GT_0trace(dsp_trace_mask, GT_2CLASS,
-					"PrintDspTraceBuffer: "
-					"before pack and unpack.\n");
 				PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
 				GT_1trace(dsp_trace_mask, GT_1CLASS,
 					"DSP Trace Buffer:\n%s\n", pszBuf);
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index a3c8657..14cfd62 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -108,9 +108,6 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 			HW_MMU_EventDisable(resources.dwDmmuBase,
 					    HW_MMU_TRANSLATION_FAULT);
 		} else {
-			DBG_Trace(DBG_LEVEL7,
-				 "***** MMU FAULT ***** faultcode 0x%x\n",
-				 dmmuEventMask);
 			HW_MMU_EventDisable(resources.dwDmmuBase,
 					    HW_MMU_ALL_INTERRUPTS);
 		}
@@ -141,8 +138,6 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext)
 	hwStatus = HW_MMU_EventStatus(resources.dwDmmuBase, &dmmuEventMask);
 	if (dmmuEventMask  ==  HW_MMU_TRANSLATION_FAULT) {
 		HW_MMU_FaultAddrRead(resources.dwDmmuBase, &faultAddr);
-		DBG_Trace(DBG_LEVEL1, "WMD_DEH_Notify: DSP_MMUFAULT, fault "
-			 "address = 0x%x\n", faultAddr);
 		retVal = true;
 	}
 	return retVal;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 3598c2b..ce8e619 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -342,7 +342,7 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 		/* Disable Automatic transition */
 		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_AUTOTRANS_DIS);
 	}
-	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - Middle ****** \n");
+
 	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
 	HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
 	CLK_Enable(SERVICESCLK_iva2_ck);
@@ -381,8 +381,6 @@ static DSP_STATUS WMD_BRD_Read(struct WMD_DEV_CONTEXT *hDevContext,
 	    pDevContext->dwInternalSize) {
 		offset = dwDSPAddr - pDevContext->dwDSPStartAdd;
 	} else {
-		DBG_Trace(DBG_LEVEL1,
-			  "**** Reading From external memory ****  \n ");
 		status = ReadExtDspData(pDevContext, pbHostBuf, dwDSPAddr,
 					ulNumBytes, ulMemType);
 		return status;
@@ -499,7 +497,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		udelay(100);
 		HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
 		udelay(100);
-		DBG_Trace(DBG_LEVEL6, "WMD_BRD_Start 0 ****** \n");
+
 		GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
 		/* Disbale the DSP MMU */
 		HW_MMU_Disable(resources.dwDmmuBase);
@@ -553,21 +551,16 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		/* Enable the BIOS clock  */
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
 				BRIDGEINIT_BIOSGPTIMER, &ulBiosGpTimer);
-		DBG_Trace(DBG_LEVEL7, "BIOS GPTimer : 0x%x\n", ulBiosGpTimer);
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
 				BRIDGEINIT_LOADMON_GPTIMER,
 				&ulLoadMonitorTimer);
-		DBG_Trace(DBG_LEVEL7, "Load Monitor Timer : 0x%x\n",
-			  ulLoadMonitorTimer);
 	}
 
 	if (DSP_SUCCEEDED(status)) {
 		if (ulLoadMonitorTimer != 0xFFFF) {
 			uClkCmd = (BPWR_DisableClock << MBX_PM_CLK_CMDSHIFT) |
 						ulLoadMonitorTimer;
-			DBG_Trace(DBG_LEVEL7,
-			       "encoded LoadMonitor cmd for Disable: 0x%x\n",
-			       uClkCmd);
+
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 			extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
@@ -589,9 +582,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			}
 			uClkCmd = (BPWR_EnableClock << MBX_PM_CLK_CMDSHIFT) |
 				  ulLoadMonitorTimer;
-			DBG_Trace(DBG_LEVEL7,
-				 "encoded LoadMonitor cmd for Enable : 0x%x\n",
-				 uClkCmd);
+
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 		} else {
@@ -605,8 +596,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		if (ulBiosGpTimer != 0xFFFF) {
 			uClkCmd = (BPWR_DisableClock << MBX_PM_CLK_CMDSHIFT) |
 								ulBiosGpTimer;
-			DBG_Trace(DBG_LEVEL7, "encoded BIOS GPTimer cmd for"
-					"Disable: 0x%x\n", uClkCmd);
+
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 			extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
@@ -630,8 +620,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 			uClkCmd = (BPWR_EnableClock << MBX_PM_CLK_CMDSHIFT) |
 				   ulBiosGpTimer;
-			DBG_Trace(DBG_LEVEL7, "encoded BIOS GPTimer cmd :"
-						"0x%x\n", uClkCmd);
+
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 		} else {
@@ -650,8 +639,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		temp = (temp & 0xFFFFFFFE) | 0x1;
 		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
 			(u32) temp;
-		DBG_Trace(DBG_LEVEL5, "WMD_BRD_Start: _BRIDGE_DSP_FREQ Addr:"
-				"0x%x \n", ulDspClkAddr);
 		if ((unsigned int *)ulDspClkAddr != NULL) {
 			/* Get the clock rate */
 			status = CLK_GetRate(SERVICESCLK_iva2_ck,
@@ -693,13 +680,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		 * stale messages */
 		(void)CHNLSM_EnableInterrupt(pDevContext);
 
-		HW_RSTCTRL_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
-		DBG_Trace(DBG_LEVEL7, "BRD_Start: RM_RSTCTRL_DSP = 0x%x \n",
-				temp);
-		HW_RSTST_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
-		DBG_Trace(DBG_LEVEL7, "BRD_Start0: RM_RSTST_DSP = 0x%x \n",
-				temp);
-
 		/* Let DSP go */
 		DBG_Trace(DBG_LEVEL7, "Unreset, WMD_BRD_Start\n");
 		/* Enable DSP MMU Interrupts */
@@ -708,12 +688,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		/* release the RST1, DSP starts executing now .. */
 		HW_RST_UnReset(resources.dwPrmBase, HW_RST1_IVA2);
 
-		HW_RSTST_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
-		DBG_Trace(DBG_LEVEL7, "BRD_Start: RM_RSTST_DSP = 0x%x \n",
-				temp);
-		HW_RSTCTRL_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
-		DBG_Trace(DBG_LEVEL5, "WMD_BRD_Start: CM_RSTCTRL_DSP: 0x%x \n",
-				temp);
 		DBG_Trace(DBG_LEVEL7, "Driver waiting for Sync @ 0x%x \n",
 				dwSyncAddr);
 		DBG_Trace(DBG_LEVEL7, "DSP c_int00 Address =  0x%x \n",
@@ -732,8 +706,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
 		if (DSP_SUCCEEDED(status)) {
 			IO_SHMsetting(hIOMgr, SHM_OPPINFO, NULL);
-			DBG_Trace(DBG_LEVEL7,
-			"WMD_BRD_Start: OPP information initialzed\n");
 			/* Write the synchronization bit to indicate the
 			 * completion of OPP table update to DSP
 			 */
@@ -742,7 +714,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			/* update board state */
 			pDevContext->dwBrdState = BRD_RUNNING;
 			/* (void)CHNLSM_EnableInterrupt(pDevContext);*/
-			DBG_Trace(DBG_LEVEL7, "Device Started \n ");
 		} else {
 			pDevContext->dwBrdState = BRD_UNKNOWN;
 			DBG_Trace(DBG_LEVEL7, "Device not Started \n ");
@@ -822,7 +793,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		pDevContext->dwDspExtBaseAddr = 0;
 
 	pDevContext->dwBrdState = BRD_STOPPED;	/* update board state */
-	DBG_Trace(DBG_LEVEL1, "Device Stopped \n ");
+
 	/* This is a good place to clear the MMU page tables as well */
 	if (pDevContext->pPtAttrs) {
 		pPtAttrs = pDevContext->pPtAttrs;
@@ -885,7 +856,7 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 		pDevContext->dwDspExtBaseAddr = 0;
 
 	pDevContext->dwBrdState = BRD_STOPPED;	/* update board state */
-	DBG_Trace(DBG_LEVEL1, "Device Stopped \n ");
+
 	/* This is a good place to clear the MMU page tables as well */
 	if (pDevContext->pPtAttrs) {
 		pPtAttrs = pDevContext->pPtAttrs;
@@ -1087,8 +1058,6 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Set the Clock Divisor for the DSP module */
-		DBG_Trace(DBG_LEVEL7, "WMD_DEV_create:Reset mail box and "
-			  "enable the clock \n");
 		status = CLK_Enable(SERVICESCLK_mailbox_ick);
 		if (DSP_FAILED(status)) {
 			DBG_Trace(DBG_LEVEL7,
@@ -1107,7 +1076,6 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 		pDevContext->dwBrdState = BRD_STOPPED;
 		/* Return this ptr to our device state to the WCD for storage:*/
 		*ppDevContext = pDevContext;
-		DBG_Trace(DBG_ENTER, "Device Created \n");
 	} else {
 		if (pPtAttrs != NULL) {
 			if (pPtAttrs->hCSObj)
@@ -1162,33 +1130,26 @@ static DSP_STATUS WMD_DEV_Ctrl(struct WMD_DEV_CONTEXT *pDevContext, u32 dwCmd,
 	case WMDIOCTL_EMERGENCYSLEEP:
 		/* Currently only DSP Idle is supported Need to update for
 		 * later releases */
-		DBG_Trace(DBG_LEVEL5, "WMDIOCTL_DEEPSLEEP\n");
 		status = SleepDSP(pDevContext, PWR_DEEPSLEEP, pArgs);
 		break;
 	case WMDIOCTL_WAKEUP:
-		DBG_Trace(DBG_LEVEL5, "WMDIOCTL_WAKEUP\n");
 		status = WakeDSP(pDevContext, pArgs);
 		break;
 	case WMDIOCTL_CLK_CTRL:
-		DBG_Trace(DBG_LEVEL5, "WMDIOCTL_CLK_CTRL\n");
 		status = DSP_SOK;
 		/* Looking For Baseport Fix for Clocks */
 		status = DSPPeripheralClkCtrl(pDevContext, pArgs);
 		break;
 	case WMDIOCTL_PWR_HIBERNATE:
-		DBG_Trace(DBG_LEVEL5, "WMDIOCTL_PWR_HIBERNATE\n");
 		status = handle_hibernation_fromDSP(pDevContext);
 		break;
 	case WMDIOCTL_PRESCALE_NOTIFY:
-		DBG_Trace(DBG_LEVEL5, "WMDIOCTL_PRESCALE_NOTIFY\n");
 		status = PreScale_DSP(pDevContext, pArgs);
 		break;
 	case WMDIOCTL_POSTSCALE_NOTIFY:
-		DBG_Trace(DBG_LEVEL5, "WMDIOCTL_POSTSCALE_NOTIFY\n");
 		status = PostScale_DSP(pDevContext, pArgs);
 		break;
 	case WMDIOCTL_CONSTRAINT_REQUEST:
-		DBG_Trace(DBG_LEVEL5, "WMDIOCTL_CONSTRAINT_REQUEST\n");
 		status = handle_constraints_set(pDevContext, pArgs);
 		break;
 	default:
@@ -1433,8 +1394,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	if (vma->vm_flags & VM_IO) {
 		numUsrPgs =  ulNumBytes / PG_SIZE_4K;
 		mpuAddr = ulMpuAddr;
-		DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap:numOfActualTabEntries=%d,"
-			  "ulNumBytes= %d\n",  numUsrPgs, ulNumBytes);
+
 		/* Get the physical addresses for user buffer */
 		for (pgI = 0; pgI < numUsrPgs; pgI++) {
 			pa = user_va2pa(mm, mpuAddr);
@@ -1601,9 +1561,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 		if (remBytes < (pteCount * PG_SIZE_4K))
 			pteCount = remBytes / PG_SIZE_4K;
 		remBytesL2 = pteCount * PG_SIZE_4K;
-		DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap L2BasePa %x, "
-			  "L2BaseVa %x pteAddrL2 %x, remBytesL2 %x\n",
-			  L2BasePa, L2BaseVa, pteAddrL2, remBytesL2);
+
 		/*
 		 * Unmap the VA space on this L2 PT. A quicker way
 		 * would be to clear pteCount entries starting from
@@ -1676,10 +1634,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 			remBytes -= pteCount * PG_SIZE_4K;
 		} else
 			status = DSP_EFAIL;
-		DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap L2PageNum %x, "
-			  "numEntries %x, pteCount %x, status: 0x%x\n",
-			  L2PageNum, pt->pgInfo[L2PageNum].numEntries,
-			  pteCount, status);
+
 		SYNC_LeaveCS(pt->hCSObj);
 		continue;
 skip_coarse_page:
@@ -1787,12 +1742,10 @@ static DSP_STATUS PteUpdate(struct WMD_DEV_CONTEXT *hDevContext, u32 pa,
 		/* To find the max. page size with which both PA & VA are
 		 * aligned */
 		allBits = paCurr | vaCurr;
-		DBG_Trace(DBG_LEVEL1, "allBits %x, paCurr %x, vaCurr %x, "
-			 "numBytes %x ", allBits, paCurr, vaCurr, numBytes);
+
 		for (i = 0; i < 4; i++) {
 			if ((numBytes >= pgSize[i]) && ((allBits &
 			   (pgSize[i] - 1)) == 0)) {
-				DBG_Trace(DBG_LEVEL1, "pgSize %x\n", pgSize[i]);
 				status = PteSet(pDevContext->pPtAttrs, paCurr,
 						vaCurr, pgSize[i], mapAttrs);
 				paCurr += pgSize[i];
@@ -1942,8 +1895,7 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 		while (++i < numPages) {
 			pPage[0] = vmalloc_to_page((void *)(vaCurr + sizeCurr));
 			paNext = page_to_phys(pPage[0]);
-			DBG_Trace(DBG_LEVEL5, "Xlate Vmalloc VA=0x%x , "
-				 "PA=0x%x \n", (vaCurr + sizeCurr), paNext);
+
 			if (paNext == (paCurr + sizeCurr))
 				sizeCurr += PAGE_SIZE;
 			else
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 193844d..5acaf44 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -124,12 +124,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 
 		/* Save mailbox settings */
 		status = HW_MBOX_saveSettings(resources.dwMboxBase);
-		DBG_Trace(DBG_LEVEL6, "MailBoxSettings: SYSCONFIG = 0x%x\n",
-			 mboxsetting.sysconfig);
-		DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE0 = 0x%x\n",
-			 mboxsetting.irqEnable0);
-		DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE1 = 0x%x\n",
-			 mboxsetting.irqEnable1);
+
 		/* Turn off DSP Peripheral clocks and DSP Load monitor timer */
 		status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
 
@@ -141,12 +136,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 			if (DSP_FAILED(status))
 				return status;
 			IO_SHMsetting(hIOMgr, SHM_GETOPP, &opplevel);
-			if (opplevel != VDD1_OPP1) {
-				DBG_Trace(DBG_LEVEL5,
-					" DSP requested OPP = %d, MPU"
-					" requesting low OPP %d instead\n",
-					opplevel, VDD1_OPP1);
-			}
+
 			/*
 			 * Set the OPP to low level before moving to OFF
 			 * mode
@@ -255,9 +245,6 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 		return WMD_E_TIMEOUT;
 	} else {
-		DBG_Trace(DBG_LEVEL7, "SleepDSP: DSP STANDBY Pwr state %x \n",
-			 pwrState);
-
 		/* Update the Bridger Driver state */
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF)
 			pDevContext->dwBrdState = BRD_HIBERNATION;
@@ -319,9 +306,6 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 #ifdef CONFIG_BRIDGE_DEBUG
 	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 			&pwrState);
-	DBG_Trace(DBG_LEVEL7,
-			"\nWakeDSP: Power State After sending Interrupt "
-			"to DSP %x\n", pwrState);
 #endif /* CONFIG_BRIDGE_DEBUG */
 
 	/* Set the device state to RUNNIG */
@@ -359,9 +343,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 	if (DSP_FAILED(status))
 		return DSP_EFAIL;
 
-	DBG_Trace(DBG_LEVEL3, "DSPPeripheralClkCtrl : extClk+Cmd = 0x%x \n",
-		 extClk);
-
 	extClkId = extClk & MBX_PM_CLK_IDMASK;
 
 	/* process the power message -- TODO, keep it in a separate function */
@@ -385,8 +366,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 	switch (extClkCmd) {
 	case BPWR_DisableClock:
 		/* Call BP to disable the needed clock */
-		DBG_Trace(DBG_LEVEL3,
-			 "DSPPeripheralClkCtrl : Disable CLK for \n");
 		status1 = CLK_Disable(BPWR_Clks[clkIdIndex].intClk);
 		status = CLK_Disable(BPWR_Clks[clkIdIndex].funClk);
 		if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP1) {
@@ -410,8 +389,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 		}
 		break;
 	case BPWR_EnableClock:
-		DBG_Trace(DBG_LEVEL3,
-			 "DSPPeripheralClkCtrl : Enable CLK for \n");
 		status1 = CLK_Enable(BPWR_Clks[clkIdIndex].intClk);
 		status = CLK_Enable(BPWR_Clks[clkIdIndex].funClk);
 		if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP1) {
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 4b6ee90..2d32b26 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -86,11 +86,8 @@ DSP_STATUS ReadExtDspData(struct WMD_DEV_CONTEXT *hDevContext,
 
 	if (DSP_SUCCEEDED(status)) {
 		if ((dwDSPAddr <= ulTraceSecEnd) &&
-			(dwDSPAddr >= ulTraceSecBeg)) {
-			DBG_Trace(DBG_LEVEL5, "Reading from DSP Trace"
-				 "section 0x%x \n", dwDSPAddr);
+			(dwDSPAddr >= ulTraceSecBeg))
 			bTraceRead = true;
-		}
 	}
 
 	/* If reading from TRACE, force remap/unmap */
@@ -142,20 +139,13 @@ DSP_STATUS ReadExtDspData(struct WMD_DEV_CONTEXT *hDevContext,
 			DBC_Assert(ulTLBBaseVirt <= ulShmBaseVirt);
 			dwExtProgVirtMem = pDevContext->aTLBEntry[0].ulGppVa;
 
-			if (bTraceRead) {
-				DBG_Trace(DBG_LEVEL7, "ReadExtDspData: "
-				"GPP VA pointing to SHMMEMBASE 0x%x \n",
-				 dwExtProgVirtMem);
-			} else {
+			if (!bTraceRead) {
 				ulShmOffsetVirt = ulShmBaseVirt - ulTLBBaseVirt;
 				ulShmOffsetVirt += PG_ALIGN_HIGH(ulExtEnd -
 						ulDynExtBase + 1,
 						HW_PAGE_SIZE_64KB);
 				dwExtProgVirtMem -= ulShmOffsetVirt;
 				dwExtProgVirtMem += (ulExtBase - ulDynExtBase);
-				DBG_Trace(DBG_LEVEL7, "ReadExtDspData: "
-				"GPP VA pointing to EXTMEMBASE 0x%x \n",
-				dwExtProgVirtMem);
 				pDevContext->dwDspExtBaseAddr =
 						dwExtProgVirtMem;
 
@@ -266,11 +256,8 @@ DSP_STATUS WriteExtDspData(struct WMD_DEV_CONTEXT *pDevContext,
 	}
 	if (DSP_SUCCEEDED(retVal)) {
 		if ((dwDSPAddr <= ulTraceSecEnd) &&
-		   (dwDSPAddr >= ulTraceSecBeg)) {
-			DBG_Trace(DBG_LEVEL5, "Writing to DSP Trace "
-				 "section 0x%x \n", dwDSPAddr);
+		   (dwDSPAddr >= ulTraceSecBeg))
 			bTraceLoad = true;
-		}
 	}
 
 	/* If dynamic, force remap/unmap */
@@ -352,9 +339,6 @@ DSP_STATUS WriteExtDspData(struct WMD_DEV_CONTEXT *pDevContext,
 				dwExtProgVirtMem = hostRes.dwMemBase[1];
 				dwExtProgVirtMem += (ulExtBase - ulDynExtBase);
 			}
-			DBG_Trace(DBG_LEVEL7, "WriteExtDspData: GPP VA "
-				 "pointing to EXTMEMBASE 0x%x \n",
-				 dwExtProgVirtMem);
 
 			pDevContext->dwDspExtBaseAddr =
 				(u32)MEM_LinearAddress((void *)dwExtProgVirtMem,
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index dd23387..032a6e3 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -117,7 +117,6 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 		*phDehMgr = NULL;
 	} else {
 		*phDehMgr = (struct DEH_MGR *)pDehMgr;
-		DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n", pDehMgr);
 	}
 
 	return status;
@@ -143,7 +142,6 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
 
 		/* Free DPC object */
 		tasklet_kill(&pDehMgr->dpc_tasklet);
-		DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
 
 		/* Deallocate the DEH manager object */
 		MEM_FreeObject(pDehMgr);
@@ -229,8 +227,6 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 					MEM_PAGED);
 			memPhysical  = VirtToPhys(PG_ALIGN_LOW((u32)dummyVaAddr,
 								PG_SIZE_4K));
-DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
-				 "mem Physical= 0x%x\n", memPhysical);
 			pDevContext = (struct WMD_DEV_CONTEXT *)
 						pDehMgr->hWmdContext;
 			/* Reset the dynamic mmu index to fixed count if it
@@ -242,9 +238,6 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 				pDevContext->numTLBEntries = pDevContext->
 					fixedTLBEntries;
 			}
-			DBG_Trace(DBG_LEVEL6, "Adding TLB Entry %d: VA: 0x%x, "
-				 "PA: 0x%x\n", pDevContext->
-				numTLBEntries, faultAddr, memPhysical);
 			if (DSP_SUCCEEDED(status)) {
 				hwStatus = HW_MMU_TLBAdd(resources.dwDmmuBase,
 					memPhysical, faultAddr,
-- 
1.6.2.4


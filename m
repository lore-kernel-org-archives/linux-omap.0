From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 02/18] DSPBRIDGE: Remove entry point custom debug statements for wmd
Date: Tue, 16 Feb 2010 02:42:12 -0600
Message-ID: <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54450 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846Ab0BPIaL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:11 -0500
In-Reply-To: <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove statements using GT_ENTER custom bridge level which is
used to print entry and exit points from functions. Few
meaningful prints were left for reference when migrating to
dev_dbg.

This changes are split to touch wmd folder only.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/chnl_sm.c        |   10 ------
 drivers/dsp/bridge/wmd/io_sm.c          |   17 +---------
 drivers/dsp/bridge/wmd/mmu_fault.c      |    4 --
 drivers/dsp/bridge/wmd/tiomap3430.c     |   49 ++----------------------------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    5 ---
 drivers/dsp/bridge/wmd/tiomap_io.c      |    9 ------
 drivers/dsp/bridge/wmd/tiomap_sm.c      |    6 ----
 drivers/dsp/bridge/wmd/ue_deh.c         |   19 ++----------
 8 files changed, 9 insertions(+), 110 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 585c004..11e3930 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -104,11 +104,6 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
 	bool fSchedDPC = false;
 	u16 wMbVal = 0;
 
-	DBG_Trace(DBG_ENTER,
-		  "> WMD_CHNL_AddIOReq pChnl %p CHNL_IsOutput %x uChnlType "
-		  "%x Id %d\n", pChnl, CHNL_IsOutput(pChnl->uMode),
-		  pChnl->uChnlType, pChnl->uId);
-
 	fIsEOS = (cBytes == 0);
 
 	/* Validate args */
@@ -239,7 +234,6 @@ func_cont:
 		IO_Schedule(pChnlMgr->hIOMgr);
 
 func_end:
-	DBG_Trace(DBG_ENTER, "< WMD_CHNL_AddIOReq pChnl %p\n", pChnl);
 	return status;
 }
 
@@ -580,9 +574,6 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
 	struct CHNL_IOC ioc = { NULL, 0, 0, 0, 0 };
 	u8 *pHostSysBuf = NULL;
 
-	DBG_Trace(DBG_ENTER, "> WMD_CHNL_GetIOC pChnl %p CHNL_IsOutput %x "
-		 "uChnlType %x\n", pChnl, CHNL_IsOutput(pChnl->uMode),
-		 pChnl->uChnlType);
 	/* Check args: */
 	if (pIOC == NULL) {
 		status = DSP_EPOINTER;
@@ -716,7 +707,6 @@ func_cont:
 	/* Update User's IOC block: */
 	*pIOC = ioc;
 func_end:
-	DBG_Trace(DBG_ENTER, "< WMD_CHNL_GetIOC pChnl %p\n", pChnl);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index a25cfd6..046300b 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -876,8 +876,6 @@ static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
 	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		goto func_end;
 
-	DBG_Trace(DBG_LEVEL3, "Entering IO_DispatchChnl \n");
-
 	/* See if there is any data available for transfer */
 	if (iMode != IO_SERVICE)
 		goto func_end;
@@ -898,8 +896,6 @@ static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		goto func_end;
 
-	DBG_Trace(DBG_LEVEL3, "Entering IO_DispatchMsg \n");
-
 	/* We are performing both input and output processing. */
 	InputMsg(pIOMgr, hMsgMgr);
 	OutputMsg(pIOMgr, hMsgMgr);
@@ -917,8 +913,6 @@ static void IO_DispatchPM(struct work_struct *work)
 	DSP_STATUS status;
 	u32 pArg[2];
 
-	DBG_Trace(DBG_LEVEL7, "IO_DispatchPM: Entering IO_DispatchPM : \n");
-
 	/* Perform Power message processing here */
 	while (pIOMgr->iQuePowerHead != pIOMgr->iQuePowerTail) {
 		pArg[0] = *(u32 *)&(pIOMgr->dQuePowerMbxVal[pIOMgr->
@@ -988,7 +982,6 @@ void IO_DPC(IN OUT unsigned long pRefData)
 	DEV_GetDehMgr(pIOMgr->hDevObject, &hDehMgr);
 	if (!MEM_IsValidHandle(pChnlMgr, CHNL_MGRSIGNATURE))
 		goto func_end;
-	DBG_Trace(DBG_LEVEL7, "Entering IO_DPC(0x%x)\n", pRefData);
 
 	requested = pIOMgr->dpc_req;
 	serviced = pIOMgr->dpc_sched;
@@ -1039,7 +1032,6 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 	if (irq != INT_MAIL_MPU_IRQ ||
 	   !MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE))
 		return IRQ_NONE;
-	DBG_Trace(DBG_LEVEL3, "Entering IO_ISR(0x%x)\n", pRefData);
 
 	/* Call WMD's CHNLSM_ISR() to see if interrupt is ours, and process. */
 	if (IO_CALLISR(hIOMgr->hWmdContext, &fSchedDPC, &hIOMgr->wIntrVal)) {
@@ -1198,8 +1190,6 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	sm = pIOMgr->pSharedMem;
 	pChnlMgr = pIOMgr->hChnlMgr;
 
-	DBG_Trace(DBG_LEVEL3, "> InputChnl\n");
-
 	/* Attempt to perform input */
 	if (!IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, inputFull))
 		goto func_end;
@@ -1302,7 +1292,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 		NotifyChnlComplete(pChnl, pChirp);
 	}
 func_end:
-	DBG_Trace(DBG_LEVEL3, "< InputChnl\n");
+	return;
 }
 
 /*
@@ -1471,7 +1461,6 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 
 	pChnlMgr = pIOMgr->hChnlMgr;
 	sm = pIOMgr->pSharedMem;
-	DBG_Trace(DBG_LEVEL3, "> OutputChnl\n");
 	/* Attempt to perform output */
 	if (IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, outputFull))
 		goto func_end;
@@ -1535,7 +1524,7 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 		NTFY_Notify(pChnl->hNtfy, DSP_STREAMDONE);
 
 func_end:
-	DBG_Trace(DBG_LEVEL3, "< OutputChnl\n");
+	return;
 }
 /*
  *  ======== OutputMsg ========
@@ -1877,8 +1866,6 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 {
 	u32 ulNewMessageLength = 0, ulGPPCurPointer;
 
-	GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");
-
 	while (true) {
 		/* Get the DSP current pointer */
 		ulGPPCurPointer = *(u32 *) (hIOMgr->ulTraceBufferCurrent);
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 14ca490..a3c8657 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -57,12 +57,9 @@ void MMU_FaultDpc(IN unsigned long pRefData)
 {
 	struct DEH_MGR *hDehMgr = (struct DEH_MGR *)pRefData;
 
-	DBG_Trace(DBG_LEVEL1, "MMU_FaultDpc Enter: 0x%x\n", pRefData);
-
 	if (hDehMgr)
 		WMD_DEH_Notify(hDehMgr, DSP_MMUFAULT, 0L);
 
-	DBG_Trace(DBG_LEVEL1, "MMU_FaultDpc Exit: 0x%x\n", pRefData);
 }
 
 /*
@@ -76,7 +73,6 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 	struct CFG_HOSTRES resources;
 	DSP_STATUS status = DSP_SOK;
 
-	DBG_Trace(DBG_LEVEL1, "Entering DEH_DspMmuIsr: 0x%x\n", pRefData);
 	DBC_Require(irq == INT_DSP_MMU_IRQ);
 	DBC_Require(MEM_IsValidHandle(pDehMgr, SIGNATURE));
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 7c1f59a..3598c2b 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -294,7 +294,6 @@ void WMD_DRV_Entry(OUT struct WMD_DRV_INTERFACE **ppDrvInterface,
 {
 
 	DBC_Require(pstrWMDFileName != NULL);
-	DBG_Trace(DBG_ENTER, "In the WMD_DRV_Entry \n");
 
 	IO_SM_init(); /* Initialization of io_sm module */
 
@@ -322,7 +321,6 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 	u32 temp;
 	enum HW_PwrState_t    pwrState;
 
-	DBG_Trace(DBG_ENTER, "Board in the monitor state  \n");
 	status = CFG_GetHostResources(
 		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 	if (DSP_FAILED(status))
@@ -354,7 +352,6 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 		pDevContext->dwBrdState = BRD_IDLE;
 	}
 error_return:
-	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - End ****** \n");
 	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
 	return status;
 }
@@ -373,10 +370,6 @@ static DSP_STATUS WMD_BRD_Read(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 offset;
 	u32 dspBaseAddr = hDevContext->dwDspBaseAddr;
 
-	DBG_Trace(DBG_ENTER, "WMD_BRD_Read, pDevContext: 0x%x\n\t\tpbHostBuf:"
-		  " 0x%x\n\t\tdwDSPAddr:  0x%x\n\t\tulNumBytes:  0x%x\n\t\t"
-		  "ulMemType:  0x%x\n", pDevContext, pbHostBuf,
-		  dwDSPAddr, ulNumBytes, ulMemType);
 	if (dwDSPAddr < pDevContext->dwDSPStartAdd) {
 		DBG_Trace(DBG_LEVEL7,
 			  "WMD_BRD_Read: DSP address < start address \n ");
@@ -410,8 +403,6 @@ static DSP_STATUS WMD_BRD_SetState(struct WMD_DEV_CONTEXT *hDevContext,
 	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 
-	DBG_Trace(DBG_ENTER, "WMD_BRD_SetState: Board State: 0x%x \n",
-		  ulBrdState);
 	pDevContext->dwBrdState = ulBrdState;
 	return status;
 }
@@ -450,9 +441,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 tmpIndex;
 	u32 clkIdIndex = MBX_PM_MAX_RESOURCES;
 
-	DBG_Trace(DBG_ENTER, "Entering WMD_BRD_Start:\n hDevContext: 0x%x\n\t "
-			     "dwDSPAddr: 0x%x\n", hDevContext, dwDSPAddr);
-
 	/* The device context contains all the mmu setup info from when the
 	 * last dsp base image was loaded. The first entry is always
 	 * SHMMEM base. */
@@ -780,9 +768,6 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 	u32 dspPwrState;
 	DSP_STATUS clk_status;
 
-	DBG_Trace(DBG_ENTER, "Entering WMD_BRD_Stop:\nhDevContext: 0x%x\n",
-		  hDevContext);
-
 	/* Disable the mail box interrupts */
 	(void)CHNLSM_DisableInterrupt(pDevContext);
 
@@ -846,7 +831,6 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		memset((u8 *) pPtAttrs->pgInfo, 0x00,
 		       (pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
-	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
 	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
 	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
 	HW_RST_Reset(resources.dwPrmBase, HW_RST3_IVA2);
@@ -871,9 +855,6 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 	struct PgTableAttrs *pPtAttrs;
 	DSP_STATUS clk_status;
 
-	DBG_Trace(DBG_ENTER, "Entering WMD_BRD_Delete:\nhDevContext: 0x%x\n",
-		  hDevContext);
-
 	/* Disable the mail box interrupts */
 	(void) CHNLSM_DisableInterrupt(pDevContext);
 
@@ -913,7 +894,6 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 		memset((u8 *)pPtAttrs->pgInfo, 0x00,
 			(pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
-	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Delete - End ****** \n");
 	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
 	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
 	HW_RST_Reset(resources.dwPrmBase, HW_RST3_IVA2);
@@ -945,10 +925,6 @@ static DSP_STATUS WMD_BRD_Write(struct WMD_DEV_CONTEXT *hDevContext,
 	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 
-	DBG_Trace(DBG_ENTER, "WMD_BRD_Write, pDevContext: 0x%x\n\t\t "
-		 "pbHostBuf: 0x%x\n\t\tdwDSPAddr: 0x%x\n\t\tulNumBytes: "
-		 "0x%x\n \t\t ulMemtype: 0x%x\n", pDevContext, pbHostBuf,
-		 dwDSPAddr, ulNumBytes, ulMemType);
 	if (dwDSPAddr < pDevContext->dwDSPStartAdd) {
 		DBG_Trace(DBG_LEVEL7,
 			 "WMD_BRD_Write: DSP address < start address \n ");
@@ -964,8 +940,6 @@ static DSP_STATUS WMD_BRD_Write(struct WMD_DEV_CONTEXT *hDevContext,
 					 ulNumBytes, ulMemType, false);
 	}
 
-	DBG_Trace(DBG_ENTER, "WMD_BRD_Write, memcopy :  DspLogicAddr=0x%x \n",
-			pDevContext->dwDspBaseAddr);
 	return status;
 }
 
@@ -989,9 +963,6 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 	u32   pg_tbl_va;
 	u32   align_size;
 
-	DBG_Trace(DBG_ENTER, "WMD_DEV_Create, ppDevContext: 0x%x\n\t\t "
-		  "hDevObject: 0x%x\n\t\tpConfig: 0x%x\n\t\tpDspConfig: 0x%x\n",
-		  ppDevContext, hDevObject, pConfig, pDspConfig);
 	 /* Allocate and initialize a data structure to contain the mini driver
 	 *  state, which becomes the context for later calls into this WMD.  */
 	pDevContext = MEM_Calloc(sizeof(struct WMD_DEV_CONTEXT), MEM_NONPAGED);
@@ -1177,8 +1148,6 @@ static DSP_STATUS WMD_DEV_Ctrl(struct WMD_DEV_CONTEXT *pDevContext, u32 dwCmd,
 	struct WMDIOCTL_EXTPROC *paExtProc = (struct WMDIOCTL_EXTPROC *)pArgs;
 	s32 ndx;
 
-	DBG_Trace(DBG_ENTER, "WMD_DEV_Ctrl, pDevContext:  0x%x\n\t\t dwCmd:  "
-		  "0x%x\n\t\tpArgs:  0x%x\n", pDevContext, dwCmd, pArgs);
 	switch (dwCmd) {
 	case WMDIOCTL_CHNLREAD:
 		break;
@@ -1245,8 +1214,6 @@ static DSP_STATUS WMD_DEV_Destroy(struct WMD_DEV_CONTEXT *hDevContext)
 	if (!hDevContext)
 		return DSP_EHANDLE;
 
-	DBG_Trace(DBG_ENTER, "Entering WMD_DEV_Destroy:n hDevContext ::0x%x\n",
-		  hDevContext);
 	/* first put the device to stop state */
 	WMD_BRD_Delete(pDevContext);
 	if (pDevContext->pPtAttrs) {
@@ -1543,7 +1510,6 @@ func_cont:
 	if (DSP_SUCCEEDED(status)) {
 		status = DSP_SOK;
 	} else {
-		DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap status %x\n", status);
 		/*
 		 * Roll out the mapped pages incase it failed in middle of
 		 * mapping
@@ -1816,8 +1782,7 @@ static DSP_STATUS PteUpdate(struct WMD_DEV_CONTEXT *hDevContext, u32 pa,
 	DSP_STATUS status = DSP_SOK;
 	u32 pgSize[] = { HW_PAGE_SIZE_16MB, HW_PAGE_SIZE_1MB,
 			   HW_PAGE_SIZE_64KB, HW_PAGE_SIZE_4KB };
-	DBG_Trace(DBG_ENTER, "> PteUpdate hDevContext %x, pa %x, va %x, "
-		 "size %x, mapAttrs %x\n", hDevContext, pa, va, size, mapAttrs);
+
 	while (numBytes && DSP_SUCCEEDED(status)) {
 		/* To find the max. page size with which both PA & VA are
 		 * aligned */
@@ -1840,8 +1805,7 @@ static DSP_STATUS PteUpdate(struct WMD_DEV_CONTEXT *hDevContext, u32 pa,
 			}
 		}
 	}
-	DBG_Trace(DBG_ENTER, "< PteUpdate status %x numBytes %x\n", status,
-		  numBytes);
+
 	return status;
 }
 
@@ -1866,8 +1830,7 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 	u32 L2BasePa = 0;
 	u32 L2PageNum = 0;
 	DSP_STATUS status = DSP_SOK;
-	DBG_Trace(DBG_ENTER, "> PteSet pPgTableAttrs %x, pa %x, va %x, "
-		 "size %x, attrs %x\n", pt, pa, va, size, attrs);
+
 	L1BaseVa = pt->L1BaseVa;
 	pgTblVa = L1BaseVa;
 	if ((size == HW_PAGE_SIZE_64KB) || (size == HW_PAGE_SIZE_4KB)) {
@@ -1933,7 +1896,7 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 			  attrs->elementSize, attrs->mixedSize);
 		status = HW_MMU_PteSet(pgTblVa, pa, va, size, attrs);
 	}
-	DBG_Trace(DBG_ENTER, "< PteSet status %x\n", status);
+
 	return status;
 }
 
@@ -1954,9 +1917,6 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 	u32 numOf4KPages;
 	u32 temp = 0;
 
-	DBG_Trace(DBG_ENTER, "> MemMapVmalloc hDevContext %x, pa %x, va %x, "
-		  "size %x\n", pDevContext, ulMpuAddr, ulVirtAddr, ulNumBytes);
-
 	/*
 	 * Do Kernel va to pa translation.
 	 * Combine physically contiguous regions to reduce TLBs.
@@ -2020,7 +1980,6 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 	 * region
 	 */
 	flush_all(pDevContext);
-	DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap at end status %x\n", status);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 084f406..193844d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -180,8 +180,6 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	u16 timeout = PWRSTST_TIMEOUT / 10;
 	enum HW_PwrState_t pwrState, targetPwrState;
 
-	DBG_Trace(DBG_LEVEL7, "SleepDSP- Enter function \n");
-
 	/* Check if sleep code is valid */
 	if ((dwCmd != PWR_DEEPSLEEP) && (dwCmd != PWR_EMERGENCYDEEPSLEEP)) {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP- Illegal sleep command\n");
@@ -350,10 +348,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 	struct CFG_HOSTRES resources;
 	u32 value;
 
-	DBG_Trace(DBG_ENTER, "Entering DSPPeripheralClkCtrl \n");
 	dspPerClksBefore = pDevContext->uDspPerClks;
-	DBG_Trace(DBG_ENTER, "DSPPeripheralClkCtrl : uDspPerClks = 0x%x \n",
-		  dspPerClksBefore);
 
 	extClk = (u32)*((u32 *)pArgs);
 
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 4e85efd..4b6ee90 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -65,12 +65,6 @@ DSP_STATUS ReadExtDspData(struct WMD_DEV_CONTEXT *hDevContext,
 	u32	dwBaseAddr = pDevContext->dwDspExtBaseAddr;
 	bool	bTraceRead = false;
 
-	DBG_Trace(DBG_ENTER, "ReadExtDspData,"
-	"hDevContext: 0x%x\n\t\tpbHostBuf: 0x%x"
-	"\n\t\tdwDSPAddr:  0x%x\n\t\tulNumBytes:  0x%x\n\t\t"
-	"ulMemType:  0x%x\n", pDevContext, pbHostBuf, dwDSPAddr,
-	ulNumBytes, ulMemType);
-
 	if (!ulShmBaseVirt) {
 		status = DEV_GetSymbol(pDevContext->hDevObject,
 		SHMBASENAME, &ulShmBaseVirt);
@@ -207,7 +201,6 @@ DSP_STATUS WriteDspData(struct WMD_DEV_CONTEXT *hDevContext, IN u8 *pbHostBuf,
 	base1 = OMAP_DSP_MEM1_SIZE;
 	base2 = OMAP_DSP_MEM2_BASE - OMAP_DSP_MEM1_BASE;
 	base3 = OMAP_DSP_MEM3_BASE - OMAP_DSP_MEM1_BASE;
-	DBG_Trace(DBG_ENTER, "Entered WriteDspData \n");
 
 	status =  CFG_GetHostResources(
 		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
@@ -263,8 +256,6 @@ DSP_STATUS WriteExtDspData(struct WMD_DEV_CONTEXT *pDevContext,
 	bTempByte1 = 0x0;
 	bTempByte2 = 0x0;
 
-	DBG_Trace(DBG_ENTER, "Entered WriteExtDspData dwDSPAddr 0x%x "
-		 "ulNumBytes 0x%x \n", dwDSPAddr, ulNumBytes);
 	  if (bSymbolsReloaded) {
 		/* Check if it is a load to Trace section */
 		retVal = DEV_GetSymbol(pDevContext->hDevObject,
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index b04ed6d..50f54c2 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -41,8 +41,6 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 	struct CFG_HOSTRES resources;
 	u32 devType;
 
-	DBG_Trace(DBG_ENTER, "CHNLSM_EnableInterrupt(0x%x)\n", pDevContext);
-
 	/* Read the messages in the mailbox until the message queue is empty */
 
 	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
@@ -84,8 +82,6 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 {
 	struct CFG_HOSTRES resources;
 
-	DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", pDevContext);
-
 	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
 			     &resources);
 	HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
@@ -171,8 +167,6 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
 	u32 numMbxMsg;
 	u32 mbxValue;
 
-	DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", pDevContext);
-
 	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 
 	HW_MBOX_NumMsgGet(resources.dwMboxBase, MBOX_DSP2ARM, &numMbxMsg);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 21d0b48..dd23387 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -72,7 +72,6 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 	struct CFG_DEVNODE *hDevNode;
 	struct WMD_DEV_CONTEXT *hWmdContext = NULL;
 
-	DBG_Trace(DBG_LEVEL1, "Entering DEH_Create: 0x%x\n", phDehMgr);
 	 /*  Message manager will be created when a file is loaded, since
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image.  */
@@ -120,7 +119,7 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 		*phDehMgr = (struct DEH_MGR *)pDehMgr;
 		DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n", pDehMgr);
 	}
-	DBG_Trace(DBG_LEVEL1, "Exiting DEH_Create.\n");
+
 	return status;
 }
 
@@ -133,7 +132,6 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
 	DSP_STATUS status = DSP_SOK;
 	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)hDehMgr;
 
-	DBG_Trace(DBG_LEVEL1, "Entering DEH_Destroy: 0x%x\n", pDehMgr);
 	if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {
 		/* Release dummy VA buffer */
 		WMD_DEH_ReleaseDummyMem();
@@ -150,7 +148,7 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
 		/* Deallocate the DEH manager object */
 		MEM_FreeObject(pDehMgr);
 	}
-	DBG_Trace(DBG_LEVEL1, "Exiting DEH_Destroy.\n");
+
 	return status;
 }
 
@@ -165,14 +163,11 @@ DSP_STATUS WMD_DEH_RegisterNotify(struct DEH_MGR *hDehMgr, u32 uEventMask,
 	DSP_STATUS status = DSP_SOK;
 	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)hDehMgr;
 
-	DBG_Trace(DBG_LEVEL1, "Entering WMD_DEH_RegisterNotify: 0x%x\n",
-		 pDehMgr);
-
 	if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {
 		status = NTFY_Register(pDehMgr->hNtfy, hNotification,
 			 uEventMask, uNotifyType);
 	}
-	DBG_Trace(DBG_LEVEL1, "Exiting WMD_DEH_RegisterNotify.\n");
+
 	return status;
 }
 
@@ -200,8 +195,6 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 		DBG_Trace(DBG_LEVEL7,
 			 "**Failed to get Host Resources in MMU ISR **\n");
 
-	DBG_Trace(DBG_LEVEL1, "Entering WMD_DEH_Notify: 0x%x, 0x%x\n", pDehMgr,
-		 ulEventMask);
 	if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {
 		printk(KERN_INFO "WMD_DEH_Notify: ********** DEVICE EXCEPTION "
 			"**********\n");
@@ -296,8 +289,6 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 		PrintDspTraceBuffer(hDehMgr->hWmdContext);
 
 	}
-	DBG_Trace(DBG_LEVEL1, "Exiting WMD_DEH_Notify\n");
-
 }
 
 /*
@@ -313,8 +304,6 @@ DSP_STATUS WMD_DEH_GetInfo(struct DEH_MGR *hDehMgr,
 	DBC_Require(pDehMgr);
 	DBC_Require(pErrInfo);
 
-	DBG_Trace(DBG_LEVEL1, "Entering WMD_DEH_GetInfo: 0x%x\n", hDehMgr);
-
 	if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {
 		/* Copy DEH error info structure to PROC error info
 		 * structure. */
@@ -326,8 +315,6 @@ DSP_STATUS WMD_DEH_GetInfo(struct DEH_MGR *hDehMgr,
 		status = DSP_EHANDLE;
 	}
 
-	DBG_Trace(DBG_LEVEL1, "Exiting WMD_DEH_GetInfo\n");
-
 	return status;
 }
 
-- 
1.6.2.4


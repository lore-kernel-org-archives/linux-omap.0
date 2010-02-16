From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 10/18] DSPBRIDGE: Remove excessive debug statements for wmd
Date: Tue, 16 Feb 2010 02:42:20 -0600
Message-ID: <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57641 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab0BPIaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 03:30:09 -0500
In-Reply-To: <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Removed debug statements that print redundant errors where
returned statuses should be enough in case of failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/chnl_sm.c        |   23 +--------
 drivers/dsp/bridge/wmd/io_sm.c          |   45 +-----------------
 drivers/dsp/bridge/wmd/tiomap3430.c     |   77 +++++-------------------------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   32 +------------
 drivers/dsp/bridge/wmd/tiomap_io.c      |   27 ++--------
 drivers/dsp/bridge/wmd/ue_deh.c         |    3 -
 6 files changed, 26 insertions(+), 181 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 08bd09d..5020e37 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -142,18 +142,12 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
 		pHostSysBuf = MEM_Alloc(cBufSize, MEM_NONPAGED);
 		if (pHostSysBuf == NULL) {
 			status = DSP_EMEMORY;
-			DBG_Trace(DBG_LEVEL7,
-				 "No memory to allocate kernel buffer\n");
 			goto func_end;
 		}
 		if (CHNL_IsOutput(pChnl->uMode)) {
 			status = copy_from_user(pHostSysBuf, pHostBuf,
 						cBufSize);
 			if (status) {
-				DBG_Trace(DBG_LEVEL7,
-					 "Error copying user buffer to "
-					 "kernel, %d bytes remaining.\n",
-					 status);
 				kfree(pHostSysBuf);
 				pHostSysBuf = NULL;
 				status = DSP_EPOINTER;
@@ -670,8 +664,6 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
 		/* If the addr is in user mode, then copy it */
 		if (!pHostSysBuf || !ioc.pBuf) {
 			status = DSP_EPOINTER;
-			DBG_Trace(DBG_LEVEL7,
-				 "System buffer NULL in IO completion.\n");
 			goto func_cont;
 		}
 		if (!CHNL_IsInput(pChnl->uMode))
@@ -680,22 +672,11 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
 		/*pHostUserBuf */
 		status = copy_to_user(ioc.pBuf, pHostSysBuf, ioc.cBytes);
 		if (status) {
-			if (current->flags & PF_EXITING) {
+			if (current->flags & PF_EXITING)
 				status = 0;
-			} else {
-				DBG_Trace(DBG_LEVEL7,
-					 "\n2current->flags != PF_EXITING, "
-					 " current->flags;0x%x\n",
-					 current->flags);
-			}
 		}
-		if (status) {
-			DBG_Trace(DBG_LEVEL7,
-				 "Error copying kernel buffer to user, %d"
-				 " bytes remaining.  in_interupt %d\n",
-				 status, in_interrupt());
+		if (status)
 			status = DSP_EPOINTER;
-		}
 func_cont1:
 		kfree(pHostSysBuf);
 	}
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 55ec6ef..ab7607f 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -497,11 +497,6 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 
 		if ((ulSegSize + ulSeg1Size + ulPadSize) >
 		   hostRes.dwMemLength[1]) {
-			DBG_Trace(DBG_LEVEL7, "ulGppPa %x, ulGppVa %x, ulDspVa "
-				 "%x, ulShm0End %x, ulDynExtBase %x, ulExtEnd "
-				 "%x, ulSegSize %x, ulSeg1Size %x \n", ulGppPa,
-				 ulGppVa, ulDspVa, ulShm0End, ulDynExtBase,
-				 ulExtEnd, ulSegSize, ulSeg1Size);
 			DBG_Trace(DBG_LEVEL7, "Insufficient SHM Reserved 0x%x. "
 				 "Required 0x%x\n", hostRes.dwMemLength[1],
 				 ulSegSize + ulSeg1Size + ulPadSize);
@@ -1532,7 +1527,6 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		/* Copy uMsgs messages into shared memory */
 		for (i = 0; i < uMsgs; i++) {
 			if (!hMsgMgr->msgUsedList) {
-				DBG_Trace(DBG_LEVEL3, "msgUsedList is NULL\n");
 				pMsg = NULL;
 				goto func_end;
 			} else {
@@ -1568,8 +1562,6 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 				LST_PutTail(hMsgMgr->msgFreeList,
 					   (struct list_head *)pMsg);
 				SYNC_SetEvent(hMsgMgr->hSyncEvent);
-			} else {
-				DBG_Trace(DBG_LEVEL3, "pMsg is NULL\n");
 			}
 		}
 
@@ -1650,13 +1642,6 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 		if (DSP_SUCCEEDED(status)) {
 			status = CMM_UnRegisterGPPSMSeg(hIOMgr->hCmmMgr,
 				 CMM_ALLSEGMENTS);
-			if (DSP_FAILED(status)) {
-				DBG_Trace(DBG_LEVEL7, "ERROR - Unable to "
-					 "Un-Register SM segments \n");
-			}
-		} else {
-			DBG_Trace(DBG_LEVEL7, "ERROR - Unable to get CMM "
-				 "Handle \n");
 		}
 	}
 	/* Register new SM region(s) */
@@ -1711,10 +1696,6 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 			 CMM_ADDTODSPPA : CMM_SUBFROMDSPPA,
 			 (u32)(ulShm0_Base * hIOMgr->uWordSize),
 			 ulDSPSize, &ulShmSegId0, dwGPPBaseVA);
-		if (DSP_FAILED(status)) {
-			DBG_Trace(DBG_LEVEL7, "ERROR - Failed to register SM "
-				 "Seg 0 \n");
-		}
 		/* First SM region is segId = 1 */
 		if (ulShmSegId0 != 1)
 			status = DSP_EFAIL;
@@ -1925,10 +1906,8 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 
 	/* Tmp workspace, 1 KB longer than input buf */
 	lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
-	if (lpTmpBuf == NULL) {
-		DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
+	if (lpTmpBuf == NULL)
 		status = DSP_EMEMORY;
-	}
 
 	if (DSP_SUCCEEDED(status)) {
 		lpBufStart = lpBuf;
@@ -1997,25 +1976,14 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 					    pWmdContext->hDevObject;
 
 	status = DEV_GetCodMgr(pDevObject, &hCodMgr);
-	if (DSP_FAILED(status))
-		GT_0trace(dsp_trace_mask, GT_2CLASS,
-			"PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");
 
 	if (DSP_SUCCEEDED(status)) {
 		/* Look for SYS_PUTCBEG/SYS_PUTCEND */
 		status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
-		if (DSP_FAILED(status))
-			GT_0trace(dsp_trace_mask, GT_2CLASS,
-				"PrintDspTraceBuffer: Failed on "
-				"COD_GetSymValue.\n");
 	}
-	if (DSP_SUCCEEDED(status)) {
+	if (DSP_SUCCEEDED(status))
 		status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
-		 if (DSP_FAILED(status))
-			GT_0trace(dsp_trace_mask, GT_2CLASS,
-				"PrintDspTraceBuffer: Failed on "
-				"COD_GetSymValue.\n");
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
 		/*
@@ -2039,10 +2007,6 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 			status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
 				(u8 *)pszBuf, (u32)ulTraceBegin,
 				ulNumBytes, 0);
-			if (DSP_FAILED(status))
-				GT_0trace(dsp_trace_mask, GT_2CLASS,
-					"PrintDspTraceBuffer: "
-					"Failed to Read Trace Buffer.\n");
 
 			if (DSP_SUCCEEDED(status)) {
 				/* Pack and do newline conversion */
@@ -2053,9 +2017,6 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 			kfree(pszBuf);
 			kfree(lpszBuf);
 		} else {
-			  GT_0trace(dsp_trace_mask, GT_2CLASS,
-				"PrintDspTraceBuffer: Failed to "
-				"allocate trace buffer.\n");
 			  status = DSP_EMEMORY;
 		}
 	}
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index ce8e619..a8dbbfe 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -371,8 +371,6 @@ static DSP_STATUS WMD_BRD_Read(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 dspBaseAddr = hDevContext->dwDspBaseAddr;
 
 	if (dwDSPAddr < pDevContext->dwDSPStartAdd) {
-		DBG_Trace(DBG_LEVEL7,
-			  "WMD_BRD_Read: DSP address < start address \n ");
 		status = DSP_EFAIL;
 		return status;
 	}
@@ -577,8 +575,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 				    CLK_Set_32KHz(BPWR_Clks[clkIdIndex].funClk);
 			} else {
 				status = DSP_EFAIL;
-				DBG_Trace(DBG_LEVEL7, " Error while setting"
-							"LM Timer  to 32KHz\n");
 			}
 			uClkCmd = (BPWR_EnableClock << MBX_PM_CLK_CMDSHIFT) |
 				  ulLoadMonitorTimer;
@@ -614,8 +610,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 						BPWR_Clks[clkIdIndex].funClk);
 			} else {
 				status = DSP_EFAIL;
-				DBG_Trace(DBG_LEVEL7,
-				" Error while setting BIOS Timer  to 32KHz\n");
 			}
 
 			uClkCmd = (BPWR_EnableClock << MBX_PM_CLK_CMDSHIFT) |
@@ -698,11 +692,9 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 		/* Wait for DSP to clear word in shared memory */
 		/* Read the Location */
-		if (!WaitForStart(pDevContext, dwSyncAddr)) {
+		if (!WaitForStart(pDevContext, dwSyncAddr))
 			status = WMD_E_TIMEOUT;
-			DBG_Trace(DBG_LEVEL7,
-				 "WMD_BRD_Start Failed to Synchronize\n");
-		}
+
 		status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
 		if (DSP_SUCCEEDED(status)) {
 			IO_SHMsetting(hIOMgr, SHM_OPPINFO, NULL);
@@ -716,7 +708,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			/* (void)CHNLSM_EnableInterrupt(pDevContext);*/
 		} else {
 			pDevContext->dwBrdState = BRD_UNKNOWN;
-			DBG_Trace(DBG_LEVEL7, "Device not Started \n ");
 		}
 	}
 	return status;
@@ -751,12 +742,8 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 	status = CFG_GetHostResources(
 			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
 			&resources);
-	if (DSP_FAILED(status)) {
-		DBG_Trace(DBG_LEVEL7,
-			  "WMD_BRD_Stop: Get Host resources failed \n");
-		DBG_Trace(DBG_LEVEL1, "Device Stopp failed \n ");
+	if (DSP_FAILED(status))
 		return DSP_EFAIL;
-	}
 
 	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &dspPwrState);
 	if (dspPwrState != HW_PWR_STATE_OFF) {
@@ -766,11 +753,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		udelay(50);
 
 		clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
-		if (DSP_FAILED(clk_status)) {
-			DBG_Trace(DBG_LEVEL6,
-				 "\n WMD_BRD_Stop: CLK_Disable failed "
-				 "for iva2_fck\n");
-		}
+
 		/* IVA2 is not in OFF state */
 		/* Set PM_PWSTCTRL_IVA2  to OFF */
 		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
@@ -780,11 +763,6 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_SW_SUP_SLEEP);
 	} else {
 		clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
-		if (DSP_FAILED(clk_status)) {
-			DBG_Trace(DBG_LEVEL6,
-				 "\n WMD_BRD_Stop: Else loop CLK_Disable failed"
-				 " for iva2_fck\n");
-		}
 	}
 	udelay(10);
 	/* Release the Ext Base virtual Address as the next DSP Program
@@ -838,18 +816,12 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 	 * IVA2 */
 	status = CFG_GetHostResources(
 		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-	if (DSP_FAILED(status)) {
-		DBG_Trace(DBG_LEVEL7,
-			 "WMD_BRD_Stop: Get Host resources failed \n");
-		DBG_Trace(DBG_LEVEL1, "Device Delete failed \n ");
+	if (DSP_FAILED(status))
 		return DSP_EFAIL;
-	}
+
 	status = SleepDSP(pDevContext, PWR_EMERGENCYDEEPSLEEP, NULL);
 	clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
-	if (DSP_FAILED(clk_status)) {
-		DBG_Trace(DBG_LEVEL6, "\n WMD_BRD_Stop: CLK_Disable failed for"
-			  " iva2_fck\n");
-	}
+
 	/* Release the Ext Base virtual Address as the next DSP Program
 	 * may have a different load address */
 	if (pDevContext->dwDspExtBaseAddr)
@@ -897,8 +869,6 @@ static DSP_STATUS WMD_BRD_Write(struct WMD_DEV_CONTEXT *hDevContext,
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 
 	if (dwDSPAddr < pDevContext->dwDSPStartAdd) {
-		DBG_Trace(DBG_LEVEL7,
-			 "WMD_BRD_Write: DSP address < start address \n ");
 		status = DSP_EFAIL;
 		return status;
 	}
@@ -938,14 +908,12 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 	 *  state, which becomes the context for later calls into this WMD.  */
 	pDevContext = MEM_Calloc(sizeof(struct WMD_DEV_CONTEXT), MEM_NONPAGED);
 	if (!pDevContext) {
-		DBG_Trace(DBG_ENTER, "Failed to allocate mem  \n");
 		status = DSP_EMEMORY;
 		goto func_end;
 	}
 	status = CFG_GetHostResources(
 		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 	if (DSP_FAILED(status)) {
-		DBG_Trace(DBG_ENTER, "Failed to get host resources   \n");
 		status = DSP_EMEMORY;
 		goto func_end;
 	}
@@ -963,11 +931,9 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 	pDevContext->numTLBEntries = 0;
 	pDevContext->dwDspBaseAddr = (u32)MEM_LinearAddress((void *)
 			(pConfig->dwMemBase[3]), pConfig->dwMemLength[3]);
-	if (!pDevContext->dwDspBaseAddr) {
+	if (!pDevContext->dwDspBaseAddr)
 		status = DSP_EFAIL;
-		DBG_Trace(DBG_LEVEL7,
-			 "WMD_DEV_Create: failed to Map the API memory\n");
-	}
+
 	pPtAttrs = MEM_Calloc(sizeof(struct PgTableAttrs), MEM_NONPAGED);
 	if (pPtAttrs != NULL) {
 		/* Assuming that we use only DSP's memory map
@@ -1059,11 +1025,6 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 	if (DSP_SUCCEEDED(status)) {
 		/* Set the Clock Divisor for the DSP module */
 		status = CLK_Enable(SERVICESCLK_mailbox_ick);
-		if (DSP_FAILED(status)) {
-			DBG_Trace(DBG_LEVEL7,
-				 "WMD_DEV_create:Reset mail box and "
-				 "enable the clock Fail\n");
-		}
 		udelay(5);
 		/* 24xx-Linux MMU address is obtained from the host
 		 * resources struct */
@@ -1095,11 +1056,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 			}
 		}
 		kfree(pPtAttrs);
-
 		kfree(pDevContext);
-
-		DBG_Trace(DBG_LEVEL7,
-			 "WMD_DEV_Create Error Device  not created\n");
 	}
 func_end:
 	return status;
@@ -1154,7 +1111,6 @@ static DSP_STATUS WMD_DEV_Ctrl(struct WMD_DEV_CONTEXT *pDevContext, u32 dwCmd,
 		break;
 	default:
 		status = DSP_EFAIL;
-		DBG_Trace(DBG_LEVEL7, "Error in WMD_BRD_Ioctl \n");
 		break;
 	}
 	return status;
@@ -1332,8 +1288,6 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 			 * Mixedsize isn't enabled, so size can't be
 			 * zero here
 			 */
-			DBG_Trace(DBG_LEVEL7,
-				 "WMD_BRD_MemMap: MMU element size is zero\n");
 			return DSP_EINVALIDARG;
 		}
 	}
@@ -1414,12 +1368,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 			}
 			status = PteSet(pDevContext->pPtAttrs, pa,
 					va, HW_PAGE_SIZE_4KB, &hwAttrs);
-			if (DSP_FAILED(status)) {
-				DBG_Trace(DBG_LEVEL7,
-					"WMD_BRD_MemMap: FAILED IN VM_IO"
-					"PTESET \n");
+			if (DSP_FAILED(status))
 				break;
-			}
+
 			va += HW_PAGE_SIZE_4KB;
 			mpuAddr += HW_PAGE_SIZE_4KB;
 			pa += HW_PAGE_SIZE_4KB;
@@ -1443,11 +1394,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 				status = PteSet(pDevContext->pPtAttrs,
 					page_to_phys(mappedPage), va,
 					HW_PAGE_SIZE_4KB, &hwAttrs);
-				if (DSP_FAILED(status)) {
-					DBG_Trace(DBG_LEVEL7,
-					"WMD_BRD_MemMap: FAILED IN PTESET \n");
+				if (DSP_FAILED(status))
 					break;
-				}
+
 				va += HW_PAGE_SIZE_4KB;
 				ulMpuAddr += HW_PAGE_SIZE_4KB;
 			} else {
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 5acaf44..270655a 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -145,9 +145,6 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 				(*pdata->dsp_set_min_opp)(VDD1_OPP1);
 			status = DSP_SOK;
 #endif /* CONFIG_BRIDGE_DVFS */
-		} else {
-			DBG_Trace(DBG_LEVEL7,
-				 "handle_hibernation_fromDSP- FAILED\n");
 		}
 	}
 #endif
@@ -171,10 +168,8 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	enum HW_PwrState_t pwrState, targetPwrState;
 
 	/* Check if sleep code is valid */
-	if ((dwCmd != PWR_DEEPSLEEP) && (dwCmd != PWR_EMERGENCYDEEPSLEEP)) {
-		DBG_Trace(DBG_LEVEL7, "SleepDSP- Illegal sleep command\n");
+	if ((dwCmd != PWR_DEEPSLEEP) && (dwCmd != PWR_EMERGENCYDEEPSLEEP))
 		return DSP_EINVALIDARG;
-	}
 
 	status = CFG_GetHostResources(
 		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
@@ -254,7 +249,6 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		/* Turn off DSP Peripheral clocks  */
 		status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
 		if (DSP_FAILED(status)) {
-			DBG_Trace(DBG_LEVEL7, "SleepDSP- FAILED\n");
 			return status;
 		}
 #ifdef CONFIG_BRIDGE_DVFS
@@ -356,9 +350,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 	 * just return with failure when the CLK ID does not match */
 	/* DBC_Assert(clkIdIndex < MBX_PM_MAX_RESOURCES);*/
 	if (clkIdIndex == MBX_PM_MAX_RESOURCES) {
-		DBG_Trace(DBG_LEVEL7,
-			 "DSPPeripheralClkCtrl : Could n't get clock Id for"
-			 "clkid 0x%x \n", clkIdIndex);
 		/* return with a more meaningfull error code */
 		return DSP_EFAIL;
 	}
@@ -383,9 +374,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
 			(pDevContext->uDspPerClks) &=
 				(~((u32) (1 << clkIdIndex)));
-		} else {
-			DBG_Trace(DBG_LEVEL7, "DSPPeripheralClkCtrl : Failed "
-				 "to disable clk\n");
 		}
 		break;
 	case BPWR_EnableClock:
@@ -405,9 +393,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 		DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, true);
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
 			(pDevContext->uDspPerClks) |= (1 << clkIdIndex);
-		} else {
-			DBG_Trace(DBG_LEVEL7,
-				 "DSPPeripheralClkCtrl:Failed to Enable clk\n");
 		}
 		break;
 	default:
@@ -449,8 +434,6 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
 		return DSP_SOK;
 	} else {
-		DBG_Trace(DBG_LEVEL7, "PreScale_DSP: Failed - DSP BRD"
-			  " state in wrong state");
 		return DSP_EFAIL;
 	}
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
@@ -496,8 +479,6 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 			"PostScale_DSP: Wrote to shared memory Sent post"
 			" notification to DSP\n");
 	} else {
-		DBG_Trace(DBG_LEVEL7, "PostScale_DSP: Failed - DSP BRD state "
-			"in wrong state");
 		status = DSP_EFAIL;
 	}
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
@@ -539,18 +520,9 @@ DSP_STATUS DSP_PeripheralClocks_Disable(struct WMD_DEV_CONTEXT *pDevContext,
 				__raw_writel(value, resources.dwSysCtrlBase
 								+ 0x274);
 			}
-			if (DSP_FAILED(status)) {
-				DBG_Trace(DBG_LEVEL7,
-					 "Failed to Enable the DSP Peripheral"
-					 "Clk 0x%x \n", BPWR_Clks[clkIdx]);
-			}
+
 			/* Disables the functional clock of the periphearl */
 			status = CLK_Disable(BPWR_Clks[clkIdx].funClk);
-			if (DSP_FAILED(status)) {
-				DBG_Trace(DBG_LEVEL7,
-					 "Failed to Enable the DSP Peripheral"
-					 "Clk 0x%x \n", BPWR_Clks[clkIdx]);
-			}
 		}
 	}
 	return status;
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 2d32b26..d11d605 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -151,22 +151,16 @@ DSP_STATUS ReadExtDspData(struct WMD_DEV_CONTEXT *hDevContext,
 
 	/* This dwDspExtBaseAddr will get cleared only when the board is
 	* stopped. */
-				if (!pDevContext->dwDspExtBaseAddr) {
+				if (!pDevContext->dwDspExtBaseAddr)
 					status = DSP_EFAIL;
-					DBG_Trace(DBG_LEVEL7, "ReadExtDspData: "
-					"failed to Map the program memory\n");
-				}
 			}
 
 			dwBaseAddr = dwExtProgVirtMem;
 		}
 	}
 
-	if (!dwBaseAddr || !ulExtBase || !ulExtEnd) {
-		DBG_Trace(DBG_LEVEL7,
-		"Symbols missing for Ext Prog reading \n");
+	if (!dwBaseAddr || !ulExtBase || !ulExtEnd)
 		status = DSP_EFAIL;
-	}
 
 	offset = dwDSPAddr - ulExtBase;
 
@@ -346,30 +340,21 @@ DSP_STATUS WriteExtDspData(struct WMD_DEV_CONTEXT *pDevContext,
 			dwBaseAddr += pDevContext->dwDspExtBaseAddr;
 			/* This dwDspExtBaseAddr will get cleared only when
 			 * the board is stopped.  */
-			if (!pDevContext->dwDspExtBaseAddr) {
+			if (!pDevContext->dwDspExtBaseAddr)
 				retVal = DSP_EFAIL;
-				DBG_Trace(DBG_LEVEL7, "WriteExtDspData: failed "
-					 "to Map the program memory\n");
-			}
 		}
 	}
-	if (!dwBaseAddr || !ulExtBase || !ulExtEnd) {
-		DBG_Trace(DBG_LEVEL7, "Symbols missing for Ext Prog loading\n");
+	if (!dwBaseAddr || !ulExtBase || !ulExtEnd)
 		retVal = DSP_EFAIL;
-	}
+
 	if (DSP_SUCCEEDED(retVal)) {
 		for (i = 0; i < 4; i++)
 			remainByte[i] = 0x0;
 
 		dwOffset = dwDSPAddr - ulExtBase;
 		/* Also make sure the dwDSPAddr is < ulExtEnd */
-		if (dwDSPAddr > ulExtEnd || dwOffset > dwDSPAddr) {
-			DBG_Trace(DBG_LEVEL7, "We can not load at this address "
-				 "dwDSPAddr=0x%x, ulExt/DynBase=0x%x, "
-				 "ulExtEnd=0x%x\n", dwDSPAddr, ulExtBase,
-				 ulExtEnd);
+		if (dwDSPAddr > ulExtEnd || dwOffset > dwDSPAddr)
 			retVal = DSP_EFAIL;
-		}
 	}
 	if (DSP_SUCCEEDED(retVal)) {
 		if (ulNumBytes)
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 032a6e3..031a1c8 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -189,9 +189,6 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 	status = CFG_GetHostResources(
 			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
 			&resources);
-	if (DSP_FAILED(status))
-		DBG_Trace(DBG_LEVEL7,
-			 "**Failed to get Host Resources in MMU ISR **\n");
 
 	if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {
 		printk(KERN_INFO "WMD_DEH_Notify: ********** DEVICE EXCEPTION "
-- 
1.6.2.4


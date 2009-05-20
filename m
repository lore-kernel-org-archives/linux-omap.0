From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 09/14] DSPBRIDGE: Fixing indentation
Date: Wed, 20 May 2009 00:02:15 -0500
Message-ID: <1242795740-21535-9-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
 <1242795740-21535-7-git-send-email-x00omar@ti.com>
 <1242795740-21535-8-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40807 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbZETE6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 00:58:35 -0400
In-Reply-To: <1242795740-21535-8-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Omar Ramirez Luna <omar.ramirez@ti.com>

Trivial patch to change spaces for tabs, and a proper indentation

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c     |  280 +++++++++++-----------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |  402 +++++++++++++++---------------
 2 files changed, 337 insertions(+), 345 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 2c372fc..afeeb2c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -188,7 +188,6 @@ struct PgTableAttrs {
  */
 extern s32 dsp_debug;
 
-
 /*
  *  This mini driver's function interface table.
  */
@@ -246,7 +245,7 @@ static struct WMD_DRV_INTERFACE drvInterfaceFxns = {
 
 static inline void tlb_flush_all(const void __iomem *base)
 {
-    __raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base + MMU_GFLUSH);
+	__raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base + MMU_GFLUSH);
 }
 
 static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
@@ -254,7 +253,8 @@ static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 	struct CFG_HOSTRES resources;
 	u32 temp = 0;
 
-	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+				&resources);
 	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
 
 	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF ||
@@ -291,9 +291,9 @@ void WMD_DRV_Entry(OUT struct WMD_DRV_INTERFACE **ppDrvInterface,
 	DBC_Require(pstrWMDFileName != NULL);
 	DBG_Trace(DBG_ENTER, "In the WMD_DRV_Entry \n");
 
-       IO_SM_init(); /* Initialization of io_sm module */
+	IO_SM_init(); /* Initialization of io_sm module */
 
-       if (strcmp(pstrWMDFileName, "UMA") == 0)
+	if (strcmp(pstrWMDFileName, "UMA") == 0)
 		*ppDrvInterface = &drvInterfaceFxns;
 	else
 		DBG_Trace(DBG_LEVEL7, "WMD_DRV_Entry Unknown WMD file name");
@@ -325,20 +325,19 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 
 	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
 	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
-    if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
+	if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
 		/* IVA2 is not in ON state */
 		/* Read and set PM_PWSTCTRL_IVA2  to ON */
 		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_ON);
 		/* Set the SW supervised state transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase,
-					   HW_SW_SUP_WAKEUP);
+		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_SW_SUP_WAKEUP);
 		/* Wait until the state has moved to ON */
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				     &pwrState);
 		/* Disable Automatic transition */
-	HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_AUTOTRANS_DIS);
+		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_AUTOTRANS_DIS);
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - Middle ****** \n");
 	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
@@ -347,7 +346,6 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 	if (DSP_SUCCEEDED(status)) {
 		/* set the device state to IDLE */
 		pDevContext->dwBrdState = BRD_IDLE;
-
 	}
 error_return:
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - End ****** \n");
@@ -449,7 +447,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 	DBG_Trace(DBG_ENTER, "Entering WMD_BRD_Start:\n hDevContext: 0x%x\n\t "
 			     "dwDSPAddr: 0x%x\n", hDevContext, dwDSPAddr);
 
-	 /* The device context contains all the mmu setup info from when the
+	/* The device context contains all the mmu setup info from when the
 	 * last dsp base image was loaded. The first entry is always
 	 * SHMMEM base. */
 	/* Get SHM_BEG - convert to byte address */
@@ -518,23 +516,23 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		for (iEntryNdx = 0; iEntryNdx < WMDIOCTL_NUMOFMMUTLB;
 			iEntryNdx++) {
 			if ((pDevContext->aTLBEntry[iEntryNdx].ulGppPa != 0) &&
-                               (pDevContext->aTLBEntry[iEntryNdx].ulDspVa != 0)) {
+			   (pDevContext->aTLBEntry[iEntryNdx].ulDspVa != 0)) {
 				DBG_Trace(DBG_LEVEL4, "** (proc) MMU %d GppPa:"
-                                       " 0x%x DspVa 0x%x Size 0x%x\n",
-                                       itmpEntryNdx,
-                                       pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
-                                       pDevContext->aTLBEntry[iEntryNdx].ulDspVa,
-                                       pDevContext->aTLBEntry[iEntryNdx].ulSize);
+				    " 0x%x DspVa 0x%x Size 0x%x\n",
+				    itmpEntryNdx,
+				    pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
+				    pDevContext->aTLBEntry[iEntryNdx].ulDspVa,
+				    pDevContext->aTLBEntry[iEntryNdx].ulSize);
 				configureDspMmu(pDevContext,
-                                       pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
-                                       pDevContext->aTLBEntry[iEntryNdx].ulDspVa *
-						DSPWORDSIZE,
-                                       pDevContext->aTLBEntry[iEntryNdx].ulSize,
-                                       itmpEntryNdx,
-                                       pDevContext->aTLBEntry[iEntryNdx].endianism,
-                                       pDevContext->aTLBEntry[iEntryNdx].elemSize,
-                                       pDevContext->aTLBEntry[iEntryNdx].
-						mixedMode);
+				    pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
+				    pDevContext->aTLBEntry[iEntryNdx].ulDspVa *
+				    DSPWORDSIZE,
+				    pDevContext->aTLBEntry[iEntryNdx].ulSize,
+				    itmpEntryNdx,
+				    pDevContext->aTLBEntry[iEntryNdx].endianism,
+				    pDevContext->aTLBEntry[iEntryNdx].elemSize,
+				    pDevContext->aTLBEntry[iEntryNdx].
+				    mixedMode);
 				itmpEntryNdx++;
 			}
 		}		/* end for */
@@ -575,13 +573,13 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			uClkCmd = (BPWR_DisableClock << MBX_PM_CLK_CMDSHIFT) |
 						ulLoadMonitorTimer;
 			DBG_Trace(DBG_LEVEL7,
-                                       "encoded LoadMonitor cmd for Disable: 0x%x\n",
-                                       uClkCmd);
+			       "encoded LoadMonitor cmd for Disable: 0x%x\n",
+			       uClkCmd);
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 			extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
 			for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES;
-                                       tmpIndex++) {
+				       tmpIndex++) {
 				if (extClkId == BPWR_CLKID[tmpIndex]) {
 					clkIdIndex = tmpIndex;
 					break;
@@ -649,7 +647,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 		} else {
 		DBG_Trace(DBG_LEVEL7,
-                               "Not able to get the symbol for BIOS Timer\n");
+			       "Not able to get the symbol for BIOS Timer\n");
 		}
 	}
 
@@ -657,12 +655,12 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		/* Set the DSP clock rate */
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
 					"_BRIDGEINIT_DSP_FREQ", &ulDspClkAddr);
-               /*Set Autoidle Mode for IVA2 PLL */
-               temp = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwCmBase) + 0x34));
-               temp = (temp & 0xFFFFFFFE) | 0x1;
-               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
-                       (u32) temp;
+		/*Set Autoidle Mode for IVA2 PLL */
+		temp = (u32) *((REG_UWORD32 *)
+			((u32) (resources.dwCmBase) + 0x34));
+		temp = (temp & 0xFFFFFFFE) | 0x1;
+		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
+			(u32) temp;
 		DBG_Trace(DBG_LEVEL5, "WMD_BRD_Start: _BRIDGE_DSP_FREQ Addr:"
 				"0x%x \n", ulDspClkAddr);
 		if ((unsigned int *)ulDspClkAddr != NULL) {
@@ -676,32 +674,31 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 				 ulDspClkAddr, sizeof(u32), 0);
 		}
 /*PM_IVA2GRPSEL_PER = 0xC0;*/
-               temp = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               temp = (temp & 0xFFFFFF30) | 0xC0;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8)) =
-                       (u32) temp;
+		temp = (u32) *((REG_UWORD32 *)
+			((u32) (resources.dwPerPmBase) + 0xA8));
+		temp = (temp & 0xFFFFFF30) | 0xC0;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8)) =
+			(u32) temp;
 
 /*PM_MPUGRPSEL_PER &= 0xFFFFFF3F;*/
-               temp = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               temp = (temp & 0xFFFFFF3F);
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4)) =
-                       (u32) temp;
+		temp = (u32) *((REG_UWORD32 *)
+			((u32) (resources.dwPerPmBase) + 0xA4));
+		temp = (temp & 0xFFFFFF3F);
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4)) =
+			(u32) temp;
 /*CM_SLEEPDEP_PER |= 0x04;*/
-               temp = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerBase) + 0x44));
-               temp = (temp & 0xFFFFFFFB) | 0x04;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerBase) + 0x44)) =
-                       (u32) temp;
+		temp = (u32) *((REG_UWORD32 *)
+			((u32) (resources.dwPerBase) + 0x44));
+		temp = (temp & 0xFFFFFFFB) | 0x04;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerBase) + 0x44)) =
+			(u32) temp;
 
 /*CM_CLKSTCTRL_IVA2 = 0x00000003 -To Allow automatic transitions*/
-               temp = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwCmBase) + 0x48));
-               temp = (temp & 0xFFFFFFFC) | 0x03;
-               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x48)) =
-                       (u32) temp;
-
+		temp = (u32) *((REG_UWORD32 *)
+			((u32) (resources.dwCmBase) + 0x48));
+		temp = (temp & 0xFFFFFFFC) | 0x03;
+		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x48)) =
+			(u32) temp;
 
 		/* Enable Mailbox events and also drain any pending
 		 * stale messages */
@@ -811,16 +808,11 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 
 	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &dspPwrState);
 	if (dspPwrState != HW_PWR_STATE_OFF) {
-
-			CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
-
-			mdelay(10);
-
-			GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
-
+		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
+		mdelay(10);
+		GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
 		run_IdleBoot(resources.dwPrmBase, resources.dwCmBase,
-			     resources.dwSysCtrlBase);
-
+				resources.dwSysCtrlBase);
 		udelay(50);
 
 		clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
@@ -828,15 +820,14 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 			DBG_Trace(DBG_LEVEL6,
 				 "\n WMD_BRD_Stop: CLK_Disable failed "
 				 "for iva2_fck\n");
-			}
+		}
 		/* IVA2 is not in OFF state */
 		/* Set PM_PWSTCTRL_IVA2  to OFF */
 		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_OFF);
 		/* Set the SW supervised state transition for Sleep */
-		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase,
-					   HW_SW_SUP_SLEEP);
+		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_SW_SUP_SLEEP);
 	} else {
 		clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
 		if (DSP_FAILED(clk_status)) {
@@ -861,9 +852,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		memset((u8 *) pPtAttrs->pgInfo, 0x00,
 		       (pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
-
-		DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
-
+	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
 	return status;
 }
 
@@ -1046,33 +1035,36 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 		/* we like to get aligned on L1 table size */
 		pg_tbl_va = (u32)MEM_AllocPhysMem(pPtAttrs->L1size,
 		    align_size, &pg_tbl_pa);
-	/* Check if the PA is aligned for us */
-	if ((pg_tbl_pa) & (align_size-1)) {
-                       /* PA not aligned to page table size ,
-                       * try with more allocation and align */
-                       MEM_FreePhysMem((void *)pg_tbl_va, pg_tbl_pa, pPtAttrs->L1size);
-                       /* we like to get aligned on L1 table size */
-                       pg_tbl_va = (u32) MEM_AllocPhysMem((pPtAttrs->L1size)*2,
-                       align_size, &pg_tbl_pa);
-                       /* We should be able to get aligned table now */
-                       pPtAttrs->L1TblAllocPa = pg_tbl_pa;
-                       pPtAttrs->L1TblAllocVa = pg_tbl_va;
-                       pPtAttrs->L1TblAllocSz = pPtAttrs->L1size * 2;
-                       /* Align the PA to the next 'align'  boundary */
-                       pPtAttrs->L1BasePa = ((pg_tbl_pa) + (align_size-1)) &
-				 (~(align_size-1));
-                       pPtAttrs->L1BaseVa = pg_tbl_va + (pPtAttrs->L1BasePa -
-				 pg_tbl_pa);
-	} else {
-                       /* We got aligned PA, cool */
-                       pPtAttrs->L1TblAllocPa = pg_tbl_pa;
-                       pPtAttrs->L1TblAllocVa = pg_tbl_va;
-                       pPtAttrs->L1TblAllocSz = pPtAttrs->L1size;
-                       pPtAttrs->L1BasePa = pg_tbl_pa;
-                       pPtAttrs->L1BaseVa = pg_tbl_va;
-	}
-       if (pPtAttrs->L1BaseVa)
-                       memset((u8 *)pPtAttrs->L1BaseVa, 0x00, pPtAttrs->L1size);
+
+		/* Check if the PA is aligned for us */
+		if ((pg_tbl_pa) & (align_size-1)) {
+			/* PA not aligned to page table size ,
+			 * try with more allocation and align */
+			MEM_FreePhysMem((void *)pg_tbl_va, pg_tbl_pa,
+					pPtAttrs->L1size);
+			/* we like to get aligned on L1 table size */
+			pg_tbl_va = (u32) MEM_AllocPhysMem((pPtAttrs->L1size)*2,
+					align_size, &pg_tbl_pa);
+			/* We should be able to get aligned table now */
+			pPtAttrs->L1TblAllocPa = pg_tbl_pa;
+			pPtAttrs->L1TblAllocVa = pg_tbl_va;
+			pPtAttrs->L1TblAllocSz = pPtAttrs->L1size * 2;
+			/* Align the PA to the next 'align'  boundary */
+			pPtAttrs->L1BasePa = ((pg_tbl_pa) + (align_size-1)) &
+				(~(align_size-1));
+			pPtAttrs->L1BaseVa = pg_tbl_va + (pPtAttrs->L1BasePa -
+				pg_tbl_pa);
+		} else {
+			/* We got aligned PA, cool */
+			pPtAttrs->L1TblAllocPa = pg_tbl_pa;
+			pPtAttrs->L1TblAllocVa = pg_tbl_va;
+			pPtAttrs->L1TblAllocSz = pPtAttrs->L1size;
+			pPtAttrs->L1BasePa = pg_tbl_pa;
+			pPtAttrs->L1BaseVa = pg_tbl_va;
+		}
+		if (pPtAttrs->L1BaseVa)
+			memset((u8 *)pPtAttrs->L1BaseVa, 0x00,
+				pPtAttrs->L1size);
 
 		/* number of L2 page tables = DMM pool used + SHMMEM +EXTMEM +
 		 * L4 pages */
@@ -1083,16 +1075,17 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 		/* we like to get aligned on L1 table size */
 		pg_tbl_va = (u32)MEM_AllocPhysMem(pPtAttrs->L2size,
 			    align_size, &pg_tbl_pa);
-	pPtAttrs->L2TblAllocPa = pg_tbl_pa;
-	pPtAttrs->L2TblAllocVa = pg_tbl_va;
-	pPtAttrs->L2TblAllocSz = pPtAttrs->L2size;
-	pPtAttrs->L2BasePa = pg_tbl_pa;
-	pPtAttrs->L2BaseVa = pg_tbl_va;
+		pPtAttrs->L2TblAllocPa = pg_tbl_pa;
+		pPtAttrs->L2TblAllocVa = pg_tbl_va;
+		pPtAttrs->L2TblAllocSz = pPtAttrs->L2size;
+		pPtAttrs->L2BasePa = pg_tbl_pa;
+		pPtAttrs->L2BaseVa = pg_tbl_va;
 
-       if (pPtAttrs->L2BaseVa)
-                       memset((u8 *)pPtAttrs->L2BaseVa, 0x00, pPtAttrs->L2size);
+		if (pPtAttrs->L2BaseVa)
+			memset((u8 *)pPtAttrs->L2BaseVa, 0x00,
+				pPtAttrs->L2size);
 
-	pPtAttrs->pgInfo = MEM_Calloc(pPtAttrs->L2NumPages *
+		pPtAttrs->pgInfo = MEM_Calloc(pPtAttrs->L2NumPages *
 				sizeof(struct PageInfo), MEM_NONPAGED);
 		DBG_Trace(DBG_LEVEL1, "L1 pa %x, va %x, size %x\n L2 pa %x, va "
 			 "%x, size %x\n", pPtAttrs->L1BasePa,
@@ -1196,7 +1189,6 @@ static DSP_STATUS WMD_DEV_Ctrl(struct WMD_DEV_CONTEXT *pDevContext, u32 dwCmd,
 		/* store away dsp-mmu setup values for later use */
 		for (ndx = 0; ndx < WMDIOCTL_NUMOFMMUTLB; ndx++, paExtProc++)
 			pDevContext->aTLBEntry[ndx] = *paExtProc;
-
 		break;
 	case WMDIOCTL_DEEPSLEEP:
 	case WMDIOCTL_EMERGENCYSLEEP:
@@ -1390,7 +1382,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 		hwAttrs.endianism = HW_LITTLE_ENDIAN;
 
 	hwAttrs.mixedSize = (enum HW_MMUMixedSize_t)
-                               ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
+			       ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
 	/* Ignore elementSize if mixedSize is enabled */
 	if (hwAttrs.mixedSize == 0) {
 		if (attrs & DSP_MAPELEMSIZE8) {
@@ -1457,9 +1449,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 		/* jump to the next VMA region */
 		vma = find_vma(mm, vma->vm_end + 1);
 		DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf ulMpuAddr=%x, "
-                       "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x\n",
-                       ulMpuAddr, ulNumBytes, vma->vm_start,
-                       vma->vm_end, vma->vm_flags);
+		       "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x\n",
+		       ulMpuAddr, ulNumBytes, vma->vm_start,
+		       vma->vm_end, vma->vm_flags);
 	}
 	if (!vma) {
 		DBG_Trace(DBG_LEVEL7, "Failed to get the VMA region for "
@@ -1861,7 +1853,7 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 	u32 pteSize;
 	u32 pgTblVa;      /* Base address of the PT that will be updated */
 	u32 L1BaseVa;
-	 /* Compiler warns that the next three variables might be used
+	/* Compiler warns that the next three variables might be used
 	 * uninitialized in this function. Doesn't seem so. Working around,
 	 * anyways.  */
 	u32 L2BaseVa = 0;
@@ -2035,7 +2027,7 @@ static DSP_STATUS run_IdleBoot(void __iomem *prm_base, void __iomem *cm_base,
 
 	/* Read PM_PWSTST_IVA2 */
 	HW_PWRST_IVA2RegGet(prm_base, &temp);
-	 if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
+	if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
 		/* IVA2 is not in ON state */
 		/* Set PM_PWSTCTRL_IVA2  to ON */
 		HW_PWR_IVA2PowerStateSet(prm_base, HW_PWR_DOMAIN_DSP,
@@ -2052,16 +2044,16 @@ static DSP_STATUS run_IdleBoot(void __iomem *prm_base, void __iomem *cm_base,
 	udelay(30);
 	/* set the SYSC for Idle Boot */
 	__raw_writel((u32)0x01, (sysctrl_base) + 0x404);
-               temp = (u32) *((REG_UWORD32 *)
-                               ((u32) (cm_base) + 0x34));
-               temp = (temp & 0xFFFFFFFE) | 0x1;
-               *((REG_UWORD32 *) ((u32) (cm_base) + 0x34)) =
-                       (u32) temp;
-               temp = (u32) *((REG_UWORD32 *)
-                       ((u32) (cm_base) + 0x4));
-               temp =  (temp & 0xFFFFFC8) | 0x37;
-               *((REG_UWORD32 *) ((u32) (cm_base) + 0x4)) =
-                       (u32) temp;
+	       temp = (u32) *((REG_UWORD32 *)
+			       ((u32) (cm_base) + 0x34));
+	       temp = (temp & 0xFFFFFFFE) | 0x1;
+	       *((REG_UWORD32 *) ((u32) (cm_base) + 0x34)) =
+		       (u32) temp;
+	       temp = (u32) *((REG_UWORD32 *)
+		       ((u32) (cm_base) + 0x4));
+	       temp =  (temp & 0xFFFFFC8) | 0x37;
+	       *((REG_UWORD32 *) ((u32) (cm_base) + 0x4)) =
+		       (u32) temp;
 	CLK_Enable(SERVICESCLK_iva2_ck);
 	udelay(20);
 	GetHWRegs(prm_base, cm_base);
@@ -2077,26 +2069,26 @@ static DSP_STATUS run_IdleBoot(void __iomem *prm_base, void __iomem *cm_base,
 static void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
 {
 	u32 temp;
-       temp = __raw_readl((cm_base) + 0x00);
-	   DBG_Trace(DBG_LEVEL6, "CM_FCLKEN_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((cm_base) + 0x10);
-	   DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((cm_base) + 0x20);
-	   DBG_Trace(DBG_LEVEL6, "CM_IDLEST_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((cm_base) + 0x48);
-	   DBG_Trace(DBG_LEVEL6, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((cm_base) + 0x4c);
-	   DBG_Trace(DBG_LEVEL6, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((prm_base) + 0x50);
-	   DBG_Trace(DBG_LEVEL6, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((prm_base) + 0x58);
-	   DBG_Trace(DBG_LEVEL6, "RM_RSTST_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((prm_base) + 0xE0);
-	   DBG_Trace(DBG_LEVEL6, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((prm_base) + 0xE4);
-	   DBG_Trace(DBG_LEVEL6, "PM_PWSTST_IVA2 = 0x%x \n", temp);
-       temp = __raw_readl((cm_base) + 0xA10);
-	   DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_CORE = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x00);
+	DBG_Trace(DBG_LEVEL6, "CM_FCLKEN_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x10);
+	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x20);
+	DBG_Trace(DBG_LEVEL6, "CM_IDLEST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x48);
+	DBG_Trace(DBG_LEVEL6, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x4c);
+	DBG_Trace(DBG_LEVEL6, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0x50);
+	DBG_Trace(DBG_LEVEL6, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0x58);
+	DBG_Trace(DBG_LEVEL6, "RM_RSTST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0xE0);
+	DBG_Trace(DBG_LEVEL6, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0xE4);
+	DBG_Trace(DBG_LEVEL6, "PM_PWSTST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0xA10);
+	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_CORE = 0x%x \n", temp);
 }
 
 /*
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index fa287b6..d9ee480 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -79,22 +79,22 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 *pConstraintVal;
-       DSP_STATUS status = DSP_SOK;
-       struct CFG_HOSTRES resources;
-       struct dspbridge_platform_data *pdata =
-	       omap_dspbridge_dev->dev.platform_data;
-       status = CFG_GetHostResources(
-                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+	DSP_STATUS status = DSP_SOK;
+	struct CFG_HOSTRES resources;
+	struct dspbridge_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
+	status = CFG_GetHostResources(
+		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 
 	pConstraintVal = (u32 *)(pArgs);
 	/* Read the target value requested by DSP  */
-       DBG_Trace(DBG_LEVEL7, "handle_constraints_set:"
-               "opp requested = 0x%x\n", (u32)*(pConstraintVal+1));
-       status = HW_MBOX_saveSettings(resources.dwMboxBase);
+	DBG_Trace(DBG_LEVEL7, "handle_constraints_set:"
+		"opp requested = 0x%x\n", (u32)*(pConstraintVal+1));
+	status = HW_MBOX_saveSettings(resources.dwMboxBase);
 
 	/* Set the new opp value */
 	if (pdata->dsp_set_min_opp)
-                       (*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
+		(*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
 	return DSP_SOK;
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 	return DSP_SOK;
@@ -230,7 +230,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		break;
 	case BRD_HIBERNATION:
 	case BRD_DSP_HIBERNATION:
-               status = HW_MBOX_saveSettings(resources.dwMboxBase);
+		status = HW_MBOX_saveSettings(resources.dwMboxBase);
 		/* Already in Hibernation, so just return */
 		DBG_Trace(DBG_LEVEL7, "SleepDSP- DSP already in "
 			 "hibernation\n");
@@ -308,17 +308,17 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 	status = DSP_PeripheralClocks_Enable(pDevContext, NULL);
 
 	/* Enabling Dppll in lock mode */
-               temp = (u32) *((REG_UWORD32 *)
-                       ((u32) (resources.dwCmBase) + 0x34));
-               temp = (temp & 0xFFFFFFFE) | 0x1;
-               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
-                                               (u32) temp;
-               temp = (u32) *((REG_UWORD32 *)
-                       ((u32) (resources.dwCmBase) + 0x4));
-               temp = (temp & 0xFFFFFC8) | 0x37;
-
-               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
-               (u32) temp;
+		temp = (u32) *((REG_UWORD32 *)
+			((u32) (resources.dwCmBase) + 0x34));
+		temp = (temp & 0xFFFFFFFE) | 0x1;
+		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
+						(u32) temp;
+		temp = (u32) *((REG_UWORD32 *)
+			((u32) (resources.dwCmBase) + 0x4));
+		temp = (temp & 0xFFFFFC8) | 0x37;
+
+		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
+						(u32) temp;
 
 	udelay(10);
 	if (DSP_SUCCEEDED(status)) {
@@ -391,7 +391,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 			 "DSPPeripheralClkCtrl : Disable CLK for \n");
 		status1 = CLK_Disable(BPWR_Clks[clkIdIndex].intClk);
 		status = CLK_Disable(BPWR_Clks[clkIdIndex].funClk);
-               DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, false);
+		DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, false);
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
 			(pDevContext->uDspPerClks) &=
 				(~((u32) (1 << clkIdIndex)));
@@ -405,7 +405,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 			 "DSPPeripheralClkCtrl : Enable CLK for \n");
 		status1 = CLK_Enable(BPWR_Clks[clkIdIndex].intClk);
 		status = CLK_Enable(BPWR_Clks[clkIdIndex].funClk);
-               DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, true);
+		DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, true);
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
 			(pDevContext->uDspPerClks) |= (1 << clkIdIndex);
 		} else {
@@ -439,13 +439,13 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 
 	DBG_Trace(DBG_LEVEL7, "PreScale_DSP: voltage_domain = %x, level = "
 		 "0x%x\n", voltage_domain, level);
-       if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
-               (pDevContext->dwBrdState == BRD_RETENTION) ||
-               (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
+	if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
+			(pDevContext->dwBrdState == BRD_RETENTION) ||
+			(pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
 		DBG_Trace(DBG_LEVEL7, "PreScale_DSP: IVA in sleep. "
 			 "No notification to DSP\n");
 		return DSP_SOK;
-       } else if ((pDevContext->dwBrdState == BRD_RUNNING)) {
+	} else if ((pDevContext->dwBrdState == BRD_RUNNING)) {
 		/* Send a prenotificatio to DSP */
 		DBG_Trace(DBG_LEVEL7,
 			 "PreScale_DSP: Sent notification to DSP\n");
@@ -478,11 +478,11 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 	voltage_domain = *((u32 *)pArgs);
 	level = *((u32 *)pArgs + 1);
 	DBG_Trace(DBG_LEVEL7,
-               "PostScale_DSP: voltage_domain = %x, level = 0x%x\n",
-               voltage_domain, level);
-       if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
-                       (pDevContext->dwBrdState == BRD_RETENTION) ||
-                       (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
+		"PostScale_DSP: voltage_domain = %x, level = 0x%x\n",
+		voltage_domain, level);
+	if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
+			(pDevContext->dwBrdState == BRD_RETENTION) ||
+			(pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
 		/* Update the OPP value in shared memory */
 		IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
 		DBG_Trace(DBG_LEVEL7,
@@ -495,12 +495,12 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 		/* Send a post notification to DSP */
 		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
 		DBG_Trace(DBG_LEVEL7,
-                       "PostScale_DSP: Wrote to shared memory Sent post"
-                       " notification to DSP\n");
+			"PostScale_DSP: Wrote to shared memory Sent post"
+			" notification to DSP\n");
 		return DSP_SOK;
 	} else {
 		DBG_Trace(DBG_LEVEL7, "PostScale_DSP: Failed - DSP BRD state "
-                       "in wrong state");
+			"in wrong state");
 		return DSP_EFAIL;
 	}
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
@@ -564,169 +564,169 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
 
 void DSPClkWakeupEventCtrl(u32 ClkId, bool enable)
 {
-       struct CFG_HOSTRES resources;
-       DSP_STATUS status = DSP_SOK;
-       u32 iva2_grpsel;
-       u32 mpu_grpsel;
-
-       status = CFG_GetHostResources(
-                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-       if (DSP_FAILED(status))
-               return;
-
-       switch (ClkId) {
-       case BPWR_GPTimer5:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_GPT5;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT5;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_GPT5;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT5;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
-                               = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
-                               = mpu_grpsel;
-       break;
-       case BPWR_GPTimer6:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_GPT6;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT6;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_GPT6;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT6;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       case BPWR_GPTimer7:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_GPT7;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT7;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_GPT7;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT7;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       case BPWR_GPTimer8:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_GPT8;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT8;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_GPT8;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT8;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       case BPWR_MCBSP1:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwCorePmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwCorePmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP1;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP1;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP1;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP1;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       case BPWR_MCBSP2:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP2;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP2;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP2;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP2;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       case BPWR_MCBSP3:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP3;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP3;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP3;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP3;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       case BPWR_MCBSP4:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwPerPmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP4;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP4;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP4;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP4;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       case BPWR_MCBSP5:
-               iva2_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwCorePmBase) + 0xA8));
-               mpu_grpsel = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwCorePmBase) + 0xA4));
-               if (enable) {
-                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP5;
-                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP5;
-               } else {
-                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP5;
-                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP5;
-               }
-               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA8))
-                                                       = iva2_grpsel;
-               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA4))
-                                                       = mpu_grpsel;
-       break;
-       }
+	struct CFG_HOSTRES resources;
+	DSP_STATUS status = DSP_SOK;
+	u32 iva2_grpsel;
+	u32 mpu_grpsel;
+
+	status = CFG_GetHostResources(
+		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+	if (DSP_FAILED(status))
+		return;
+
+	switch (ClkId) {
+	case BPWR_GPTimer5:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_GPT5;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_GPT5;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_GPT5;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_GPT5;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+				= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+				= mpu_grpsel;
+	break;
+	case BPWR_GPTimer6:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_GPT6;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_GPT6;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_GPT6;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_GPT6;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	case BPWR_GPTimer7:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_GPT7;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_GPT7;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_GPT7;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_GPT7;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	case BPWR_GPTimer8:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_GPT8;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_GPT8;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_GPT8;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_GPT8;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	case BPWR_MCBSP1:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwCorePmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwCorePmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_MCBSP1;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP1;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_MCBSP1;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP1;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	case BPWR_MCBSP2:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_MCBSP2;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP2;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_MCBSP2;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP2;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	case BPWR_MCBSP3:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_MCBSP3;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP3;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_MCBSP3;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP3;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	case BPWR_MCBSP4:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwPerPmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_MCBSP4;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP4;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_MCBSP4;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP4;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	case BPWR_MCBSP5:
+		iva2_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwCorePmBase) + 0xA8));
+		mpu_grpsel = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwCorePmBase) + 0xA4));
+		if (enable) {
+			iva2_grpsel |= OMAP3430_GRPSEL_MCBSP5;
+			mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP5;
+		} else {
+			mpu_grpsel |= OMAP3430_GRPSEL_MCBSP5;
+			iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP5;
+		}
+		*((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA8))
+							= iva2_grpsel;
+		*((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA4))
+							= mpu_grpsel;
+	break;
+	}
 }
-- 
1.6.2.4


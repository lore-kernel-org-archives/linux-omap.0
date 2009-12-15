From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 16/17] DSPBRIDGE: Avoid REGistry if pDevContext is available
Date: Tue, 15 Dec 2009 00:19:57 -0600
Message-ID: <1260857998-19349-17-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43257 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbZLOGMz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:55 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Avoid calls to read the register if pDevContext is available
to the function, this will save a call to query and hold
a semaphore under registry operations.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    2 +-
 drivers/dsp/bridge/rmgr/drv.c                  |    2 +-
 drivers/dsp/bridge/wmd/_tiomap.h               |    8 +-
 drivers/dsp/bridge/wmd/mmu_fault.c             |   24 +---
 drivers/dsp/bridge/wmd/tiomap3430.c            |  182 +++++++++++-------------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |  106 +++++----------
 drivers/dsp/bridge/wmd/tiomap_sm.c             |   50 +++----
 drivers/dsp/bridge/wmd/ue_deh.c                |   15 +--
 8 files changed, 156 insertions(+), 233 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 0155e13..bce1c5e 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -90,7 +90,7 @@
 		void __iomem *dwPrmBase;
 		void __iomem *dwCmBase;
 		void __iomem *dwPerBase;
-		u32 dwPerPmBase;
+		void __iomem *dwPerPmBase;
 		u32 dwCorePmBase;
 		void __iomem *dwWdTimerDspBase;
 		void __iomem *dwMboxBase;
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 74388d5..a485d03 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1807,7 +1807,7 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 							OMAP_DSP_MEM3_SIZE);
 		pResources->dwPerBase = ioremap(OMAP_PER_CM_BASE,
 							OMAP_PER_CM_SIZE);
-               pResources->dwPerPmBase = (u32)ioremap(OMAP_PER_PRM_BASE,
+		pResources->dwPerPmBase = ioremap(OMAP_PER_PRM_BASE,
                                                        OMAP_PER_PRM_SIZE);
                pResources->dwCorePmBase = (u32)ioremap(OMAP_CORE_PRM_BASE,
                                                        OMAP_CORE_PRM_SIZE);
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 96bf7d3..186f476 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -340,8 +340,12 @@ struct WMD_DEV_CONTEXT {
 	 */
 	u32 dwDspExtBaseAddr;	/* See the comment above        */
 	u32 dwAPIRegBase;	/* API memory mapped registers  */
-	void __iomem *dwDSPMmuBase;	/* DSP MMU Mapped registers     */
-	u32 dwMailBoxBase;	/* Mail box mapped registers    */
+	void __iomem *dwDSPMmuBase;	/* DSP MMU Mapped registers */
+	void __iomem *dwMailBoxBase;	/* Mail box mapped registers */
+	void __iomem *cmbase;			/* CM mapped registers */
+	void __iomem *sysctrlbase;		/* SysCtrl mapped registers */
+	void __iomem *prmbase;			/* PRM mapped registers	*/
+	void __iomem *perbase;			/* PER mapped registers	*/
 	u32 dwAPIClkBase;	/* CLK Registers                */
 	u32 dwDSPClkM2Base;	/* DSP Clock Module m2          */
 	u32 dwPublicRhea;	/* Pub Rhea                     */
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 5585cdb..147e5b3 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -90,24 +90,13 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 {
 	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)pRefData;
 	struct WMD_DEV_CONTEXT *pDevContext;
-	struct CFG_HOSTRES resources;
-	DSP_STATUS status = DSP_SOK;
-
 
 	DBG_Trace(DBG_LEVEL1, "Entering DEH_DspMmuIsr: 0x%x\n", pRefData);
        DBC_Require(irq == INT_DSP_MMU_IRQ);
 	DBC_Require(MEM_IsValidHandle(pDehMgr, SIGNATURE));
 
 	if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {
-
 		pDevContext = (struct WMD_DEV_CONTEXT *)pDehMgr->hWmdContext;
-		status = CFG_GetHostResources(
-			 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			 &resources);
-		if (DSP_FAILED(status))
-			DBG_Trace(DBG_LEVEL7,
-				 "**Failed to get Host Resources "
-				 "in MMU ISR **\n");
 		if (MMU_CheckIfFault(pDevContext)) {
 			printk(KERN_INFO "***** DSPMMU FAULT ***** IRQStatus "
 				"0x%x\n", dmmuEventMask);
@@ -128,13 +117,13 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 			pDehMgr->errInfo.dwVal3 = 0L;
 			/* Disable the MMU events, else once we clear it will
 			 * start to raise INTs again */
-			HW_MMU_EventDisable(resources.dwDmmuBase,
+			HW_MMU_EventDisable(pDevContext->dwDSPMmuBase,
 					    HW_MMU_TRANSLATION_FAULT);
 		} else {
 			DBG_Trace(DBG_LEVEL7,
 				 "***** MMU FAULT ***** faultcode 0x%x\n",
 				 dmmuEventMask);
-			HW_MMU_EventDisable(resources.dwDmmuBase,
+			HW_MMU_EventDisable(pDevContext->dwDSPMmuBase,
 					    HW_MMU_ALL_INTERRUPTS);
 		}
 	}
@@ -154,16 +143,15 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext)
 	bool retVal = false;
 	DSP_STATUS status = DSP_SOK;
 	HW_STATUS hwStatus;
-	struct CFG_HOSTRES resources;
-	status = CFG_GetHostResources(
-		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+
 	if (DSP_FAILED(status))
 		DBG_Trace(DBG_LEVEL7, "**Failed to get Host Resources in "
 			 "MMU_CheckIfFault **\n");
 
-	hwStatus = HW_MMU_EventStatus(resources.dwDmmuBase, &dmmuEventMask);
+	hwStatus = HW_MMU_EventStatus(pDevContext->dwDSPMmuBase,
+								&dmmuEventMask);
 	if (dmmuEventMask  ==  HW_MMU_TRANSLATION_FAULT) {
-		HW_MMU_FaultAddrRead(resources.dwDmmuBase, &faultAddr);
+		HW_MMU_FaultAddrRead(pDevContext->dwDSPMmuBase, &faultAddr);
 		DBG_Trace(DBG_LEVEL1, "WMD_DEH_Notify: DSP_MMUFAULT, fault "
 			 "address = 0x%x\n", faultAddr);
 		retVal = true;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index f41763c..0650a46 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -275,12 +275,9 @@ static inline void tlb_flush_all(const void __iomem *base)
 
 static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 {
-	struct CFG_HOSTRES resources;
 	u32 temp = 0;
 
-	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-				&resources);
-	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
+	HW_PWRST_IVA2RegGet(pDevContext->prmbase, &temp);
 
 	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF ||
 	    (temp & HW_PWR_STATE_ON) == HW_PWR_STATE_RET) {
@@ -336,47 +333,42 @@ void WMD_DRV_Entry(OUT struct WMD_DRV_INTERFACE **ppDrvInterface,
  */
 static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 {
-	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-	struct CFG_HOSTRES resources;
 	u32 temp;
 	enum HW_PwrState_t    pwrState;
 
 	DBG_Trace(DBG_ENTER, "Board in the monitor state  \n");
-	status = CFG_GetHostResources(
-		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-	if (DSP_FAILED(status))
-		goto error_return;
 
-	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
-	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
+	GetHWRegs(pDevContext->prmbase, pDevContext->cmbase);
+	HW_PWRST_IVA2RegGet(pDevContext->prmbase, &temp);
 	if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
 		/* IVA2 is not in ON state */
 		/* Read and set PM_PWSTCTRL_IVA2  to ON */
-		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
+		HW_PWR_IVA2PowerStateSet(pDevContext->prmbase,
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_ON);
 		/* Set the SW supervised state transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_SW_SUP_WAKEUP);
+		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase,
+							HW_SW_SUP_WAKEUP);
 		/* Wait until the state has moved to ON */
-		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
+		HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 				     &pwrState);
 		/* Disable Automatic transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(resources.dwCmBase, HW_AUTOTRANS_DIS);
+		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase,
+							HW_AUTOTRANS_DIS);
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - Middle ****** \n");
-	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
-	HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
+	GetHWRegs(pDevContext->prmbase, pDevContext->cmbase);
+	HW_RST_UnReset(pDevContext->prmbase, HW_RST2_IVA2);
 	CLK_Enable(SERVICESCLK_iva2_ck);
 
-	if (DSP_SUCCEEDED(status)) {
-		/* set the device state to IDLE */
-		pDevContext->dwBrdState = BRD_IDLE;
-	}
-error_return:
+	/* set the device state to IDLE */
+	pDevContext->dwBrdState = BRD_IDLE;
+
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - End ****** \n");
-	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
-	return status;
+	GetHWRegs(pDevContext->prmbase, pDevContext->cmbase);
+
+	return DSP_SOK;
 }
 
 /*
@@ -458,7 +450,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 ulShmOffsetVirt;	/* offset of ulShmBaseVirt from ulTLBBaseVirt */
 	s32 iEntryNdx;
 	s32 itmpEntryNdx = 0;	/* DSP-MMU TLB entry base address */
-	struct CFG_HOSTRES resources;
 	u32 temp;
 	u32 ulDspClkRate;
 	u32 ulDspClkAddr;
@@ -499,44 +490,36 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 	} else
 		*((volatile u32 *)dwSyncAddr) = 0xffffffff;
 
+	/* TODO: Reduce indentation as this can goto to end */
 	if (DSP_SUCCEEDED(status)) {
-		status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
 		/* Assert RST1 i.e only the RST only for DSP megacell  */
-		/* HW_RST_Reset(resources.dwPrcmBase, HW_RST1_IVA2);*/
-		if (DSP_SUCCEEDED(status)) {
-			HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
-			if (dsp_debug) {
-				/* Set the bootmode to self loop  */
-				DBG_Trace(DBG_LEVEL7,
-						"Set boot mode to self loop"
-						" for IVA2 Device\n");
-				HW_DSPSS_BootModeSet(resources.dwSysCtrlBase,
-					HW_DSPSYSC_SELFLOOPBOOT, dwDSPAddr);
-			} else {
-				/* Set the bootmode to '0' - direct boot */
-				DBG_Trace(DBG_LEVEL7,
-						"Set boot mode to direct"
-						" boot for IVA2 Device \n");
-				HW_DSPSS_BootModeSet(resources.dwSysCtrlBase,
-					HW_DSPSYSC_DIRECTBOOT, dwDSPAddr);
-			}
+		HW_RST_Reset(pDevContext->prmbase, HW_RST1_IVA2);
+		if (dsp_debug) {
+			/* Set the bootmode to self loop  */
+			DBG_Trace(DBG_LEVEL7,
+				"Set boot mode to self loop for IVA2 Device\n");
+			HW_DSPSS_BootModeSet(pDevContext->sysctrlbase,
+				HW_DSPSYSC_SELFLOOPBOOT, dwDSPAddr);
+		} else {
+			/* Set the bootmode to '0' - direct boot */
+			DBG_Trace(DBG_LEVEL7,
+					"Set boot mode to direct"
+					" boot for IVA2 Device \n");
+			HW_DSPSS_BootModeSet(pDevContext->sysctrlbase,
+				HW_DSPSYSC_DIRECTBOOT, dwDSPAddr);
 		}
-	}
-	if (DSP_SUCCEEDED(status)) {
 		/* Reset and Unreset the RST2, so that BOOTADDR is copied to
 		 * IVA2 SYSC register */
-		HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
+		HW_RST_Reset(pDevContext->prmbase, HW_RST2_IVA2);
 		udelay(100);
-		HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
+		HW_RST_UnReset(pDevContext->prmbase, HW_RST2_IVA2);
 		udelay(100);
 		DBG_Trace(DBG_LEVEL6, "WMD_BRD_Start 0 ****** \n");
-		GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
+		GetHWRegs(pDevContext->prmbase, pDevContext->cmbase);
 		/* Disbale the DSP MMU */
-		HW_MMU_Disable(resources.dwDmmuBase);
+		HW_MMU_Disable(pDevContext->dwDSPMmuBase);
 		/* Disable TWL */
-		HW_MMU_TWLDisable(resources.dwDmmuBase);
+		HW_MMU_TWLDisable(pDevContext->dwDSPMmuBase);
 
 		/* Only make TLB entry if both addresses are non-zero */
 		for (iEntryNdx = 0; iEntryNdx < WMDIOCTL_NUMOFMMUTLB;
@@ -562,39 +545,35 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 				itmpEntryNdx++;
 			}
 		}		/* end for */
-	}
 
-	/* Lock the above TLB entries and get the BIOS and load monitor timer
-	 * information*/
-	if (DSP_SUCCEEDED(status)) {
-		HW_MMU_NumLockedSet(resources.dwDmmuBase, itmpEntryNdx);
-		HW_MMU_VictimNumSet(resources.dwDmmuBase, itmpEntryNdx);
-		HW_MMU_TTBSet(resources.dwDmmuBase,
+		/*
+		 * Lock the above TLB entries and get the BIOS and load monitor
+		 * timer information
+		 */
+		HW_MMU_NumLockedSet(pDevContext->dwDSPMmuBase, itmpEntryNdx);
+		HW_MMU_VictimNumSet(pDevContext->dwDSPMmuBase, itmpEntryNdx);
+		HW_MMU_TTBSet(pDevContext->dwDSPMmuBase,
 				pDevContext->pPtAttrs->L1BasePa);
-		HW_MMU_TWLEnable(resources.dwDmmuBase);
-		/* Enable the SmartIdle and AutoIdle bit for MMU_SYSCONFIG */
+		HW_MMU_TWLEnable(pDevContext->dwDSPMmuBase);
 
-
-		temp = __raw_readl((resources.dwDmmuBase) + 0x10);
+		/* Enable the SmartIdle and AutoIdle bit for MMU_SYSCONFIG */
+		temp = __raw_readl((pDevContext->dwDSPMmuBase) + 0x10);
 		temp = (temp & 0xFFFFFFEF) | 0x11;
-		__raw_writel(temp, (resources.dwDmmuBase) + 0x10);
+		__raw_writel(temp, (pDevContext->dwDSPMmuBase) + 0x10);
 
 		/* Let the DSP MMU run */
-		HW_MMU_Enable(resources.dwDmmuBase);
+		HW_MMU_Enable(pDevContext->dwDSPMmuBase);
 
 		/* Enable the BIOS clock  */
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
-					BRIDGEINIT_BIOSGPTIMER,
-				     &ulBiosGpTimer);
+					BRIDGEINIT_BIOSGPTIMER, &ulBiosGpTimer);
 		DBG_Trace(DBG_LEVEL7, "BIOS GPTimer : 0x%x\n", ulBiosGpTimer);
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
 				BRIDGEINIT_LOADMON_GPTIMER,
-				     &ulLoadMonitorTimer);
+				&ulLoadMonitorTimer);
 		DBG_Trace(DBG_LEVEL7, "Load Monitor Timer : 0x%x\n",
 			  ulLoadMonitorTimer);
-	}
 
-	if (DSP_SUCCEEDED(status)) {
 		if (ulLoadMonitorTimer != 0xFFFF) {
 			uClkCmd = (BPWR_DisableClock << MBX_PM_CLK_CMDSHIFT) |
 						ulLoadMonitorTimer;
@@ -605,7 +584,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 			extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
 			for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES;
-				       tmpIndex++) {
+								tmpIndex++) {
 				if (extClkId == BPWR_CLKID[tmpIndex]) {
 					clkIdIndex = tmpIndex;
 					break;
@@ -613,8 +592,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			}
 
 			if (clkIdIndex < MBX_PM_MAX_RESOURCES)
-				status = CLK_Set_32KHz(
-						BPWR_Clks[clkIdIndex].funClk);
+				status = CLK_Set_32KHz(BPWR_Clks[clkIdIndex].
+									funClk);
 			else
 				status = DSP_EFAIL;
 
@@ -683,9 +662,9 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 					"_BRIDGEINIT_DSP_FREQ", &ulDspClkAddr);
 		/*Set Autoidle Mode for IVA2 PLL */
 		temp = (u32) *((REG_UWORD32 *)
-			((u32) (resources.dwCmBase) + 0x34));
+			((u32) (pDevContext->cmbase) + 0x34));
 		temp = (temp & 0xFFFFFFFE) | 0x1;
-		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
+		*((REG_UWORD32 *) ((u32) (pDevContext->cmbase) + 0x34)) =
 			(u32) temp;
 		DBG_Trace(DBG_LEVEL5, "WMD_BRD_Start: _BRIDGE_DSP_FREQ Addr:"
 				"0x%x \n", ulDspClkAddr);
@@ -701,29 +680,29 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		}
 /*PM_IVA2GRPSEL_PER = 0xC0;*/
 		temp = (u32) *((REG_UWORD32 *)
-			((u32) (resources.dwPerPmBase) + 0xA8));
+			((u32) (pDevContext->perbase) + 0xA8));
 		temp = (temp & 0xFFFFFF30) | 0xC0;
-		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8)) =
+		*((REG_UWORD32 *) ((u32) (pDevContext->perbase) + 0xA8)) =
 			(u32) temp;
 
 /*PM_MPUGRPSEL_PER &= 0xFFFFFF3F;*/
 		temp = (u32) *((REG_UWORD32 *)
-			((u32) (resources.dwPerPmBase) + 0xA4));
+			((u32) (pDevContext->perbase) + 0xA4));
 		temp = (temp & 0xFFFFFF3F);
-		*((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4)) =
+		*((REG_UWORD32 *) ((u32) (pDevContext->perbase) + 0xA4)) =
 			(u32) temp;
 /*CM_SLEEPDEP_PER |= 0x04;*/
 		temp = (u32) *((REG_UWORD32 *)
-			((u32) (resources.dwPerBase) + 0x44));
+			((u32) (pDevContext->perbase) + 0x44));
 		temp = (temp & 0xFFFFFFFB) | 0x04;
-		*((REG_UWORD32 *) ((u32) (resources.dwPerBase) + 0x44)) =
+		*((REG_UWORD32 *) ((u32) (pDevContext->perbase) + 0x44)) =
 			(u32) temp;
 
 /*CM_CLKSTCTRL_IVA2 = 0x00000003 -To Allow automatic transitions*/
 		temp = (u32) *((REG_UWORD32 *)
-			((u32) (resources.dwCmBase) + 0x48));
+			((u32) (pDevContext->cmbase) + 0x48));
 		temp = (temp & 0xFFFFFFFC) | 0x03;
-		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x48)) =
+		*((REG_UWORD32 *) ((u32) (pDevContext->cmbase) + 0x48)) =
 			(u32) temp;
 
 		/* Enable Mailbox events and also drain any pending
@@ -732,25 +711,25 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 	}
 
 	if (DSP_SUCCEEDED(status)) {
-		HW_RSTCTRL_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
+		HW_RSTCTRL_RegGet(pDevContext->prmbase, HW_RST1_IVA2, &temp);
 		DBG_Trace(DBG_LEVEL7, "BRD_Start: RM_RSTCTRL_DSP = 0x%x \n",
 				temp);
-		HW_RSTST_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
+		HW_RSTST_RegGet(pDevContext->prmbase, HW_RST1_IVA2, &temp);
 		DBG_Trace(DBG_LEVEL7, "BRD_Start0: RM_RSTST_DSP = 0x%x \n",
 				temp);
 
 		/* Let DSP go */
 		DBG_Trace(DBG_LEVEL7, "Unreset, WMD_BRD_Start\n");
 		/* Enable DSP MMU Interrupts */
-		HW_MMU_EventEnable(resources.dwDmmuBase,
+		HW_MMU_EventEnable(pDevContext->dwDSPMmuBase,
 				HW_MMU_ALL_INTERRUPTS);
 		/* release the RST1, DSP starts executing now .. */
-		HW_RST_UnReset(resources.dwPrmBase, HW_RST1_IVA2);
+		HW_RST_UnReset(pDevContext->prmbase, HW_RST1_IVA2);
 
-		HW_RSTST_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
+		HW_RSTST_RegGet(pDevContext->prmbase, HW_RST1_IVA2, &temp);
 		DBG_Trace(DBG_LEVEL7, "BRD_Start: RM_RSTST_DSP = 0x%x \n",
 				temp);
-		HW_RSTCTRL_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
+		HW_RSTCTRL_RegGet(pDevContext->prmbase, HW_RST1_IVA2, &temp);
 		DBG_Trace(DBG_LEVEL5, "WMD_BRD_Start: CM_RSTCTRL_DSP: 0x%x \n",
 				temp);
 		DBG_Trace(DBG_LEVEL7, "Driver waiting for Sync @ 0x%x \n",
@@ -832,11 +811,11 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		return DSP_EFAIL;
 	}
 
-	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &dspPwrState);
+	HW_PWRST_IVA2RegGet(pDevContext->prmbase, &dspPwrState);
 	if (dspPwrState != HW_PWR_STATE_OFF) {
 		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
 		mdelay(10);
-		GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
+		GetHWRegs(pDevContext->prmbase, pDevContext->cmbase);
 		udelay(50);
 
 		clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
@@ -847,7 +826,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		}
 		/* IVA2 is not in OFF state */
 		/* Set PM_PWSTCTRL_IVA2  to OFF */
-		HW_PWR_IVA2PowerStateSet(resources.dwPrmBase,
+		HW_PWR_IVA2PowerStateSet(pDevContext->prmbase,
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_OFF);
 		/* Set the SW supervised state transition for Sleep */
@@ -877,8 +856,8 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		       (pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
-	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
-	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
+	HW_RST_Reset(pDevContext->prmbase, HW_RST1_IVA2);
+	HW_RST_Reset(pDevContext->prmbase, HW_RST2_IVA2);
 
 	return status;
 }
@@ -943,8 +922,8 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 			(pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Delete - End ****** \n");
-	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
-	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
+	HW_RST_Reset(pDevContext->prmbase, HW_RST1_IVA2);
+	HW_RST_Reset(pDevContext->prmbase, HW_RST2_IVA2);
 
 	return status;
 }
@@ -1153,9 +1132,14 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 				 "enable the clock Fail\n");
 		}
 		udelay(5);
-		/* 24xx-Linux MMU address is obtained from the host
+		/* 34xx-Linux Base addresses are obtained from the host
 		 * resources struct */
 		pDevContext->dwDSPMmuBase = resources.dwDmmuBase;
+		pDevContext->dwMailBoxBase = resources.dwMboxBase;
+		pDevContext->cmbase = resources.dwCmBase;
+		pDevContext->sysctrlbase = resources.dwSysCtrlBase;
+		pDevContext->prmbase = resources.dwPrmBase;
+		pDevContext->perbase = resources.dwPerPmBase;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		pDevContext->hDevObject = hDevObject;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index ea299a0..1c3bec3 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -82,11 +82,8 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 *pConstraintVal;
 	DSP_STATUS status = DSP_SOK;
-	struct CFG_HOSTRES resources;
 	struct dspbridge_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
-	status = CFG_GetHostResources(
-		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 
 	pConstraintVal = (u32 *)(pArgs);
 	/* Read the target value requested by DSP  */
@@ -111,7 +108,6 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
 	u16 timeout = PWRSTST_TIMEOUT / 10;
-	struct CFG_HOSTRES resources;
 	enum HW_PwrState_t pwrState;
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 opplevel;
@@ -120,12 +116,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 				omap_dspbridge_dev->dev.platform_data;
 #endif
 
-	status = CFG_GetHostResources(
-		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-	if (DSP_FAILED(status))
-		return status;
-
-	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
+	HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 			    &pwrState);
 	/* Wait for DSP to move into OFF state */
 	while ((pwrState != HW_PWR_STATE_OFF) && --timeout) {
@@ -133,7 +124,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 			pr_err("Waiting for DSP OFF mode interrupted\n");
 			return DSP_EFAIL;
 		}
-		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
+		HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
 	if (timeout == 0) {
@@ -141,9 +132,8 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 		status = WMD_E_TIMEOUT;
 		return status;
 	} else {
-
 		/* Save mailbox settings */
-		status = HW_MBOX_saveSettings(resources.dwMboxBase);
+		status = HW_MBOX_saveSettings(pDevContext->dwMailBoxBase);
 		DBG_Trace(DBG_LEVEL6, "MailBoxSettings: SYSCONFIG = 0x%x\n",
 			 mboxsetting.sysconfig);
 		DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE0 = 0x%x\n",
@@ -193,7 +183,6 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 {
 	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
-	struct CFG_HOSTRES resources;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	struct DEH_MGR *hDehMgr;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
@@ -208,14 +197,9 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		return DSP_EINVALIDARG;
 	}
 
-	status = CFG_GetHostResources(
-		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-	if (DSP_FAILED(status))
-		return status;
-
 	switch (pDevContext->dwBrdState) {
 	case BRD_RUNNING:
-		status = HW_MBOX_saveSettings(resources.dwMboxBase);
+		status = HW_MBOX_saveSettings(pDevContext->dwMailBoxBase);
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
 			CHNLSM_InterruptDSP2(pDevContext,
 					     MBX_PM_DSPHIBERNATE);
@@ -230,7 +214,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		}
 		break;
 	case BRD_RETENTION:
-		status = HW_MBOX_saveSettings(resources.dwMboxBase);
+		status = HW_MBOX_saveSettings(pDevContext->dwMailBoxBase);
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
 			CHNLSM_InterruptDSP2(pDevContext,
 					     MBX_PM_DSPHIBERNATE);
@@ -255,7 +239,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	}
 
 	/* Get the PRCM DSP power domain status */
-	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
+	HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 			&pwrState);
 
 	/* Wait for DSP to move into target power state */
@@ -264,7 +248,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			pr_err("Waiting for DSP to Suspend interrupted\n");
 			return DSP_EFAIL;
 		}
-		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
+		HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
 
@@ -315,16 +299,9 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
  */
 DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 {
-	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
 #ifdef CONFIG_BRIDGE_DEBUG
 	enum HW_PwrState_t pwrState;
-	struct CFG_HOSTRES resources;
-
-	status = CFG_GetHostResources(
-		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-	if (DSP_FAILED(status))
-		return status;
 #endif /* CONFIG_BRIDGE_DEBUG */
 
 	/* Check the BRD/WMD state, if it is not 'SLEEP' then return failure */
@@ -339,7 +316,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
 
 #ifdef CONFIG_BRIDGE_DEBUG
-	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
+	HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 			&pwrState);
 	DBG_Trace(DBG_LEVEL7,
 			"\nWakeDSP: Power State After sending Interrupt "
@@ -349,7 +326,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 	/* Set the device state to RUNNIG */
 	pDevContext->dwBrdState = BRD_RUNNING;
 #endif /* CONFIG_PM */
-	return status;
+	return DSP_SOK;
 }
 
 /*
@@ -367,7 +344,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 	u32 dspPerClksBefore;
 	DSP_STATUS status = DSP_SOK;
 	DSP_STATUS status1 = DSP_SOK;
-	struct CFG_HOSTRES resources;
 	u32 value;
 
 	DBG_Trace(DBG_ENTER, "Entering DSPPeripheralClkCtrl \n");
@@ -377,13 +353,6 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 
 	extClk = (u32)*((u32 *)pArgs);
 
-	status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
-
-	if (DSP_FAILED(status))
-		return DSP_EFAIL;
-
 	DBG_Trace(DBG_LEVEL3, "DSPPeripheralClkCtrl : extClk+Cmd = 0x%x \n",
 		 extClk);
 
@@ -416,14 +385,14 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 		status = CLK_Disable(BPWR_Clks[clkIdIndex].funClk);
 		if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP1) {
 			/* clear MCBSP1_CLKS, on McBSP1 OFF */
-			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value = __raw_readl(pDevContext->sysctrlbase + 0x274);
 			value &= ~(1 << 2);
-			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+			__raw_writel(value, pDevContext->sysctrlbase + 0x274);
 		} else if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP2) {
 			/* clear MCBSP2_CLKS, on McBSP2 OFF */
-			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value = __raw_readl(pDevContext->sysctrlbase + 0x274);
 			value &= ~(1 << 6);
-			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+			__raw_writel(value, pDevContext->sysctrlbase + 0x274);
 		}
 		DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, false);
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
@@ -441,14 +410,14 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 		status = CLK_Enable(BPWR_Clks[clkIdIndex].funClk);
 		if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP1) {
 			/* set MCBSP1_CLKS, on McBSP1 ON */
-			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value = __raw_readl(pDevContext->sysctrlbase + 0x274);
 			value |= 1 << 2;
-			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+			__raw_writel(value, pDevContext->sysctrlbase + 0x274);
 		} else if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP2) {
 			/* set MCBSP2_CLKS, on McBSP2 ON */
-			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value = __raw_readl(pDevContext->sysctrlbase + 0x274);
 			value |= 1 << 6;
-			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+			__raw_writel(value, pDevContext->sysctrlbase + 0x274);
 		}
 		DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, true);
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
@@ -561,31 +530,26 @@ DSP_STATUS DSP_PeripheralClocks_Disable(struct WMD_DEV_CONTEXT *pDevContext,
 {
 	u32 clkIdx;
 	DSP_STATUS status = DSP_SOK;
-	struct CFG_HOSTRES resources;
 	u32 value;
 
-	status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
-
 	for (clkIdx = 0; clkIdx < MBX_PM_MAX_RESOURCES; clkIdx++) {
 		if (((pDevContext->uDspPerClks) >> clkIdx) & 0x01) {
 			/* Disables the interface clock of the peripheral */
 			status = CLK_Disable(BPWR_Clks[clkIdx].intClk);
 			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
 				/* clear MCBSP1_CLKS, on McBSP1 OFF */
-				value = __raw_readl(resources.dwSysCtrlBase
-								+ 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase +
+									0x274);
 				value &= ~(1 << 2);
-				__raw_writel(value, resources.dwSysCtrlBase
-								+ 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase +
+									0x274);
 			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
 				/* clear MCBSP2_CLKS, on McBSP2 OFF */
-				value = __raw_readl(resources.dwSysCtrlBase
-								+ 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase +
+									0x274);
 				value &= ~(1 << 6);
-				__raw_writel(value, resources.dwSysCtrlBase
-								+ 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase +
+									0x274);
 			}
 			if (DSP_FAILED(status)) {
 				DBG_Trace(DBG_LEVEL7,
@@ -613,30 +577,26 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
 {
 	u32 clkIdx;
 	DSP_STATUS int_clk_status = DSP_EFAIL, fun_clk_status = DSP_EFAIL;
-	struct CFG_HOSTRES resources;
 	u32 value;
 
-	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
-
 	for (clkIdx = 0; clkIdx < MBX_PM_MAX_RESOURCES; clkIdx++) {
 		if (((pDevContext->uDspPerClks) >> clkIdx) & 0x01) {
 			/* Enable the interface clock of the peripheral */
 			int_clk_status = CLK_Enable(BPWR_Clks[clkIdx].intClk);
 			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
 				/* set MCBSP1_CLKS, on McBSP1 ON */
-				value = __raw_readl(resources.dwSysCtrlBase
-								+ 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase +
+									0x274);
 				value |= 1 << 2;
-				__raw_writel(value, resources.dwSysCtrlBase
-								+ 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase +
+									0x274);
 			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
 				/* set MCBSP2_CLKS, on McBSP2 ON */
-				value = __raw_readl(resources.dwSysCtrlBase
-								+ 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase +
+									0x274);
 				value |= 1 << 6;
-				__raw_writel(value, resources.dwSysCtrlBase
-								+ 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase +
+									0x274);
 			}
 			/* Enable the functional clock of the periphearl */
 			fun_clk_status = CLK_Enable(BPWR_Clks[clkIdx].funClk);
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index fe4d8b0..fecff54 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -38,7 +38,6 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 	DSP_STATUS status = DSP_SOK;
 	u32 numMbxMsg;
 	u32 mbxValue;
-	struct CFG_HOSTRES resources;
 	u32 devType;
 	struct IO_MGR *hIOMgr;
 
@@ -46,34 +45,33 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 
 	/* Read the messages in the mailbox until the message queue is empty */
 
-	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			     &resources);
 	DEV_GetDevType(pDevContext->hDevObject, &devType);
 	status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
 	if (devType == DSP_UNIT) {
-		HW_MBOX_NumMsgGet(resources.dwMboxBase,
+		HW_MBOX_NumMsgGet(pDevContext->dwMailBoxBase,
 				  MBOX_DSP2ARM, &numMbxMsg);
 		while (numMbxMsg != 0) {
-			HW_MBOX_MsgRead(resources.dwMboxBase,
+			HW_MBOX_MsgRead(pDevContext->dwMailBoxBase,
 					MBOX_DSP2ARM,
 					&mbxValue);
 			numMbxMsg--;
 		}
 		/* clear the DSP mailbox as well...*/
-		HW_MBOX_NumMsgGet(resources.dwMboxBase,
+		HW_MBOX_NumMsgGet(pDevContext->dwMailBoxBase,
 				  MBOX_ARM2DSP, &numMbxMsg);
 		while (numMbxMsg != 0) {
-			HW_MBOX_MsgRead(resources.dwMboxBase,
+			HW_MBOX_MsgRead(pDevContext->dwMailBoxBase,
 					MBOX_ARM2DSP, &mbxValue);
 			numMbxMsg--;
 			udelay(10);
 
-			HW_MBOX_EventAck(resources.dwMboxBase, MBOX_ARM2DSP,
+			HW_MBOX_EventAck(pDevContext->dwMailBoxBase,
+					 MBOX_ARM2DSP,
 					 HW_MBOX_U1_DSP1,
 					 HW_MBOX_INT_NEW_MSG);
 		}
 		/* Enable the new message events on this IRQ line */
-		HW_MBOX_EventEnable(resources.dwMboxBase,
+		HW_MBOX_EventEnable(pDevContext->dwMailBoxBase,
 				    MBOX_DSP2ARM,
 				    MBOX_ARM,
 				    HW_MBOX_INT_NEW_MSG);
@@ -84,13 +82,9 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 
 DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 {
-	struct CFG_HOSTRES resources;
-
 	DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", pDevContext);
 
-	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			     &resources);
-	HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
+	HW_MBOX_EventDisable(pDevContext->dwMailBoxBase, MBOX_DSP2ARM,
 			     MBOX_ARM, HW_MBOX_INT_NEW_MSG);
 	return DSP_SOK;
 }
@@ -103,13 +97,10 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		omap_dspbridge_dev->dev.platform_data;
 	u32 opplevel = 0;
 #endif
-	struct CFG_HOSTRES resources;
 	DSP_STATUS status = DSP_SOK;
 	unsigned long timeout;
 	u32 temp;
 
-	status = CFG_GetHostResources((struct CFG_DEVNODE *)
-			DRV_GetFirstDevExtension(), &resources);
 	if (DSP_FAILED(status))
 		return DSP_EFAIL;
 
@@ -130,22 +121,22 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
 		 *     in CM_AUTOIDLE_PLL_IVA2 register
 		 */
-		*(REG_UWORD32 *)(resources.dwCmBase + 0x34) = 0x1;
+		*(REG_UWORD32 *)(pDevContext->cmbase + 0x34) = 0x1;
 
 		/*
 		 * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
 		 *     0.75 MHz - 1.0 MHz
 		 * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
 		 */
-		temp = *(REG_UWORD32 *)(resources.dwCmBase + 0x4);
+		temp = *(REG_UWORD32 *)(pDevContext->cmbase + 0x4);
 		temp = (temp & 0xFFFFFF08) | 0x37;
-		*(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;
+		*(REG_UWORD32 *)(pDevContext->cmbase + 0x4) = temp;
 
 		/* Restore mailbox settings */
-		HW_MBOX_restoreSettings(resources.dwMboxBase);
+		HW_MBOX_restoreSettings(pDevContext->dwMailBoxBase);
 
 		/* Access MMU SYS CONFIG register to generate a short wakeup */
-		temp = *(REG_UWORD32 *)(resources.dwDmmuBase + 0x10);
+		temp = *(REG_UWORD32 *)(pDevContext->dwDSPMmuBase + 0x10);
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	} else if (pDevContext->dwBrdState == BRD_RETENTION)
@@ -153,7 +144,7 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		DSP_PeripheralClocks_Enable(pDevContext, NULL);
 
 	timeout = jiffies + msecs_to_jiffies(1);
-	while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
+	while (fifo_full((void __iomem *) pDevContext->dwMailBoxBase, 0)) {
 		if (time_after(jiffies, timeout)) {
 			pr_err("dspbridge: timed out waiting for mailbox\n");
 			return WMD_E_TIMEOUT;
@@ -161,27 +152,26 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 	}
 
 	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n", wMbVal);
-	HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP, wMbVal);
+	HW_MBOX_MsgWrite(pDevContext->dwMailBoxBase, MBOX_ARM2DSP, wMbVal);
+
 	return DSP_SOK;
 }
 
 bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
 		u16 *pwIntrVal)
 {
-	struct CFG_HOSTRES resources;
 	u32 numMbxMsg;
 	u32 mbxValue;
 
 	DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", pDevContext);
 
-	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-
-	HW_MBOX_NumMsgGet(resources.dwMboxBase, MBOX_DSP2ARM, &numMbxMsg);
+	HW_MBOX_NumMsgGet(pDevContext->dwMailBoxBase, MBOX_DSP2ARM, &numMbxMsg);
 
 	if (numMbxMsg > 0) {
-		HW_MBOX_MsgRead(resources.dwMboxBase, MBOX_DSP2ARM, &mbxValue);
+		HW_MBOX_MsgRead(pDevContext->dwMailBoxBase, MBOX_DSP2ARM,
+				&mbxValue);
 
-		HW_MBOX_EventAck(resources.dwMboxBase, MBOX_DSP2ARM,
+		HW_MBOX_EventAck(pDevContext->dwMailBoxBase, MBOX_DSP2ARM,
 				 HW_MBOX_U0_ARM, HW_MBOX_INT_NEW_MSG);
 
 		DBG_Trace(DBG_LEVEL3, "Read %x from Mailbox\n", mbxValue);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index d6d6043..c03b816 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -205,12 +205,8 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 	u32 memPhysical = 0;
 	u32 HW_MMU_MAX_TLB_COUNT = 31;
 	u32 extern faultAddr;
-	struct CFG_HOSTRES resources;
 	HW_STATUS hwStatus;
 
-	status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
 	if (DSP_FAILED(status))
 		DBG_Trace(DBG_LEVEL7,
 			 "**Failed to get Host Resources in MMU ISR **\n");
@@ -268,16 +264,17 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 				 "PA: 0x%x\n", pDevContext->
 				numTLBEntries, faultAddr, memPhysical);
 			if (DSP_SUCCEEDED(status)) {
-				hwStatus = HW_MMU_TLBAdd(resources.dwDmmuBase,
-					memPhysical, faultAddr,
+				hwStatus = HW_MMU_TLBAdd(pDevContext->
+					dwDSPMmuBase, memPhysical, faultAddr,
 					HW_PAGE_SIZE_4KB, 1, &mapAttrs,
 					HW_SET, HW_SET);
 			}
 			/* send an interrupt to DSP */
-			HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
-					 MBX_DEH_CLASS | MBX_DEH_EMMU);
+			HW_MBOX_MsgWrite(pDevContext->dwMailBoxBase,
+					MBOX_ARM2DSP,
+					MBX_DEH_CLASS | MBX_DEH_EMMU);
 			/* Clear MMU interrupt */
-			HW_MMU_EventAck(resources.dwDmmuBase,
+			HW_MMU_EventAck(pDevContext->dwDSPMmuBase,
 					 HW_MMU_TRANSLATION_FAULT);
 			break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
-- 
1.6.2.4


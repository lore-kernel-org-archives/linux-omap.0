From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 08/20] DSPBRIDGE: Checkpatch - line over 80 characters
Date: Mon, 30 Nov 2009 15:54:49 -0600
Message-ID: <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56613 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbZK3VtC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 16:49:02 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn6E0027026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:06 -0600
In-Reply-To: <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

WARNING: line over 80 characters

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                |    3 ++-
 drivers/dsp/bridge/wmd/mmu_fault.c            |    3 ++-
 drivers/dsp/bridge/wmd/tiomap3430.c           |   23 ++++++++++++++---------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c       |   24 ++++++++++++++++--------
 drivers/dsp/bridge/wmd/tiomap_sm.c            |   11 ++++++-----
 drivers/dsp/bridge/wmd/ue_deh.c               |   14 ++++++++------
 7 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 4385b3a..526b7f3 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -554,7 +554,7 @@ bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
 #define AUTOSTART	"AutoStart"		/* Statically load flag */
 #define CURRENTCONFIG	"CurrentConfig"		/* Current resources */
 #define SHMSIZE		"SHMSize"		/* Size of SHM reservd on MPU */
-#define TCWORDSWAP	"TCWordSwap"		/* Traffic Contoller Word Swap */
+#define TCWORDSWAP	"TCWordSwap"		/* Traffic Controller WordSwp */
 #define DSPRESOURCES	"DspTMSResources"	/* C55 DSP resurces on OMAP */
 
 #endif				/* DBDEFS_ */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index c923c47..c541400 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1566,7 +1566,8 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				   postSWI, true);
 			/* Tell the DSP we have written the output. */
-			CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+			CHNLSM_InterruptDSP2(pIOMgr->hWmdContext,
+						MBX_PCPY_CLASS);
 		}
 	}
 func_end:
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index b6cbbb3..bb98e56 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -140,7 +140,8 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext)
 		DBG_Trace(DBG_LEVEL7, "**Failed to get Host Resources in "
 			 "MMU_CheckIfFault **\n");
 
-	hwStatus = HW_MMU_EventStatus(pDevContext->dwDSPMmuBase, &dmmuEventMask);
+	hwStatus = HW_MMU_EventStatus(pDevContext->dwDSPMmuBase,
+					&dmmuEventMask);
 	if (dmmuEventMask  ==  HW_MMU_TRANSLATION_FAULT) {
 		HW_MMU_FaultAddrRead(pDevContext->dwDSPMmuBase, &faultAddr);
 		DBG_Trace(DBG_LEVEL1, "WMD_DEH_Notify: DSP_MMUFAULT, fault "
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index c73cea7..cfa8868 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -340,12 +340,14 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_ON);
 		/* Set the SW supervised state transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase, HW_SW_SUP_WAKEUP);
+		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase,
+							HW_SW_SUP_WAKEUP);
 		/* Wait until the state has moved to ON */
 		HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 				     &pwrState);
 		/* Disable Automatic transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase, HW_AUTOTRANS_DIS);
+		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase,
+							HW_AUTOTRANS_DIS);
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - Middle ****** \n");
 	GetHWRegs(pDevContext->prmbase, pDevContext->cmbase);
@@ -490,7 +492,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		if (dsp_debug) {
 			/* Set the bootmode to self loop  */
 			DBG_Trace(DBG_LEVEL7,
-					"Set boot mode to self loop for IVA2 Device\n");
+				"Set boot mode to self loop for IVA2 Device\n");
 			HW_DSPSS_BootModeSet(pDevContext->sysctrlbase,
 				HW_DSPSYSC_SELFLOOPBOOT, dwDSPAddr);
 		} else {
@@ -540,8 +542,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		}		/* end for */
 
 		/*
-		 * Lock the above TLB entries and get the BIOS and load monitor timer
-		 * information
+		 * Lock the above TLB entries and get the BIOS and load
+		 * monitor timer information
 		 */
 		HW_MMU_NumLockedSet(pDevContext->dwDSPMmuBase, itmpEntryNdx);
 		HW_MMU_VictimNumSet(pDevContext->dwDSPMmuBase, itmpEntryNdx);
@@ -559,10 +561,11 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 		/* Enable the BIOS clock  */
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
-					BRIDGEINIT_BIOSGPTIMER, &ulBiosGpTimer);
+				BRIDGEINIT_BIOSGPTIMER, &ulBiosGpTimer);
 		DBG_Trace(DBG_LEVEL7, "BIOS GPTimer : 0x%x\n", ulBiosGpTimer);
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
-				BRIDGEINIT_LOADMON_GPTIMER, &ulLoadMonitorTimer);
+				BRIDGEINIT_LOADMON_GPTIMER,
+				&ulLoadMonitorTimer);
 		DBG_Trace(DBG_LEVEL7, "Load Monitor Timer : 0x%x\n",
 			  ulLoadMonitorTimer);
 
@@ -575,7 +578,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 			extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
-			for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES; tmpIndex++) {
+			for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES;
+			     tmpIndex++) {
 				if (extClkId == BPWR_CLKID[tmpIndex]) {
 					clkIdIndex = tmpIndex;
 					break;
@@ -583,7 +587,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			}
 
 			if (clkIdIndex < MBX_PM_MAX_RESOURCES)
-				status = CLK_Set_32KHz(BPWR_Clks[clkIdIndex].funClk);
+				status =
+				    CLK_Set_32KHz(BPWR_Clks[clkIdIndex].funClk);
 			else
 				status = DSP_EFAIL;
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index dc20684..f5eb21c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -547,14 +547,18 @@ DSP_STATUS DSP_PeripheralClocks_Disable(struct WMD_DEV_CONTEXT *pDevContext,
 			status = CLK_Disable(BPWR_Clks[clkIdx].intClk);
 			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
 				/* clear MCBSP1_CLKS, on McBSP1 OFF */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value &= ~(1 << 2);
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
 				/* clear MCBSP2_CLKS, on McBSP2 OFF */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value &= ~(1 << 6);
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			}
 			if (DSP_FAILED(status)) {
 				DBG_Trace(DBG_LEVEL7,
@@ -590,14 +594,18 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
 			int_clk_status = CLK_Enable(BPWR_Clks[clkIdx].intClk);
 			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
 				/* set MCBSP1_CLKS, on McBSP1 ON */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value |= 1 << 2;
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
 				/* set MCBSP2_CLKS, on McBSP2 ON */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value |= 1 << 6;
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			}
 			/* Enable the functional clock of the periphearl */
 			fun_clk_status = CLK_Enable(BPWR_Clks[clkIdx].funClk);
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index fb0b661..b74ce68 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -65,9 +65,9 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 			numMbxMsg--;
 			udelay(10);
 
-			HW_MBOX_EventAck(pDevContext->dwMailBoxBase, MBOX_ARM2DSP,
-					 HW_MBOX_U1_DSP1,
-					 HW_MBOX_INT_NEW_MSG);
+			HW_MBOX_EventAck(pDevContext->dwMailBoxBase,
+					MBOX_ARM2DSP, HW_MBOX_U1_DSP1,
+					HW_MBOX_INT_NEW_MSG);
 		}
 		/* Enable the new message events on this IRQ line */
 		HW_MBOX_EventEnable(pDevContext->dwMailBoxBase,
@@ -158,10 +158,11 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
 	HW_MBOX_NumMsgGet(pDevContext->dwMailBoxBase, MBOX_DSP2ARM, &numMbxMsg);
 
 	if (numMbxMsg > 0) {
-		HW_MBOX_MsgRead(pDevContext->dwMailBoxBase, MBOX_DSP2ARM, &mbxValue);
+		HW_MBOX_MsgRead(pDevContext->dwMailBoxBase, MBOX_DSP2ARM,
+				&mbxValue);
 
 		HW_MBOX_EventAck(pDevContext->dwMailBoxBase, MBOX_DSP2ARM,
-				 HW_MBOX_U0_ARM, HW_MBOX_INT_NEW_MSG);
+				HW_MBOX_U0_ARM, HW_MBOX_INT_NEW_MSG);
 
 		DBG_Trace(DBG_LEVEL3, "Read %x from Mailbox\n", mbxValue);
 		*pwIntrVal = (u16) mbxValue;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index c2020a1..6d6c76b 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -248,14 +248,16 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 				 "PA: 0x%x\n", pDevContext->
 				numTLBEntries, faultAddr, memPhysical);
 			if (DSP_SUCCEEDED(status)) {
-				hwStatus = HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase,
-					memPhysical, faultAddr,
-					HW_PAGE_SIZE_4KB, 1, &mapAttrs,
-					HW_SET, HW_SET);
+				hwStatus =
+					HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase,
+						memPhysical, faultAddr,
+						HW_PAGE_SIZE_4KB, 1, &mapAttrs,
+						HW_SET, HW_SET);
 			}
 			/* send an interrupt to DSP */
-			HW_MBOX_MsgWrite(pDevContext->dwMailBoxBase, MBOX_ARM2DSP,
-					 MBX_DEH_CLASS | MBX_DEH_EMMU);
+			HW_MBOX_MsgWrite(pDevContext->dwMailBoxBase,
+					MBOX_ARM2DSP,
+					MBX_DEH_CLASS | MBX_DEH_EMMU);
 			/* Clear MMU interrupt */
 			HW_MMU_EventAck(pDevContext->dwDSPMmuBase,
 					 HW_MMU_TRANSLATION_FAULT);
-- 
1.6.2.4


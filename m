From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 03/17] DSPBRIDGE: Enable/Disable MCBSP_CLOCKS for MCBSP2
Date: Tue, 15 Dec 2009 00:19:44 -0600
Message-ID: <1260857998-19349-4-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44510 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbZLOGMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:51 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

Enable/Disable McBSP_CLOCKS when McBSP2 is requested
so DPLL can be gated.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   73 ++++++++++++++++++++++++++++++-
 1 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 619ed1a..f30da74 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -361,6 +361,8 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 	u32 dspPerClksBefore;
 	DSP_STATUS status = DSP_SOK;
 	DSP_STATUS status1 = DSP_SOK;
+	struct CFG_HOSTRES resources;
+	u32 value;
 
 	DBG_Trace(DBG_ENTER, "Entering DSPPeripheralClkCtrl \n");
 	dspPerClksBefore = pDevContext->uDspPerClks;
@@ -369,6 +371,13 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 
 	extClk = (u32)*((u32 *)pArgs);
 
+	status = CFG_GetHostResources(
+			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+			&resources);
+
+	if (DSP_FAILED(status))
+		return DSP_EFAIL;
+
 	DBG_Trace(DBG_LEVEL3, "DSPPeripheralClkCtrl : extClk+Cmd = 0x%x \n",
 		 extClk);
 
@@ -399,6 +408,17 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 			 "DSPPeripheralClkCtrl : Disable CLK for \n");
 		status1 = CLK_Disable(BPWR_Clks[clkIdIndex].intClk);
 		status = CLK_Disable(BPWR_Clks[clkIdIndex].funClk);
+		if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP1) {
+			/* clear MCBSP1_CLKS, on McBSP1 OFF */
+			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value &= ~(1 << 2);
+			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+		} else if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP2) {
+			/* clear MCBSP2_CLKS, on McBSP2 OFF */
+			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value &= ~(1 << 6);
+			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+		}
 		DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, false);
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
 			(pDevContext->uDspPerClks) &=
@@ -413,6 +433,17 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
 			 "DSPPeripheralClkCtrl : Enable CLK for \n");
 		status1 = CLK_Enable(BPWR_Clks[clkIdIndex].intClk);
 		status = CLK_Enable(BPWR_Clks[clkIdIndex].funClk);
+		if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP1) {
+			/* set MCBSP1_CLKS, on McBSP1 ON */
+			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value |= 1 << 2;
+			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+		} else if (BPWR_CLKID[clkIdIndex] == BPWR_MCBSP2) {
+			/* set MCBSP2_CLKS, on McBSP2 ON */
+			value = __raw_readl(resources.dwSysCtrlBase + 0x274);
+			value |= 1 << 6;
+			__raw_writel(value, resources.dwSysCtrlBase + 0x274);
+		}
 		DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, true);
 		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
 			(pDevContext->uDspPerClks) |= (1 << clkIdIndex);
@@ -522,14 +553,34 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 DSP_STATUS DSP_PeripheralClocks_Disable(struct WMD_DEV_CONTEXT *pDevContext,
 					IN void *pArgs)
 {
-
 	u32 clkIdx;
 	DSP_STATUS status = DSP_SOK;
+	struct CFG_HOSTRES resources;
+	u32 value;
+
+	status = CFG_GetHostResources(
+			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+			&resources);
 
 	for (clkIdx = 0; clkIdx < MBX_PM_MAX_RESOURCES; clkIdx++) {
 		if (((pDevContext->uDspPerClks) >> clkIdx) & 0x01) {
 			/* Disables the interface clock of the peripheral */
 			status = CLK_Disable(BPWR_Clks[clkIdx].intClk);
+			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
+				/* clear MCBSP1_CLKS, on McBSP1 OFF */
+				value = __raw_readl(resources.dwSysCtrlBase
+								+ 0x274);
+				value &= ~(1 << 2);
+				__raw_writel(value, resources.dwSysCtrlBase
+								+ 0x274);
+			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
+				/* clear MCBSP2_CLKS, on McBSP2 OFF */
+				value = __raw_readl(resources.dwSysCtrlBase
+								+ 0x274);
+				value &= ~(1 << 6);
+				__raw_writel(value, resources.dwSysCtrlBase
+								+ 0x274);
+			}
 			if (DSP_FAILED(status)) {
 				DBG_Trace(DBG_LEVEL7,
 					 "Failed to Enable the DSP Peripheral"
@@ -556,11 +607,31 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
 {
 	u32 clkIdx;
 	DSP_STATUS int_clk_status = DSP_EFAIL, fun_clk_status = DSP_EFAIL;
+	struct CFG_HOSTRES resources;
+	u32 value;
+
+	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+			&resources);
 
 	for (clkIdx = 0; clkIdx < MBX_PM_MAX_RESOURCES; clkIdx++) {
 		if (((pDevContext->uDspPerClks) >> clkIdx) & 0x01) {
 			/* Enable the interface clock of the peripheral */
 			int_clk_status = CLK_Enable(BPWR_Clks[clkIdx].intClk);
+			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
+				/* set MCBSP1_CLKS, on McBSP1 ON */
+				value = __raw_readl(resources.dwSysCtrlBase
+								+ 0x274);
+				value |= 1 << 2;
+				__raw_writel(value, resources.dwSysCtrlBase
+								+ 0x274);
+			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
+				/* set MCBSP2_CLKS, on McBSP2 ON */
+				value = __raw_readl(resources.dwSysCtrlBase
+								+ 0x274);
+				value |= 1 << 6;
+				__raw_writel(value, resources.dwSysCtrlBase
+								+ 0x274);
+			}
 			/* Enable the functional clock of the periphearl */
 			fun_clk_status = CLK_Enable(BPWR_Clks[clkIdx].funClk);
 		}
-- 
1.6.2.4


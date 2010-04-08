From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 15/19] DSPBRIDGE: use one call for both ick and fck clocks
Date: Thu,  8 Apr 2010 18:16:04 -0500
Message-ID: <1270768568-10712-16-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-10-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-11-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-12-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-13-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-14-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-15-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41637 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933794Ab0DHXAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 19:00:13 -0400
In-Reply-To: <1270768568-10712-15-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Instead of two calls to enable/disable for ick and fck use
one call to enable/disable both.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |   33 ++++++++-----------------
 drivers/dsp/bridge/services/clk.c          |   12 ++++----
 drivers/dsp/bridge/wmd/_tiomap.h           |   25 +++++++++----------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |   35 ++++++++--------------------
 4 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index a51308e..da2549d 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -20,28 +20,17 @@
 #define _CLK_H
 
 enum dsp_clk_id {
-	DSP_CLK_GPT5_FCK,
-	DSP_CLK_GPT5_ICK,
-	DSP_CLK_GPT6_FCK,
-	DSP_CLK_GPT6_ICK,
-	DSP_CLK_GPT7_FCK,
-	DSP_CLK_GPT7_ICK,
-	DSP_CLK_GPT8_FCK,
-	DSP_CLK_GPT8_ICK,
-	DSP_CLK_WDT3_FCK,
-	DSP_CLK_WDT3_ICK,
-	DSP_CLK_MCBSP1_FCK,
-	DSP_CLK_MCBSP1_ICK,
-	DSP_CLK_MCBSP2_FCK,
-	DSP_CLK_MCBSP2_ICK,
-	DSP_CLK_MCBSP3_FCK,
-	DSP_CLK_MCBSP3_ICK,
-	DSP_CLK_MCBSP4_FCK,
-	DSP_CLK_MCBSP4_ICK,
-	DSP_CLK_MCBSP5_FCK,
-	DSP_CLK_MCBSP5_ICK,
-	DSP_CLK_SSI_FCK,
-	DSP_CLK_SSI_ICK,
+	DSP_CLK_GPT5,
+	DSP_CLK_GPT6,
+	DSP_CLK_GPT7,
+	DSP_CLK_GPT8,
+	DSP_CLK_WDT3,
+	DSP_CLK_MCBSP1,
+	DSP_CLK_MCBSP2,
+	DSP_CLK_MCBSP3,
+	DSP_CLK_MCBSP4,
+	DSP_CLK_MCBSP5,
+	DSP_CLK_SSI,
 	DSP_CLK_NOT_DEFINED
 };
 
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index af3c5a2..aa706ce 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -54,8 +54,8 @@
 /* Bridge GPT id (0 - 3), DM Timer id (5 - 8) */
 #define DMT_ID(id) ((id) + 5)
 
-/* Bridge MCBSP id (5 - 9), OMAP Mcbsp id (1 - 5) */
-#define MCBSP_ID(id) ((id) - 12)
+/* Bridge MCBSP id (5 - 9), OMAP Mcbsp id (0 - 4) */
+#define MCBSP_ID(id) ((id) - 5)
 
 static struct omap_dm_timer *timer[4];
 
@@ -71,13 +71,13 @@ static s8 get_clk_type(u8 id)
 {
 	s8 type;
 
-	if (id <= DSP_CLK_GPT8_ICK)
+	if (id <= DSP_CLK_GPT8)
 		type = GPT_CLK;
-	else if (id <= DSP_CLK_WDT3_ICK)
+	else if (id == DSP_CLK_WDT3)
 		type = WDT_CLK;
-	else if (id <= DSP_CLK_MCBSP5_ICK)
+	else if (id <= DSP_CLK_MCBSP5)
 		type = MCBSP_CLK;
-	else if (id < DSP_CLK_SSI_ICK)
+	else if (id == DSP_CLK_SSI)
 		type = SSI_CLK;
 	else
 		type = -1;
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 5e4e518..927fc6a 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -242,22 +242,21 @@ static const u32 bpwr_clkid[] = {
 
 struct bpwr_clk_t {
 	u32 clk_id;
-	enum dsp_clk_id fun_clk;
-	enum dsp_clk_id int_clk;
+	enum dsp_clk_id clk;
 };
 
 static const struct bpwr_clk_t bpwr_clks[] = {
-	{(u32) BPWR_GP_TIMER5, DSP_CLK_GPT5_FCK, DSP_CLK_GPT5_ICK},
-	{(u32) BPWR_GP_TIMER6, DSP_CLK_GPT6_FCK, DSP_CLK_GPT6_ICK},
-	{(u32) BPWR_GP_TIMER7, DSP_CLK_GPT7_FCK, DSP_CLK_GPT7_ICK},
-	{(u32) BPWR_GP_TIMER8, DSP_CLK_GPT8_FCK, DSP_CLK_GPT8_ICK},
-	{(u32) BPWR_WD_TIMER3, DSP_CLK_WDT3_FCK, DSP_CLK_WDT3_ICK},
-	{(u32) BPWR_MCBSP1, DSP_CLK_MCBSP1_FCK, DSP_CLK_MCBSP1_ICK},
-	{(u32) BPWR_MCBSP2, DSP_CLK_MCBSP2_FCK, DSP_CLK_MCBSP2_ICK},
-	{(u32) BPWR_MCBSP3, DSP_CLK_MCBSP3_FCK, DSP_CLK_MCBSP3_ICK},
-	{(u32) BPWR_MCBSP4, DSP_CLK_MCBSP4_FCK, DSP_CLK_MCBSP4_ICK},
-	{(u32) BPWR_MCBSP5, DSP_CLK_MCBSP5_FCK, DSP_CLK_MCBSP5_ICK},
-	{(u32) BPWR_SSI, DSP_CLK_SSI_FCK, DSP_CLK_SSI_ICK}
+	{(u32) BPWR_GP_TIMER5, DSP_CLK_GPT5},
+	{(u32) BPWR_GP_TIMER6, DSP_CLK_GPT6},
+	{(u32) BPWR_GP_TIMER7, DSP_CLK_GPT7},
+	{(u32) BPWR_GP_TIMER8, DSP_CLK_GPT8},
+	{(u32) BPWR_WD_TIMER3, DSP_CLK_WDT3},
+	{(u32) BPWR_MCBSP1, DSP_CLK_MCBSP1},
+	{(u32) BPWR_MCBSP2, DSP_CLK_MCBSP2},
+	{(u32) BPWR_MCBSP3, DSP_CLK_MCBSP3},
+	{(u32) BPWR_MCBSP4, DSP_CLK_MCBSP4},
+	{(u32) BPWR_MCBSP5, DSP_CLK_MCBSP5},
+	{(u32) BPWR_SSI, DSP_CLK_SSI}
 };
 
 /* Interrupt Register Offsets */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 087a416..5c518d0 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -300,7 +300,6 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 	u32 tmp_index;
 	u32 dsp_per_clks_before;
 	dsp_status status = DSP_SOK;
-	dsp_status status1 = DSP_SOK;
 	struct cfg_hostres resources;
 	u32 value;
 
@@ -334,9 +333,6 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 	ext_clk_cmd = (ext_clk >> MBX_PM_CLK_CMDSHIFT) & MBX_PM_CLK_CMDMASK;
 	switch (ext_clk_cmd) {
 	case BPWR_DISABLE_CLOCK:
-		/* Call BP to disable the needed clock */
-		status1 = dsp_clk_disable(bpwr_clks[clk_id_index].int_clk);
-		status = dsp_clk_disable(bpwr_clks[clk_id_index].fun_clk);
 		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
 			/* clear MCBSP1_CLKS, on McBSP1 OFF */
 			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
@@ -348,16 +344,16 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 			value &= ~(1 << 6);
 			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
 		}
+		status = dsp_clk_disable(bpwr_clks[clk_id_index].clk);
 		dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id,
 					  false);
-		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
+		if (DSP_SUCCEEDED(status)) {
 			(dev_context->dsp_per_clks) &=
 			    (~((u32) (1 << clk_id_index)));
 		}
 		break;
 	case BPWR_ENABLE_CLOCK:
-		status1 = dsp_clk_enable(bpwr_clks[clk_id_index].int_clk);
-		status = dsp_clk_enable(bpwr_clks[clk_id_index].fun_clk);
+		status = dsp_clk_enable(bpwr_clks[clk_id_index].clk);
 		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
 			/* set MCBSP1_CLKS, on McBSP1 ON */
 			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
@@ -370,9 +366,8 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
 		}
 		dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id, true);
-		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
+		if (DSP_SUCCEEDED(status))
 			(dev_context->dsp_per_clks) |= (1 << clk_id_index);
-		}
 		break;
 	default:
 		dev_dbg(bridge, "%s: Unsupported CMD\n", __func__);
@@ -476,9 +471,6 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
 
 	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
-			/* Disables the interface clock of the peripheral */
-			status =
-			    dsp_clk_disable(bpwr_clks[clk_idx].int_clk);
 			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
 				/* clear MCBSP1_CLKS, on McBSP1 OFF */
 				value = __raw_readl(resources.dw_sys_ctrl_base
@@ -495,9 +487,8 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
 					     + 0x274);
 			}
 
-			/* Disables the functional clock of the periphearl */
-			status =
-			    dsp_clk_disable(bpwr_clks[clk_idx].fun_clk);
+			/* Disables the clocks of the peripheral */
+			status = dsp_clk_disable(bpwr_clks[clk_idx].clk);
 		}
 	}
 	return status;
@@ -511,7 +502,7 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 					IN void *pargs)
 {
 	u32 clk_idx;
-	dsp_status int_clk_status = DSP_EFAIL, fun_clk_status = DSP_EFAIL;
+	dsp_status clk_status = DSP_EFAIL;
 	struct cfg_hostres resources;
 	u32 value;
 
@@ -520,9 +511,8 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 
 	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
-			/* Enable the interface clock of the peripheral */
-			int_clk_status =
-			    dsp_clk_enable(bpwr_clks[clk_idx].int_clk);
+			/* Enable the clocks of the peripheral */
+			clk_status = dsp_clk_enable(bpwr_clks[clk_idx].clk);
 			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
 				/* set MCBSP1_CLKS, on McBSP1 ON */
 				value = __raw_readl(resources.dw_sys_ctrl_base
@@ -538,14 +528,9 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 				__raw_writel(value, resources.dw_sys_ctrl_base
 					     + 0x274);
 			}
-			/* Enable the functional clock of the periphearl */
-			fun_clk_status =
-			    dsp_clk_enable(bpwr_clks[clk_idx].fun_clk);
 		}
 	}
-	if ((int_clk_status | fun_clk_status) != DSP_SOK)
-		return DSP_EFAIL;
-	return DSP_SOK;
+	return clk_status;
 }
 
 void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
-- 
1.6.2.4


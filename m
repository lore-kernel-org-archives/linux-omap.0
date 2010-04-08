From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 16/19] DSPBRIDGE: Move MCBSP_CLOCKS code to a common place
Date: Thu,  8 Apr 2010 18:16:05 -0500
Message-ID: <1270768568-10712-17-git-send-email-omar.ramirez@ti.com>
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
 <1270768568-10712-16-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41604 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933811Ab0DHW7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 18:59:32 -0400
In-Reply-To: <1270768568-10712-16-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Given that:
"Bridge should enable McBSP_CLKS (using T2 clock) so that DPLL4
 can be gated. Once McBSP2 clock is released, it should disable
 McBSP_CLKS as it prevents PER and CORE domain transitions when
 OFF is set to target power state."

It seems this code was duplicated, now it has been moved to be
called only when dsp is requesting a MCBSP clock.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c       |   40 +++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   73 -------------------------------
 2 files changed, 40 insertions(+), 73 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index aa706ce..711bae4 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -25,6 +25,8 @@
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
+#include <dspbridge/cfg.h>
+#include <dspbridge/drv.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
@@ -134,6 +136,42 @@ static void ssi_clk_prepare(bool FLAG)
 	iounmap(ssi_base);
 }
 
+static void mcbsp_clk_prepare(bool flag, u8 id)
+{
+	struct cfg_hostres resources;
+	u32 value;
+
+	cfg_get_host_resources((struct cfg_devnode *)
+			       drv_get_first_dev_extension(), &resources);
+
+	if (flag) {
+		if (id == DSP_CLK_MCBSP1) {
+			/* set MCBSP1_CLKS, on McBSP1 ON */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value |= 1 << 2;
+			__raw_writel(value, resources.dw_sys_ctrl_base
+					     + 0x274);
+		} else if (id == DSP_CLK_MCBSP2) {
+			/* set MCBSP2_CLKS, on McBSP2 ON */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value |= 1 << 6;
+			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+		}
+	} else {
+		if (id == DSP_CLK_MCBSP1) {
+			/* clear MCBSP1_CLKS, on McBSP1 OFF */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value &= ~(1 << 2);
+			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+		} else if (id == DSP_CLK_MCBSP2) {
+			/* clear MCBSP2_CLKS, on McBSP2 OFF */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value &= ~(1 << 6);
+			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+		}
+	}
+}
+
 /*
  *  ======== dsp_clk_enable ========
  *  Purpose:
@@ -149,6 +187,7 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
 		break;
 	case MCBSP_CLK:
+		mcbsp_clk_prepare(true, clk_id);
 		omap_mcbsp_set_io_type(MCBSP_ID(clk_id), OMAP_MCBSP_POLL_IO);
 		omap_mcbsp_request(MCBSP_ID(clk_id));
 		break;
@@ -193,6 +232,7 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		omap_dm_timer_free(timer[clk_id]);
 		break;
 	case MCBSP_CLK:
+		mcbsp_clk_prepare(false, clk_id);
 		omap_mcbsp_free(MCBSP_ID(clk_id));
 		break;
 	case WDT_CLK:
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 5c518d0..a6e8e57 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -300,20 +300,11 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 	u32 tmp_index;
 	u32 dsp_per_clks_before;
 	dsp_status status = DSP_SOK;
-	struct cfg_hostres resources;
-	u32 value;
 
 	dsp_per_clks_before = dev_context->dsp_per_clks;
 
 	ext_clk = (u32) *((u32 *) pargs);
 
-	status = cfg_get_host_resources((struct cfg_devnode *)
-					drv_get_first_dev_extension(),
-					&resources);
-
-	if (DSP_FAILED(status))
-		return DSP_EFAIL;
-
 	ext_clk_id = ext_clk & MBX_PM_CLK_IDMASK;
 
 	/* process the power message -- TODO, keep it in a separate function */
@@ -333,17 +324,6 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 	ext_clk_cmd = (ext_clk >> MBX_PM_CLK_CMDSHIFT) & MBX_PM_CLK_CMDMASK;
 	switch (ext_clk_cmd) {
 	case BPWR_DISABLE_CLOCK:
-		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
-			/* clear MCBSP1_CLKS, on McBSP1 OFF */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value &= ~(1 << 2);
-			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
-		} else if (bpwr_clkid[clk_id_index] == BPWR_MCBSP2) {
-			/* clear MCBSP2_CLKS, on McBSP2 OFF */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value &= ~(1 << 6);
-			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
-		}
 		status = dsp_clk_disable(bpwr_clks[clk_id_index].clk);
 		dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id,
 					  false);
@@ -354,17 +334,6 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 		break;
 	case BPWR_ENABLE_CLOCK:
 		status = dsp_clk_enable(bpwr_clks[clk_id_index].clk);
-		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
-			/* set MCBSP1_CLKS, on McBSP1 ON */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value |= 1 << 2;
-			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
-		} else if (bpwr_clkid[clk_id_index] == BPWR_MCBSP2) {
-			/* set MCBSP2_CLKS, on McBSP2 ON */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value |= 1 << 6;
-			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
-		}
 		dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id, true);
 		if (DSP_SUCCEEDED(status))
 			(dev_context->dsp_per_clks) |= (1 << clk_id_index);
@@ -462,31 +431,9 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
 {
 	u32 clk_idx;
 	dsp_status status = DSP_SOK;
-	struct cfg_hostres resources;
-	u32 value;
-
-	status = cfg_get_host_resources((struct cfg_devnode *)
-					drv_get_first_dev_extension(),
-					&resources);
 
 	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
-			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
-				/* clear MCBSP1_CLKS, on McBSP1 OFF */
-				value = __raw_readl(resources.dw_sys_ctrl_base
-						    + 0x274);
-				value &= ~(1 << 2);
-				__raw_writel(value, resources.dw_sys_ctrl_base
-					     + 0x274);
-			} else if (bpwr_clkid[clk_idx] == BPWR_MCBSP2) {
-				/* clear MCBSP2_CLKS, on McBSP2 OFF */
-				value = __raw_readl(resources.dw_sys_ctrl_base
-						    + 0x274);
-				value &= ~(1 << 6);
-				__raw_writel(value, resources.dw_sys_ctrl_base
-					     + 0x274);
-			}
-
 			/* Disables the clocks of the peripheral */
 			status = dsp_clk_disable(bpwr_clks[clk_idx].clk);
 		}
@@ -503,31 +450,11 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 {
 	u32 clk_idx;
 	dsp_status clk_status = DSP_EFAIL;
-	struct cfg_hostres resources;
-	u32 value;
-
-	cfg_get_host_resources((struct cfg_devnode *)
-			       drv_get_first_dev_extension(), &resources);
 
 	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
 			/* Enable the clocks of the peripheral */
 			clk_status = dsp_clk_enable(bpwr_clks[clk_idx].clk);
-			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
-				/* set MCBSP1_CLKS, on McBSP1 ON */
-				value = __raw_readl(resources.dw_sys_ctrl_base
-						    + 0x274);
-				value |= 1 << 2;
-				__raw_writel(value, resources.dw_sys_ctrl_base
-					     + 0x274);
-			} else if (bpwr_clkid[clk_idx] == BPWR_MCBSP2) {
-				/* set MCBSP2_CLKS, on McBSP2 ON */
-				value = __raw_readl(resources.dw_sys_ctrl_base
-						    + 0x274);
-				value |= 1 << 6;
-				__raw_writel(value, resources.dw_sys_ctrl_base
-					     + 0x274);
-			}
 		}
 	}
 	return clk_status;
-- 
1.6.2.4


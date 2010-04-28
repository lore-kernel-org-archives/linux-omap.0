From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: Move MCBSP_CLOCKS code to a common place
Date: Tue, 27 Apr 2010 20:29:24 -0500
Message-ID: <1272418167-12630-17-git-send-email-omar.ramirez@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-2-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-3-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-5-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-7-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-9-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-10-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-11-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-13-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-14-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-15-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-16-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41690 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab0D1BYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 21:24:33 -0400
In-Reply-To: <1272418167-12630-16-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Given that:
"Bridge should enable McBSP_CLKS (using T2 clock) so that DPLL4
 can be gated. Once McBSP2 clock is released, it should disable
 McBSP_CLKS as it prevents PER and CORE domain transitions when
 OFF is set to target power state."

It seems this code was duplicated, now it has been moved to be
called only when dsp is requesting a MCBSP clock.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c       |   52 +++++++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   77 -------------------------------
 2 files changed, 52 insertions(+), 77 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 9a439c7..763a599 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -25,6 +25,10 @@
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
+#include <dspbridge/cfg.h>
+#include <dspbridge/drv.h>
+#include <dspbridge/dev.h>
+#include "_tiomap.h"
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
@@ -124,6 +128,52 @@ void dsp_clk_init(void)
 					ssi.sst_fck, ssi.ssr_fck, ssi.ick);
 }
 
+static void mcbsp_clk_prepare(bool flag, u8 id)
+{
+	struct cfg_hostres *resources;
+	struct dev_object *hdev_object = NULL;
+	struct wmd_dev_context *wmd_context = NULL;
+	u32 val;
+
+	hdev_object = (struct dev_object *)drv_get_first_dev_object();
+	if (!hdev_object)
+		return;
+
+	dev_get_wmd_context(hdev_object, &wmd_context);
+	if (!wmd_context)
+		return;
+
+	resources = wmd_context->resources;
+	if (!resources)
+		return;
+
+	if (flag) {
+		if (id == DSP_CLK_MCBSP1) {
+			/* set MCBSP1_CLKS, on McBSP1 ON */
+			val = __raw_readl(resources->dw_sys_ctrl_base + 0x274);
+			val |= 1 << 2;
+			__raw_writel(val, resources->dw_sys_ctrl_base + 0x274);
+		} else if (id == DSP_CLK_MCBSP2) {
+			/* set MCBSP2_CLKS, on McBSP2 ON */
+			val = __raw_readl(resources->dw_sys_ctrl_base + 0x274);
+			val |= 1 << 6;
+			__raw_writel(val, resources->dw_sys_ctrl_base + 0x274);
+		}
+	} else {
+		if (id == DSP_CLK_MCBSP1) {
+			/* clear MCBSP1_CLKS, on McBSP1 OFF */
+			val = __raw_readl(resources->dw_sys_ctrl_base + 0x274);
+			val &= ~(1 << 2);
+			__raw_writel(val, resources->dw_sys_ctrl_base + 0x274);
+		} else if (id == DSP_CLK_MCBSP2) {
+			/* clear MCBSP2_CLKS, on McBSP2 OFF */
+			val = __raw_readl(resources->dw_sys_ctrl_base + 0x274);
+			val &= ~(1 << 6);
+			__raw_writel(val, resources->dw_sys_ctrl_base + 0x274);
+		}
+	}
+}
+
 /*
  *  ======== dsp_clk_enable ========
  *  Purpose:
@@ -142,6 +192,7 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
 		break;
 	case MCBSP_CLK:
+		mcbsp_clk_prepare(true, clk_id);
 		omap_mcbsp_set_io_type(MCBSP_ID(clk_id), OMAP_MCBSP_POLL_IO);
 		omap_mcbsp_request(MCBSP_ID(clk_id));
 		break;
@@ -187,6 +238,7 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		omap_dm_timer_free(timer[clk_id]);
 		break;
 	case MCBSP_CLK:
+		mcbsp_clk_prepare(false, clk_id);
 		omap_mcbsp_free(MCBSP_ID(clk_id));
 		break;
 	case WDT_CLK:
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 879f99e..6d1d557 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -288,16 +288,10 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 	u32 tmp_index;
 	u32 dsp_per_clks_before;
 	dsp_status status = DSP_SOK;
-	struct cfg_hostres *resources = dev_context->resources;
-	u32 value;
 
 	dsp_per_clks_before = dev_context->dsp_per_clks;
 
 	ext_clk = (u32) *((u32 *) pargs);
-
-	if (!resources)
-		return -EPERM;
-
 	ext_clk_id = ext_clk & MBX_PM_CLK_IDMASK;
 
 	/* process the power message -- TODO, keep it in a separate function */
@@ -317,21 +311,6 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 	ext_clk_cmd = (ext_clk >> MBX_PM_CLK_CMDSHIFT) & MBX_PM_CLK_CMDMASK;
 	switch (ext_clk_cmd) {
 	case BPWR_DISABLE_CLOCK:
-		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
-			/* clear MCBSP1_CLKS, on McBSP1 OFF */
-			value = __raw_readl(
-				resources->dw_sys_ctrl_base + 0x274);
-			value &= ~(1 << 2);
-			__raw_writel(value,
-				resources->dw_sys_ctrl_base + 0x274);
-		} else if (bpwr_clkid[clk_id_index] == BPWR_MCBSP2) {
-			/* clear MCBSP2_CLKS, on McBSP2 OFF */
-			value = __raw_readl(
-				resources->dw_sys_ctrl_base + 0x274);
-			value &= ~(1 << 6);
-			__raw_writel(value,
-				resources->dw_sys_ctrl_base + 0x274);
-		}
 		status = dsp_clk_disable(bpwr_clks[clk_id_index].clk);
 		dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id,
 					  false);
@@ -342,21 +321,6 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 		break;
 	case BPWR_ENABLE_CLOCK:
 		status = dsp_clk_enable(bpwr_clks[clk_id_index].clk);
-		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
-			/* set MCBSP1_CLKS, on McBSP1 ON */
-			value = __raw_readl(
-				resources->dw_sys_ctrl_base + 0x274);
-			value |= 1 << 2;
-			__raw_writel(value,
-				resources->dw_sys_ctrl_base + 0x274);
-		} else if (bpwr_clkid[clk_id_index] == BPWR_MCBSP2) {
-			/* set MCBSP2_CLKS, on McBSP2 ON */
-			value = __raw_readl(
-				resources->dw_sys_ctrl_base + 0x274);
-			value |= 1 << 6;
-			__raw_writel(value,
-				resources->dw_sys_ctrl_base + 0x274);
-		}
 		dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id, true);
 		if (DSP_SUCCEEDED(status))
 			(dev_context->dsp_per_clks) |= (1 << clk_id_index);
@@ -454,30 +418,9 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
 {
 	u32 clk_idx;
 	dsp_status status = DSP_SOK;
-	struct cfg_hostres *resources = dev_context->resources;
-	u32 value;
-
-	if (!resources)
-		return -EPERM;
 
 	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
-			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
-				/* clear MCBSP1_CLKS, on McBSP1 OFF */
-				value = __raw_readl(resources->dw_sys_ctrl_base
-						    + 0x274);
-				value &= ~(1 << 2);
-				__raw_writel(value, resources->dw_sys_ctrl_base
-					     + 0x274);
-			} else if (bpwr_clkid[clk_idx] == BPWR_MCBSP2) {
-				/* clear MCBSP2_CLKS, on McBSP2 OFF */
-				value = __raw_readl(resources->dw_sys_ctrl_base
-						    + 0x274);
-				value &= ~(1 << 6);
-				__raw_writel(value, resources->dw_sys_ctrl_base
-					     + 0x274);
-			}
-
 			/* Disables the clocks of the peripheral */
 			status = dsp_clk_disable(bpwr_clks[clk_idx].clk);
 		}
@@ -494,31 +437,11 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 {
 	u32 clk_idx;
 	dsp_status clk_status = -EPERM;
-	struct cfg_hostres *resources = dev_context->resources;
-	u32 value;
-
-	if (!resources)
-		return -EPERM;
 
 	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
 			/* Enable the clocks of the peripheral */
 			clk_status = dsp_clk_enable(bpwr_clks[clk_idx].clk);
-			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
-				/* set MCBSP1_CLKS, on McBSP1 ON */
-				value = __raw_readl(resources->dw_sys_ctrl_base
-						    + 0x274);
-				value |= 1 << 2;
-				__raw_writel(value, resources->dw_sys_ctrl_base
-					     + 0x274);
-			} else if (bpwr_clkid[clk_idx] == BPWR_MCBSP2) {
-				/* set MCBSP2_CLKS, on McBSP2 ON */
-				value = __raw_readl(resources->dw_sys_ctrl_base
-						    + 0x274);
-				value |= 1 << 6;
-				__raw_writel(value, resources->dw_sys_ctrl_base
-					     + 0x274);
-			}
 		}
 	}
 	return clk_status;
-- 
1.6.0.4


From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Tue, 27 Apr 2010 20:29:19 -0500
Message-ID: <1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45746 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754248Ab0D1BYc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:32 -0400
In-Reply-To: <1272418167-12630-11-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

This patch switches to use DM timer framework instead of
a custom one for GPT timers, currently dsp can make use of
gpt 5, 6, 7 or 8.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@hotmail.com>
---
 drivers/dsp/bridge/services/clk.c   |   25 ++++++++++++-----------
 drivers/dsp/bridge/wmd/tiomap3430.c |   36 -----------------------------------
 2 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 9c994d3..37739a9 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -18,6 +18,7 @@
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <plat/dmtimer.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -47,24 +48,21 @@
 #define MCBSP_CLK	3
 #define SSI_CLK		4
 
+/*
+ * Bridge specific DM Timer macro.
+ * Bridge GPT id (1 - 4), DM Timer id (5 - 8)
+ */
+#define DMT_ID(id) ((id) + 4)
+
 struct dsp_clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
 	int id;
 };
 
-/* The row order of the below array needs to match with the clock enumerations
- * 'dsp_clk_id' provided in the header file.. any changes in the
- * enumerations needs to be fixed in the array as well */
+static struct omap_dm_timer *timer[4];
+
 static struct dsp_clk_t dsp_clks[] = {
-	{NULL, "gpt5_fck", -1},
-	{NULL, "gpt5_ick", -1},
-	{NULL, "gpt6_fck", -1},
-	{NULL, "gpt6_ick", -1},
-	{NULL, "gpt7_fck", -1},
-	{NULL, "gpt7_ick", -1},
-	{NULL, "gpt8_fck", -1},
-	{NULL, "gpt8_ick", -1},
 	{NULL, "wdt_fck", 3},
 	{NULL, "wdt_ick", 3},
 	{NULL, "mcbsp_fck", 1},
@@ -79,7 +77,6 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, "mcbsp_ick", 5},
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
-	{NULL, ""}
 };
 
 struct clk *iva2_clk;
@@ -146,6 +143,8 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		clk_enable(iva2_clk);
 		break;
 	case GPT_CLK:
+		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
+		break;
 	case MCBSP_CLK:
 	case WDT_CLK:
 	case SSI_CLK:
@@ -192,6 +191,8 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		clk_disable(iva2_clk);
 		break;
 	case GPT_CLK:
+		omap_dm_timer_free(timer[clk_id]);
+		break;
 	case MCBSP_CLK:
 	case WDT_CLK:
 	case SSI_CLK:
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index bb78df2..38338d1 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -392,9 +392,6 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 	u32 clk_cmd;
 	struct io_mgr *hio_mgr;
 	u32 ul_load_monitor_timer;
-	u32 ext_clk_id = 0;
-	u32 tmp_index;
-	u32 clk_id_index = MBX_PM_MAX_RESOURCES;
 	struct dspbridge_platform_data *pdata =
 				omap_dspbridge_dev->dev.platform_data;
 
@@ -529,25 +526,9 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 
 	if (DSP_SUCCEEDED(status)) {
 		if (ul_load_monitor_timer != 0xFFFF) {
-			clk_cmd = (BPWR_DISABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
-			    ul_load_monitor_timer;
-
-			dsp_peripheral_clk_ctrl(dev_context, &clk_cmd);
-
-			ext_clk_id = clk_cmd & MBX_PM_CLK_IDMASK;
-			for (tmp_index = 0; tmp_index < MBX_PM_MAX_RESOURCES;
-			     tmp_index++) {
-				if (ext_clk_id == bpwr_clkid[tmp_index]) {
-					clk_id_index = tmp_index;
-					break;
-				}
-			}
-
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
 			    ul_load_monitor_timer;
-
 			dsp_peripheral_clk_ctrl(dev_context, &clk_cmd);
-
 		} else {
 			dev_dbg(bridge, "Not able to get the symbol for Load "
 				"Monitor Timer\n");
@@ -556,26 +537,9 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 
 	if (DSP_SUCCEEDED(status)) {
 		if (ul_bios_gp_timer != 0xFFFF) {
-			clk_cmd = (BPWR_DISABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
-			    ul_bios_gp_timer;
-
-			dsp_peripheral_clk_ctrl(dev_context, &clk_cmd);
-
-			ext_clk_id = clk_cmd & MBX_PM_CLK_IDMASK;
-
-			for (tmp_index = 0; tmp_index < MBX_PM_MAX_RESOURCES;
-			     tmp_index++) {
-				if (ext_clk_id == bpwr_clkid[tmp_index]) {
-					clk_id_index = tmp_index;
-					break;
-				}
-			}
-
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
 			    ul_bios_gp_timer;
-
 			dsp_peripheral_clk_ctrl(dev_context, &clk_cmd);
-
 		} else {
 			dev_dbg(bridge,
 				"Not able to get the symbol for BIOS Timer\n");
-- 
1.6.0.4


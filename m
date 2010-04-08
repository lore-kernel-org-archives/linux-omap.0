From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 11/19] DSPBRIDGE: use dm timer framework for gpt timers
Date: Thu,  8 Apr 2010 18:16:00 -0500
Message-ID: <1270768568-10712-12-git-send-email-omar.ramirez@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41611 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933801Ab0DHW7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 18:59:36 -0400
In-Reply-To: <1270768568-10712-11-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

This patch switches to use DM timer framework instead of
a custom one for GPT timers, currently dsp can make use of
gpt 5, 6, 7 or 8.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@hotmail.com>
---
 drivers/dsp/bridge/services/clk.c   |   28 ++++++++++++++------------
 drivers/dsp/bridge/wmd/tiomap3430.c |   36 -----------------------------------
 2 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 6e76dd3..46b4cab 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -18,6 +18,7 @@
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <plat/dmtimer.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -49,24 +50,21 @@
 #define MCBSP_CLK	2
 #define SSI_CLK		3
 
+/*
+ * Bridge specific DM Timer macro.
+ * Bridge GPT id (0 - 3), DM Timer id (5 - 8)
+ */
+#define DMT_ID(id) ((id) + 5)
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
@@ -81,7 +79,6 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, "mcbsp_ick", 5},
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
-	{NULL, ""}
 };
 
 static s8 get_clk_type(u8 id)
@@ -132,11 +129,12 @@ bool dsp_clk_init(void)
 	static struct platform_device dspbridge_device;
 	struct clk *clk_handle;
 	int i = 0;
+	int num_clks = ARRAY_SIZE(dsp_clks);
 
 	dspbridge_device.dev.bus = &platform_bus_type;
 
 	/* Get the clock handles from base port and store locally */
-	while (i < DSP_CLK_NOT_DEFINED) {
+	while (i < num_clks) {
 		/* get the handle from BP */
 		dspbridge_device.id = dsp_clks[i].id;
 
@@ -169,6 +167,8 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 
 	switch (get_clk_type(clk_id)) {
 	case GPT_CLK:
+		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
+		break;
 	case MCBSP_CLK:
 	case WDT_CLK:
 	case SSI_CLK:
@@ -212,6 +212,8 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 
 	switch (get_clk_type(clk_id)) {
 	case GPT_CLK:
+		omap_dm_timer_free(timer[clk_id]);
+		break;
 	case MCBSP_CLK:
 	case WDT_CLK:
 	case SSI_CLK:
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index fedd521..f3b5bdb 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -436,9 +436,6 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 	u32 clk_cmd;
 	struct io_mgr *hio_mgr;
 	u32 ul_load_monitor_timer;
-	u32 ext_clk_id = 0;
-	u32 tmp_index;
-	u32 clk_id_index = MBX_PM_MAX_RESOURCES;
 
 	/* The device context contains all the mmu setup info from when the
 	 * last dsp base image was loaded. The first entry is always
@@ -573,25 +570,9 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 
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
@@ -600,26 +581,9 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 
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
1.6.2.4


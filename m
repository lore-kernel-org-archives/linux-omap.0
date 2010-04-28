From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: use omap mcbsp to enable mcbsp clocks
Date: Tue, 27 Apr 2010 20:29:20 -0500
Message-ID: <1272418167-12630-13-git-send-email-omar.ramirez@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45750 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab0D1BYd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:33 -0400
In-Reply-To: <1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Use omap mcbsp to enable mcbsp clocks

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 37739a9..2e3c64d 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -19,6 +19,7 @@
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
 #include <plat/dmtimer.h>
+#include <plat/mcbsp.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -48,12 +49,12 @@
 #define MCBSP_CLK	3
 #define SSI_CLK		4
 
-/*
- * Bridge specific DM Timer macro.
- * Bridge GPT id (1 - 4), DM Timer id (5 - 8)
- */
+/* Bridge GPT id (1 - 4), DM Timer id (5 - 8) */
 #define DMT_ID(id) ((id) + 4)
 
+/* Bridge MCBSP id (6 - 10), OMAP Mcbsp id (1 - 5) */
+#define MCBSP_ID(id) ((id) - 13)
+
 struct dsp_clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
@@ -65,16 +66,6 @@ static struct omap_dm_timer *timer[4];
 static struct dsp_clk_t dsp_clks[] = {
 	{NULL, "wdt_fck", 3},
 	{NULL, "wdt_ick", 3},
-	{NULL, "mcbsp_fck", 1},
-	{NULL, "mcbsp_ick", 1},
-	{NULL, "mcbsp_fck", 2},
-	{NULL, "mcbsp_ick", 2},
-	{NULL, "mcbsp_fck", 3},
-	{NULL, "mcbsp_ick", 3},
-	{NULL, "mcbsp_fck", 4},
-	{NULL, "mcbsp_ick", 4},
-	{NULL, "mcbsp_fck", 5},
-	{NULL, "mcbsp_ick", 5},
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
 };
@@ -146,6 +137,9 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
 		break;
 	case MCBSP_CLK:
+		omap_mcbsp_set_io_type(MCBSP_ID(clk_id), OMAP_MCBSP_POLL_IO);
+		omap_mcbsp_request(MCBSP_ID(clk_id));
+		break;
 	case WDT_CLK:
 	case SSI_CLK:
 		clk_handle = dsp_clks[clk_id].clk_handle;
@@ -194,6 +188,8 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		omap_dm_timer_free(timer[clk_id]);
 		break;
 	case MCBSP_CLK:
+		omap_mcbsp_free(MCBSP_ID(clk_id));
+		break;
 	case WDT_CLK:
 	case SSI_CLK:
 		clk_handle = dsp_clks[clk_id].clk_handle;
-- 
1.6.0.4


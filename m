From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: remove wdt3 from dsp control
Date: Tue, 27 Apr 2010 20:29:21 -0500
Message-ID: <1272418167-12630-14-git-send-email-omar.ramirez@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56116 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab0D1BYb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:31 -0400
In-Reply-To: <1272418167-12630-13-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

WDT3 is used as a way to detect dsp hangs, as of now its
control is left to arm side driver, so, no requests should
be received by the dsp to enable/disable this clock.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 2e3c64d..ee85905 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -64,8 +64,6 @@ struct dsp_clk_t {
 static struct omap_dm_timer *timer[4];
 
 static struct dsp_clk_t dsp_clks[] = {
-	{NULL, "wdt_fck", 3},
-	{NULL, "wdt_ick", 3},
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
 };
@@ -141,6 +139,8 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		omap_mcbsp_request(MCBSP_ID(clk_id));
 		break;
 	case WDT_CLK:
+		dev_err(bridge, "ERROR: DSP requested to enable WDT3 clk\n");
+		break;
 	case SSI_CLK:
 		clk_handle = dsp_clks[clk_id].clk_handle;
 		if (clk_enable(clk_handle)) {
@@ -191,6 +191,8 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		omap_mcbsp_free(MCBSP_ID(clk_id));
 		break;
 	case WDT_CLK:
+		dev_err(bridge, "ERROR: DSP requested to disable WDT3 clk\n");
+		break;
 	case SSI_CLK:
 		clk_handle = dsp_clks[clk_id].clk_handle;
 
-- 
1.6.0.4


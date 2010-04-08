From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 13/19] DSPBRIDGE: remove wdt3 from dsp control
Date: Thu,  8 Apr 2010 18:16:02 -0500
Message-ID: <1270768568-10712-14-git-send-email-omar.ramirez@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59845 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933762Ab0DHW7h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:37 -0400
In-Reply-To: <1270768568-10712-13-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

WDT3 is used as a way to detect dsp hangs, as of now its
control is left to arm side driver, so, no requests should
be received by the dsp to enable/disable this clock.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index ae46e47..a7d82bd 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -66,8 +66,6 @@ struct dsp_clk_t {
 static struct omap_dm_timer *timer[4];
 
 static struct dsp_clk_t dsp_clks[] = {
-	{NULL, "wdt_fck", 3},
-	{NULL, "wdt_ick", 3},
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
 };
@@ -165,6 +163,8 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		omap_mcbsp_request(MCBSP_ID(clk_id));
 		break;
 	case WDT_CLK:
+		dev_err(bridge, "ERROR: DSP requested to enable WDT3 clk\n");
+		break;
 	case SSI_CLK:
 		clk_handle = dsp_clks[clk_id].clk_handle;
 		if (clk_enable(clk_handle)) {
@@ -212,6 +212,8 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		omap_mcbsp_free(MCBSP_ID(clk_id));
 		break;
 	case WDT_CLK:
+		dev_err(bridge, "ERROR: DSP requested to disable WDT3 clk\n");
+		break;
 	case SSI_CLK:
 		clk_handle = dsp_clks[clk_id].clk_handle;
 
-- 
1.6.2.4


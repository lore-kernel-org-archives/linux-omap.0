From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/5] OMAP: DSS2: DSI: fix dsi_dump_clocks()
Date: Fri, 15 Apr 2011 11:11:08 +0300
Message-ID: <1302855071-5510-3-git-send-email-tomi.valkeinen@ti.com>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42566 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973Ab1DOILa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 04:11:30 -0400
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

On OMAP4, reading DSI_PLL_CONFIGURATION2 register requires the L3 clock
(CIO_CLK_ICG) to PLL. Currently dsi_dump_clocks() tries to read that
register without enabling the L3 clock, leading to crash if DSI is not
in use.

The status of the bit being read from DSI_PLL_CONFIGURATION2 is
available from dsi_clock_info->use_sys_clk, so we can avoid the whole
problem by just using that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8604153..1464ac4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1491,7 +1491,6 @@ void dsi_pll_uninit(void)
 
 void dsi_dump_clocks(struct seq_file *s)
 {
-	int clksel;
 	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
 	enum dss_clk_source dispc_clk_src, dsi_clk_src;
 
@@ -1500,13 +1499,10 @@ void dsi_dump_clocks(struct seq_file *s)
 
 	enable_clocks(1);
 
-	clksel = REG_GET(DSI_PLL_CONFIGURATION2, 11, 11);
-
 	seq_printf(s,	"- DSI PLL -\n");
 
 	seq_printf(s,	"dsi pll source = %s\n",
-			clksel == 0 ?
-			"dss_sys_clk" : "pclkfree");
+			cinfo->use_sys_clk ? "dss_sys_clk" : "pclkfree");
 
 	seq_printf(s,	"Fint\t\t%-16luregn %u\n", cinfo->fint, cinfo->regn);
 
-- 
1.7.1


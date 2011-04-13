From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/5] OMAP: DSS2: DSI: fix dsi_dump_clocks()
Date: Wed, 13 Apr 2011 09:50:14 +0300
Message-ID: <1302677417-4590-3-git-send-email-tomi.valkeinen@ti.com>
References: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:58161 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755295Ab1DMGuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 02:50:37 -0400
Received: by mail-ey0-f171.google.com with SMTP id d26so129902eyd.30
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 23:50:36 -0700 (PDT)
In-Reply-To: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
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
index 74334b5..1cc4f37 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1481,7 +1481,6 @@ void dsi_pll_uninit(void)
 
 void dsi_dump_clocks(struct seq_file *s)
 {
-	int clksel;
 	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
 	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
 
@@ -1490,13 +1489,10 @@ void dsi_dump_clocks(struct seq_file *s)
 
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


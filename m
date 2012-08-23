From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/8] OMAP: 4430SDP: remove DSI clock config from board file
Date: Thu, 23 Aug 2012 16:45:13 +0300
Message-ID: <1345729514-2441-8-git-send-email-tomi.valkeinen@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:56911 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933657Ab2HWNpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:47 -0400
Received: by lbon3 with SMTP id n3so399316lbo.28
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:44 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

DSI clocks are now configured dynamically by the DSI driver, so we can
remove the hardcoded clock configuration from the board file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   46 -----------------------------------
 1 file changed, 46 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 852e05c..4352d91 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -621,29 +621,6 @@ static struct omap_dss_device sdp4430_lcd_device = {
 	.phy.dsi		= {
 		.module		= 0,
 	},
-
-	.clocks = {
-		.dispc = {
-			.channel = {
-				/* Logic Clock = 172.8 MHz */
-				.lck_div	= 1,
-				/* Pixel Clock = 34.56 MHz */
-				.pck_div	= 5,
-				.lcd_clk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,
-			},
-			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
-		},
-
-		.dsi = {
-			.regn		= 16,	/* Fint = 2.4 MHz */
-			.regm		= 180,	/* DDR Clock = 216 MHz */
-			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
-			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
-
-			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
-			.dsi_fclk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,
-		},
-	},
 	.channel		= OMAP_DSS_CHANNEL_LCD,
 };
 
@@ -668,29 +645,6 @@ static struct omap_dss_device sdp4430_lcd2_device = {
 
 		.module		= 1,
 	},
-
-	.clocks = {
-		.dispc = {
-			.channel = {
-				/* Logic Clock = 172.8 MHz */
-				.lck_div	= 1,
-				/* Pixel Clock = 34.56 MHz */
-				.pck_div	= 5,
-				.lcd_clk_src	= OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC,
-			},
-			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
-		},
-
-		.dsi = {
-			.regn		= 16,	/* Fint = 2.4 MHz */
-			.regm		= 180,	/* DDR Clock = 216 MHz */
-			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
-			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
-
-			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
-			.dsi_fclk_src	= OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI,
-		},
-	},
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-- 
1.7.9.5


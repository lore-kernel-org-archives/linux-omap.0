From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 1/4] OMAP: DSS2: Adding dss_features for independent core clk divider
Date: Thu,  3 Feb 2011 19:39:18 +0530
Message-ID: <1296742161-9395-2-git-send-email-raghuveer.murthy@ti.com>
References: <1296742161-9395-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34560 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185Ab1BCOOr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:14:47 -0500
In-Reply-To: <1296742161-9395-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

In OMAP3xxx DISPC_DIVISOR register has a logical clock divisor (lcd_div)
field. The lcd_div is common, for deciding the DISPC core functional clock
frequency, and the final pixel clock frequency for LCD display.

In OMAP4, there are 2 LCD channels, hence two divisor registers, DISPC_DIVISOR1
and DISPC_DIVISOR2. Also, there is a third register DISPC_DIVISOR.

The DISPC_DIVISOR in OMAP4 is used to configure lcd_div exclusively for core
functional clock configuration. For pixel clock configuration of primary and
secondary LCDs, lcd_div of DISPC_DIVISOR1 and DISPC_DIVISOR2 are used
respectively

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 4630f0c..39864f6 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -191,7 +191,7 @@ static struct omap_dss_features omap4_dss_features = {
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
 		FEAT_MGR_LCD2 | FEAT_VAR_DPLL_FCK |
-		FEAT_DPLL_FCK_32_DIV,
+		FEAT_DPLL_FCK_32_DIV | FEAT_CORE_CLK_DIV,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 76b5fce..ed5c880 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -37,6 +37,8 @@ enum dss_feat_id {
 	FEAT_VAR_DPLL_FCK		= 1 << 9, /* Variable DPLL Func CLK */
 	/* DPLL FCLK has max divider value 32 */
 	FEAT_DPLL_FCK_32_DIV		= 1 << 10,
+	/* Independent core clk divider */
+	FEAT_CORE_CLK_DIV		= 1 << 11,
 };
 
 /* DSS register field id */
-- 
1.7.0.4


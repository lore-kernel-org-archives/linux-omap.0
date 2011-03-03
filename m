From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH v3 1/3] OMAP: DSS2: Adding dss_features for independent core clk divider
Date: Thu,  3 Mar 2011 20:57:58 +0530
Message-ID: <1299166080-15380-2-git-send-email-raghuveer.murthy@ti.com>
References: <1299166080-15380-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48816 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758261Ab1CCP1k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 10:27:40 -0500
In-Reply-To: <1299166080-15380-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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
 drivers/video/omap2/dss/dss_features.c |    3 ++-
 drivers/video/omap2/dss/dss_features.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index ccae57b..dc170ad 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -234,7 +234,8 @@ static struct omap_dss_features omap4_dss_features = {
 
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
-		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1,
+		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
+		FEAT_CORE_CLK_DIV,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 65d6de7..569d1b2 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -36,6 +36,8 @@ enum dss_feat_id {
 	FEAT_LINEBUFFERSPLIT	= 1 << 8,
 	FEAT_ROWREPEATENABLE	= 1 << 9,
 	FEAT_RESIZECONF		= 1 << 10,
+	/* Independent core clk divider */
+	FEAT_CORE_CLK_DIV	= 1 << 11,
 };
 
 /* DSS register field id */
-- 
1.7.0.4


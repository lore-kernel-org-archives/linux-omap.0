From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH v1 1/3] OMAP: DSS2: Adding dss_features for independent core clk divider
Date: Thu,  3 Mar 2011 15:25:28 +0530
Message-ID: <1299146130-8269-2-git-send-email-raghuveer.murthy@ti.com>
References: <1299146130-8269-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43407 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab1CCJzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 04:55:12 -0500
In-Reply-To: <1299146130-8269-1-git-send-email-raghuveer.murthy@ti.com>
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
index fe22d11..82a4ac3 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -195,7 +195,7 @@ static struct omap_dss_features omap4_dss_features = {
 
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
-		FEAT_MGR_LCD2,
+		FEAT_MGR_LCD2 | FEAT_CORE_CLK_DIV,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index b9c70be..24fcef5 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -33,6 +33,8 @@ enum dss_feat_id {
 	FEAT_PCKFREEENABLE	= 1 << 5,
 	FEAT_FUNCGATED		= 1 << 6,
 	FEAT_MGR_LCD2		= 1 << 7,
+	/* Independent core clk divider */
+	FEAT_CORE_CLK_DIV	= 1 << 8,
 };
 
 /* DSS register field id */
-- 
1.7.0.4


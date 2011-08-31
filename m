From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/8] OMAP: DSS2: HDMI: use default dividers
Date: Wed, 31 Aug 2011 16:21:42 +0300
Message-ID: <1314796908-17354-3-git-send-email-tomi.valkeinen@ti.com>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:39029 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755534Ab1HaNWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:22:10 -0400
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use default regn and regm2 dividers in the hdmi driver if the board file
does not define them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    9 ---------
 drivers/video/omap2/dss/hdmi.c      |   15 +++++++++++++--
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 6713d6e..3fd7e8f 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -818,15 +818,6 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.clocks	= {
-		.dispc	= {
-			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
-		},
-		.hdmi	= {
-			.regn	= 15,
-			.regm2	= 1,
-		},
-	},
 	.platform_enable = sdp4430_panel_enable_hdmi,
 	.platform_disable = sdp4430_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b8e02e4..a3b3899 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -43,6 +43,9 @@
 #include "hdmi.h"
 #include "dss_features.h"
 
+#define HDMI_DEFAULT_REGN 15
+#define HDMI_DEFAULT_REGM2 1
+
 static struct {
 	struct mutex lock;
 	struct omap_display_platform_data *pdata;
@@ -1076,7 +1079,11 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	 * Input clock is predivided by N + 1
 	 * out put of which is reference clk
 	 */
-	pi->regn = dssdev->clocks.hdmi.regn;
+	if (dssdev->clocks.hdmi.regn == 0)
+		pi->regn = HDMI_DEFAULT_REGN;
+	else
+		pi->regn = dssdev->clocks.hdmi.regn;
+
 	refclk = clkin / (pi->regn + 1);
 
 	/*
@@ -1084,7 +1091,11 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	 * Multiplying by 100 to avoid fractional part removal
 	 */
 	pi->regm = (phy * 100 / (refclk)) / 100;
-	pi->regm2 = dssdev->clocks.hdmi.regm2;
+
+	if (dssdev->clocks.hdmi.regm2 == 0)
+		pi->regm2 = HDMI_DEFAULT_REGM2;
+	else
+		pi->regm2 = dssdev->clocks.hdmi.regm2;
 
 	/*
 	 * fractional multiplier is remainder of the difference between
-- 
1.7.4.1


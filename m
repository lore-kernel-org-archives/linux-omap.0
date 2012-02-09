From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/3] OMAPDSS: Add DSS feature for HDMI MCLK for audio
Date: Wed, 8 Feb 2012 21:10:21 -0600
Message-ID: <1328757023-20543-2-git-send-email-ricardo.neri@ti.com>
References: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42881 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757561Ab2BIDLA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 22:11:00 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q193B0Rq005358
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q193B0mj020241
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600 (CST)
In-Reply-To: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: a0393947@ti.com, molnar@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Certain OMAP4 revisions (i.e., 4430 ES2.3, 4460, and 4470) use
a pseudo clock (generated from the TMDS clock), MCLK, to drive the
generation of Audio Clock Regeneration packets. Other devices
(i.e., 4430 ES2.[0,2]) use the TMDS clock directly.

This patch adds a new DSS feature for MCLK support. It also rearranges
the omap_dss_features structures to reflect the devices supporting it.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   31 ++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index afcb593..162c9a9 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -432,6 +432,30 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.burst_size_unit = 16,
 };
 
+/* For OMAP4430 ES 2.0, 2.1 and 2.2 revisions */
+static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
+	.reg_fields = omap4_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
+
+	.has_feature	=
+		FEAT_MGR_LCD2 |
+		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
+		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
+		FEAT_DSI_GNQ | FEAT_HDMI_CTS_SWMODE |
+		FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 | FEAT_CPR |
+		FEAT_PRELOAD | FEAT_FIR_COEF_V | FEAT_ALPHA_FREE_ZORDER,
+
+	.num_mgrs = 3,
+	.num_ovls = 4,
+	.supported_displays = omap4_dss_supported_displays,
+	.supported_color_modes = omap4_dss_supported_color_modes,
+	.overlay_caps = omap4_dss_overlay_caps,
+	.clksrc_names = omap4_dss_clk_source_names,
+	.dss_params = omap4_dss_param_range,
+	.buffer_size_unit = 16,
+	.burst_size_unit = 16,
+};
+
 /* For all the other OMAP4 versions */
 static const struct omap_dss_features omap4_dss_features = {
 	.reg_fields = omap4_dss_reg_fields,
@@ -443,7 +467,8 @@ static const struct omap_dss_features omap4_dss_features = {
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
 		FEAT_DSI_GNQ | FEAT_HDMI_CTS_SWMODE |
 		FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 | FEAT_CPR |
-		FEAT_PRELOAD | FEAT_FIR_COEF_V | FEAT_ALPHA_FREE_ZORDER,
+		FEAT_PRELOAD | FEAT_FIR_COEF_V | FEAT_ALPHA_FREE_ZORDER |
+		FEAT_HDMI_AUDIO_USE_MCLK,
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
@@ -569,6 +594,10 @@ void dss_features_init(void)
 		omap_current_dss_features = &omap3430_dss_features;
 	else if (omap_rev() == OMAP4430_REV_ES1_0)
 		omap_current_dss_features = &omap4430_es1_0_dss_features;
+	else if (omap_rev() == OMAP4430_REV_ES2_0 ||
+		omap_rev() == OMAP4430_REV_ES2_1 ||
+		omap_rev() == OMAP4430_REV_ES2_2)
+		omap_current_dss_features = &omap4430_es2_0_1_2_dss_features;
 	else if (cpu_is_omap44xx())
 		omap_current_dss_features = &omap4_dss_features;
 	else
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index cd833bb..62dfb2e 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -58,6 +58,7 @@ enum dss_feat_id {
 	FEAT_FIR_COEF_V			= 1 << 25,
 	FEAT_ALPHA_FIXED_ZORDER		= 1 << 26,
 	FEAT_ALPHA_FREE_ZORDER		= 1 << 27,
+	FEAT_HDMI_AUDIO_USE_MCLK	= 1 << 28,
 };
 
 /* DSS register field id */
-- 
1.7.0.4


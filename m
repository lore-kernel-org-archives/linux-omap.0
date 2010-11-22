From: Archit Taneja <archit@ti.com>
Subject: [PATCH v5 1/7] OMAP: DSS2: Add dss_features for omap4 and overlay manager related features
Date: Mon, 22 Nov 2010 12:52:59 +0530
Message-ID: <1290410585-29418-2-git-send-email-archit@ti.com>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39395 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab0KVHXS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 02:23:18 -0500
In-Reply-To: <1290410585-29418-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add support for LCD2 manager through introducing a new has_feature,
Initialize a dss_features struct for omap4.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   43 ++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss_features.h |    7 ++++-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 854deba..8ab54ab 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -82,6 +82,18 @@ static const enum omap_display_type omap3_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_VENC,
 };
 
+static const enum omap_display_type omap4_dss_supported_displays[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DISPLAY_TYPE_VENC,
+
+	/* OMAP_DSS_CHANNEL_LCD2 */
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+	OMAP_DISPLAY_TYPE_DSI,
+};
+
 static const enum omap_color_mode omap2_dss_supported_color_modes[] = {
 	/* OMAP_DSS_GFX */
 	OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
@@ -127,6 +139,10 @@ static struct omap_dss_features omap2_dss_features = {
 	.reg_fields = omap2_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap2_dss_reg_fields),
 
+	.has_feature	=
+		FEAT_LCDENABLEPOL | FEAT_LCDENABLESIGNAL |
+		FEAT_PCKFREEENABLE | FEAT_FUNCGATED,
+
 	.num_mgrs = 2,
 	.num_ovls = 3,
 	.supported_displays = omap2_dss_supported_displays,
@@ -138,7 +154,10 @@ static struct omap_dss_features omap3430_dss_features = {
 	.reg_fields = omap3_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
 
-	.has_feature	= FEAT_GLOBAL_ALPHA,
+	.has_feature	=
+		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
+		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
+		FEAT_FUNCGATED,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -150,7 +169,10 @@ static struct omap_dss_features omap3630_dss_features = {
 	.reg_fields = omap3_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
 
-	.has_feature    = FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA,
+	.has_feature    =
+		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
+		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
+		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -158,6 +180,21 @@ static struct omap_dss_features omap3630_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
 
+/* OMAP4 DSS Features */
+static struct omap_dss_features omap4_dss_features = {
+	.reg_fields = omap3_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
+
+	.has_feature	=
+		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
+		FEAT_MGR_LCD2,
+
+	.num_mgrs = 3,
+	.num_ovls = 3,
+	.supported_displays = omap4_dss_supported_displays,
+	.supported_color_modes = omap3_dss_supported_color_modes,
+};
+
 /* Functions returning values related to a DSS feature */
 int dss_feat_get_num_mgrs(void)
 {
@@ -202,4 +239,6 @@ void dss_features_init(void)
 		omap_current_dss_features = &omap3630_dss_features;
 	else if (cpu_is_omap34xx())
 		omap_current_dss_features = &omap3430_dss_features;
+	else
+		omap_current_dss_features = &omap4_dss_features;
 }
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index aeb2eea..161d378 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -20,7 +20,7 @@
 #ifndef __OMAP2_DSS_FEATURES_H
 #define __OMAP2_DSS_FEATURES_H
 
-#define MAX_DSS_MANAGERS	2
+#define MAX_DSS_MANAGERS	3
 #define MAX_DSS_OVERLAYS	3
 
 /* DSS has feature id */
@@ -28,6 +28,11 @@ enum dss_feat_id {
 	FEAT_GLOBAL_ALPHA	= 1 << 0,
 	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
 	FEAT_PRE_MULT_ALPHA	= 1 << 2,
+	FEAT_LCDENABLEPOL	= 1 << 3,
+	FEAT_LCDENABLESIGNAL	= 1 << 4,
+	FEAT_PCKFREEENABLE	= 1 << 5,
+	FEAT_FUNCGATED		= 1 << 6,
+	FEAT_MGR_LCD2		= 1 << 7,
 };
 
 /* DSS register field id */
-- 
1.7.0.4


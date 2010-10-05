From: Archit Taneja <archit@ti.com>
Subject: [RFC v3][PATCH 1/4] OMAP: DSS2: Add dss_features for omap4 and new overlay manager level features
Date: Tue,  5 Oct 2010 17:25:21 +0530
Message-ID: <1286279724-11692-2-git-send-email-archit@ti.com>
References: <1286279724-11692-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38762 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab0JELyz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 07:54:55 -0400
In-Reply-To: <1286279724-11692-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add support for LCD2 manager through introducing a new has_feature,
Initialize a dss_features struct for omap4.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   39 ++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss_features.h |    7 +++++-
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 867f68d..fd1da4f 100644
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
+		FEAT_PCKFREEENABLE,
+
 	.num_mgrs = 2,
 	.num_ovls = 3,
 	.supported_displays = omap2_dss_supported_displays,
@@ -138,7 +154,9 @@ static struct omap_dss_features omap3_dss_features = {
 	.reg_fields = omap3_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
 
-	.has_feature	= FEAT_GLOBAL_ALPHA,
+	.has_feature	=
+		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
+		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -146,6 +164,21 @@ static struct omap_dss_features omap3_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
 
+/* OMAP4 DSS Features */
+static struct omap_dss_features omap4_dss_features = {
+	.reg_fields = omap3_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
+
+	.has_feature	=
+		FEAT_GLOBAL_ALPHA | FEAT_MGR_LCD2 |
+		FEAT_GAMMATABLE,
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
@@ -186,6 +219,8 @@ void dss_features_init(void)
 {
 	if (cpu_is_omap24xx())
 		omap_current_dss_features = &omap2_dss_features;
-	else
+	else if (cpu_is_omap34xx())
 		omap_current_dss_features = &omap3_dss_features;
+	else
+		omap_current_dss_features = &omap4_dss_features;
 }
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index cb231ea..2c31559 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -20,13 +20,18 @@
 #ifndef __OMAP2_DSS_FEATURES_H
 #define __OMAP2_DSS_FEATURES_H
 
-#define MAX_DSS_MANAGERS	2
+#define MAX_DSS_MANAGERS	3
 #define MAX_DSS_OVERLAYS	3
 
 /* DSS has feature id */
 enum dss_feat_id {
 	FEAT_GLOBAL_ALPHA	= 1 << 0,
 	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
+	FEAT_LCDENABLEPOL	= 1 << 2,
+	FEAT_LCDENABLESIGNAL	= 1 << 3,
+	FEAT_PCKFREEENABLE	= 1 << 4,
+	FEAT_MGR_LCD2		= 1 << 5,
+	FEAT_GAMMATABLE		= 1 << 6,
 };
 
 /* DSS register field id */
-- 
1.7.0.4


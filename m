From: Samreen <samreen@ti.com>
Subject: [PATCH v2 1/2] OMAP3: DSS2: Split OMAP3 has feature for 3430 & 3630
Date: Thu,  4 Nov 2010 16:58:41 +0530
Message-ID: <1288870122-22836-2-git-send-email-samreen@ti.com>
References: <1288870122-22836-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33692 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab0KDLeC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Nov 2010 07:34:02 -0400
In-Reply-To: <1288870122-22836-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ville.syrjala@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>, Archit Taneja <archit@ti.com>

Splitting the OMAP3 dss has feature separately for
omap3430 & omap3630

Signed-off-by: Samreen <samreen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   20 +++++++++++++++++---
 drivers/video/omap2/dss/dss_features.h |    1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 867f68d..854deba 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -134,7 +134,7 @@ static struct omap_dss_features omap2_dss_features = {
 };
 
 /* OMAP3 DSS Features */
-static struct omap_dss_features omap3_dss_features = {
+static struct omap_dss_features omap3430_dss_features = {
 	.reg_fields = omap3_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
 
@@ -146,6 +146,18 @@ static struct omap_dss_features omap3_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
 
+static struct omap_dss_features omap3630_dss_features = {
+	.reg_fields = omap3_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
+
+	.has_feature    = FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA,
+
+	.num_mgrs = 2,
+	.num_ovls = 3,
+	.supported_displays = omap3_dss_supported_displays,
+	.supported_color_modes = omap3_dss_supported_color_modes,
+};
+
 /* Functions returning values related to a DSS feature */
 int dss_feat_get_num_mgrs(void)
 {
@@ -186,6 +198,8 @@ void dss_features_init(void)
 {
 	if (cpu_is_omap24xx())
 		omap_current_dss_features = &omap2_dss_features;
-	else
-		omap_current_dss_features = &omap3_dss_features;
+	else if (cpu_is_omap3630())
+		omap_current_dss_features = &omap3630_dss_features;
+	else if (cpu_is_omap34xx())
+		omap_current_dss_features = &omap3430_dss_features;
 }
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index cb231ea..aeb2eea 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -27,6 +27,7 @@
 enum dss_feat_id {
 	FEAT_GLOBAL_ALPHA	= 1 << 0,
 	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
+	FEAT_PRE_MULT_ALPHA	= 1 << 2,
 };
 
 /* DSS register field id */
-- 
1.5.6.3


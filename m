From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 30/32] OMAPDSS: export dss_feat functions
Date: Thu, 15 Nov 2012 17:58:38 +0200
Message-ID: <1352995120-3288-31-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59151 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768316Ab2KOQAB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 11:00:01 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Export dss_features related functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    5 +++++
 drivers/video/omap2/dss/dss_features.h |    4 ----
 include/video/omapdss.h                |    7 +++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 8dcecbc..3a179f2 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -847,11 +848,13 @@ int dss_feat_get_num_mgrs(void)
 {
 	return omap_current_dss_features->num_mgrs;
 }
+EXPORT_SYMBOL(dss_feat_get_num_mgrs);
 
 int dss_feat_get_num_ovls(void)
 {
 	return omap_current_dss_features->num_ovls;
 }
+EXPORT_SYMBOL(dss_feat_get_num_ovls);
 
 int dss_feat_get_num_wbs(void)
 {
@@ -872,6 +875,7 @@ enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel
 {
 	return omap_current_dss_features->supported_displays[channel];
 }
+EXPORT_SYMBOL(dss_feat_get_supported_displays);
 
 enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel)
 {
@@ -882,6 +886,7 @@ enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane)
 {
 	return omap_current_dss_features->supported_color_modes[plane];
 }
+EXPORT_SYMBOL(dss_feat_get_supported_color_modes);
 
 enum omap_overlay_caps dss_feat_get_overlay_caps(enum omap_plane plane)
 {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index fc492ef..61370b2 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -103,14 +103,10 @@ enum dss_range_param {
 };
 
 /* DSS Feature Functions */
-int dss_feat_get_num_mgrs(void);
-int dss_feat_get_num_ovls(void);
 int dss_feat_get_num_wbs(void);
 unsigned long dss_feat_get_param_min(enum dss_range_param param);
 unsigned long dss_feat_get_param_max(enum dss_range_param param);
-enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
 enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel);
-enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
 enum omap_overlay_caps dss_feat_get_overlay_caps(enum omap_plane plane);
 bool dss_feat_color_mode_supported(enum omap_plane plane,
 		enum omap_color_mode color_mode);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d1bf3bc..60077f4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -755,6 +755,13 @@ const char *omapdss_get_default_display_name(void);
 int omap_dss_start_device(struct omap_dss_device *dssdev);
 void omap_dss_stop_device(struct omap_dss_device *dssdev);
 
+int dss_feat_get_num_mgrs(void);
+int dss_feat_get_num_ovls(void);
+enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
+enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
+
+
+
 int omap_dss_get_num_overlay_managers(void);
 struct omap_overlay_manager *omap_dss_get_overlay_manager(int num);
 
-- 
1.7.10.4


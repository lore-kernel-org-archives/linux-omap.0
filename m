From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] OMAP: DSS2: Fix FIFO threshold and burst size for OMAP4
Date: Wed, 22 Jun 2011 11:45:26 +0300
Message-ID: <1308732326-17278-5-git-send-email-tomi.valkeinen@ti.com>
References: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:42273 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754081Ab1FVIpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 04:45:51 -0400
In-Reply-To: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DMA FIFO threshold registers and burst size registers have changed
for OMAP4.  The current code only handles OMAP2/3 case, and so the
values are a bit off for OMAP4.  A summary of the differences between
OMAP2/3 and OMAP4:

Burst size:
OMAP2/3: 4 x 32 bits / 8 x 32 bits / 16 x 32 bits
OMAP4: 2 x 128 bits / 4 x 128 bits / 8 x 128 bits

Threshold size:
OMAP2/3: in bytes (8 bit units)
OMAP4: in 128bit units

This patch fixes the issue by creating two new helper functions in
dss_features: dss_feat_get_buffer_size_unit() and
dss_feat_get_burst_size_unit(). These return (in bytes) the unit size
for threshold registers and unit size for burst size register,
respectively, and are used to calculate correct values.

For the threshold size the usage is straightforward. However, the burst
size register has different multipliers for OMAP2/3 and OMAP4. This
patch solves the problem by defining the multipliers for the burst size
as 2x, 4x and 8x, which fit fine for the OMAP4 burst size definition
(i.e. burst size unit for OMAP4 is 128bits), but requires a slight twist
on OMAP2/3 by defining the burst size unit as 64bit.

As the driver in practice always uses the maximum burst size, and no use
case currently exists where we would want to use a smaller burst size,
this patch changes the driver to hardcode the burst size when
initializing DISPC. This makes the threshold configuration code somewhat
simpler.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   50 ++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/display.c      |   12 +++----
 drivers/video/omap2/dss/dsi.c          |   11 ++-----
 drivers/video/omap2/dss/dss.h          |   15 ++-------
 drivers/video/omap2/dss/dss_features.c |   23 ++++++++++++++
 drivers/video/omap2/dss/dss_features.h |    3 ++
 drivers/video/omap2/dss/manager.c      |   12 ++++----
 7 files changed, 86 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0151f16..2fcb73b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -79,6 +79,12 @@ struct dispc_v_coef {
 	s8 vc00;
 };
 
+enum omap_burst_size {
+	BURST_SIZE_X2 = 0,
+	BURST_SIZE_X4 = 1,
+	BURST_SIZE_X8 = 2,
+};
+
 #define REG_GET(idx, start, end) \
 	FLD_GET(dispc_read_reg(idx), start, end)
 
@@ -1044,11 +1050,10 @@ void dispc_set_channel_out(enum omap_plane plane,
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
-void dispc_set_burst_size(enum omap_plane plane,
+static void dispc_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
 	int shift;
-	u32 val;
 
 	switch (plane) {
 	case OMAP_DSS_GFX:
@@ -1063,9 +1068,24 @@ void dispc_set_burst_size(enum omap_plane plane,
 		return;
 	}
 
-	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
-	val = FLD_MOD(val, burst_size, shift+1, shift);
-	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), burst_size, shift + 1, shift);
+}
+
+static void dispc_configure_burst_sizes(void)
+{
+	int i;
+	const int burst_size = BURST_SIZE_X8;
+
+	/* Configure burst size always to maximum size */
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i)
+		dispc_set_burst_size(i, burst_size);
+}
+
+u32 dispc_get_burst_size(enum omap_plane plane)
+{
+	unsigned unit = dss_feat_get_burst_size_unit();
+	/* burst multiplier is always x8 (see dispc_configure_burst_sizes()) */
+	return unit * 8;
 }
 
 void dispc_enable_gamma_table(bool enable)
@@ -1160,12 +1180,15 @@ static void dispc_read_plane_fifo_sizes(void)
 	u32 size;
 	int plane;
 	u8 start, end;
+	u32 unit;
+
+	unit = dss_feat_get_buffer_size_unit();
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
 	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
-		size = FLD_GET(dispc_read_reg(DISPC_OVL_FIFO_SIZE_STATUS(plane)),
-			start, end);
+		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(plane), start, end);
+		size *= unit;
 		dispc.fifo_size[plane] = size;
 	}
 }
@@ -1175,9 +1198,18 @@ u32 dispc_get_plane_fifo_size(enum omap_plane plane)
 	return dispc.fifo_size[plane];
 }
 
-void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
+void dispc_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 {
 	u8 hi_start, hi_end, lo_start, lo_end;
+	u32 unit;
+
+	unit = dss_feat_get_buffer_size_unit();
+
+	WARN_ON(low % unit != 0);
+	WARN_ON(high % unit != 0);
+
+	low /= unit;
+	high /= unit;
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
 	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
@@ -3601,6 +3633,8 @@ static void _omap_dispc_initial_config(void)
 	dispc_set_loadmode(OMAP_DSS_LOAD_FRAME_ONLY);
 
 	dispc_read_plane_fifo_sizes();
+
+	dispc_configure_burst_sizes();
 }
 
 /* DISPC HW IP initialisation */
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index a0bbdf6..94495e4 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -29,6 +29,7 @@
 
 #include <video/omapdss.h>
 #include "dss.h"
+#include "dss_features.h"
 
 static ssize_t display_enabled_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -282,16 +283,13 @@ void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 EXPORT_SYMBOL(omapdss_default_get_resolution);
 
 void default_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, enum omap_burst_size *burst_size,
+		u32 fifo_size, u32 burst_size,
 		u32 *fifo_low, u32 *fifo_high)
 {
-	unsigned burst_size_bytes;
+	unsigned buf_unit = dss_feat_get_buffer_size_unit();
 
-	*burst_size = OMAP_DSS_BURST_16x32;
-	burst_size_bytes = 16 * 32 / 8;
-
-	*fifo_high = fifo_size - 1;
-	*fifo_low = fifo_size - burst_size_bytes;
+	*fifo_high = fifo_size - buf_unit;
+	*fifo_low = fifo_size - burst_size;
 }
 
 int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 62b11c5..12bc2e7 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4292,16 +4292,11 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, enum omap_burst_size *burst_size,
+		u32 fifo_size, u32 burst_size,
 		u32 *fifo_low, u32 *fifo_high)
 {
-	unsigned burst_size_bytes;
-
-	*burst_size = OMAP_DSS_BURST_16x32;
-	burst_size_bytes = 16 * 32 / 8;
-
-	*fifo_high = fifo_size - burst_size_bytes;
-	*fifo_low = fifo_size - burst_size_bytes * 2;
+	*fifo_high = fifo_size - burst_size;
+	*fifo_low = fifo_size - burst_size * 2;
 }
 
 int dsi_init_display(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9dc5c00..adeff04 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -97,12 +97,6 @@ extern unsigned int dss_debug;
 #define FLD_MOD(orig, val, start, end) \
 	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
 
-enum omap_burst_size {
-	OMAP_DSS_BURST_4x32 = 0,
-	OMAP_DSS_BURST_8x32 = 1,
-	OMAP_DSS_BURST_16x32 = 2,
-};
-
 enum omap_parallel_interface_mode {
 	OMAP_DSS_PARALLELMODE_BYPASS,		/* MIPI DPI */
 	OMAP_DSS_PARALLELMODE_RFBI,		/* MIPI DBI */
@@ -186,7 +180,7 @@ void dss_uninit_device(struct platform_device *pdev,
 bool dss_use_replication(struct omap_dss_device *dssdev,
 		enum omap_color_mode mode);
 void default_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, enum omap_burst_size *burst_size,
+		u32 fifo_size, u32 burst_size,
 		u32 *fifo_low, u32 *fifo_high);
 
 /* manager */
@@ -293,7 +287,7 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 		bool enable_hsdiv);
 void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, enum omap_burst_size *burst_size,
+		u32 fifo_size, u32 burst_size,
 		u32 *fifo_low, u32 *fifo_high);
 void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev);
 void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev);
@@ -394,10 +388,9 @@ void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable);
 void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 void dispc_set_digit_size(u16 width, u16 height);
 u32 dispc_get_plane_fifo_size(enum omap_plane plane);
-void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high);
+void dispc_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 void dispc_enable_fifomerge(bool enable);
-void dispc_set_burst_size(enum omap_plane plane,
-		enum omap_burst_size burst_size);
+u32 dispc_get_burst_size(enum omap_plane plane);
 void dispc_enable_cpr(enum omap_channel channel, bool enable);
 void dispc_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index bd420f9..b415c4e 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -49,6 +49,9 @@ struct omap_dss_features {
 	const enum omap_color_mode *supported_color_modes;
 	const char * const *clksrc_names;
 	const struct dss_param_range *dss_params;
+
+	const u32 buffer_size_unit;
+	const u32 burst_size_unit;
 };
 
 /* This struct is assigned to one of the below during initialization */
@@ -274,6 +277,8 @@ static const struct omap_dss_features omap2_dss_features = {
 	.supported_color_modes = omap2_dss_supported_color_modes,
 	.clksrc_names = omap2_dss_clk_source_names,
 	.dss_params = omap2_dss_param_range,
+	.buffer_size_unit = 1,
+	.burst_size_unit = 8,
 };
 
 /* OMAP3 DSS Features */
@@ -296,6 +301,8 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
+	.buffer_size_unit = 1,
+	.burst_size_unit = 8,
 };
 
 static const struct omap_dss_features omap3630_dss_features = {
@@ -317,6 +324,8 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
+	.buffer_size_unit = 1,
+	.burst_size_unit = 8,
 };
 
 /* OMAP4 DSS Features */
@@ -339,6 +348,8 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
+	.buffer_size_unit = 16,
+	.burst_size_unit = 16,
 };
 
 /* For all the other OMAP4 versions */
@@ -361,6 +372,8 @@ static const struct omap_dss_features omap4_dss_features = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
+	.buffer_size_unit = 16,
+	.burst_size_unit = 16,
 };
 
 /* Functions returning values related to a DSS feature */
@@ -406,6 +419,16 @@ const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id)
 	return omap_current_dss_features->clksrc_names[id];
 }
 
+u32 dss_feat_get_buffer_size_unit(void)
+{
+	return omap_current_dss_features->buffer_size_unit;
+}
+
+u32 dss_feat_get_burst_size_unit(void)
+{
+	return omap_current_dss_features->burst_size_unit;
+}
+
 /* DSS has_feature check */
 bool dss_has_feature(enum dss_feat_id id)
 {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 5be8103..b7398cb 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -94,6 +94,9 @@ bool dss_feat_color_mode_supported(enum omap_plane plane,
 		enum omap_color_mode color_mode);
 const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id);
 
+u32 dss_feat_get_buffer_size_unit(void);	/* in bytes */
+u32 dss_feat_get_burst_size_unit(void);		/* in bytes */
+
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(void);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index ad76c5b..13d72d5 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -507,7 +507,6 @@ struct overlay_cache_data {
 	bool replication;
 	bool ilace;
 
-	enum omap_burst_size burst_size;
 	u32 fifo_low;
 	u32 fifo_high;
 };
@@ -947,8 +946,7 @@ static int configure_overlay(enum omap_plane plane)
 
 	dispc_enable_replication(plane, c->replication);
 
-	dispc_set_burst_size(plane, c->burst_size);
-	dispc_setup_plane_fifo(plane, c->fifo_low, c->fifo_high);
+	dispc_set_fifo_threshold(plane, c->fifo_low, c->fifo_high);
 
 	dispc_enable_plane(plane, 1);
 
@@ -1421,7 +1419,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	/* Configure overlay fifos */
 	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
 		struct omap_dss_device *dssdev;
-		u32 size;
+		u32 size, burst_size;
 
 		ovl = omap_dss_get_overlay(i);
 
@@ -1439,6 +1437,8 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		if (use_fifomerge)
 			size *= 3;
 
+		burst_size = dispc_get_burst_size(ovl->id);
+
 		switch (dssdev->type) {
 		case OMAP_DISPLAY_TYPE_DPI:
 		case OMAP_DISPLAY_TYPE_DBI:
@@ -1446,13 +1446,13 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		case OMAP_DISPLAY_TYPE_VENC:
 		case OMAP_DISPLAY_TYPE_HDMI:
 			default_get_overlay_fifo_thresholds(ovl->id, size,
-					&oc->burst_size, &oc->fifo_low,
+					burst_size, &oc->fifo_low,
 					&oc->fifo_high);
 			break;
 #ifdef CONFIG_OMAP2_DSS_DSI
 		case OMAP_DISPLAY_TYPE_DSI:
 			dsi_get_overlay_fifo_thresholds(ovl->id, size,
-					&oc->burst_size, &oc->fifo_low,
+					burst_size, &oc->fifo_low,
 					&oc->fifo_high);
 			break;
 #endif
-- 
1.7.4.1


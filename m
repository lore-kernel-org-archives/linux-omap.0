From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 2/2] OMAP: DSS2: Use dss_features framework on DSS2 code
Date: Mon, 13 Sep 2010 11:00:10 +0530
Message-ID: <1284355810-20899-3-git-send-email-archit@ti.com>
References: <1284355810-20899-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab0IMF24 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Sep 2010 01:28:56 -0400
In-Reply-To: <1284355810-20899-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Calls init functions of dss_features during dss_probe, and the following
features are made omapxxxx independent:
  - number of managers, overlays
  - supported color modes for each overlay
  - supported displays for each manager
  - global aplha, and restriction of global alpha for video1 pipeline
  - The register field ranges : FIRHINC, FIRVINC, FIFOHIGHTHRESHOLD
    FIFOLOWTHRESHOLD and FIFOSIZE

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |   31 ----------------
 drivers/video/omap2/dss/core.c            |    3 ++
 drivers/video/omap2/dss/dispc.c           |   56 ++++++++++++++++-------------
 drivers/video/omap2/dss/manager.c         |   33 ++++++++---------
 drivers/video/omap2/dss/overlay.c         |   24 +++++-------
 5 files changed, 60 insertions(+), 87 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 8bd15bd..c915a66 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -81,37 +81,6 @@ enum omap_color_mode {
 	OMAP_DSS_COLOR_ARGB32	= 1 << 11, /* ARGB32 */
 	OMAP_DSS_COLOR_RGBA32	= 1 << 12, /* RGBA32 */
 	OMAP_DSS_COLOR_RGBX32	= 1 << 13, /* RGBx32 */
-
-	OMAP_DSS_COLOR_GFX_OMAP2 =
-		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
-		OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
-		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
-		OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P,
-
-	OMAP_DSS_COLOR_VID_OMAP2 =
-		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
-		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
-		OMAP_DSS_COLOR_UYVY,
-
-	OMAP_DSS_COLOR_GFX_OMAP3 =
-		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
-		OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
-		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
-		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
-		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
-		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
-
-	OMAP_DSS_COLOR_VID1_OMAP3 =
-		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
-		OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P |
-		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY,
-
-	OMAP_DSS_COLOR_VID2_OMAP3 =
-		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
-		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
-		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
-		OMAP_DSS_COLOR_UYVY | OMAP_DSS_COLOR_ARGB32 |
-		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
 };
 
 enum omap_lcd_display_type {
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b3a498f..8e89f60 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -37,6 +37,7 @@
 #include <plat/clock.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 static struct {
 	struct platform_device *pdev;
@@ -502,6 +503,8 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	core.pdev = pdev;
 
+	dss_features_init();
+
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 90eb110..68f86dc
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -39,6 +39,7 @@
 #include <plat/display.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 /* DISPC */
 #define DISPC_BASE			0x48050400
@@ -774,12 +775,12 @@ static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
 
 static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 {
-
-	BUG_ON(plane == OMAP_DSS_VIDEO1);
-
-	if (cpu_is_omap24xx())
+	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return;
 
+	BUG_ON(!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
+			plane == OMAP_DSS_VIDEO1);
+
 	if (plane == OMAP_DSS_GFX)
 		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 7, 0);
 	else if (plane == OMAP_DSS_VIDEO2)
@@ -949,17 +950,14 @@ static void dispc_read_plane_fifo_sizes(void)
 				      DISPC_VID_FIFO_SIZE_STATUS(1) };
 	u32 size;
 	int plane;
+	u8 size1, size2;
 
 	enable_clocks(1);
 
-	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
-		if (cpu_is_omap24xx())
-			size = FLD_GET(dispc_read_reg(fsz_reg[plane]), 8, 0);
-		else if (cpu_is_omap34xx())
-			size = FLD_GET(dispc_read_reg(fsz_reg[plane]), 10, 0);
-		else
-			BUG();
+	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &size1, &size2);
 
+	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
+		size = FLD_GET(dispc_read_reg(fsz_reg[plane]), size1, size2);
 		dispc.fifo_size[plane] = size;
 	}
 
@@ -976,6 +974,8 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 	const struct dispc_reg ftrs_reg[] = { DISPC_GFX_FIFO_THRESHOLD,
 				       DISPC_VID_FIFO_THRESHOLD(0),
 				       DISPC_VID_FIFO_THRESHOLD(1) };
+	u8 high1, high2, low1, low2;
+
 	enable_clocks(1);
 
 	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
@@ -984,12 +984,12 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 			REG_GET(ftrs_reg[plane], 27, 16),
 			low, high);
 
-	if (cpu_is_omap24xx())
-		dispc_write_reg(ftrs_reg[plane],
-				FLD_VAL(high, 24, 16) | FLD_VAL(low, 8, 0));
-	else
-		dispc_write_reg(ftrs_reg[plane],
-				FLD_VAL(high, 27, 16) | FLD_VAL(low, 11, 0));
+	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &high1, &high2);
+	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &low1, &low2);
+
+	dispc_write_reg(ftrs_reg[plane],
+			FLD_VAL(high, high1, high2) |
+			FLD_VAL(low, low1, low2));
 
 	enable_clocks(0);
 }
@@ -1009,13 +1009,16 @@ static void _dispc_set_fir(enum omap_plane plane, int hinc, int vinc)
 	u32 val;
 	const struct dispc_reg fir_reg[] = { DISPC_VID_FIR(0),
 				      DISPC_VID_FIR(1) };
+	u8 hinc1, hinc2, vinc1, vinc2;
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	if (cpu_is_omap24xx())
-		val = FLD_VAL(vinc, 27, 16) | FLD_VAL(hinc, 11, 0);
-	else
-		val = FLD_VAL(vinc, 28, 16) | FLD_VAL(hinc, 12, 0);
+	dss_feat_get_reg_field(FEAT_REG_FIRHINC, &hinc1, &hinc2);
+	dss_feat_get_reg_field(FEAT_REG_FIRVINC, &vinc1, &vinc2);
+
+	val = FLD_VAL(vinc, vinc1, vinc2) |
+			FLD_VAL(hinc, hinc1, hinc2);
+
 	dispc_write_reg(fir_reg[plane-1], val);
 }
 
@@ -1541,6 +1544,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		case OMAP_DSS_COLOR_ARGB16:
 		case OMAP_DSS_COLOR_ARGB32:
 		case OMAP_DSS_COLOR_RGBA32:
+			if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
+				return -EINVAL;
 		case OMAP_DSS_COLOR_RGBX32:
 			if (cpu_is_omap24xx())
 				return -EINVAL;
@@ -1581,9 +1586,10 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		case OMAP_DSS_COLOR_ARGB16:
 		case OMAP_DSS_COLOR_ARGB32:
 		case OMAP_DSS_COLOR_RGBA32:
-			if (cpu_is_omap24xx())
+			if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 				return -EINVAL;
-			if (plane == OMAP_DSS_VIDEO1)
+			if (!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
+					plane == OMAP_DSS_VIDEO1)
 				return -EINVAL;
 			break;
 
@@ -1976,7 +1982,7 @@ void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 }
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 {
-	if (cpu_is_omap24xx())
+	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return;
 
 	enable_clocks(1);
@@ -1990,7 +1996,7 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 {
 	bool enabled;
 
-	if (cpu_is_omap24xx())
+	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return false;
 
 	enable_clocks(1);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 6a649ab..545e9b9
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -33,6 +33,7 @@
 #include <plat/cpu.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 static int num_managers;
 static struct list_head manager_list;
@@ -448,8 +449,8 @@ struct manager_cache_data {
 
 static struct {
 	spinlock_t lock;
-	struct overlay_cache_data overlay_cache[3];
-	struct manager_cache_data manager_cache[2];
+	struct overlay_cache_data overlay_cache[MAX_DSS_OVERLAYS];
+	struct manager_cache_data manager_cache[MAX_DSS_MANAGERS];
 
 	bool irq_enabled;
 } dss_cache;
@@ -882,12 +883,12 @@ static int configure_dispc(void)
 {
 	struct overlay_cache_data *oc;
 	struct manager_cache_data *mc;
-	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
-	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	const int num_ovls = dss_feat_get_num_ovls();
+	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i;
 	int r;
-	bool mgr_busy[2];
-	bool mgr_go[2];
+	bool mgr_busy[MAX_DSS_MANAGERS];
+	bool mgr_go[MAX_DSS_MANAGERS];
 	bool busy;
 
 	r = 0;
@@ -989,7 +990,7 @@ void dss_setup_partial_planes(struct omap_dss_device *dssdev,
 {
 	struct overlay_cache_data *oc;
 	struct manager_cache_data *mc;
-	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
+	const int num_ovls = dss_feat_get_num_ovls();
 	struct omap_overlay_manager *mgr;
 	int i;
 	u16 x, y, w, h;
@@ -1121,8 +1122,8 @@ void dss_start_update(struct omap_dss_device *dssdev)
 {
 	struct manager_cache_data *mc;
 	struct overlay_cache_data *oc;
-	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
-	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	const int num_ovls = dss_feat_get_num_ovls();
+	const int num_mgrs = dss_feat_get_num_mgrs();
 	struct omap_overlay_manager *mgr;
 	int i;
 
@@ -1151,10 +1152,10 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 {
 	struct manager_cache_data *mc;
 	struct overlay_cache_data *oc;
-	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
-	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	const int num_ovls = dss_feat_get_num_ovls();
+	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i, r;
-	bool mgr_busy[2];
+	bool mgr_busy[MAX_DSS_MANAGERS];
 
 	mgr_busy[0] = dispc_go_busy(0);
 	mgr_busy[1] = dispc_go_busy(1);
@@ -1461,7 +1462,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 
 	num_managers = 0;
 
-	for (i = 0; i < 2; ++i) {
+	for (i = 0; i < dss_feat_get_num_mgrs(); ++i) {
 		struct omap_overlay_manager *mgr;
 		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
 
@@ -1471,14 +1472,10 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		case 0:
 			mgr->name = "lcd";
 			mgr->id = OMAP_DSS_CHANNEL_LCD;
-			mgr->supported_displays =
-				OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
-				OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI;
 			break;
 		case 1:
 			mgr->name = "tv";
 			mgr->id = OMAP_DSS_CHANNEL_DIGIT;
-			mgr->supported_displays = OMAP_DISPLAY_TYPE_VENC;
 			break;
 		}
 
@@ -1494,6 +1491,8 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->disable = &dss_mgr_disable;
 
 		mgr->caps = OMAP_DSS_OVL_MGR_CAP_DISPC;
+		mgr->supported_displays =
+			dss_feat_get_supported_displays(mgr->id);
 
 		dss_overlay_setup_dispc_manager(mgr);
 
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 244dca8..75642c2
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -35,6 +35,7 @@
 #include <plat/cpu.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 static int num_overlays;
 static struct list_head overlay_list;
@@ -237,7 +238,8 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 	/* Video1 plane does not support global alpha
 	 * to always make it 255 completely opaque
 	 */
-	if (ovl->id == OMAP_DSS_VIDEO1)
+	if (!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
+			ovl->id == OMAP_DSS_VIDEO1)
 		info.global_alpha = 255;
 	else
 		info.global_alpha = simple_strtoul(buf, NULL, 10);
@@ -510,11 +512,11 @@ static void omap_dss_add_overlay(struct omap_overlay *overlay)
 	list_add_tail(&overlay->list, &overlay_list);
 }
 
-static struct omap_overlay *dispc_overlays[3];
+static struct omap_overlay *dispc_overlays[MAX_DSS_OVERLAYS];
 
 void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr)
 {
-	mgr->num_overlays = 3;
+	mgr->num_overlays = dss_feat_get_num_ovls();
 	mgr->overlays = dispc_overlays;
 }
 
@@ -535,7 +537,7 @@ void dss_init_overlays(struct platform_device *pdev)
 
 	num_overlays = 0;
 
-	for (i = 0; i < 3; ++i) {
+	for (i = 0; i < dss_feat_get_num_ovls(); ++i) {
 		struct omap_overlay *ovl;
 		ovl = kzalloc(sizeof(*ovl), GFP_KERNEL);
 
@@ -545,18 +547,12 @@ void dss_init_overlays(struct platform_device *pdev)
 		case 0:
 			ovl->name = "gfx";
 			ovl->id = OMAP_DSS_GFX;
-			ovl->supported_modes = cpu_is_omap34xx() ?
-				OMAP_DSS_COLOR_GFX_OMAP3 :
-				OMAP_DSS_COLOR_GFX_OMAP2;
 			ovl->caps = OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
 			break;
 		case 1:
 			ovl->name = "vid1";
 			ovl->id = OMAP_DSS_VIDEO1;
-			ovl->supported_modes = cpu_is_omap34xx() ?
-				OMAP_DSS_COLOR_VID1_OMAP3 :
-				OMAP_DSS_COLOR_VID_OMAP2;
 			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
 				OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
@@ -564,9 +560,6 @@ void dss_init_overlays(struct platform_device *pdev)
 		case 2:
 			ovl->name = "vid2";
 			ovl->id = OMAP_DSS_VIDEO2;
-			ovl->supported_modes = cpu_is_omap34xx() ?
-				OMAP_DSS_COLOR_VID2_OMAP3 :
-				OMAP_DSS_COLOR_VID_OMAP2;
 			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
 				OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
@@ -579,6 +572,9 @@ void dss_init_overlays(struct platform_device *pdev)
 		ovl->get_overlay_info = &dss_ovl_get_overlay_info;
 		ovl->wait_for_go = &dss_ovl_wait_for_go;
 
+		ovl->supported_modes =
+			dss_feat_get_supported_color_modes(ovl->id);
+
 		omap_dss_add_overlay(ovl);
 
 		r = kobject_init_and_add(&ovl->kobj, &overlay_ktype,
@@ -651,7 +647,7 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 	}
 
 	if (mgr) {
-		for (i = 0; i < 3; i++) {
+		for (i = 0; i < dss_feat_get_num_ovls(); i++) {
 			struct omap_overlay *ovl;
 			ovl = omap_dss_get_overlay(i);
 			if (!ovl->manager || force) {
-- 
1.7.0.4


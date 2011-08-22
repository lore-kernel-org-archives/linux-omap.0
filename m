From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/10] OMAP: DSS2: Remove support for non-DISPC overlays
Date: Mon, 22 Aug 2011 11:27:42 +0300
Message-ID: <1314001671-18123-2-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37760 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756701Ab1HVI2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:04 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove support for non-DISPC overlays and overlay managers.

The support to possibly have non-DISPC overlays and managers was made to
make it possible to use CPU and/or sDMA to update RFBI or DSI command
mode displays. It is ok to remove the support, because:

- No one has used the feature.
- Display update without DISPC is very slow, so it is debatable if the
  update would even be usable.
- Removal cleans up code.
- If such a feature is needed later, it is better implemented outside
  omapdss driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   22 +----
 drivers/video/omap2/dss/dsi.c     |  190 ++----------------------------------
 drivers/video/omap2/dss/manager.c |   47 +---------
 drivers/video/omap2/dss/overlay.c |    8 +-
 drivers/video/omap2/dss/rfbi.c    |   23 +----
 include/video/omapdss.h           |    7 +-
 6 files changed, 22 insertions(+), 275 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9d9fbeb..7c76370 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3056,9 +3056,6 @@ static void dispc_error_worker(struct work_struct *work)
 			struct omap_overlay *ovl;
 			ovl = omap_dss_get_overlay(i);
 
-			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-				continue;
-
 			if (ovl->id == 0) {
 				dispc_enable_plane(ovl->id, 0);
 				dispc_go(ovl->manager->id);
@@ -3074,9 +3071,6 @@ static void dispc_error_worker(struct work_struct *work)
 			struct omap_overlay *ovl;
 			ovl = omap_dss_get_overlay(i);
 
-			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-				continue;
-
 			if (ovl->id == 1) {
 				dispc_enable_plane(ovl->id, 0);
 				dispc_go(ovl->manager->id);
@@ -3092,9 +3086,6 @@ static void dispc_error_worker(struct work_struct *work)
 			struct omap_overlay *ovl;
 			ovl = omap_dss_get_overlay(i);
 
-			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-				continue;
-
 			if (ovl->id == 2) {
 				dispc_enable_plane(ovl->id, 0);
 				dispc_go(ovl->manager->id);
@@ -3129,9 +3120,6 @@ static void dispc_error_worker(struct work_struct *work)
 				struct omap_overlay *ovl;
 				ovl = omap_dss_get_overlay(i);
 
-				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-					continue;
-
 				if (ovl->id != 0 && ovl->manager == manager)
 					dispc_enable_plane(ovl->id, 0);
 			}
@@ -3168,9 +3156,6 @@ static void dispc_error_worker(struct work_struct *work)
 				struct omap_overlay *ovl;
 				ovl = omap_dss_get_overlay(i);
 
-				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-					continue;
-
 				if (ovl->id != 0 && ovl->manager == manager)
 					dispc_enable_plane(ovl->id, 0);
 			}
@@ -3207,9 +3192,6 @@ static void dispc_error_worker(struct work_struct *work)
 				struct omap_overlay *ovl;
 				ovl = omap_dss_get_overlay(i);
 
-				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-					continue;
-
 				if (ovl->id != 0 && ovl->manager == manager)
 					dispc_enable_plane(ovl->id, 0);
 			}
@@ -3226,9 +3208,7 @@ static void dispc_error_worker(struct work_struct *work)
 		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
 			struct omap_overlay_manager *mgr;
 			mgr = omap_dss_get_overlay_manager(i);
-
-			if (mgr->caps & OMAP_DSS_OVL_CAP_DISPC)
-				mgr->device->driver->disable(mgr->device);
+			mgr->device->driver->disable(mgr->device);
 		}
 	}
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c951a75..bd0ff1d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3648,161 +3648,6 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 			enter_hs_mode_lat, exit_hs_mode_lat);
 }
 
-
-#define DSI_DECL_VARS \
-	int __dsi_cb = 0; u32 __dsi_cv = 0;
-
-#define DSI_FLUSH(dsidev, ch) \
-	if (__dsi_cb > 0) { \
-		/*DSSDBG("sending long packet %#010x\n", __dsi_cv);*/ \
-		dsi_write_reg(dsidev, DSI_VC_LONG_PACKET_PAYLOAD(ch), __dsi_cv); \
-		__dsi_cb = __dsi_cv = 0; \
-	}
-
-#define DSI_PUSH(dsidev, ch, data) \
-	do { \
-		__dsi_cv |= (data) << (__dsi_cb * 8); \
-		/*DSSDBG("cv = %#010x, cb = %d\n", __dsi_cv, __dsi_cb);*/ \
-		if (++__dsi_cb > 3) \
-			DSI_FLUSH(dsidev, ch); \
-	} while (0)
-
-static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
-			int x, int y, int w, int h)
-{
-	/* Note: supports only 24bit colors in 32bit container */
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	int first = 1;
-	int fifo_stalls = 0;
-	int max_dsi_packet_size;
-	int max_data_per_packet;
-	int max_pixels_per_packet;
-	int pixels_left;
-	int bytespp = dssdev->ctrl.pixel_size / 8;
-	int scr_width;
-	u32 __iomem *data;
-	int start_offset;
-	int horiz_inc;
-	int current_x;
-	struct omap_overlay *ovl;
-
-	debug_irq = 0;
-
-	DSSDBG("dsi_update_screen_l4 (%d,%d %dx%d)\n",
-			x, y, w, h);
-
-	ovl = dssdev->manager->overlays[0];
-
-	if (ovl->info.color_mode != OMAP_DSS_COLOR_RGB24U)
-		return -EINVAL;
-
-	if (dssdev->ctrl.pixel_size != 24)
-		return -EINVAL;
-
-	scr_width = ovl->info.screen_width;
-	data = ovl->info.vaddr;
-
-	start_offset = scr_width * y + x;
-	horiz_inc = scr_width - w;
-	current_x = x;
-
-	/* We need header(4) + DCSCMD(1) + pixels(numpix*bytespp) bytes
-	 * in fifo */
-
-	/* When using CPU, max long packet size is TX buffer size */
-	max_dsi_packet_size = dsi->vc[0].fifo_size * 32 * 4;
-
-	/* we seem to get better perf if we divide the tx fifo to half,
-	   and while the other half is being sent, we fill the other half
-	   max_dsi_packet_size /= 2; */
-
-	max_data_per_packet = max_dsi_packet_size - 4 - 1;
-
-	max_pixels_per_packet = max_data_per_packet / bytespp;
-
-	DSSDBG("max_pixels_per_packet %d\n", max_pixels_per_packet);
-
-	pixels_left = w * h;
-
-	DSSDBG("total pixels %d\n", pixels_left);
-
-	data += start_offset;
-
-	while (pixels_left > 0) {
-		/* 0x2c = write_memory_start */
-		/* 0x3c = write_memory_continue */
-		u8 dcs_cmd = first ? 0x2c : 0x3c;
-		int pixels;
-		DSI_DECL_VARS;
-		first = 0;
-
-#if 1
-		/* using fifo not empty */
-		/* TX_FIFO_NOT_EMPTY */
-		while (FLD_GET(dsi_read_reg(dsidev, DSI_VC_CTRL(0)), 5, 5)) {
-			fifo_stalls++;
-			if (fifo_stalls > 0xfffff) {
-				DSSERR("fifo stalls overflow, pixels left %d\n",
-						pixels_left);
-				dsi_if_enable(dsidev, 0);
-				return -EIO;
-			}
-			udelay(1);
-		}
-#elif 1
-		/* using fifo emptiness */
-		while ((REG_GET(dsidev, DSI_TX_FIFO_VC_EMPTINESS, 7, 0)+1)*4 <
-				max_dsi_packet_size) {
-			fifo_stalls++;
-			if (fifo_stalls > 0xfffff) {
-				DSSERR("fifo stalls overflow, pixels left %d\n",
-					       pixels_left);
-				dsi_if_enable(dsidev, 0);
-				return -EIO;
-			}
-		}
-#else
-		while ((REG_GET(dsidev, DSI_TX_FIFO_VC_EMPTINESS,
-				7, 0) + 1) * 4 == 0) {
-			fifo_stalls++;
-			if (fifo_stalls > 0xfffff) {
-				DSSERR("fifo stalls overflow, pixels left %d\n",
-					       pixels_left);
-				dsi_if_enable(dsidev, 0);
-				return -EIO;
-			}
-		}
-#endif
-		pixels = min(max_pixels_per_packet, pixels_left);
-
-		pixels_left -= pixels;
-
-		dsi_vc_write_long_header(dsidev, 0, DSI_DT_DCS_LONG_WRITE,
-				1 + pixels * bytespp, 0);
-
-		DSI_PUSH(dsidev, 0, dcs_cmd);
-
-		while (pixels-- > 0) {
-			u32 pix = __raw_readl(data++);
-
-			DSI_PUSH(dsidev, 0, (pix >> 16) & 0xff);
-			DSI_PUSH(dsidev, 0, (pix >> 8) & 0xff);
-			DSI_PUSH(dsidev, 0, (pix >> 0) & 0xff);
-
-			current_x++;
-			if (current_x == x+w) {
-				current_x = x;
-				data += horiz_inc;
-			}
-		}
-
-		DSI_FLUSH(dsidev, 0);
-	}
-
-	return 0;
-}
-
 static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h)
 {
@@ -3970,11 +3815,9 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 
 	dsi_perf_mark_setup(dsidev);
 
-	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		dss_setup_partial_planes(dssdev, x, y, w, h,
-				enlarge_update_area);
-		dispc_set_lcd_size(dssdev->manager->id, *w, *h);
-	}
+	dss_setup_partial_planes(dssdev, x, y, w, h,
+			enlarge_update_area);
+	dispc_set_lcd_size(dssdev->manager->id, *w, *h);
 
 	return 0;
 }
@@ -3996,27 +3839,16 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 	 * see rather obscure HW error happening, as DSS halts. */
 	BUG_ON(x % 2 == 1);
 
-	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		dsi->framedone_callback = callback;
-		dsi->framedone_data = data;
-
-		dsi->update_region.x = x;
-		dsi->update_region.y = y;
-		dsi->update_region.w = w;
-		dsi->update_region.h = h;
-		dsi->update_region.device = dssdev;
-
-		dsi_update_screen_dispc(dssdev, x, y, w, h);
-	} else {
-		int r;
+	dsi->framedone_callback = callback;
+	dsi->framedone_data = data;
 
-		r = dsi_update_screen_l4(dssdev, x, y, w, h);
-		if (r)
-			return r;
+	dsi->update_region.x = x;
+	dsi->update_region.y = y;
+	dsi->update_region.w = w;
+	dsi->update_region.h = h;
+	dsi->update_region.device = dssdev;
 
-		dsi_perf_show(dsidev, "L4");
-		callback(0, data);
-	}
+	dsi_update_screen_dispc(dssdev, x, y, w, h);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 63674b0..b9c4fb0 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1333,9 +1333,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		ovl = omap_dss_get_overlay(i);
 
-		if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-			continue;
-
 		oc = &dss_cache.overlay_cache[ovl->id];
 
 		if (!overlay_enabled(ovl)) {
@@ -1382,9 +1379,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	list_for_each_entry(mgr, &manager_list, list) {
 		struct omap_dss_device *dssdev;
 
-		if (!(mgr->caps & OMAP_DSS_OVL_MGR_CAP_DISPC))
-			continue;
-
 		mc = &dss_cache.manager_cache[mgr->id];
 
 		if (mgr->device_changed) {
@@ -1430,9 +1424,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		ovl = omap_dss_get_overlay(i);
 
-		if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
-			continue;
-
 		oc = &dss_cache.overlay_cache[ovl->id];
 
 		if (!oc->enabled)
@@ -1587,7 +1578,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->enable = &dss_mgr_enable;
 		mgr->disable = &dss_mgr_disable;
 
-		mgr->caps = OMAP_DSS_OVL_MGR_CAP_DISPC;
+		mgr->caps = 0;
 		mgr->supported_displays =
 			dss_feat_get_supported_displays(mgr->id);
 
@@ -1604,42 +1595,6 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		}
 	}
 
-#ifdef L4_EXAMPLE
-	{
-		int omap_dss_mgr_apply_l4(struct omap_overlay_manager *mgr)
-		{
-			DSSDBG("omap_dss_mgr_apply_l4(%s)\n", mgr->name);
-
-			return 0;
-		}
-
-		struct omap_overlay_manager *mgr;
-		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
-
-		BUG_ON(mgr == NULL);
-
-		mgr->name = "l4";
-		mgr->supported_displays =
-			OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI;
-
-		mgr->set_device = &omap_dss_set_device;
-		mgr->unset_device = &omap_dss_unset_device;
-		mgr->apply = &omap_dss_mgr_apply_l4;
-		mgr->set_manager_info = &omap_dss_mgr_set_info;
-		mgr->get_manager_info = &omap_dss_mgr_get_info;
-
-		dss_overlay_setup_l4_manager(mgr);
-
-		omap_dss_add_overlay_manager(mgr);
-
-		r = kobject_init_and_add(&mgr->kobj, &manager_ktype,
-				&pdev->dev.kobj, "managerl4");
-
-		if (r)
-			DSSERR("failed to create sysfs file\n");
-	}
-#endif
-
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index c84380c..bf1abeb 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -618,21 +618,19 @@ void dss_init_overlays(struct platform_device *pdev)
 		case 0:
 			ovl->name = "gfx";
 			ovl->id = OMAP_DSS_GFX;
-			ovl->caps = OMAP_DSS_OVL_CAP_DISPC;
+			ovl->caps = 0;
 			ovl->info.global_alpha = 255;
 			break;
 		case 1:
 			ovl->name = "vid1";
 			ovl->id = OMAP_DSS_VIDEO1;
-			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
-				OMAP_DSS_OVL_CAP_DISPC;
+			ovl->caps = OMAP_DSS_OVL_CAP_SCALE;
 			ovl->info.global_alpha = 255;
 			break;
 		case 2:
 			ovl->name = "vid2";
 			ovl->id = OMAP_DSS_VIDEO2;
-			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
-				OMAP_DSS_OVL_CAP_DISPC;
+			ovl->caps = OMAP_DSS_OVL_CAP_SCALE;
 			ovl->info.global_alpha = 255;
 			break;
 		}
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 50394ba..b605066 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -783,10 +783,8 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 	if (*w == 0 || *h == 0)
 		return -EINVAL;
 
-	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		dss_setup_partial_planes(dssdev, x, y, w, h, true);
-		dispc_set_lcd_size(dssdev->manager->id, *w, *h);
-	}
+	dss_setup_partial_planes(dssdev, x, y, w, h, true);
+	dispc_set_lcd_size(dssdev->manager->id, *w, *h);
 
 	return 0;
 }
@@ -796,22 +794,7 @@ int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data)
 {
-	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		rfbi_transfer_area(dssdev, w, h, callback, data);
-	} else {
-		struct omap_overlay *ovl;
-		void __iomem *addr;
-		int scr_width;
-
-		ovl = dssdev->manager->overlays[0];
-		scr_width = ovl->info.screen_width;
-		addr = ovl->info.vaddr;
-
-		omap_rfbi_write_pixels(addr, scr_width, x, y, w, h);
-
-		callback(data);
-	}
-
+	rfbi_transfer_area(dssdev, w, h, callback, data);
 	return 0;
 }
 EXPORT_SYMBOL(omap_rfbi_update);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index dd6a580..5721de8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -162,11 +162,10 @@ enum omap_dss_rotation_angle {
 
 enum omap_overlay_caps {
 	OMAP_DSS_OVL_CAP_SCALE = 1 << 0,
-	OMAP_DSS_OVL_CAP_DISPC = 1 << 1,
 };
 
 enum omap_overlay_manager_caps {
-	OMAP_DSS_OVL_MGR_CAP_DISPC = 1 << 0,
+	OMAP_DSS_DUMMY_VALUE, /* add a dummy value to prevent compiler error */
 };
 
 enum omap_dss_clk_source {
@@ -315,7 +314,7 @@ struct omap_overlay {
 
 	/* static fields */
 	const char *name;
-	int id;
+	enum omap_plane id;
 	enum omap_color_mode supported_modes;
 	enum omap_overlay_caps caps;
 
@@ -357,7 +356,7 @@ struct omap_overlay_manager {
 
 	/* static fields */
 	const char *name;
-	int id;
+	enum omap_channel id;
 	enum omap_overlay_manager_caps caps;
 	int num_overlays;
 	struct omap_overlay **overlays;
-- 
1.7.4.1


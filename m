From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 08/17] OMAP: DSS2: move enable/disable_channel to overlay manager
Date: Mon,  8 Feb 2010 17:57:32 +0200
Message-ID: <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26927 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab0BHPzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:33 -0500
In-Reply-To: <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move enable/disable_channel() from omap_dss_device to overlay manager.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 +++
 drivers/video/omap2/dss/dispc.c           |   24 ++++++++++++++++++++++--
 drivers/video/omap2/dss/dpi.c             |   14 +++++++-------
 drivers/video/omap2/dss/dsi.c             |    2 +-
 drivers/video/omap2/dss/dss.h             |    4 ++--
 drivers/video/omap2/dss/manager.c         |   17 ++++++++++++++++-
 drivers/video/omap2/dss/rfbi.c            |    2 +-
 drivers/video/omap2/dss/sdi.c             |   14 +++++++-------
 drivers/video/omap2/dss/venc.c            |    4 ++--
 9 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 2308912..df8277c 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -371,6 +371,9 @@ struct omap_overlay_manager {
 	int (*apply)(struct omap_overlay_manager *mgr);
 	int (*wait_for_go)(struct omap_overlay_manager *mgr);
 	int (*wait_for_vsync)(struct omap_overlay_manager *mgr);
+
+	int (*enable)(struct omap_overlay_manager *mgr);
+	int (*disable)(struct omap_overlay_manager *mgr);
 };
 
 struct omap_dss_device {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7781c65..68edc32 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1725,7 +1725,7 @@ static void _enable_lcd_out(bool enable)
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
 }
 
-void dispc_enable_lcd_out(bool enable)
+static void dispc_enable_lcd_out(bool enable)
 {
 	struct completion frame_done_completion;
 	bool is_on;
@@ -1772,7 +1772,7 @@ static void _enable_digit_out(bool enable)
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 1, 1);
 }
 
-void dispc_enable_digit_out(bool enable)
+static void dispc_enable_digit_out(bool enable)
 {
 	struct completion frame_done_completion;
 	int r;
@@ -1836,6 +1836,26 @@ void dispc_enable_digit_out(bool enable)
 	enable_clocks(0);
 }
 
+bool dispc_is_channel_enabled(enum omap_channel channel)
+{
+	if (channel == OMAP_DSS_CHANNEL_LCD)
+		return !!REG_GET(DISPC_CONTROL, 0, 0);
+	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
+		return !!REG_GET(DISPC_CONTROL, 1, 1);
+	else
+		BUG();
+}
+
+void dispc_enable_channel(enum omap_channel channel, bool enable)
+{
+	if (channel == OMAP_DSS_CHANNEL_LCD)
+		dispc_enable_lcd_out(enable);
+	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
+		dispc_enable_digit_out(enable);
+	else
+		BUG();
+}
+
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
 	enable_clocks(1);
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index c5091ed..77b9557 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -194,7 +194,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 
 	mdelay(2);
 
-	dispc_enable_lcd_out(1);
+	dssdev->manager->enable(dssdev->manager);
 
 	r = dssdev->driver->enable(dssdev);
 	if (r)
@@ -205,7 +205,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 
 err6:
-	dispc_enable_lcd_out(0);
+	dssdev->manager->disable(dssdev->manager);
 err5:
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dsi_pll_uninit();
@@ -235,7 +235,7 @@ static void dpi_display_disable(struct omap_dss_device *dssdev)
 
 	dssdev->driver->disable(dssdev);
 
-	dispc_enable_lcd_out(0);
+	dssdev->manager->disable(dssdev->manager);
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
@@ -263,7 +263,7 @@ static int dpi_display_suspend(struct omap_dss_device *dssdev)
 	if (dssdev->driver->suspend)
 		dssdev->driver->suspend(dssdev);
 
-	dispc_enable_lcd_out(0);
+	dssdev->manager->disable(dssdev->manager);
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
@@ -292,7 +292,7 @@ static int dpi_display_resume(struct omap_dss_device *dssdev)
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
-	dispc_enable_lcd_out(1);
+	dssdev->manager->enable(dssdev->manager);
 
 	if (dssdev->driver->resume)
 		dssdev->driver->resume(dssdev);
@@ -383,10 +383,10 @@ static int dpi_display_set_update_mode(struct omap_dss_device *dssdev,
 		return -EINVAL;
 
 	if (mode == OMAP_DSS_UPDATE_DISABLED) {
-		dispc_enable_lcd_out(0);
+		dssdev->manager->disable(dssdev->manager);
 		dpi.update_enabled = 0;
 	} else {
-		dispc_enable_lcd_out(1);
+		dssdev->manager->enable(dssdev->manager);
 		dpi.update_enabled = 1;
 	}
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8d6a436..e355517 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3011,7 +3011,7 @@ static int dsi_update_thread(void *data)
 						x, y, w, h);
 
 				dispc_enable_sidle();
-				dispc_enable_lcd_out(0);
+				device->manager->disable(device->manager);
 
 				dsi_reset_tx_fifo(0);
 			} else {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3713dc6..24326a5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -324,8 +324,8 @@ int dispc_setup_plane(enum omap_plane plane,
 
 bool dispc_go_busy(enum omap_channel channel);
 void dispc_go(enum omap_channel channel);
-void dispc_enable_lcd_out(bool enable);
-void dispc_enable_digit_out(bool enable);
+void dispc_enable_channel(enum omap_channel channel, bool enable);
+bool dispc_is_channel_enabled(enum omap_channel channel);
 int dispc_enable_plane(enum omap_plane plane, bool enable);
 void dispc_enable_replication(enum omap_plane plane, bool enable);
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 486cd4a..4ede519 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1077,7 +1077,7 @@ void dss_start_update(struct omap_dss_device *dssdev)
 		mc->shadow_dirty = false;
 	}
 
-	dispc_enable_lcd_out(1);
+	dssdev->manager->enable(dssdev->manager);
 }
 
 static void dss_apply_irq_handler(void *data, u32 mask)
@@ -1364,6 +1364,18 @@ static void omap_dss_mgr_get_info(struct omap_overlay_manager *mgr,
 	*info = mgr->info;
 }
 
+static int dss_mgr_enable(struct omap_overlay_manager *mgr)
+{
+	dispc_enable_channel(mgr->id, 1);
+	return 0;
+}
+
+static int dss_mgr_disable(struct omap_overlay_manager *mgr)
+{
+	dispc_enable_channel(mgr->id, 0);
+	return 0;
+}
+
 static void omap_dss_add_overlay_manager(struct omap_overlay_manager *manager)
 {
 	++num_managers;
@@ -1409,6 +1421,9 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->wait_for_go = &dss_mgr_wait_for_go;
 		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
 
+		mgr->enable = &dss_mgr_enable;
+		mgr->disable = &dss_mgr_disable;
+
 		mgr->caps = OMAP_DSS_OVL_MGR_CAP_DISPC;
 
 		dss_overlay_setup_dispc_manager(mgr);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index b936495..6b9cd76 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -382,7 +382,7 @@ void rfbi_transfer_area(u16 width, u16 height,
 
 	dispc_set_lcd_size(width, height);
 
-	dispc_enable_lcd_out(1);
+	dispc_enable_channel(OMAP_DSS_CHANNEL_LCD, true);
 
 	rfbi.framedone_callback = callback;
 	rfbi.framedone_callback_data = data;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index c24f307..5f852ed 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -119,7 +119,7 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 		mdelay(2);
 	}
 
-	dispc_enable_lcd_out(1);
+	dssdev->manager->enable(dssdev->manager);
 
 	if (dssdev->driver->enable) {
 		r = dssdev->driver->enable(dssdev);
@@ -133,7 +133,7 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 err3:
-	dispc_enable_lcd_out(0);
+	dssdev->manager->disable(dssdev->manager);
 err2:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 err1:
@@ -156,7 +156,7 @@ static void sdi_display_disable(struct omap_dss_device *dssdev)
 	if (dssdev->driver->disable)
 		dssdev->driver->disable(dssdev);
 
-	dispc_enable_lcd_out(0);
+	dssdev->manager->disable(dssdev->manager);
 
 	dss_sdi_disable();
 
@@ -175,7 +175,7 @@ static int sdi_display_suspend(struct omap_dss_device *dssdev)
 	if (dssdev->driver->suspend)
 		dssdev->driver->suspend(dssdev);
 
-	dispc_enable_lcd_out(0);
+	dssdev->manager->disable(dssdev->manager);
 
 	dss_sdi_disable();
 
@@ -200,7 +200,7 @@ static int sdi_display_resume(struct omap_dss_device *dssdev)
 		goto err;
 	mdelay(2);
 
-	dispc_enable_lcd_out(1);
+	dssdev->manager->enable(dssdev->manager);
 
 	if (dssdev->driver->resume)
 		dssdev->driver->resume(dssdev);
@@ -220,10 +220,10 @@ static int sdi_display_set_update_mode(struct omap_dss_device *dssdev,
 		return -EINVAL;
 
 	if (mode == OMAP_DSS_UPDATE_DISABLED) {
-		dispc_enable_lcd_out(0);
+		dssdev->manager->disable(dssdev->manager);
 		sdi.update_enabled = 0;
 	} else {
-		dispc_enable_lcd_out(1);
+		dssdev->manager->enable(dssdev->manager);
 		sdi.update_enabled = 1;
 	}
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 44b4998..4e6bd1d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -538,7 +538,7 @@ static void venc_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->platform_enable)
 		dssdev->platform_enable(dssdev);
 
-	dispc_enable_digit_out(1);
+	dssdev->manager->enable(dssdev->manager);
 }
 
 static void venc_power_off(struct omap_dss_device *dssdev)
@@ -546,7 +546,7 @@ static void venc_power_off(struct omap_dss_device *dssdev)
 	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
 	dss_set_dac_pwrdn_bgz(0);
 
-	dispc_enable_digit_out(0);
+	dssdev->manager->disable(dssdev->manager);
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
-- 
1.6.5


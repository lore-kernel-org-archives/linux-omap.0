From: Archit Taneja <archit@ti.com>
Subject: [PATCH 14/23] OMAPDSS: RFBI: Pass outputs from panel driver to RFBI interface driver
Date: Tue, 21 Aug 2012 11:28:21 +0530
Message-ID: <1345528711-27801-15-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34830 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab2HUGBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 02:01:08 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

With outputs introduces as new entities, we can now pass output pointer to
functions used to configure the connected interface. These functions currently
pass the omap_dss_device pointer, and extract output information via
omap_dss_device. This is unnecessary, and it doesn't make sense for interface
related functions to get the panel's/device's pointer, it should receive a
pointer related to the connected interface, which in our case is the output
entity.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output yet. Ensure that panel drivers call the interface
functions only if outputs are non NULL.

Modify DSI functions to pass omap_dss_output pointer instead of omap_dss_device
pointer. Modify the panel drivers to call the updated functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |   38 +++++++++++++++++----------
 drivers/video/omap2/dss/rfbi.c            |   40 +++++++++++++++--------------
 include/video/omapdss.h                   |   16 ++++++------
 3 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 17ae85e..3601c59 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -116,6 +116,7 @@ static void blizzard_ctrl_setup_update(struct omap_dss_device *dssdev,
 		int x, int y, int w, int h)
 {
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	u8 tmp[18];
 	int x_end, y_end;
 
@@ -150,17 +151,17 @@ static void blizzard_ctrl_setup_update(struct omap_dss_device *dssdev,
 			BLIZZARD_SRC_WRITE_LCD :
 			BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE;
 
-	omapdss_rfbi_set_pixel_size(dssdev, 16);
-	omapdss_rfbi_set_data_lines(dssdev, 8);
+	omapdss_rfbi_set_pixel_size(out, 16);
+	omapdss_rfbi_set_data_lines(out, 8);
 
-	omap_rfbi_configure(dssdev);
+	omap_rfbi_configure(out);
 
 	blizzard_write(BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
 
-	omapdss_rfbi_set_pixel_size(dssdev, 16);
-	omapdss_rfbi_set_data_lines(dssdev, 16);
+	omapdss_rfbi_set_pixel_size(out, 16);
+	omapdss_rfbi_set_data_lines(out, 16);
 
-	omap_rfbi_configure(dssdev);
+	omap_rfbi_configure(out);
 }
 
 static void mipid_transfer(struct spi_device *spi, int cmd, const u8 *wbuf,
@@ -288,10 +289,14 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 	struct panel_n8x0_data *bdata = get_board_data(dssdev);
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
 	struct spi_device *spi = ddata->spidev;
+	struct omap_dss_output *out = dssdev->output;
 	u8 rev, conf;
 	u8 display_id[3];
 	const char *panel_name;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
@@ -303,13 +308,13 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 			goto err_plat_en;
 	}
 
-	omapdss_rfbi_set_size(dssdev, dssdev->panel.timings.x_res,
+	omapdss_rfbi_set_size(out, dssdev->panel.timings.x_res,
 		dssdev->panel.timings.y_res);
-	omapdss_rfbi_set_pixel_size(dssdev, dssdev->ctrl.pixel_size);
-	omapdss_rfbi_set_data_lines(dssdev, dssdev->phy.rfbi.data_lines);
-	omapdss_rfbi_set_interface_timings(dssdev, &dssdev->ctrl.rfbi_timings);
+	omapdss_rfbi_set_pixel_size(out, dssdev->ctrl.pixel_size);
+	omapdss_rfbi_set_data_lines(out, dssdev->phy.rfbi.data_lines);
+	omapdss_rfbi_set_interface_timings(out, &dssdev->ctrl.rfbi_timings);
 
-	r = omapdss_rfbi_display_enable(dssdev);
+	r = omapdss_rfbi_display_enable(out);
 	if (r)
 		goto err_rfbi_en;
 
@@ -373,7 +378,7 @@ err_inv_panel:
 	 */
 	/* gpio_direction_output(bdata->panel_reset, 0); */
 err_inv_chip:
-	omapdss_rfbi_display_disable(dssdev);
+	omapdss_rfbi_display_disable(out);
 err_rfbi_en:
 	if (bdata->platform_disable)
 		bdata->platform_disable(dssdev);
@@ -386,6 +391,7 @@ static void n8x0_panel_power_off(struct omap_dss_device *dssdev)
 {
 	struct panel_n8x0_data *bdata = get_board_data(dssdev);
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	struct spi_device *spi = ddata->spidev;
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
@@ -404,7 +410,7 @@ static void n8x0_panel_power_off(struct omap_dss_device *dssdev)
 	 */
 	/* gpio_direction_output(bdata->panel_reset, 0); */
 	gpio_direction_output(bdata->ctrl_pwrdown, 0);
-	omapdss_rfbi_display_disable(dssdev);
+	omapdss_rfbi_display_disable(out);
 }
 
 static const struct rfbi_timings n8x0_panel_timings = {
@@ -637,10 +643,14 @@ static int n8x0_panel_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h)
 {
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	u16 dw, dh;
 
 	dev_dbg(&dssdev->dev, "update\n");
 
+	if (out == NULL)
+		return -ENODEV;
+
 	dw = dssdev->panel.timings.x_res;
 	dh = dssdev->panel.timings.y_res;
 
@@ -655,7 +665,7 @@ static int n8x0_panel_update(struct omap_dss_device *dssdev,
 
 	blizzard_ctrl_setup_update(dssdev, x, y, w, h);
 
-	omap_rfbi_update(dssdev, update_done, NULL);
+	omap_rfbi_update(out, update_done, NULL);
 
 	mutex_unlock(&ddata->lock);
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 9d9244c..ca264e8 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -305,11 +305,12 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-static int rfbi_transfer_area(struct omap_dss_device *dssdev,
+static int rfbi_transfer_area(struct omap_dss_output *out,
 		void (*callback)(void *data), void *data)
 {
 	u32 l;
 	int r;
+	struct omap_overlay_manager *mgr = out->manager;
 	u16 width = rfbi.timings.x_res;
 	u16 height = rfbi.timings.y_res;
 
@@ -318,9 +319,9 @@ static int rfbi_transfer_area(struct omap_dss_device *dssdev,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dss_mgr_set_timings(dssdev->manager, &rfbi.timings);
+	dss_mgr_set_timings(mgr, &rfbi.timings);
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(mgr);
 	if (r)
 		return r;
 
@@ -767,40 +768,40 @@ static int rfbi_configure(int rfbi_module, int bpp, int lines)
 	return 0;
 }
 
-int omap_rfbi_configure(struct omap_dss_device *dssdev)
+int omap_rfbi_configure(struct omap_dss_output *out)
 {
-	return rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
+	return rfbi_configure(out->device->phy.rfbi.channel, rfbi.pixel_size,
 			rfbi.data_lines);
 }
 EXPORT_SYMBOL(omap_rfbi_configure);
 
-int omap_rfbi_update(struct omap_dss_device *dssdev, void (*callback)(void *),
+int omap_rfbi_update(struct omap_dss_output *out, void (*callback)(void *),
 		void *data)
 {
-	return rfbi_transfer_area(dssdev, callback, data);
+	return rfbi_transfer_area(out, callback, data);
 }
 EXPORT_SYMBOL(omap_rfbi_update);
 
-void omapdss_rfbi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h)
+void omapdss_rfbi_set_size(struct omap_dss_output *out, u16 w, u16 h)
 {
 	rfbi.timings.x_res = w;
 	rfbi.timings.y_res = h;
 }
 EXPORT_SYMBOL(omapdss_rfbi_set_size);
 
-void omapdss_rfbi_set_pixel_size(struct omap_dss_device *dssdev, int pixel_size)
+void omapdss_rfbi_set_pixel_size(struct omap_dss_output *out, int pixel_size)
 {
 	rfbi.pixel_size = pixel_size;
 }
 EXPORT_SYMBOL(omapdss_rfbi_set_pixel_size);
 
-void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
+void omapdss_rfbi_set_data_lines(struct omap_dss_output *out, int data_lines)
 {
 	rfbi.data_lines = data_lines;
 }
 EXPORT_SYMBOL(omapdss_rfbi_set_data_lines);
 
-void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
+void omapdss_rfbi_set_interface_timings(struct omap_dss_output *out,
 		struct rfbi_timings *timings)
 {
 	rfbi.intf_timings = *timings;
@@ -847,7 +848,7 @@ static void rfbi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
+static void rfbi_config_lcd_manager(struct omap_dss_output *out)
 {
 	struct dss_lcd_mgr_config mgr_config;
 
@@ -860,7 +861,7 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 	mgr_config.video_port_width = rfbi.pixel_size;
 	mgr_config.lcden_sig_polarity = 0;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &mgr_config);
+	dss_mgr_set_lcd_config(out->manager, &mgr_config);
 
 	/*
 	 * Set rfbi.timings with default values, the x_res and y_res fields
@@ -881,14 +882,15 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 	rfbi.timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	rfbi.timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 
-	dss_mgr_set_timings(dssdev->manager, &rfbi.timings);
+	dss_mgr_set_timings(out->manager, &rfbi.timings);
 }
 
-int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_rfbi_display_enable(struct omap_dss_output *out)
 {
 	int r;
+	struct omap_dss_device *dssdev = out->device;
 
-	if (dssdev->manager == NULL) {
+	if (out->manager == NULL) {
 		DSSERR("failed to enable display: no manager\n");
 		return -ENODEV;
 	}
@@ -910,7 +912,7 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	rfbi_config_lcd_manager(dssdev);
+	rfbi_config_lcd_manager(out);
 
 	rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
 			rfbi.data_lines);
@@ -926,11 +928,11 @@ err0:
 }
 EXPORT_SYMBOL(omapdss_rfbi_display_enable);
 
-void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_rfbi_display_disable(struct omap_dss_output *out)
 {
 	omap_dispc_unregister_isr(framedone_callback, NULL,
 			DISPC_IRQ_FRAMEDONE);
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 
 	rfbi_runtime_put();
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index cf881c0..723f091 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -798,17 +798,17 @@ void omapdss_sdi_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
 void omapdss_sdi_set_datapairs(struct omap_dss_output *out, int datapairs);
 
-int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev);
-int omap_rfbi_update(struct omap_dss_device *dssdev, void (*callback)(void *),
+int omapdss_rfbi_display_enable(struct omap_dss_output *out);
+void omapdss_rfbi_display_disable(struct omap_dss_output *out);
+int omap_rfbi_update(struct omap_dss_output *out, void (*callback)(void *),
 		void *data);
-int omap_rfbi_configure(struct omap_dss_device *dssdev);
-void omapdss_rfbi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h);
-void omapdss_rfbi_set_pixel_size(struct omap_dss_device *dssdev,
+int omap_rfbi_configure(struct omap_dss_output *out);
+void omapdss_rfbi_set_size(struct omap_dss_output *out, u16 w, u16 h);
+void omapdss_rfbi_set_pixel_size(struct omap_dss_output *out,
 		int pixel_size);
-void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
+void omapdss_rfbi_set_data_lines(struct omap_dss_output *out,
 		int data_lines);
-void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
+void omapdss_rfbi_set_interface_timings(struct omap_dss_output *out,
 		struct rfbi_timings *timings);
 
 #endif
-- 
1.7.9.5


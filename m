From: Archit Taneja <archit@ti.com>
Subject: [PATCH 12/23] OMAPDSS: DSI: Pass outputs from panel driver to DSI interface driver
Date: Tue, 21 Aug 2012 11:28:19 +0530
Message-ID: <1345528711-27801-13-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33227 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab2HUGBA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:01:00 -0400
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

There is a lack of clarity about how to deal with functions called in the probe
of panel drivers. For the case of DSI, it's the functions which request for a
VC. There is no guarantee in the panel's probe that it would be connected to an
output. Another panel of higher priority may have already grabbed this
interface.

Interface specific functions should either be removed from the panel's probe and
be called later, or, we should figure out a better way to deal with this. We
currently don't face the above issue on any platform, but it's possible for
sure.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |  201 ++++++++++++---------
 drivers/video/omap2/dss/dsi.c             |  269 +++++++++++++++--------------
 include/video/omapdss.h                   |   69 ++++----
 3 files changed, 296 insertions(+), 243 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 77aed0e..cd88145 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -176,10 +176,11 @@ static void hw_guard_wait(struct taal_data *td)
 
 static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 {
+	struct omap_dss_output *out = td->dssdev->output;
 	int r;
 	u8 buf[1];
 
-	r = dsi_vc_dcs_read(td->dssdev, td->channel, dcs_cmd, buf, 1);
+	r = dsi_vc_dcs_read(out, td->channel, dcs_cmd, buf, 1);
 
 	if (r < 0)
 		return r;
@@ -191,27 +192,33 @@ static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 
 static int taal_dcs_write_0(struct taal_data *td, u8 dcs_cmd)
 {
-	return dsi_vc_dcs_write(td->dssdev, td->channel, &dcs_cmd, 1);
+	struct omap_dss_output *out = td->dssdev->output;
+
+	return dsi_vc_dcs_write(out, td->channel, &dcs_cmd, 1);
 }
 
 static int taal_dcs_write_1(struct taal_data *td, u8 dcs_cmd, u8 param)
 {
+	struct omap_dss_output *out = td->dssdev->output;
 	u8 buf[2];
+
 	buf[0] = dcs_cmd;
 	buf[1] = param;
-	return dsi_vc_dcs_write(td->dssdev, td->channel, buf, 2);
+
+	return dsi_vc_dcs_write(out, td->channel, buf, 2);
 }
 
 static int taal_sleep_in(struct taal_data *td)
 
 {
+	struct omap_dss_output *out = td->dssdev->output;
 	u8 cmd;
 	int r;
 
 	hw_guard_wait(td);
 
 	cmd = MIPI_DCS_ENTER_SLEEP_MODE;
-	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, &cmd, 1);
+	r = dsi_vc_dcs_write_nosync(out, td->channel, &cmd, 1);
 	if (r)
 		return r;
 
@@ -304,6 +311,7 @@ static int taal_set_addr_mode(struct taal_data *td, u8 rotate, bool mirror)
 static int taal_set_update_window(struct taal_data *td,
 		u16 x, u16 y, u16 w, u16 h)
 {
+	struct omap_dss_output *out = td->dssdev->output;
 	int r;
 	u16 x1 = x;
 	u16 x2 = x + w - 1;
@@ -317,7 +325,7 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (x2 >> 8) & 0xff;
 	buf[4] = (x2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(out, td->channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
@@ -327,11 +335,11 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (y2 >> 8) & 0xff;
 	buf[4] = (y2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(out, td->channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
-	dsi_vc_send_bta_sync(td->dssdev, td->channel);
+	dsi_vc_send_bta_sync(out, td->channel);
 
 	return r;
 }
@@ -371,6 +379,7 @@ static void taal_cancel_ulps_work(struct omap_dss_device *dssdev)
 static int taal_enter_ulps(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
@@ -385,7 +394,7 @@ static int taal_enter_ulps(struct omap_dss_device *dssdev)
 
 	disable_irq(gpio_to_irq(panel_data->ext_te_gpio));
 
-	omapdss_dsi_display_disable(dssdev, false, true);
+	omapdss_dsi_display_disable(out, false, true);
 
 	td->ulps_enabled = true;
 
@@ -405,19 +414,20 @@ err:
 static int taal_exit_ulps(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	if (!td->ulps_enabled)
 		return 0;
 
-	r = omapdss_dsi_display_enable(dssdev);
+	r = omapdss_dsi_display_enable(out);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
 		goto err1;
 	}
 
-	omapdss_dsi_vc_enable_hs(dssdev, td->channel, true);
+	omapdss_dsi_vc_enable_hs(out, td->channel, true);
 
 	r = _taal_enable_te(dssdev, true);
 	if (r) {
@@ -462,6 +472,7 @@ static int taal_wake_up(struct omap_dss_device *dssdev)
 static int taal_bl_update_status(struct backlight_device *dev)
 {
 	struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int r;
 	int level;
@@ -477,13 +488,13 @@ static int taal_bl_update_status(struct backlight_device *dev)
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock(dssdev);
+		dsi_bus_lock(out);
 
 		r = taal_wake_up(dssdev);
 		if (!r)
 			r = taal_dcs_write_1(td, DCS_BRIGHTNESS, level);
 
-		dsi_bus_unlock(dssdev);
+		dsi_bus_unlock(out);
 	} else {
 		r = 0;
 	}
@@ -525,6 +536,7 @@ static ssize_t taal_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	u8 errors = 0;
 	int r;
@@ -532,13 +544,13 @@ static ssize_t taal_num_errors_show(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock(dssdev);
+		dsi_bus_lock(out);
 
 		r = taal_wake_up(dssdev);
 		if (!r)
 			r = taal_dcs_read_1(td, DCS_READ_NUM_ERRORS, &errors);
 
-		dsi_bus_unlock(dssdev);
+		dsi_bus_unlock(out);
 	} else {
 		r = -ENODEV;
 	}
@@ -555,6 +567,7 @@ static ssize_t taal_hw_revision_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	u8 id1, id2, id3;
 	int r;
@@ -562,13 +575,13 @@ static ssize_t taal_hw_revision_show(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock(dssdev);
+		dsi_bus_lock(out);
 
 		r = taal_wake_up(dssdev);
 		if (!r)
 			r = taal_get_id(td, &id1, &id2, &id3);
 
-		dsi_bus_unlock(dssdev);
+		dsi_bus_unlock(out);
 	} else {
 		r = -ENODEV;
 	}
@@ -613,6 +626,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 		const char *buf, size_t count)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int i;
 	int r;
@@ -628,7 +642,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock(dssdev);
+		dsi_bus_lock(out);
 
 		if (!td->cabc_broken) {
 			r = taal_wake_up(dssdev);
@@ -640,7 +654,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 				goto err;
 		}
 
-		dsi_bus_unlock(dssdev);
+		dsi_bus_unlock(out);
 	}
 
 	td->cabc_mode = i;
@@ -649,7 +663,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 
 	return count;
 err:
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 	return r;
 }
@@ -714,6 +728,7 @@ static ssize_t taal_store_ulps(struct device *dev,
 		const char *buf, size_t count)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	unsigned long t;
 	int r;
@@ -725,14 +740,14 @@ static ssize_t taal_store_ulps(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock(dssdev);
+		dsi_bus_lock(out);
 
 		if (t)
 			r = taal_enter_ulps(dssdev);
 		else
 			r = taal_wake_up(dssdev);
 
-		dsi_bus_unlock(dssdev);
+		dsi_bus_unlock(out);
 	}
 
 	mutex_unlock(&td->lock);
@@ -763,6 +778,7 @@ static ssize_t taal_store_ulps_timeout(struct device *dev,
 		const char *buf, size_t count)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_output *out = dssdev->output;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	unsigned long t;
 	int r;
@@ -776,9 +792,9 @@ static ssize_t taal_store_ulps_timeout(struct device *dev,
 
 	if (td->enabled) {
 		/* taal_wake_up will restart the timer */
-		dsi_bus_lock(dssdev);
+		dsi_bus_lock(out);
 		r = taal_wake_up(dssdev);
-		dsi_bus_unlock(dssdev);
+		dsi_bus_unlock(out);
 	}
 
 	mutex_unlock(&td->lock);
@@ -968,13 +984,13 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
 	}
 
-	r = omap_dsi_request_vc(dssdev, &td->channel);
+	r = omap_dsi_request_vc(dssdev->output, &td->channel);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to get virtual channel\n");
 		goto err_req_vc;
 	}
 
-	r = omap_dsi_set_vc_id(dssdev, td->channel, TCH);
+	r = omap_dsi_set_vc_id(dssdev->output, td->channel, TCH);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to set VC_ID\n");
 		goto err_vc_id;
@@ -989,7 +1005,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	return 0;
 
 err_vc_id:
-	omap_dsi_release_vc(dssdev, td->channel);
+	omap_dsi_release_vc(dssdev->output, td->channel);
 err_req_vc:
 	if (panel_data->use_ext_te)
 		free_irq(gpio_to_irq(panel_data->ext_te_gpio), dssdev);
@@ -1019,7 +1035,7 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	dev_dbg(&dssdev->dev, "remove\n");
 
 	sysfs_remove_group(&dssdev->dev.kobj, &taal_attr_group);
-	omap_dsi_release_vc(dssdev, td->channel);
+	omap_dsi_release_vc(dssdev->output, td->channel);
 
 	if (panel_data->use_ext_te) {
 		int gpio = panel_data->ext_te_gpio;
@@ -1051,21 +1067,28 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	u8 id1, id2, id3;
 	int r;
 
-	r = omapdss_dsi_configure_pins(dssdev, &panel_data->pin_config);
+	if (out == NULL) {
+		dev_err(&dssdev->dev, "not output connected to display\n");
+		r = -ENODEV;
+		goto err0;
+	}
+
+	r = omapdss_dsi_configure_pins(out, &panel_data->pin_config);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to configure DSI pins\n");
 		goto err0;
 	};
 
-	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
+	omapdss_dsi_set_size(out, dssdev->panel.timings.x_res,
 		dssdev->panel.timings.y_res);
-	omapdss_dsi_set_pixel_format(dssdev, OMAP_DSS_DSI_FMT_RGB888);
-	omapdss_dsi_set_operation_mode(dssdev, OMAP_DSS_DSI_CMD_MODE);
+	omapdss_dsi_set_pixel_format(out, OMAP_DSS_DSI_FMT_RGB888);
+	omapdss_dsi_set_operation_mode(out, OMAP_DSS_DSI_CMD_MODE);
 
-	r = omapdss_dsi_display_enable(dssdev);
+	r = omapdss_dsi_display_enable(out);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
 		goto err0;
@@ -1073,7 +1096,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	taal_hw_reset(dssdev);
 
-	omapdss_dsi_vc_enable_hs(dssdev, td->channel, false);
+	omapdss_dsi_vc_enable_hs(out, td->channel, false);
 
 	r = taal_sleep_out(td);
 	if (r)
@@ -1120,7 +1143,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	r = dsi_enable_video_output(dssdev, td->channel);
+	r = dsi_enable_video_output(out, td->channel);
 	if (r)
 		goto err;
 
@@ -1135,7 +1158,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		td->intro_printed = true;
 	}
 
-	omapdss_dsi_vc_enable_hs(dssdev, td->channel, true);
+	omapdss_dsi_vc_enable_hs(out, td->channel, true);
 
 	return 0;
 err:
@@ -1143,7 +1166,7 @@ err:
 
 	taal_hw_reset(dssdev);
 
-	omapdss_dsi_display_disable(dssdev, true, false);
+	omapdss_dsi_display_disable(out, true, false);
 err0:
 	return r;
 }
@@ -1151,9 +1174,10 @@ err0:
 static void taal_power_off(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
-	dsi_disable_video_output(dssdev, td->channel);
+	dsi_disable_video_output(out, td->channel);
 
 	r = taal_dcs_write_0(td, MIPI_DCS_SET_DISPLAY_OFF);
 	if (!r)
@@ -1165,7 +1189,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 		taal_hw_reset(dssdev);
 	}
 
-	omapdss_dsi_display_disable(dssdev, true, false);
+	omapdss_dsi_display_disable(out, true, false);
 
 	td->enabled = 0;
 }
@@ -1182,6 +1206,7 @@ static int taal_panel_reset(struct omap_dss_device *dssdev)
 static int taal_enable(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "enable\n");
@@ -1193,11 +1218,11 @@ static int taal_enable(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	r = taal_power_on(dssdev);
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 
 	if (r)
 		goto err;
@@ -1218,6 +1243,7 @@ err:
 static void taal_disable(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 
 	dev_dbg(&dssdev->dev, "disable\n");
 
@@ -1226,7 +1252,7 @@ static void taal_disable(struct omap_dss_device *dssdev)
 	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
@@ -1236,7 +1262,7 @@ static void taal_disable(struct omap_dss_device *dssdev)
 			taal_power_off(dssdev);
 	}
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
@@ -1246,6 +1272,7 @@ static void taal_disable(struct omap_dss_device *dssdev)
 static int taal_suspend(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "suspend\n");
@@ -1260,13 +1287,13 @@ static int taal_suspend(struct omap_dss_device *dssdev)
 	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	r = taal_wake_up(dssdev);
 	if (!r)
 		taal_power_off(dssdev);
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
@@ -1281,6 +1308,7 @@ err:
 static int taal_resume(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "resume\n");
@@ -1292,11 +1320,11 @@ static int taal_resume(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	r = taal_power_on(dssdev);
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 
 	if (r) {
 		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
@@ -1317,13 +1345,14 @@ static void taal_framedone_cb(int err, void *data)
 {
 	struct omap_dss_device *dssdev = data;
 	dev_dbg(&dssdev->dev, "framedone, err %d\n", err);
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(dssdev->output);
 }
 
 static irqreturn_t taal_te_isr(int irq, void *data)
 {
 	struct omap_dss_device *dssdev = data;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int old;
 	int r;
 
@@ -1332,7 +1361,7 @@ static irqreturn_t taal_te_isr(int irq, void *data)
 	if (old) {
 		cancel_delayed_work(&td->te_timeout_work);
 
-		r = omap_dsi_update(dssdev, td->channel, taal_framedone_cb,
+		r = omap_dsi_update(out, td->channel, taal_framedone_cb,
 				dssdev);
 		if (r)
 			goto err;
@@ -1341,7 +1370,7 @@ static irqreturn_t taal_te_isr(int irq, void *data)
 	return IRQ_HANDLED;
 err:
 	dev_err(&dssdev->dev, "start update failed\n");
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	return IRQ_HANDLED;
 }
 
@@ -1350,11 +1379,12 @@ static void taal_te_timeout_work_callback(struct work_struct *work)
 	struct taal_data *td = container_of(work, struct taal_data,
 					te_timeout_work.work);
 	struct omap_dss_device *dssdev = td->dssdev;
+	struct omap_dss_output *out = dssdev->output;
 
 	dev_err(&dssdev->dev, "TE not received for 250ms!\n");
 
 	atomic_set(&td->do_update, 0);
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 }
 
 static int taal_update(struct omap_dss_device *dssdev,
@@ -1362,12 +1392,16 @@ static int taal_update(struct omap_dss_device *dssdev,
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&td->lock);
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	r = taal_wake_up(dssdev);
 	if (r)
@@ -1390,7 +1424,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 				msecs_to_jiffies(250));
 		atomic_set(&td->do_update, 1);
 	} else {
-		r = omap_dsi_update(dssdev, td->channel, taal_framedone_cb,
+		r = omap_dsi_update(out, td->channel, taal_framedone_cb,
 				dssdev);
 		if (r)
 			goto err;
@@ -1400,20 +1434,21 @@ static int taal_update(struct omap_dss_device *dssdev,
 	mutex_unlock(&td->lock);
 	return 0;
 err:
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 	return r;
 }
 
 static int taal_sync(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 
 	dev_dbg(&dssdev->dev, "sync\n");
 
 	mutex_lock(&td->lock);
-	dsi_bus_lock(dssdev);
-	dsi_bus_unlock(dssdev);
+	dsi_bus_lock(out);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 
 	dev_dbg(&dssdev->dev, "sync done\n");
@@ -1425,6 +1460,7 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	if (enable)
@@ -1433,7 +1469,7 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 		r = taal_dcs_write_0(td, MIPI_DCS_SET_TEAR_OFF);
 
 	if (!panel_data->use_ext_te)
-		omapdss_dsi_enable_te(dssdev, enable);
+		omapdss_dsi_enable_te(out, enable);
 
 	if (td->panel_config->sleep.enable_te)
 		msleep(td->panel_config->sleep.enable_te);
@@ -1444,6 +1480,7 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	mutex_lock(&td->lock);
@@ -1451,7 +1488,7 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	if (td->te_enabled == enable)
 		goto end;
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	if (td->enabled) {
 		r = taal_wake_up(dssdev);
@@ -1465,13 +1502,13 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 
 	td->te_enabled = enable;
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 end:
 	mutex_unlock(&td->lock);
 
 	return 0;
 err:
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 
 	return r;
@@ -1493,6 +1530,7 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	u16 dw, dh;
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "rotate %d\n", rotate);
@@ -1502,7 +1540,7 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 	if (td->rotate == rotate)
 		goto end;
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	if (td->enabled) {
 		r = taal_wake_up(dssdev);
@@ -1522,16 +1560,16 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 		dh = dssdev->panel.timings.x_res;
 	}
 
-	omapdss_dsi_set_size(dssdev, dw, dh);
+	omapdss_dsi_set_size(out, dw, dh);
 
 	td->rotate = rotate;
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 end:
 	mutex_unlock(&td->lock);
 	return 0;
 err:
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 	return r;
 }
@@ -1551,6 +1589,7 @@ static u8 taal_get_rotate(struct omap_dss_device *dssdev)
 static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "mirror %d\n", enable);
@@ -1560,7 +1599,7 @@ static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
 	if (td->mirror == enable)
 		goto end;
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 	if (td->enabled) {
 		r = taal_wake_up(dssdev);
 		if (r)
@@ -1573,12 +1612,12 @@ static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
 
 	td->mirror = enable;
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 end:
 	mutex_unlock(&td->lock);
 	return 0;
 err:
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 	return r;
 }
@@ -1598,6 +1637,7 @@ static bool taal_get_mirror(struct omap_dss_device *dssdev)
 static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	u8 id1, id2, id3;
 	int r;
 
@@ -1608,7 +1648,7 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 		goto err1;
 	}
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	r = taal_wake_up(dssdev);
 	if (r)
@@ -1624,11 +1664,11 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 	if (r)
 		goto err2;
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 	return 0;
 err2:
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 err1:
 	mutex_unlock(&td->lock);
 	return r;
@@ -1643,6 +1683,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 	int plen;
 	unsigned buf_used = 0;
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 
 	if (size < w * h * 3)
 		return -ENOMEM;
@@ -1658,7 +1699,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 			dssdev->panel.timings.x_res *
 			dssdev->panel.timings.y_res * 3);
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	r = taal_wake_up(dssdev);
 	if (r)
@@ -1674,7 +1715,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 
 	taal_set_update_window(td, x, y, w, h);
 
-	r = dsi_vc_set_max_rx_packet_size(dssdev, td->channel, plen);
+	r = dsi_vc_set_max_rx_packet_size(out, td->channel, plen);
 	if (r)
 		goto err2;
 
@@ -1682,7 +1723,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 		u8 dcs_cmd = first ? 0x2e : 0x3e;
 		first = 0;
 
-		r = dsi_vc_dcs_read(dssdev, td->channel, dcs_cmd,
+		r = dsi_vc_dcs_read(out, td->channel, dcs_cmd,
 				buf + buf_used, size - buf_used);
 
 		if (r < 0) {
@@ -1708,9 +1749,9 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 	r = buf_used;
 
 err3:
-	dsi_vc_set_max_rx_packet_size(dssdev, td->channel, 1);
+	dsi_vc_set_max_rx_packet_size(out, td->channel, 1);
 err2:
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 err1:
 	mutex_unlock(&td->lock);
 	return r;
@@ -1721,6 +1762,7 @@ static void taal_ulps_work(struct work_struct *work)
 	struct taal_data *td = container_of(work, struct taal_data,
 			ulps_work.work);
 	struct omap_dss_device *dssdev = td->dssdev;
+	struct omap_dss_output *out = dssdev->output;
 
 	mutex_lock(&td->lock);
 
@@ -1729,11 +1771,11 @@ static void taal_ulps_work(struct work_struct *work)
 		return;
 	}
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	taal_enter_ulps(dssdev);
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 	mutex_unlock(&td->lock);
 }
 
@@ -1742,6 +1784,7 @@ static void taal_esd_work(struct work_struct *work)
 	struct taal_data *td = container_of(work, struct taal_data,
 			esd_work.work);
 	struct omap_dss_device *dssdev = td->dssdev;
+	struct omap_dss_output *out = dssdev->output;
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	u8 state1, state2;
 	int r;
@@ -1753,7 +1796,7 @@ static void taal_esd_work(struct work_struct *work)
 		return;
 	}
 
-	dsi_bus_lock(dssdev);
+	dsi_bus_lock(out);
 
 	r = taal_wake_up(dssdev);
 	if (r) {
@@ -1795,7 +1838,7 @@ static void taal_esd_work(struct work_struct *work)
 			goto err;
 	}
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 
 	taal_queue_esd_work(dssdev);
 
@@ -1806,7 +1849,7 @@ err:
 
 	taal_panel_reset(dssdev);
 
-	dsi_bus_unlock(dssdev);
+	dsi_bus_unlock(out);
 
 	taal_queue_esd_work(dssdev);
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 19a4d4d..2eb3b75 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -354,9 +354,9 @@ static inline struct dsi_data *dsi_get_dsidrv_data(struct platform_device *dside
 	return dev_get_drvdata(&dsidev->dev);
 }
 
-static inline struct platform_device *dsi_get_dsidev_from_dssdev(struct omap_dss_device *dssdev)
+static inline struct platform_device *dsi_get_dsidev_from_output(struct omap_dss_output *out)
 {
-	return dssdev->output->pdev;
+	return out->pdev;
 }
 
 struct platform_device *dsi_get_dsidev_from_id(int module)
@@ -387,18 +387,18 @@ static inline u32 dsi_read_reg(struct platform_device *dsidev,
 	return __raw_readl(dsi->base + idx.idx);
 }
 
-void dsi_bus_lock(struct omap_dss_device *dssdev)
+void dsi_bus_lock(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	down(&dsi->bus_lock);
 }
 EXPORT_SYMBOL(dsi_bus_lock);
 
-void dsi_bus_unlock(struct omap_dss_device *dssdev)
+void dsi_bus_unlock(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	up(&dsi->bus_lock);
@@ -1203,10 +1203,11 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 	return r;
 }
 
-static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
+static int dsi_set_lp_clk_divisor(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_device *dssdev = out->device;
 	unsigned long dsi_fclk;
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
@@ -2684,10 +2685,10 @@ static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
 	return 0;
 }
 
-void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
+void omapdss_dsi_vc_enable_hs(struct omap_dss_output *out, int channel,
 		bool enable)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("dsi_vc_enable_hs(%d, %d)\n", channel, enable);
@@ -2706,7 +2707,7 @@ void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 
 	/* start the DDR clock by sending a NULL packet */
 	if (dsi->vm_timings.ddr_clk_always_on && enable)
-		dsi_vc_send_null(dssdev, channel);
+		dsi_vc_send_null(out, channel);
 }
 EXPORT_SYMBOL(omapdss_dsi_vc_enable_hs);
 
@@ -2813,9 +2814,9 @@ static int dsi_vc_send_bta(struct platform_device *dsidev, int channel)
 	return 0;
 }
 
-int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel)
+int dsi_vc_send_bta_sync(struct omap_dss_output *out, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	DECLARE_COMPLETION_ONSTACK(completion);
 	int r = 0;
 	u32 err;
@@ -2982,9 +2983,9 @@ static int dsi_vc_send_short(struct platform_device *dsidev, int channel,
 	return 0;
 }
 
-int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel)
+int dsi_vc_send_null(struct omap_dss_output *out, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_send_long(dsidev, channel, MIPI_DSI_NULL_PACKET, NULL,
 		0, 0);
@@ -3021,37 +3022,37 @@ static int dsi_vc_write_nosync_common(struct platform_device *dsidev,
 	return r;
 }
 
-int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_dcs_write_nosync(struct omap_dss_output *out, int channel,
 		u8 *data, int len)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_write_nosync_common(dsidev, channel, data, len,
 			DSS_DSI_CONTENT_DCS);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_nosync);
 
-int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_write_nosync(struct omap_dss_output *out, int channel,
 		u8 *data, int len)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_write_nosync_common(dsidev, channel, data, len,
 			DSS_DSI_CONTENT_GENERIC);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_nosync);
 
-static int dsi_vc_write_common(struct omap_dss_device *dssdev, int channel,
+static int dsi_vc_write_common(struct omap_dss_output *out, int channel,
 		u8 *data, int len, enum dss_dsi_content_type type)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	int r;
 
 	r = dsi_vc_write_nosync_common(dsidev, channel, data, len, type);
 	if (r)
 		goto err;
 
-	r = dsi_vc_send_bta_sync(dssdev, channel);
+	r = dsi_vc_send_bta_sync(out, channel);
 	if (r)
 		goto err;
 
@@ -3070,58 +3071,58 @@ err:
 	return r;
 }
 
-int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+int dsi_vc_dcs_write(struct omap_dss_output *out, int channel, u8 *data,
 		int len)
 {
-	return dsi_vc_write_common(dssdev, channel, data, len,
+	return dsi_vc_write_common(out, channel, data, len,
 			DSS_DSI_CONTENT_DCS);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write);
 
-int dsi_vc_generic_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+int dsi_vc_generic_write(struct omap_dss_output *out, int channel, u8 *data,
 		int len)
 {
-	return dsi_vc_write_common(dssdev, channel, data, len,
+	return dsi_vc_write_common(out, channel, data, len,
 			DSS_DSI_CONTENT_GENERIC);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write);
 
-int dsi_vc_dcs_write_0(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd)
+int dsi_vc_dcs_write_0(struct omap_dss_output *out, int channel, u8 dcs_cmd)
 {
-	return dsi_vc_dcs_write(dssdev, channel, &dcs_cmd, 1);
+	return dsi_vc_dcs_write(out, channel, &dcs_cmd, 1);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_0);
 
-int dsi_vc_generic_write_0(struct omap_dss_device *dssdev, int channel)
+int dsi_vc_generic_write_0(struct omap_dss_output *out, int channel)
 {
-	return dsi_vc_generic_write(dssdev, channel, NULL, 0);
+	return dsi_vc_generic_write(out, channel, NULL, 0);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_0);
 
-int dsi_vc_dcs_write_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+int dsi_vc_dcs_write_1(struct omap_dss_output *out, int channel, u8 dcs_cmd,
 		u8 param)
 {
 	u8 buf[2];
 	buf[0] = dcs_cmd;
 	buf[1] = param;
-	return dsi_vc_dcs_write(dssdev, channel, buf, 2);
+	return dsi_vc_dcs_write(out, channel, buf, 2);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_1);
 
-int dsi_vc_generic_write_1(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_write_1(struct omap_dss_output *out, int channel,
 		u8 param)
 {
-	return dsi_vc_generic_write(dssdev, channel, &param, 1);
+	return dsi_vc_generic_write(out, channel, &param, 1);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_1);
 
-int dsi_vc_generic_write_2(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_write_2(struct omap_dss_output *out, int channel,
 		u8 param1, u8 param2)
 {
 	u8 buf[2];
 	buf[0] = param1;
 	buf[1] = param2;
-	return dsi_vc_generic_write(dssdev, channel, buf, 2);
+	return dsi_vc_generic_write(out, channel, buf, 2);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_2);
 
@@ -3290,17 +3291,17 @@ err:
 	return r;
 }
 
-int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+int dsi_vc_dcs_read(struct omap_dss_output *out, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	int r;
 
 	r = dsi_vc_dcs_send_read_request(dsidev, channel, dcs_cmd);
 	if (r)
 		goto err;
 
-	r = dsi_vc_send_bta_sync(dssdev, channel);
+	r = dsi_vc_send_bta_sync(out, channel);
 	if (r)
 		goto err;
 
@@ -3321,17 +3322,17 @@ err:
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read);
 
-static int dsi_vc_generic_read(struct omap_dss_device *dssdev, int channel,
+static int dsi_vc_generic_read(struct omap_dss_output *out, int channel,
 		u8 *reqdata, int reqlen, u8 *buf, int buflen)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	int r;
 
 	r = dsi_vc_generic_send_read_request(dsidev, channel, reqdata, reqlen);
 	if (r)
 		return r;
 
-	r = dsi_vc_send_bta_sync(dssdev, channel);
+	r = dsi_vc_send_bta_sync(out, channel);
 	if (r)
 		return r;
 
@@ -3348,12 +3349,12 @@ static int dsi_vc_generic_read(struct omap_dss_device *dssdev, int channel,
 	return 0;
 }
 
-int dsi_vc_generic_read_0(struct omap_dss_device *dssdev, int channel, u8 *buf,
+int dsi_vc_generic_read_0(struct omap_dss_output *out, int channel, u8 *buf,
 		int buflen)
 {
 	int r;
 
-	r = dsi_vc_generic_read(dssdev, channel, NULL, 0, buf, buflen);
+	r = dsi_vc_generic_read(out, channel, NULL, 0, buf, buflen);
 	if (r) {
 		DSSERR("dsi_vc_generic_read_0(ch %d) failed\n", channel);
 		return r;
@@ -3363,12 +3364,12 @@ int dsi_vc_generic_read_0(struct omap_dss_device *dssdev, int channel, u8 *buf,
 }
 EXPORT_SYMBOL(dsi_vc_generic_read_0);
 
-int dsi_vc_generic_read_1(struct omap_dss_device *dssdev, int channel, u8 param,
+int dsi_vc_generic_read_1(struct omap_dss_output *out, int channel, u8 param,
 		u8 *buf, int buflen)
 {
 	int r;
 
-	r = dsi_vc_generic_read(dssdev, channel, &param, 1, buf, buflen);
+	r = dsi_vc_generic_read(out, channel, &param, 1, buf, buflen);
 	if (r) {
 		DSSERR("dsi_vc_generic_read_1(ch %d) failed\n", channel);
 		return r;
@@ -3378,7 +3379,7 @@ int dsi_vc_generic_read_1(struct omap_dss_device *dssdev, int channel, u8 param,
 }
 EXPORT_SYMBOL(dsi_vc_generic_read_1);
 
-int dsi_vc_generic_read_2(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_read_2(struct omap_dss_output *out, int channel,
 		u8 param1, u8 param2, u8 *buf, int buflen)
 {
 	int r;
@@ -3387,7 +3388,7 @@ int dsi_vc_generic_read_2(struct omap_dss_device *dssdev, int channel,
 	reqdata[0] = param1;
 	reqdata[1] = param2;
 
-	r = dsi_vc_generic_read(dssdev, channel, reqdata, 2, buf, buflen);
+	r = dsi_vc_generic_read(out, channel, reqdata, 2, buf, buflen);
 	if (r) {
 		DSSERR("dsi_vc_generic_read_2(ch %d) failed\n", channel);
 		return r;
@@ -3397,10 +3398,10 @@ int dsi_vc_generic_read_2(struct omap_dss_device *dssdev, int channel,
 }
 EXPORT_SYMBOL(dsi_vc_generic_read_2);
 
-int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_set_max_rx_packet_size(struct omap_dss_output *out, int channel,
 		u16 len)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_send_short(dsidev, channel,
 			MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE, len, 0);
@@ -3736,10 +3737,11 @@ static int dsi_compute_interleave_lp(int blank, int enter_hs, int exit_hs,
 	return max(lp_inter, 0);
 }
 
-static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
+static void dsi_config_cmd_mode_interleaving(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_device *dssdev = out->device;
 	int blanking_mode;
 	int hfp_blanking_mode, hbp_blanking_mode, hsa_blanking_mode;
 	int hsa, hfp, hbp, width_bytes, bllp, lp_clk_div;
@@ -3854,9 +3856,9 @@ static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
 	dsi_write_reg(dsidev, DSI_VM_TIMING6, r);
 }
 
-static int dsi_proto_config(struct omap_dss_device *dssdev)
+static int dsi_proto_config(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r;
 	int buswidth = 0;
@@ -3914,7 +3916,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		dsi_config_vp_sync_events(dsidev);
 		dsi_config_blanking_modes(dsidev);
-		dsi_config_cmd_mode_interleaving(dssdev);
+		dsi_config_cmd_mode_interleaving(out);
 	}
 
 	dsi_vc_initial_config(dsidev, 0);
@@ -4037,10 +4039,10 @@ static void dsi_proto_timings(struct platform_device *dsidev)
 	}
 }
 
-int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
+int omapdss_dsi_configure_pins(struct omap_dss_output *out,
 		const struct omap_dsi_pin_config *pin_cfg)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int num_pins;
 	const int *pins;
@@ -4105,9 +4107,9 @@ int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_configure_pins);
 
-int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
+int dsi_enable_video_output(struct omap_dss_output *out, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	u8 data_type;
@@ -4148,7 +4150,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 		dsi_if_enable(dsidev, true);
 	}
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(out->manager);
 	if (r) {
 		if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 			dsi_if_enable(dsidev, false);
@@ -4162,9 +4164,9 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 }
 EXPORT_SYMBOL(dsi_enable_video_output);
 
-void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
+void dsi_disable_video_output(struct omap_dss_output *out, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
@@ -4178,13 +4180,13 @@ void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 		dsi_if_enable(dsidev, true);
 	}
 
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 }
 EXPORT_SYMBOL(dsi_disable_video_output);
 
-static void dsi_update_screen_dispc(struct omap_dss_device *dssdev)
+static void dsi_update_screen_dispc(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned bytespp;
 	unsigned bytespl;
@@ -4247,9 +4249,9 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev)
 		msecs_to_jiffies(250));
 	BUG_ON(r == 0);
 
-	dss_mgr_set_timings(dssdev->manager, &dsi->timings);
+	dss_mgr_set_timings(out->manager, &dsi->timings);
 
-	dss_mgr_start_update(dssdev->manager);
+	dss_mgr_start_update(out->manager);
 
 	if (dsi->te_enabled) {
 		/* disable LP_RX_TO, so that we can receive TE.  Time to wait
@@ -4320,10 +4322,10 @@ static void dsi_framedone_irq_callback(void *data, u32 mask)
 	dsi_handle_framedone(dsidev, 0);
 }
 
-int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
+int omap_dsi_update(struct omap_dss_output *out, int channel,
 		void (*callback)(int, void *), void *data)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u16 dw, dh;
 
@@ -4341,7 +4343,7 @@ int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 	dsi->update_bytes = dw * dh *
 		dsi_get_pixel_size(dsi->pix_fmt) / 8;
 #endif
-	dsi_update_screen_dispc(dssdev);
+	dsi_update_screen_dispc(out);
 
 	return 0;
 }
@@ -4349,10 +4351,11 @@ EXPORT_SYMBOL(omap_dsi_update);
 
 /* Display funcs */
 
-static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
+static int dsi_configure_dispc_clocks(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_device *dssdev = out->device;
 	struct dispc_clock_info dispc_cinfo;
 	int r;
 	unsigned long long fck;
@@ -4373,10 +4376,11 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
+static int dsi_display_init_dispc(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_overlay_manager *mgr = out->manager;
 	int r;
 	u32 irq = 0;
 
@@ -4388,7 +4392,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dsi->timings.vfp = 0;
 		dsi->timings.vbp = 0;
 
-		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
+		irq = dispc_mgr_get_framedone_irq(mgr->id);
 
 		r = omap_dispc_register_isr(dsi_framedone_irq_callback,
 			(void *) dsidev, irq);
@@ -4415,9 +4419,9 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	dsi->timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	dsi->timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 
-	dss_mgr_set_timings(dssdev->manager, &dsi->timings);
+	dss_mgr_set_timings(mgr, &dsi->timings);
 
-	r = dsi_configure_dispc_clocks(dssdev);
+	r = dsi_configure_dispc_clocks(out);
 	if (r)
 		goto err1;
 
@@ -4426,7 +4430,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			dsi_get_pixel_size(dsi->pix_fmt);
 	dsi->mgr_config.lcden_sig_polarity = 0;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &dsi->mgr_config);
+	dss_mgr_set_lcd_config(mgr, &dsi->mgr_config);
 
 	return 0;
 err1:
@@ -4437,24 +4441,25 @@ err:
 	return r;
 }
 
-static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
+static void dsi_display_uninit_dispc(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		u32 irq;
 
-		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
+		irq = dispc_mgr_get_framedone_irq(out->manager->id);
 
 		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
 			(void *) dsidev, irq);
 	}
 }
 
-static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
+static int dsi_configure_dsi_clocks(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
+	struct omap_dss_device *dssdev = out->device;
 	struct dsi_clock_info cinfo;
 	int r;
 
@@ -4477,23 +4482,25 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
+static int dsi_display_init_dsi(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_overlay_manager *mgr = out->manager;
+	struct omap_dss_device *dssdev = out->device;
 	int r;
 
 	r = dsi_pll_init(dsidev, true, true);
 	if (r)
 		goto err0;
 
-	r = dsi_configure_dsi_clocks(dssdev);
+	r = dsi_configure_dsi_clocks(out);
 	if (r)
 		goto err1;
 
 	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
 	dss_select_dsi_clk_source(dsi->module_id, dssdev->clocks.dsi.dsi_fclk_src);
-	dss_select_lcd_clk_source(dssdev->manager->id,
+	dss_select_lcd_clk_source(out->manager->id,
 			dssdev->clocks.dispc.channel.lcd_clk_src);
 
 	DSSDBG("PLL OK\n");
@@ -4505,12 +4512,12 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	_dsi_print_reset_status(dsidev);
 
 	dsi_proto_timings(dsidev);
-	dsi_set_lp_clk_divisor(dssdev);
+	dsi_set_lp_clk_divisor(out);
 
 	if (1)
 		_dsi_print_reset_status(dsidev);
 
-	r = dsi_proto_config(dssdev);
+	r = dsi_proto_config(out);
 	if (r)
 		goto err3;
 
@@ -4528,7 +4535,7 @@ err3:
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
-	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
+	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 
 err1:
 	dsi_pll_uninit(dsidev, true);
@@ -4536,11 +4543,12 @@ err0:
 	return r;
 }
 
-static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
+static void dsi_display_uninit_dsi(struct omap_dss_output *out,
 		bool disconnect_lanes, bool enter_ulps)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_overlay_manager *mgr = out->manager;
 
 	if (enter_ulps && !dsi->ulps_enabled)
 		dsi_enter_ulps(dsidev);
@@ -4554,14 +4562,14 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
-	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
+	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit(dsidev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
 
-int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_dsi_display_enable(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r = 0;
 
@@ -4571,13 +4579,13 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&dsi->lock);
 
-	if (dssdev->manager == NULL) {
+	if (out->manager == NULL) {
 		DSSERR("failed to enable display: no manager\n");
 		r = -ENODEV;
 		goto err_start_dev;
 	}
 
-	r = omap_dss_start_device(dssdev);
+	r = omap_dss_start_device(out->device);
 	if (r) {
 		DSSERR("failed to start device\n");
 		goto err_start_dev;
@@ -4591,11 +4599,11 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 
 	_dsi_initialize_irq(dsidev);
 
-	r = dsi_display_init_dispc(dssdev);
+	r = dsi_display_init_dispc(out);
 	if (r)
 		goto err_init_dispc;
 
-	r = dsi_display_init_dsi(dssdev);
+	r = dsi_display_init_dsi(out);
 	if (r)
 		goto err_init_dsi;
 
@@ -4604,12 +4612,12 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 
 err_init_dsi:
-	dsi_display_uninit_dispc(dssdev);
+	dsi_display_uninit_dispc(out);
 err_init_dispc:
 	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
 err_get_dsi:
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 err_start_dev:
 	mutex_unlock(&dsi->lock);
 	DSSDBG("dsi_display_enable FAILED\n");
@@ -4617,10 +4625,10 @@ err_start_dev:
 }
 EXPORT_SYMBOL(omapdss_dsi_display_enable);
 
-void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
+void omapdss_dsi_display_disable(struct omap_dss_output *out,
 		bool disconnect_lanes, bool enter_ulps)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("dsi_display_disable\n");
@@ -4634,22 +4642,22 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 	dsi_sync_vc(dsidev, 2);
 	dsi_sync_vc(dsidev, 3);
 
-	dsi_display_uninit_dispc(dssdev);
+	dsi_display_uninit_dispc(out);
 
-	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
+	dsi_display_uninit_dsi(out, disconnect_lanes, enter_ulps);
 
 	dsi_runtime_put(dsidev);
 	dsi_enable_pll_clock(dsidev, 0);
 
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 
 	mutex_unlock(&dsi->lock);
 }
 EXPORT_SYMBOL(omapdss_dsi_display_disable);
 
-int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
+int omapdss_dsi_enable_te(struct omap_dss_output *out, bool enable)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	dsi->te_enabled = enable;
@@ -4657,10 +4665,10 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 }
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
-void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
+void omapdss_dsi_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4671,9 +4679,9 @@ void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_timings);
 
-void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h)
+void omapdss_dsi_set_size(struct omap_dss_output *out, u16 w, u16 h)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4685,10 +4693,10 @@ void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h)
 }
 EXPORT_SYMBOL(omapdss_dsi_set_size);
 
-void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
+void omapdss_dsi_set_pixel_format(struct omap_dss_output *out,
 		enum omap_dss_dsi_pixel_format fmt)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4699,10 +4707,10 @@ void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_pixel_format);
 
-void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
+void omapdss_dsi_set_operation_mode(struct omap_dss_output *out,
 		enum omap_dss_dsi_mode mode)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4713,10 +4721,10 @@ void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_operation_mode);
 
-void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
+void omapdss_dsi_set_videomode_timings(struct omap_dss_output *out,
 		struct omap_dss_dsi_videomode_timings *timings)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4729,7 +4737,8 @@ EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
 
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev =
+			dsi_get_dsidev_from_id(dssdev->phy.dsi.module);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("DSI init\n");
@@ -4755,28 +4764,28 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel)
+int omap_dsi_request_vc(struct omap_dss_output *out, int *channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dsi->vc); i++) {
 		if (!dsi->vc[i].dssdev) {
-			dsi->vc[i].dssdev = dssdev;
+			dsi->vc[i].dssdev = out->device;
 			*channel = i;
 			return 0;
 		}
 	}
 
-	DSSERR("cannot get VC for display %s", dssdev->name);
+	DSSERR("cannot get VC for display %s", out->device->name);
 	return -ENOSPC;
 }
 EXPORT_SYMBOL(omap_dsi_request_vc);
 
-int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id)
+int omap_dsi_set_vc_id(struct omap_dss_output *out, int channel, int vc_id)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (vc_id < 0 || vc_id > 3) {
@@ -4789,9 +4798,9 @@ int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id)
 		return -EINVAL;
 	}
 
-	if (dsi->vc[channel].dssdev != dssdev) {
+	if (dsi->vc[channel].dssdev != out->device) {
 		DSSERR("Virtual Channel not allocated to display %s\n",
-			dssdev->name);
+			out->device->name);
 		return -EINVAL;
 	}
 
@@ -4801,13 +4810,13 @@ int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id)
 }
 EXPORT_SYMBOL(omap_dsi_set_vc_id);
 
-void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel)
+void omap_dsi_release_vc(struct omap_dss_output *out, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if ((channel >= 0 && channel <= 3) &&
-		dsi->vc[channel].dssdev == dssdev) {
+		dsi->vc[channel].dssdev == out->device) {
 		dsi->vc[channel].dssdev = NULL;
 		dsi->vc[channel].vc_id = 0;
 	}
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index da3f070..f8902f9 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -54,6 +54,7 @@
 #define DISPC_IRQ_SYNC_LOST3		(1 << 29)
 
 struct omap_dss_device;
+struct omap_dss_output;
 struct omap_overlay_manager;
 struct snd_aes_iec958;
 struct snd_cea_861_aud_if;
@@ -278,38 +279,38 @@ struct omap_dss_dsi_videomode_timings {
 	int window_sync;
 };
 
-void dsi_bus_lock(struct omap_dss_device *dssdev);
-void dsi_bus_unlock(struct omap_dss_device *dssdev);
-int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+void dsi_bus_lock(struct omap_dss_output *out);
+void dsi_bus_unlock(struct omap_dss_output *out);
+int dsi_vc_dcs_write(struct omap_dss_output *out, int channel, u8 *data,
 		int len);
-int dsi_vc_generic_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+int dsi_vc_generic_write(struct omap_dss_output *out, int channel, u8 *data,
 		int len);
-int dsi_vc_dcs_write_0(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd);
-int dsi_vc_generic_write_0(struct omap_dss_device *dssdev, int channel);
-int dsi_vc_dcs_write_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+int dsi_vc_dcs_write_0(struct omap_dss_output *out, int channel, u8 dcs_cmd);
+int dsi_vc_generic_write_0(struct omap_dss_output *out, int channel);
+int dsi_vc_dcs_write_1(struct omap_dss_output *out, int channel, u8 dcs_cmd,
 		u8 param);
-int dsi_vc_generic_write_1(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_write_1(struct omap_dss_output *out, int channel,
 		u8 param);
-int dsi_vc_generic_write_2(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_write_2(struct omap_dss_output *out, int channel,
 		u8 param1, u8 param2);
-int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_dcs_write_nosync(struct omap_dss_output *out, int channel,
 		u8 *data, int len);
-int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_write_nosync(struct omap_dss_output *out, int channel,
 		u8 *data, int len);
-int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+int dsi_vc_dcs_read(struct omap_dss_output *out, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen);
-int dsi_vc_generic_read_0(struct omap_dss_device *dssdev, int channel, u8 *buf,
+int dsi_vc_generic_read_0(struct omap_dss_output *out, int channel, u8 *buf,
 		int buflen);
-int dsi_vc_generic_read_1(struct omap_dss_device *dssdev, int channel, u8 param,
+int dsi_vc_generic_read_1(struct omap_dss_output *out, int channel, u8 param,
 		u8 *buf, int buflen);
-int dsi_vc_generic_read_2(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_generic_read_2(struct omap_dss_output *out, int channel,
 		u8 param1, u8 param2, u8 *buf, int buflen);
-int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
+int dsi_vc_set_max_rx_packet_size(struct omap_dss_output *out, int channel,
 		u16 len);
-int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel);
-int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel);
-int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel);
-void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel);
+int dsi_vc_send_null(struct omap_dss_output *out, int channel);
+int dsi_vc_send_bta_sync(struct omap_dss_output *out, int channel);
+int dsi_enable_video_output(struct omap_dss_output *out, int channel);
+void dsi_disable_video_output(struct omap_dss_output *out, int channel);
 
 /* Board specific data */
 struct omap_dss_board_info {
@@ -758,29 +759,29 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 #define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
 #define to_dss_device(x) container_of((x), struct omap_dss_device, dev)
 
-void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
+void omapdss_dsi_vc_enable_hs(struct omap_dss_output *out, int channel,
 		bool enable);
-int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
-void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
+int omapdss_dsi_enable_te(struct omap_dss_output *out, bool enable);
+void omapdss_dsi_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
-void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h);
-void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
+void omapdss_dsi_set_size(struct omap_dss_output *out, u16 w, u16 h);
+void omapdss_dsi_set_pixel_format(struct omap_dss_output *out,
 		enum omap_dss_dsi_pixel_format fmt);
-void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
+void omapdss_dsi_set_operation_mode(struct omap_dss_output *out,
 		enum omap_dss_dsi_mode mode);
-void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
+void omapdss_dsi_set_videomode_timings(struct omap_dss_output *out,
 		struct omap_dss_dsi_videomode_timings *timings);
 
-int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
+int omap_dsi_update(struct omap_dss_output *out, int channel,
 		void (*callback)(int, void *), void *data);
-int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel);
-int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id);
-void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
-int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
+int omap_dsi_request_vc(struct omap_dss_output *out, int *channel);
+int omap_dsi_set_vc_id(struct omap_dss_output *out, int channel, int vc_id);
+void omap_dsi_release_vc(struct omap_dss_output *out, int channel);
+int omapdss_dsi_configure_pins(struct omap_dss_output *out,
 		const struct omap_dsi_pin_config *pin_cfg);
 
-int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
+int omapdss_dsi_display_enable(struct omap_dss_output *out);
+void omapdss_dsi_display_disable(struct omap_dss_output *out,
 		bool disconnect_lanes, bool enter_ulps);
 
 int omapdss_dpi_display_enable(struct omap_dss_output *out);
-- 
1.7.9.5


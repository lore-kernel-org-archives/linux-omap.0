From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/19] OMAP: DSS2: Taal: Implement ULPS functionality
Date: Tue, 19 Apr 2011 12:22:22 +0300
Message-ID: <1303204942-25450-20-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56537 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836Ab1DSJXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:13 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

ULPS is a low power state where the DSI lanes are kept at ground. This
patch implements ULPS by having a DSI bus inactivity timer which
triggers the entry to ULPS. ULPS exit will happen automatically when the
driver needs to do something on the DSI lanes.

The ulps_timeout is configurable from board file or via sysfs.
Additionally another sysfs file, "ulps", can be used to check the
current ULPS state, or to manually enter or exit ULPS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |    2 +
 drivers/video/omap2/displays/panel-taal.c         |  310 ++++++++++++++++++++-
 2 files changed, 305 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
index aaa1c14..36ba7bd 100644
--- a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
+++ b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
@@ -9,6 +9,7 @@
  * @use_ext_te: use external TE
  * @ext_te_gpio: external TE GPIO
  * @esd_interval: interval of ESD checks, 0 = disabled (ms)
+ * @ulps_timeout: time to wait before entering ULPS, 0 = disabled (ms)
  * @max_backlight_level: maximum backlight level
  * @set_backlight: pointer to backlight set function
  * @get_backlight: pointer to backlight get function
@@ -22,6 +23,7 @@ struct nokia_dsi_panel_data {
 	int ext_te_gpio;
 
 	unsigned esd_interval;
+	unsigned ulps_timeout;
 
 	int max_backlight_level;
 	int (*set_backlight)(struct omap_dss_device *dssdev, int level);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 9626e49..78ad355 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -67,6 +67,8 @@ static irqreturn_t taal_te_isr(int irq, void *data);
 static void taal_te_timeout_work_callback(struct work_struct *work);
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
 
+static int taal_panel_reset(struct omap_dss_device *dssdev);
+
 struct panel_regulator {
 	struct regulator *regulator;
 	const char *name;
@@ -232,6 +234,10 @@ struct taal_data {
 	struct delayed_work esd_work;
 	unsigned esd_interval;
 
+	bool ulps_enabled;
+	unsigned ulps_timeout;
+	struct delayed_work ulps_work;
+
 	struct panel_config *panel_config;
 };
 
@@ -242,6 +248,7 @@ static inline struct nokia_dsi_panel_data
 }
 
 static void taal_esd_work(struct work_struct *work);
+static void taal_ulps_work(struct work_struct *work);
 
 static void hw_guard_start(struct taal_data *td, int guard_msec)
 {
@@ -437,6 +444,107 @@ static void taal_cancel_esd_work(struct omap_dss_device *dssdev)
 	cancel_delayed_work(&td->esd_work);
 }
 
+static void taal_queue_ulps_work(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	if (td->ulps_timeout > 0)
+		queue_delayed_work(td->workqueue, &td->ulps_work,
+				msecs_to_jiffies(td->ulps_timeout));
+}
+
+static void taal_cancel_ulps_work(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	cancel_delayed_work(&td->ulps_work);
+}
+
+static int taal_enter_ulps(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
+	int r;
+
+	if (td->ulps_enabled)
+		return 0;
+
+	taal_cancel_ulps_work(dssdev);
+
+	r = _taal_enable_te(dssdev, false);
+	if (r)
+		goto err;
+
+	disable_irq(gpio_to_irq(panel_data->ext_te_gpio));
+
+	omapdss_dsi_display_disable(dssdev, false, true);
+
+	td->ulps_enabled = true;
+
+	return 0;
+
+err:
+	dev_err(&dssdev->dev, "enter ULPS failed");
+	taal_panel_reset(dssdev);
+
+	td->ulps_enabled = false;
+
+	taal_queue_ulps_work(dssdev);
+
+	return r;
+}
+
+static int taal_exit_ulps(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
+	int r;
+
+	if (!td->ulps_enabled)
+		return 0;
+
+	r = omapdss_dsi_display_enable(dssdev);
+	if (r)
+		goto err;
+
+	omapdss_dsi_vc_enable_hs(td->channel, true);
+
+	r = _taal_enable_te(dssdev, true);
+	if (r)
+		goto err;
+
+	enable_irq(gpio_to_irq(panel_data->ext_te_gpio));
+
+	taal_queue_ulps_work(dssdev);
+
+	td->ulps_enabled = false;
+
+	return 0;
+
+err:
+	dev_err(&dssdev->dev, "exit ULPS failed");
+	r = taal_panel_reset(dssdev);
+
+	enable_irq(gpio_to_irq(panel_data->ext_te_gpio));
+	td->ulps_enabled = false;
+
+	taal_queue_ulps_work(dssdev);
+
+	return r;
+}
+
+static int taal_wake_up(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	if (td->ulps_enabled)
+		return taal_exit_ulps(dssdev);
+
+	taal_cancel_ulps_work(dssdev);
+	taal_queue_ulps_work(dssdev);
+	return 0;
+}
+
 static int taal_bl_update_status(struct backlight_device *dev)
 {
 	struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
@@ -458,7 +566,11 @@ static int taal_bl_update_status(struct backlight_device *dev)
 	if (td->use_dsi_bl) {
 		if (td->enabled) {
 			dsi_bus_lock();
-			r = taal_dcs_write_1(td, DCS_BRIGHTNESS, level);
+
+			r = taal_wake_up(dssdev);
+			if (!r)
+				r = taal_dcs_write_1(td, DCS_BRIGHTNESS, level);
+
 			dsi_bus_unlock();
 		} else {
 			r = 0;
@@ -521,7 +633,11 @@ static ssize_t taal_num_errors_show(struct device *dev,
 
 	if (td->enabled) {
 		dsi_bus_lock();
-		r = taal_dcs_read_1(td, DCS_READ_NUM_ERRORS, &errors);
+
+		r = taal_wake_up(dssdev);
+		if (!r)
+			r = taal_dcs_read_1(td, DCS_READ_NUM_ERRORS, &errors);
+
 		dsi_bus_unlock();
 	} else {
 		r = -ENODEV;
@@ -547,7 +663,11 @@ static ssize_t taal_hw_revision_show(struct device *dev,
 
 	if (td->enabled) {
 		dsi_bus_lock();
-		r = taal_get_id(td, &id1, &id2, &id3);
+
+		r = taal_wake_up(dssdev);
+		if (!r)
+			r = taal_get_id(td, &id1, &id2, &id3);
+
 		dsi_bus_unlock();
 	} else {
 		r = -ENODEV;
@@ -595,6 +715,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int i;
+	int r;
 
 	for (i = 0; i < ARRAY_SIZE(cabc_modes); i++) {
 		if (sysfs_streq(cabc_modes[i], buf))
@@ -608,8 +729,17 @@ static ssize_t store_cabc_mode(struct device *dev,
 
 	if (td->enabled) {
 		dsi_bus_lock();
-		if (!td->cabc_broken)
-			taal_dcs_write_1(td, DCS_WRITE_CABC, i);
+
+		if (!td->cabc_broken) {
+			r = taal_wake_up(dssdev);
+			if (r)
+				goto err;
+
+			r = taal_dcs_write_1(td, DCS_WRITE_CABC, i);
+			if (r)
+				goto err;
+		}
+
 		dsi_bus_unlock();
 	}
 
@@ -618,6 +748,10 @@ static ssize_t store_cabc_mode(struct device *dev,
 	mutex_unlock(&td->lock);
 
 	return count;
+err:
+	dsi_bus_unlock();
+	mutex_unlock(&td->lock);
+	return r;
 }
 
 static ssize_t show_cabc_available_modes(struct device *dev,
@@ -675,6 +809,101 @@ static ssize_t taal_show_esd_interval(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", t);
 }
 
+static ssize_t taal_store_ulps(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	unsigned long t;
+	int r;
+
+	r = strict_strtoul(buf, 10, &t);
+	if (r)
+		return r;
+
+	mutex_lock(&td->lock);
+
+	if (td->enabled) {
+		dsi_bus_lock();
+
+		if (t)
+			r = taal_enter_ulps(dssdev);
+		else
+			r = taal_wake_up(dssdev);
+
+		dsi_bus_unlock();
+	}
+
+	mutex_unlock(&td->lock);
+
+	if (r)
+		return r;
+
+	return count;
+}
+
+static ssize_t taal_show_ulps(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	unsigned t;
+
+	mutex_lock(&td->lock);
+	t = td->ulps_enabled;
+	mutex_unlock(&td->lock);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", t);
+}
+
+static ssize_t taal_store_ulps_timeout(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	unsigned long t;
+	int r;
+
+	r = strict_strtoul(buf, 10, &t);
+	if (r)
+		return r;
+
+	mutex_lock(&td->lock);
+	td->ulps_timeout = t;
+
+	if (td->enabled) {
+		/* taal_wake_up will restart the timer */
+		dsi_bus_lock();
+		r = taal_wake_up(dssdev);
+		dsi_bus_unlock();
+	}
+
+	mutex_unlock(&td->lock);
+
+	if (r)
+		return r;
+
+	return count;
+}
+
+static ssize_t taal_show_ulps_timeout(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	unsigned t;
+
+	mutex_lock(&td->lock);
+	t = td->ulps_timeout;
+	mutex_unlock(&td->lock);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", t);
+}
+
 static DEVICE_ATTR(num_dsi_errors, S_IRUGO, taal_num_errors_show, NULL);
 static DEVICE_ATTR(hw_revision, S_IRUGO, taal_hw_revision_show, NULL);
 static DEVICE_ATTR(cabc_mode, S_IRUGO | S_IWUSR,
@@ -683,6 +912,10 @@ static DEVICE_ATTR(cabc_available_modes, S_IRUGO,
 		show_cabc_available_modes, NULL);
 static DEVICE_ATTR(esd_interval, S_IRUGO | S_IWUSR,
 		taal_show_esd_interval, taal_store_esd_interval);
+static DEVICE_ATTR(ulps, S_IRUGO | S_IWUSR,
+		taal_show_ulps, taal_store_ulps);
+static DEVICE_ATTR(ulps_timeout, S_IRUGO | S_IWUSR,
+		taal_show_ulps_timeout, taal_store_ulps_timeout);
 
 static struct attribute *taal_attrs[] = {
 	&dev_attr_num_dsi_errors.attr,
@@ -690,6 +923,8 @@ static struct attribute *taal_attrs[] = {
 	&dev_attr_cabc_mode.attr,
 	&dev_attr_cabc_available_modes.attr,
 	&dev_attr_esd_interval.attr,
+	&dev_attr_ulps.attr,
+	&dev_attr_ulps_timeout.attr,
 	NULL,
 };
 
@@ -759,6 +994,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	td->dssdev = dssdev;
 	td->panel_config = panel_config;
 	td->esd_interval = panel_data->esd_interval;
+	td->ulps_enabled = false;
+	td->ulps_timeout = panel_data->ulps_timeout;
 
 	mutex_init(&td->lock);
 
@@ -776,6 +1013,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		goto err_wq;
 	}
 	INIT_DELAYED_WORK_DEFERRABLE(&td->esd_work, taal_esd_work);
+	INIT_DELAYED_WORK(&td->ulps_work, taal_ulps_work);
 
 	dev_set_drvdata(&dssdev->dev, td);
 
@@ -900,6 +1138,7 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	taal_bl_update_status(bldev);
 	backlight_device_unregister(bldev);
 
+	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
 	destroy_workqueue(td->workqueue);
 
@@ -1072,12 +1311,15 @@ static void taal_disable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&td->lock);
 
+	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
 
 	dsi_bus_lock();
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		taal_wake_up(dssdev);
 		taal_power_off(dssdev);
+	}
 
 	dsi_bus_unlock();
 
@@ -1100,11 +1342,14 @@ static int taal_suspend(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
+	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
 
 	dsi_bus_lock();
 
-	taal_power_off(dssdev);
+	r = taal_wake_up(dssdev);
+	if (!r)
+		taal_power_off(dssdev);
 
 	dsi_bus_unlock();
 
@@ -1213,6 +1458,10 @@ static int taal_update(struct omap_dss_device *dssdev,
 	mutex_lock(&td->lock);
 	dsi_bus_lock();
 
+	r = taal_wake_up(dssdev);
+	if (r)
+		goto err;
+
 	if (!td->enabled) {
 		r = 0;
 		goto err;
@@ -1300,6 +1549,10 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	dsi_bus_lock();
 
 	if (td->enabled) {
+		r = taal_wake_up(dssdev);
+		if (r)
+			goto err;
+
 		r = _taal_enable_te(dssdev, enable);
 		if (r)
 			goto err;
@@ -1346,6 +1599,10 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 	dsi_bus_lock();
 
 	if (td->enabled) {
+		r = taal_wake_up(dssdev);
+		if (r)
+			goto err;
+
 		r = taal_set_addr_mode(td, rotate, td->mirror);
 		if (r)
 			goto err;
@@ -1389,6 +1646,10 @@ static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
 
 	dsi_bus_lock();
 	if (td->enabled) {
+		r = taal_wake_up(dssdev);
+		if (r)
+			goto err;
+
 		r = taal_set_addr_mode(td, td->rotate, enable);
 		if (r)
 			goto err;
@@ -1433,6 +1694,10 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 
 	dsi_bus_lock();
 
+	r = taal_wake_up(dssdev);
+	if (r)
+		goto err2;
+
 	r = taal_dcs_read_1(td, DCS_GET_ID1, &id1);
 	if (r)
 		goto err2;
@@ -1479,6 +1744,10 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 
 	dsi_bus_lock();
 
+	r = taal_wake_up(dssdev);
+	if (r)
+		goto err2;
+
 	/* plen 1 or 2 goes into short packet. until checksum error is fixed,
 	 * use short packets. plen 32 works, but bigger packets seem to cause
 	 * an error. */
@@ -1531,6 +1800,27 @@ err1:
 	return r;
 }
 
+static void taal_ulps_work(struct work_struct *work)
+{
+	struct taal_data *td = container_of(work, struct taal_data,
+			ulps_work.work);
+	struct omap_dss_device *dssdev = td->dssdev;
+
+	mutex_lock(&td->lock);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE || !td->enabled) {
+		mutex_unlock(&td->lock);
+		return;
+	}
+
+	dsi_bus_lock();
+
+	taal_enter_ulps(dssdev);
+
+	dsi_bus_unlock();
+	mutex_unlock(&td->lock);
+}
+
 static void taal_esd_work(struct work_struct *work)
 {
 	struct taal_data *td = container_of(work, struct taal_data,
@@ -1549,6 +1839,12 @@ static void taal_esd_work(struct work_struct *work)
 
 	dsi_bus_lock();
 
+	r = taal_wake_up(dssdev);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to exit ULPS\n");
+		goto err;
+	}
+
 	r = taal_dcs_read_1(td, DCS_RDDSDR, &state1);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to read Taal status\n");
-- 
1.7.1


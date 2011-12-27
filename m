From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 25/29] OMAPDSS: Writeback: Add sysfs attributes to writeback panel
Date: Tue, 27 Dec 2011 18:07:08 +0530
Message-ID: <1324989432-3625-26-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45135 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab1L0MkH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:40:07 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add the following sysfs attributes to the writeback panel driver:
- paddr
- p_uv_addr
- rotation_type
- color_mode
- pre_mult_alpha
- capture_rate

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/writeback.c |  210 +++++++++++++++++++++++++++++++++++
 1 files changed, 210 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 215958e..c6450e7 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -214,8 +214,218 @@ int dss_wb_simple_check(struct omap_dss_writeback *wb,
 
 /* Dummy Writeback Panel driver */
 
+static ssize_t writeback_panel_paddr_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	wb->get_wb_info(wb, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%x\n", info.paddr);
+}
+
+static ssize_t writeback_panel_p_uv_addr_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	wb->get_wb_info(wb, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%x\n", info.p_uv_addr);
+}
+
+static ssize_t writeback_panel_rotation_type_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	wb->get_wb_info(wb, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.rotation_type);
+}
+
+static ssize_t writeback_panel_color_mode_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	wb->get_wb_info(wb, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.color_mode);
+}
+
+static ssize_t writeback_panel_color_mode_store(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t size)
+{
+	int r;
+	int color_mode;
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	r = kstrtoint(buf, 0, &color_mode);
+	if (r)
+		return r;
+
+	wb->get_wb_info(wb, &info);
+
+	info.color_mode = color_mode;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set color mode %d\n",
+			color_mode);
+		return r;
+	}
+
+	if (dssdev->manager) {
+		r = dssdev->manager->apply(dssdev->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t writeback_panel_pre_mult_alpha_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	wb->get_wb_info(wb, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.pre_mult_alpha);
+}
+
+static ssize_t writeback_panel_pre_mult_alpha_store(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t size)
+{
+	int r;
+	u8 pre_mult_alpha;
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	r = kstrtou8(buf, 0, &pre_mult_alpha);
+	if (r)
+		return r;
+
+	wb->get_wb_info(wb, &info);
+
+	info.pre_mult_alpha = pre_mult_alpha;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set pre_mult_alpha %d\n",
+			pre_mult_alpha);
+		return r;
+	}
+
+	if (dssdev->manager) {
+		r = dssdev->manager->apply(dssdev->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t writeback_panel_capture_rate_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	wb->get_wb_info(wb, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.capture_rate);
+}
+
+static ssize_t writeback_panel_capture_rate_store(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t size)
+{
+	int r;
+	int capture_rate;
+	struct omap_dss_writeback_info info;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+
+	r = kstrtoint(buf, 0, &capture_rate);
+	if (r)
+		return r;
+
+	wb->get_wb_info(wb, &info);
+
+	info.capture_rate = capture_rate;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set capture_rate %d\n",
+			capture_rate);
+		return r;
+	}
+
+	if (dssdev->manager) {
+		r = dssdev->manager->apply(dssdev->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static DEVICE_ATTR(paddr, S_IRUGO, writeback_panel_paddr_show, NULL);
+static DEVICE_ATTR(p_uv_addr, S_IRUGO, writeback_panel_p_uv_addr_show, NULL);
+static DEVICE_ATTR(rotation_type, S_IRUGO, writeback_panel_rotation_type_show,
+		NULL);
+static DEVICE_ATTR(color_mode, S_IRUGO | S_IWUSR,
+		writeback_panel_color_mode_show,
+		writeback_panel_color_mode_store);
+static DEVICE_ATTR(pre_mult_alpha, S_IRUGO | S_IWUSR,
+		writeback_panel_pre_mult_alpha_show,
+		writeback_panel_pre_mult_alpha_store);
+static DEVICE_ATTR(capture_rate, S_IRUGO | S_IWUSR,
+		writeback_panel_capture_rate_show,
+		writeback_panel_capture_rate_store);
+
+static struct attribute *writeback_attrs[] = {
+	&dev_attr_paddr.attr,
+	&dev_attr_p_uv_addr.attr,
+	&dev_attr_rotation_type.attr,
+	&dev_attr_color_mode.attr,
+	&dev_attr_pre_mult_alpha.attr,
+	&dev_attr_capture_rate.attr,
+	NULL,
+};
+
+static struct attribute_group writeback_attr_group = {
+	.attrs = writeback_attrs,
+};
+
 static int writeback_panel_probe(struct omap_dss_device *dssdev)
 {
+	int r;
+
+	r = sysfs_create_group(&dssdev->dev.kobj, &writeback_attr_group);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to create sysfs files\n");
+		return r;
+	}
+
 	return 0;
 }
 
-- 
1.7.4.1


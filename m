From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/19] OMAP: DSS2: Taal: Add sysfs file for ESD interval
Date: Tue, 19 Apr 2011 12:22:19 +0300
Message-ID: <1303204942-25450-17-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60477 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456Ab1DSJXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:06 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Implement sysfs support to configure the ESD interval.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   42 +++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 2787a51..3192dd7 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -635,18 +635,60 @@ static ssize_t show_cabc_available_modes(struct device *dev,
 	return len < PAGE_SIZE ? len : PAGE_SIZE - 1;
 }
 
+static ssize_t taal_store_esd_interval(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	unsigned long t;
+	int r;
+
+	r = strict_strtoul(buf, 10, &t);
+	if (r)
+		return r;
+
+	mutex_lock(&td->lock);
+	taal_cancel_esd_work(dssdev);
+	td->esd_interval = t;
+	if (td->enabled)
+		taal_queue_esd_work(dssdev);
+	mutex_unlock(&td->lock);
+
+	return count;
+}
+
+static ssize_t taal_show_esd_interval(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	unsigned t;
+
+	mutex_lock(&td->lock);
+	t = td->esd_interval;
+	mutex_unlock(&td->lock);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", t);
+}
+
 static DEVICE_ATTR(num_dsi_errors, S_IRUGO, taal_num_errors_show, NULL);
 static DEVICE_ATTR(hw_revision, S_IRUGO, taal_hw_revision_show, NULL);
 static DEVICE_ATTR(cabc_mode, S_IRUGO | S_IWUSR,
 		show_cabc_mode, store_cabc_mode);
 static DEVICE_ATTR(cabc_available_modes, S_IRUGO,
 		show_cabc_available_modes, NULL);
+static DEVICE_ATTR(esd_interval, S_IRUGO | S_IWUSR,
+		taal_show_esd_interval, taal_store_esd_interval);
 
 static struct attribute *taal_attrs[] = {
 	&dev_attr_num_dsi_errors.attr,
 	&dev_attr_hw_revision.attr,
 	&dev_attr_cabc_mode.attr,
 	&dev_attr_cabc_available_modes.attr,
+	&dev_attr_esd_interval.attr,
 	NULL,
 };
 
-- 
1.7.1


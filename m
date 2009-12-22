From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 3/3] DSS2 sysfs enteries to export LPR enable to user
Date: Tue, 22 Dec 2009 15:07:56 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45848 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbZLVJhb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 04:37:31 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tomi Valkeinen (tomi.valkeinen@nokia.com)" <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Subramani Venkatesh <x0108988@ti.com>

LPR power saving methods are exported to user by sysfs entires,
implementing of ioctl will help user application to use the LPR.

echo 1 > /sys/devices/platform/omapdss/display0/lpr_enable
enables the LPR on LCD.

echo 0 > /sys/devices/platform/omapdss/display0/lpr_enable
disables the LPR on LCD.

Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
---
 drivers/video/omap2/dss/display.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 3b92b84..81fc70e 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -277,6 +277,28 @@ static ssize_t display_wss_store(struct device *dev,
 	return size;
 }
 
+unsigned long lpr_enable;
+extern int omap_dispc_lpr_enable(void);
+extern void omap_dispc_lpr_disable(void);
+
+static ssize_t display_lpr_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	lpr_enable = simple_strtoul(buf, NULL, 0);
+	if (lpr_enable)
+		omap_dispc_lpr_enable();
+	else
+		omap_dispc_lpr_disable();
+
+	return size;
+}
+
+static ssize_t display_lpr_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%lu\n", lpr_enable);
+}
+
 static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
 		display_enabled_show, display_enabled_store);
 static DEVICE_ATTR(update_mode, S_IRUGO|S_IWUSR,
@@ -291,6 +313,8 @@ static DEVICE_ATTR(mirror, S_IRUGO|S_IWUSR,
 		display_mirror_show, display_mirror_store);
 static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
 		display_wss_show, display_wss_store);
+static DEVICE_ATTR(lpr_enable, S_IRUGO|S_IWUSR,
+		display_lpr_show, display_lpr_store);
 
 static struct device_attribute *display_sysfs_attrs[] = {
 	&dev_attr_enabled,
@@ -300,6 +324,7 @@ static struct device_attribute *display_sysfs_attrs[] = {
 	&dev_attr_rotate,
 	&dev_attr_mirror,
 	&dev_attr_wss,
+	&dev_attr_lpr_enable,
 	NULL
 };
 
-- 
1.5.4.3


Regards,
Kishore Y


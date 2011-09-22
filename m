From: <mythripk@ti.com>
Subject: [PATCH 3/3] OMAPDSS: HDMI: Add sysfs support to configure
Date: Thu, 22 Sep 2011 16:09:12 +0530
Message-ID: <1316687952-27686-3-git-send-email-mythripk@ti.com>
References: <1316687952-27686-1-git-send-email-mythripk@ti.com>
 <1316687952-27686-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33865 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914Ab1IVKrR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 06:47:17 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MAlETW018459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 05:47:16 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MAlCxJ012133
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 16:17:13 +0530 (IST)
In-Reply-To: <1316687952-27686-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add sysfs support for the uset space to configure limited range or full range
quantization for HDMI.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.h          |    2 +
 drivers/video/omap2/dss/dss_features.c |    1 +
 drivers/video/omap2/dss/hdmi.c         |   28 +++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi_panel.c   |   35 +++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi.h      |    2 +
 5 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ef8770a..bcfb5fa 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -499,6 +499,8 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
 int omapdss_hdmi_read_edid(u8 *buf, int len);
 bool omapdss_hdmi_detect(void);
+int omapdss_hdmi_get_range(void);
+int omapdss_hdmi_set_range(int range);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index a2fc8e0..8303ea2 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -451,6 +451,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.dump_core		=	ti_hdmi_4xxx_core_dump,
 	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
 	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
+	.configure_range	=	ti_hdmi_4xxx_configure_range,
 
 };
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8930998..ff33cb2 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -407,6 +407,34 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi_runtime_put();
 }
 
+int omapdss_hdmi_set_range(int range)
+{
+	int r = 0;
+	enum hdmi_range old_range;
+
+	old_range = hdmi.ip_data.range;
+	hdmi.ip_data.range = range;
+
+	/* HDMI 1.3 section 6.6 VGA (640x480) format requires Full Range */
+	if ((range == 0) &&
+		((hdmi.ip_data.cfg.cm.code == 4 &&
+		hdmi.ip_data.cfg.cm.mode == HDMI_DVI) ||
+		(hdmi.ip_data.cfg.cm.code == 1 &&
+		hdmi.ip_data.cfg.cm.mode == HDMI_HDMI)))
+			return -EINVAL;
+
+	r = hdmi.ip_data.ops->configure_range(&hdmi.ip_data);
+	if (r)
+		hdmi.ip_data.range = old_range;
+
+	return r;
+}
+
+int omapdss_hdmi_get_range(void)
+{
+	return hdmi.ip_data.range;
+}
+
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings)
 {
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 533d5dc..c0aa922 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -33,6 +33,33 @@ static struct {
 	struct mutex hdmi_lock;
 } hdmi;
 
+static ssize_t hdmi_range_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int r;
+
+	r = omapdss_hdmi_get_range();
+	return snprintf(buf, PAGE_SIZE, "%d\n", r);
+}
+
+static ssize_t hdmi_range_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t size)
+{
+	unsigned long range;
+	int r = kstrtoul(buf, 0, &range);
+
+	if (r || range > 1)
+		return -EINVAL;
+
+	r = omapdss_hdmi_set_range(range);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static DEVICE_ATTR(range, S_IRUGO | S_IWUSR, hdmi_range_show, hdmi_range_store);
 
 static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 {
@@ -41,6 +68,12 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 	dssdev->panel.config = OMAP_DSS_LCD_TFT |
 			OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 
+	/* sysfs entry to provide user space control to set
+	 * quantization range
+	 */
+	if (device_create_file(&dssdev->dev, &dev_attr_range))
+		DSSERR("failed to create sysfs file\n");
+
 	dssdev->panel.timings = (struct omap_video_timings){640, 480, 25175, 96, 16, 48, 2 , 11, 31};
 
 	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
@@ -51,7 +84,7 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 
 static void hdmi_panel_remove(struct omap_dss_device *dssdev)
 {
-
+	device_remove_file(&dssdev->dev, &dev_attr_range);
 }
 
 static int hdmi_panel_enable(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index ec30961..4e2418e 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -115,6 +115,8 @@ struct ti_hdmi_ip_ops {
 
 	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
 
+	int (*configure_range)(struct hdmi_ip_data *ip_data);
+
 };
 
 /*
-- 
1.7.5.4


From: <mythripk@ti.com>
Subject: [PATCH v3 3/3] OMAPDSS: HDMI: Sysfs support to configure quantization range
Date: Fri, 6 Jan 2012 17:58:49 +0530
Message-ID: <1325852929-5609-3-git-send-email-mythripk@ti.com>
References: <1325852929-5609-1-git-send-email-mythripk@ti.com>
 <1325852929-5609-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36187 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753949Ab2AFMgU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:36:20 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06CaGsq023354
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:36:17 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06CaFAc023500
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 18:06:16 +0530 (IST)
In-Reply-To: <1325852929-5609-2-git-send-email-mythripk@ti.com>
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
 drivers/video/omap2/dss/hdmi.c         |   28 +++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi_panel.c   |   39 +++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi.h      |    2 +
 5 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3cf99a9..0b1b6f2 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -518,6 +518,8 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
 int omapdss_hdmi_read_edid(u8 *buf, int len);
 bool omapdss_hdmi_detect(void);
+int omapdss_hdmi_get_range(void);
+int omapdss_hdmi_set_range(enum hdmi_range range);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index afcb593..544b172 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -476,6 +476,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
 #endif
+	.configure_range	=	ti_hdmi_4xxx_configure_range,
 
 };
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 92a6679..65397f7 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -384,6 +384,34 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi_runtime_put();
 }
 
+int omapdss_hdmi_set_range(enum hdmi_range range)
+{
+	int r = 0;
+	enum hdmi_range old_range;
+
+	old_range = hdmi.ip_data.range;
+	hdmi.ip_data.range = range;
+
+	/* HDMI 1.3 section 6.6 VGA (640x480) format requires Full Range */
+	if ((range == HDMI_LIMITED_RANGE) &&
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
index 533d5dc..3166602 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -33,6 +33,37 @@ static struct {
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
+	int r ;
+
+	if (strncmp("limited", buf, 7) == 0)
+		range = 0;
+	else if (strncmp("full", buf, 4) == 0)
+		range = 1;
+	else
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
@@ -41,6 +72,12 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
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
@@ -51,7 +88,7 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 
 static void hdmi_panel_remove(struct omap_dss_device *dssdev)
 {
-
+	device_remove_file(&dssdev->dev, &dev_attr_range);
 }
 
 static int hdmi_panel_enable(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index ab0f2c2..9a31683 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -111,6 +111,8 @@ struct ti_hdmi_ip_ops {
 	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
 #endif
 
+	int (*configure_range)(struct hdmi_ip_data *ip_data);
+
 };
 
 /*
-- 
1.7.5.4


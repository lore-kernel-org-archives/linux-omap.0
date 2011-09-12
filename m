From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Mon, 12 Sep 2011 12:13:32 +0300
Message-ID: <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38287 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754437Ab1ILJOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:14 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

Implement detect() by checking the hot plug detect status.

The implementation is not very good, as it always turns on the HDMI
output to get the detection working. HDMI driver needs improvements so
that we could enable only core parts of it.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h             |    1 +
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   17 +++++++++++++++++
 drivers/video/omap2/dss/hdmi_panel.c      |   25 +++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi.h         |    3 +++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   12 ++++++++++++
 6 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 2e7799c..f58c302 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -495,6 +495,7 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev);
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
 int omapdss_hdmi_read_edid(u8 *buf, int len);
+bool omapdss_hdmi_detect(void);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 076f399..ab41665 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -440,6 +440,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.phy_enable		=	ti_hdmi_4xxx_phy_enable,
 	.phy_disable		=	ti_hdmi_4xxx_phy_disable,
 	.read_edid		=	ti_hdmi_4xxx_read_edid,
+	.detect			=	ti_hdmi_4xxx_detect,
 	.pll_enable		=	ti_hdmi_4xxx_pll_enable,
 	.pll_disable		=	ti_hdmi_4xxx_pll_disable,
 	.video_enable		=	ti_hdmi_4xxx_wp_video_start,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index fb85ce5..7818670 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -449,6 +449,23 @@ int omapdss_hdmi_read_edid(u8 *buf, int len)
 	return r;
 }
 
+bool omapdss_hdmi_detect(void)
+{
+	int r;
+
+	mutex_lock(&hdmi.lock);
+
+	r = hdmi_runtime_get();
+	BUG_ON(r);
+
+	r = hdmi.ip_data.ops->detect(&hdmi.ip_data);
+
+	hdmi_runtime_put();
+	mutex_unlock(&hdmi.lock);
+
+	return r == 1;
+}
+
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 71aa813..533d5dc 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -25,6 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <video/omapdss.h>
+#include <linux/slab.h>
 
 #include "dss.h"
 
@@ -198,6 +199,29 @@ err:
 	return r;
 }
 
+static bool hdmi_detect(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	mutex_lock(&hdmi.hdmi_lock);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		r = omapdss_hdmi_display_enable(dssdev);
+		if (r)
+			goto err;
+	}
+
+	r = omapdss_hdmi_detect();
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
+			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
+		omapdss_hdmi_display_disable(dssdev);
+err:
+	mutex_unlock(&hdmi.hdmi_lock);
+
+	return r;
+}
+
 static struct omap_dss_driver hdmi_driver = {
 	.probe		= hdmi_panel_probe,
 	.remove		= hdmi_panel_remove,
@@ -209,6 +233,7 @@ static struct omap_dss_driver hdmi_driver = {
 	.set_timings	= hdmi_set_timings,
 	.check_timings	= hdmi_check_timings,
 	.read_edid	= hdmi_read_edid,
+	.detect		= hdmi_detect,
 	.driver			= {
 		.name   = "hdmi_panel",
 		.owner  = THIS_MODULE,
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 390cd85b..d48603c 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -94,6 +94,8 @@ struct ti_hdmi_ip_ops {
 
 	int (*read_edid)(struct hdmi_ip_data *ip_data, u8 *edid, int len);
 
+	bool (*detect)(struct hdmi_ip_data *ip_data);
+
 	int (*pll_enable)(struct hdmi_ip_data *ip_data);
 
 	void (*pll_disable)(struct hdmi_ip_data *ip_data);
@@ -114,6 +116,7 @@ struct hdmi_ip_data {
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
 int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data, u8 *edid, int len);
+bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
 int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index e9885dc..da7fe50 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -416,6 +416,18 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
 	return l;
 }
 
+bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
+{
+	int r;
+
+	void __iomem *base = hdmi_core_sys_base(ip_data);
+
+	/* HPD */
+	r = REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
+
+	return r == 1;
+}
+
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
 			struct hdmi_core_infoframe_avi *avi_cfg,
 			struct hdmi_core_packet_enable_repeat *repeat_cfg)
-- 
1.7.4.1


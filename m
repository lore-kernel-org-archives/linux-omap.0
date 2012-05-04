From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 02/14] OMAPDSS: HDMI: Split video_enable into video_enable/disable
Date: Thu, 3 May 2012 20:43:56 -0500
Message-ID: <1336095848-6923-3-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37429 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755207Ab2EDBoa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:30 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

To improve readability, split the video_enable HDMI IP operation
into two separate functions for enabling and disabling video.
The video_enable function is also modified to return an error value.

While there, update these operations for the OMAP4 IP accordingly.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   11 +++++++----
 drivers/video/omap2/dss/ti_hdmi.h         |    7 +++++--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   10 ++++++++--
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 52fbc72..c677095 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -562,6 +562,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.pll_enable		=	ti_hdmi_4xxx_pll_enable,
 	.pll_disable		=	ti_hdmi_4xxx_pll_disable,
 	.video_enable		=	ti_hdmi_4xxx_wp_video_start,
+	.video_disable		=	ti_hdmi_4xxx_wp_video_stop,
 	.dump_wrapper		=	ti_hdmi_4xxx_wp_dump,
 	.dump_core		=	ti_hdmi_4xxx_core_dump,
 	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 9a8b32c..159aa66 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -344,7 +344,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
 
-	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
+	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
 	r = hdmi.ip_data.ops->pll_enable(&hdmi.ip_data);
@@ -379,7 +379,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_set_digit_size(dssdev->panel.timings.x_res,
 			dssdev->panel.timings.y_res);
 
-	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
+	r = hdmi.ip_data.ops->video_enable(&hdmi.ip_data);
+	if (r)
+		goto err_vid_enable;
 
 	r = dss_mgr_enable(dssdev->manager);
 	if (r)
@@ -388,7 +390,8 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	return 0;
 
 err_mgr_enable:
-	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
+	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
+err_vid_enable:
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 err:
@@ -400,7 +403,7 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dss_mgr_disable(dssdev->manager);
 
-	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
+	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 	hdmi_runtime_put();
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 88fdc1c..4c84a9c 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -96,7 +96,9 @@ struct ti_hdmi_ip_ops {
 
 	void (*pll_disable)(struct hdmi_ip_data *ip_data);
 
-	void (*video_enable)(struct hdmi_ip_data *ip_data, bool start);
+	int (*video_enable)(struct hdmi_ip_data *ip_data);
+
+	void (*video_disable)(struct hdmi_ip_data *ip_data);
 
 	void (*dump_wrapper)(struct hdmi_ip_data *ip_data, struct seq_file *s);
 
@@ -175,7 +177,8 @@ int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
 int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data, u8 *edid, int len);
 bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data);
-void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
+int ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data);
+void ti_hdmi_4xxx_wp_video_stop(struct hdmi_ip_data *ip_data);
 int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index b25b519..aa18163 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -699,9 +699,15 @@ static void hdmi_wp_init(struct omap_video_timings *timings,
 
 }
 
-void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
+int ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data)
 {
-	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
+	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, true, 31, 31);
+	return 0;
+}
+
+void ti_hdmi_4xxx_wp_video_stop(struct hdmi_ip_data *ip_data)
+{
+	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, false, 31, 31);
 }
 
 static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
-- 
1.7.5.4


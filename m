From: <mythripk@ti.com>
Subject: [PATCH v2 08/10] OMAP4: DSS2: HDMI: Function pointer approach to call
Date: Mon, 29 Aug 2011 11:44:58 +0530
Message-ID: <1314598500-24005-9-git-send-email-mythripk@ti.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com>
 <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com>
 <1314598500-24005-5-git-send-email-mythripk@ti.com>
 <1314598500-24005-6-git-send-email-mythripk@ti.com>
 <1314598500-24005-7-git-send-email-mythripk@ti.com>
 <1314598500-24005-8-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40187 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab1H2GXN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 02:23:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T6NAwN010894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 01:23:12 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T6N90d021158
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:53:09 +0530 (IST)
In-Reply-To: <1314598500-24005-8-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

To make the current hdmi DSS driver compatible with future OMAP with different
IP blocks , add HDMI as a feature in dss_features and abstract the internal
function in hdmi dss driver.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   24 +++++++++++++++++++++++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/hdmi.c         |   22 +++++++++++-----------
 include/video/omapdss.h                |   19 +++++++++++++++++++
 include/video/omaphdmi.h               |    1 +
 5 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b63c5f8..edf2929 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -429,6 +429,26 @@ static const struct omap_dss_features omap4_dss_features = {
 	.burst_size_unit = 16,
 };
 
+const struct omap_hdmi_ip_driver *omap_hdmi_functions;
+
+/* HDMI OMAP4 Functions*/
+const struct omap_hdmi_ip_driver omap4_hdmi_functions = {
+
+	.video_configure	=	hdmi_basic_configure,
+	.phy_enable		=	hdmi_phy_enable,
+	.phy_disable		=	hdmi_phy_disable,
+	.read_edid		=	read_edid,
+	.pll_enable		=	hdmi_pll_enable,
+	.pll_disable		=	hdmi_pll_disable,
+	.video_enable		=	hdmi_wp_video_start,
+};
+
+void dss_hdmi_features_init(struct hdmi_ip_data *ip_data)
+{
+	if (cpu_is_omap44xx())
+		ip_data->hdmi_ops = &omap4_hdmi_functions;
+}
+
 /* Functions returning values related to a DSS feature */
 int dss_feat_get_num_mgrs(void)
 {
@@ -512,8 +532,10 @@ void dss_features_init(void)
 		omap_current_dss_features = &omap3430_dss_features;
 	else if (omap_rev() == OMAP4430_REV_ES1_0)
 		omap_current_dss_features = &omap4430_es1_0_dss_features;
-	else if (cpu_is_omap44xx())
+	else if (cpu_is_omap44xx()) {
 		omap_current_dss_features = &omap4_dss_features;
+		omap_hdmi_functions = &omap4_hdmi_functions;
+	}
 	else
 		DSSWARN("Unsupported OMAP version");
 }
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 4271e96..ca64b21 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -99,4 +99,5 @@ u32 dss_feat_get_burst_size_unit(void);		/* in bytes */
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(void);
+void dss_hdmi_features_init(struct hdmi_ip_data *ip_data);
 #endif
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index fb7d66f..c508cf6 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -184,7 +184,7 @@ static void hdmi_runtime_put(void)
 int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
-
+	dss_hdmi_features_init(&hdmi.hdmi_data);
 	return 0;
 }
 
@@ -364,8 +364,8 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
 
 	if (!hdmi.edid_set)
-		ret = read_edid(&hdmi.hdmi_data, hdmi.edid,
-						HDMI_EDID_MAX_LENGTH);
+		ret = hdmi.hdmi_data.hdmi_ops->read_edid(&hdmi.hdmi_data,
+					hdmi.edid, HDMI_EDID_MAX_LENGTH);
 	if (!ret) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
 			/* search for timings of default resolution */
@@ -475,16 +475,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &hdmi.hdmi_data.pll_data);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
+	hdmi.hdmi_data.hdmi_ops->video_enable(&hdmi.hdmi_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_enable(&hdmi.hdmi_data);
+	r = hdmi.hdmi_data.hdmi_ops->pll_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = hdmi_phy_enable(&hdmi.hdmi_data);
+	r = hdmi.hdmi_data.hdmi_ops->phy_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -492,7 +492,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.hdmi_data.cfg.cm.mode = hdmi.mode;
 	hdmi.hdmi_data.cfg.cm.code = hdmi.code;
-	hdmi_basic_configure(&hdmi.hdmi_data);
+	hdmi.hdmi_data.hdmi_ops->video_configure(&hdmi.hdmi_data);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
@@ -514,7 +514,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 1);
+	hdmi.hdmi_data.hdmi_ops->video_enable(&hdmi.hdmi_data, 1);
 
 	return 0;
 err:
@@ -526,9 +526,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
-	hdmi_phy_disable(&hdmi.hdmi_data);
-	hdmi_pll_disable(&hdmi.hdmi_data);
+	hdmi.hdmi_data.hdmi_ops->video_enable(&hdmi.hdmi_data, 0);
+	hdmi.hdmi_data.hdmi_ops->phy_disable(&hdmi.hdmi_data);
+	hdmi.hdmi_data.hdmi_ops->pll_disable(&hdmi.hdmi_data);
 	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9398dd3..bf2aeba 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#include <video/omaphdmi.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
@@ -555,6 +556,24 @@ struct omap_dss_driver {
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 };
 
+struct omap_hdmi_ip_driver {
+
+	void (*video_configure)(struct hdmi_ip_data *ip_data);
+
+	int (*phy_enable)(struct hdmi_ip_data *ip_data);
+
+	void (*phy_disable)(struct hdmi_ip_data *ip_data);
+
+	int (*read_edid)(struct hdmi_ip_data *ip_data,
+			u8 *pedid, u16 max_length);
+
+	int (*pll_enable)(struct hdmi_ip_data *ip_data);
+
+	void (*pll_disable)(struct hdmi_ip_data *ip_data);
+
+	void (*video_enable)(struct hdmi_ip_data *ip_data, bool start);
+};
+
 int omap_dss_register_driver(struct omap_dss_driver *);
 void omap_dss_unregister_driver(struct omap_dss_driver *);
 
diff --git a/include/video/omaphdmi.h b/include/video/omaphdmi.h
index 88b1ccb..a740237 100644
--- a/include/video/omaphdmi.h
+++ b/include/video/omaphdmi.h
@@ -80,6 +80,7 @@ struct hdmi_ip_data {
 	unsigned long	core_av_offset;
 	unsigned long	pll_offset;
 	unsigned long	phy_offset;
+	const struct omap_hdmi_ip_driver *hdmi_ops;
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 };
-- 
1.7.5.4


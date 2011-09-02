From: <mythripk@ti.com>
Subject: [PATCH v3 09/10] OMAP4: DSS2: HDMI: Function pointer approach to call
Date: Fri, 2 Sep 2011 16:17:49 +0530
Message-ID: <1314960470-2616-10-git-send-email-mythripk@ti.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com>
 <1314960470-2616-3-git-send-email-mythripk@ti.com>
 <1314960470-2616-4-git-send-email-mythripk@ti.com>
 <1314960470-2616-5-git-send-email-mythripk@ti.com>
 <1314960470-2616-6-git-send-email-mythripk@ti.com>
 <1314960470-2616-7-git-send-email-mythripk@ti.com>
 <1314960470-2616-8-git-send-email-mythripk@ti.com>
 <1314960470-2616-9-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41685 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933420Ab1IBK4C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 06:56:02 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p82Atw4a010795
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 05:56:00 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p82AtvlR016870
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 16:25:57 +0530 (IST)
In-Reply-To: <1314960470-2616-9-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

To make the current hdmi DSS driver compatible with future OMAP having
different IP blocks( A combination of different core, PHY, PLL blocks),
Add HDMI hdmi functions as a function pointer in dss_features to abstract
hdmi dss driver IP agnostic, hdmi dss driver  which will now access
generic functions irrespective of underlying IP.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   20 ++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |    3 +++
 drivers/video/omap2/dss/hdmi.c         |   19 ++++++++++---------
 include/video/omapdss.h                |   23 +++++++++++++++++++++++
 include/video/ti_hdmi.h                |    1 +
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b63c5f8..4d50b30 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -429,6 +429,26 @@ static const struct omap_dss_features omap4_dss_features = {
 	.burst_size_unit = 16,
 };
 
+#if defined(CONFIG_OMAP4_DSS_HDMI)
+/* HDMI OMAP4 Functions*/
+static const struct omap_hdmi_ip_ops omap4_hdmi_functions = {
+
+	.video_configure	=	ti_hdmi_4xxx_basic_configure,
+	.phy_enable		=	ti_hdmi_4xxx_phy_enable,
+	.phy_disable		=	ti_hdmi_4xxx_phy_disable,
+	.read_edid		=	ti_hdmi_4xxx_read_edid,
+	.pll_enable		=	ti_hdmi_4xxx_pll_enable,
+	.pll_disable		=	ti_hdmi_4xxx_pll_disable,
+	.video_enable		=	ti_hdmi_4xxx_wp_video_start,
+};
+
+void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data)
+{
+	if (cpu_is_omap44xx())
+		ip_data->ops = &omap4_hdmi_functions;
+}
+#endif
+
 /* Functions returning values related to a DSS feature */
 int dss_feat_get_num_mgrs(void)
 {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 4271e96..8b74f69 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -99,4 +99,7 @@ u32 dss_feat_get_burst_size_unit(void);		/* in bytes */
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(void);
+#if defined(CONFIG_OMAP4_DSS_HDMI)
+void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data);
+#endif
 #endif
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 1b989b3..cb54925 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -185,6 +185,7 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
+	dss_init_hdmi_ip_ops(&hdmi.hdmi_data);
 	return 0;
 }
 
@@ -365,7 +366,7 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
 
 	if (!hdmi.edid_set)
-		ret = ti_hdmi_4xxx_read_edid(&hdmi.hdmi_data, hdmi.edid,
+		ret = hdmi.hdmi_data.ops->read_edid(&hdmi.hdmi_data, hdmi.edid,
 						HDMI_EDID_MAX_LENGTH);
 	if (!ret) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
@@ -479,16 +480,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &hdmi.hdmi_data.pll_data);
 
-	ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
+	hdmi.hdmi_data.ops->video_enable(&hdmi.hdmi_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = ti_hdmi_4xxx_pll_enable(&hdmi.hdmi_data);
+	r = hdmi.hdmi_data.ops->pll_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = ti_hdmi_4xxx_phy_enable(&hdmi.hdmi_data);
+	r = hdmi.hdmi_data.ops->phy_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -496,7 +497,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.hdmi_data.cfg.cm.mode = hdmi.mode;
 	hdmi.hdmi_data.cfg.cm.code = hdmi.code;
-	ti_hdmi_4xxx_basic_configure(&hdmi.hdmi_data);
+	hdmi.hdmi_data.ops->video_configure(&hdmi.hdmi_data);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
@@ -518,7 +519,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
 
-	ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 1);
+	hdmi.hdmi_data.ops->video_enable(&hdmi.hdmi_data, 1);
 
 	return 0;
 err:
@@ -530,9 +531,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
-	ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
-	ti_hdmi_4xxx_phy_disable(&hdmi.hdmi_data);
-	ti_hdmi_4xxx_pll_disable(&hdmi.hdmi_data);
+	hdmi.hdmi_data.ops->video_enable(&hdmi.hdmi_data, 0);
+	hdmi.hdmi_data.ops->phy_disable(&hdmi.hdmi_data);
+	hdmi.hdmi_data.ops->pll_disable(&hdmi.hdmi_data);
 	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9398dd3..c8891d1 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -21,6 +21,9 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#if defined(CONFIG_OMAP4_DSS_HDMI)
+#include <video/ti_hdmi.h>
+#endif
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
@@ -555,6 +558,26 @@ struct omap_dss_driver {
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 };
 
+#if defined(CONFIG_OMAP4_DSS_HDMI)
+struct omap_hdmi_ip_ops {
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
+#endif
+
 int omap_dss_register_driver(struct omap_dss_driver *);
 void omap_dss_unregister_driver(struct omap_dss_driver *);
 
diff --git a/include/video/ti_hdmi.h b/include/video/ti_hdmi.h
index 823fbe6..d44e73c 100644
--- a/include/video/ti_hdmi.h
+++ b/include/video/ti_hdmi.h
@@ -88,6 +88,7 @@ struct hdmi_ip_data {
 	unsigned long	core_av_offset;
 	unsigned long	pll_offset;
 	unsigned long	phy_offset;
+	const struct omap_hdmi_ip_ops *ops;
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 };
-- 
1.7.5.4


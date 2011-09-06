From: <mythripk@ti.com>
Subject: [PATCH v4 10/11] OMAP4: DSS2: HDMI: Function pointer approach to call
Date: Tue, 6 Sep 2011 18:26:24 +0530
Message-ID: <1315313784-28478-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab1IFNEd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 09:04:33 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p86D4UH7016593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Sep 2011 08:04:32 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p86D4Sqb010560
	for <linux-omap@vger.kernel.org>; Tue, 6 Sep 2011 18:34:29 +0530 (IST)
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
 drivers/video/omap2/dss/dss_features.h |    7 +++++++
 drivers/video/omap2/dss/hdmi.c         |   19 ++++++++++---------
 include/video/ti_hdmi.h                |   21 +++++++++++++++++++++
 4 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b63c5f8..8670612 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -429,6 +429,26 @@ static const struct omap_dss_features omap4_dss_features = {
 	.burst_size_unit = 16,
 };
 
+#if defined(CONFIG_OMAP4_DSS_HDMI)
+/* HDMI OMAP4 Functions*/
+static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
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
index 4271e96..e89ae5f 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -20,6 +20,10 @@
 #ifndef __OMAP2_DSS_FEATURES_H
 #define __OMAP2_DSS_FEATURES_H
 
+#if defined(CONFIG_OMAP4_DSS_HDMI)
+#include <video/ti_hdmi.h>
+#endif
+
 #define MAX_DSS_MANAGERS	3
 #define MAX_DSS_OVERLAYS	3
 #define MAX_DSS_LCD_MANAGERS	2
@@ -99,4 +103,7 @@ u32 dss_feat_get_burst_size_unit(void);		/* in bytes */
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(void);
+#if defined(CONFIG_OMAP4_DSS_HDMI)
+void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data);
+#endif
 #endif
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b11ac70..6284460 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -186,6 +186,7 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
+	dss_init_hdmi_ip_ops(&hdmi.ip_data);
 	return 0;
 }
 
@@ -366,7 +367,7 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
 
 	if (!hdmi.edid_set)
-		ret = ti_hdmi_4xxx_read_edid(&hdmi.ip_data, hdmi.edid,
+		ret = hdmi.ip_data.ops->read_edid(&hdmi.ip_data, hdmi.edid,
 						HDMI_EDID_MAX_LENGTH);
 	if (!ret) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
@@ -480,16 +481,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
 
-	ti_hdmi_4xxx_wp_video_start(&hdmi.ip_data, 0);
+	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = ti_hdmi_4xxx_pll_enable(&hdmi.ip_data);
+	r = hdmi.ip_data.ops->pll_enable(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = ti_hdmi_4xxx_phy_enable(&hdmi.ip_data);
+	r = hdmi.ip_data.ops->phy_enable(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -497,7 +498,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.ip_data.cfg.cm.mode = hdmi.mode;
 	hdmi.ip_data.cfg.cm.code = hdmi.code;
-	ti_hdmi_4xxx_basic_configure(&hdmi.ip_data);
+	hdmi.ip_data.ops->video_configure(&hdmi.ip_data);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
@@ -519,7 +520,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
 
-	ti_hdmi_4xxx_wp_video_start(&hdmi.ip_data, 1);
+	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
 
 	return 0;
 err:
@@ -531,9 +532,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
-	ti_hdmi_4xxx_wp_video_start(&hdmi.ip_data, 0);
-	ti_hdmi_4xxx_phy_disable(&hdmi.ip_data);
-	ti_hdmi_4xxx_pll_disable(&hdmi.ip_data);
+	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
+	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
+	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
diff --git a/include/video/ti_hdmi.h b/include/video/ti_hdmi.h
index 823fbe6..acf1022 100644
--- a/include/video/ti_hdmi.h
+++ b/include/video/ti_hdmi.h
@@ -21,6 +21,8 @@
 #ifndef _TI_HDMI_H
 #define _TI_HDMI_H
 
+struct hdmi_ip_data;
+
 enum hdmi_pll_pwr {
 	HDMI_PLLPWRCMD_ALLOFF = 0,
 	HDMI_PLLPWRCMD_PLLONLY = 1,
@@ -82,12 +84,31 @@ struct hdmi_pll_info {
 	enum hdmi_clk_refsel refsel;
 };
 
+struct ti_hdmi_ip_ops {
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
 struct hdmi_ip_data {
 	void __iomem	*base_wp;	/* HDMI wrapper */
 	unsigned long	core_sys_offset;
 	unsigned long	core_av_offset;
 	unsigned long	pll_offset;
 	unsigned long	phy_offset;
+	const struct ti_hdmi_ip_ops *ops;
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 };
-- 
1.7.5.4


From: <mythripk@ti.com>
Subject: [PATCH 08/10] OMAP4: DSS: HDMI: Rename the functions in HDMI IP library
Date: Thu, 8 Sep 2011 19:06:25 +0530
Message-ID: <1315488987-4546-9-git-send-email-mythripk@ti.com>
References: <1315488987-4546-1-git-send-email-mythripk@ti.com>
 <1315488987-4546-2-git-send-email-mythripk@ti.com>
 <1315488987-4546-3-git-send-email-mythripk@ti.com>
 <1315488987-4546-4-git-send-email-mythripk@ti.com>
 <1315488987-4546-5-git-send-email-mythripk@ti.com>
 <1315488987-4546-6-git-send-email-mythripk@ti.com>
 <1315488987-4546-7-git-send-email-mythripk@ti.com>
 <1315488987-4546-8-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59434 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932902Ab1IHNog (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 09:44:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p88DiXlQ023856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 08:44:35 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p88DiWKN003411
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 19:14:32 +0530 (IST)
In-Reply-To: <1315488987-4546-8-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Functions that are included in HDMI IP driver is renamed to have
IP specific names so that it will not conflict with similar functions
from other IP.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |   18 +++++++++---------
 drivers/video/omap2/dss/ti_hdmi.h         |   15 ++++++++-------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   20 +++++++++++++-------
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2a8a55d..5afc51b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -366,7 +366,7 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
 
 	if (!hdmi.edid_set)
-		ret = read_edid(&hdmi.ip_data, hdmi.edid,
+		ret = ti_hdmi_4xxx_read_edid(&hdmi.ip_data, hdmi.edid,
 						HDMI_EDID_MAX_LENGTH);
 	if (!ret) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
@@ -480,16 +480,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
 
-	hdmi_wp_video_start(&hdmi.ip_data, 0);
+	ti_hdmi_4xxx_wp_video_start(&hdmi.ip_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_program(&hdmi.ip_data);
+	r = ti_hdmi_4xxx_pll_enable(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = hdmi_phy_init(&hdmi.ip_data);
+	r = ti_hdmi_4xxx_phy_enable(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -497,7 +497,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.ip_data.cfg.cm.mode = hdmi.mode;
 	hdmi.ip_data.cfg.cm.code = hdmi.code;
-	hdmi_basic_configure(&hdmi.ip_data);
+	ti_hdmi_4xxx_basic_configure(&hdmi.ip_data);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
@@ -519,7 +519,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
 
-	hdmi_wp_video_start(&hdmi.ip_data, 1);
+	ti_hdmi_4xxx_wp_video_start(&hdmi.ip_data, 1);
 
 	return 0;
 err:
@@ -531,9 +531,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
-	hdmi_wp_video_start(&hdmi.ip_data, 0);
-	hdmi_phy_off(&hdmi.ip_data);
-	hdmi_set_pll_pwr(&hdmi.ip_data, HDMI_PLLPWRCMD_ALLOFF);
+	ti_hdmi_4xxx_wp_video_start(&hdmi.ip_data, 0);
+	ti_hdmi_4xxx_phy_disable(&hdmi.ip_data);
+	ti_hdmi_4xxx_pll_disable(&hdmi.ip_data);
 	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 7c63098..823fbe6 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -91,11 +91,12 @@ struct hdmi_ip_data {
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 };
-int hdmi_phy_init(struct hdmi_ip_data *ip_data);
-void hdmi_phy_off(struct hdmi_ip_data *ip_data);
-int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length);
-void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
-int hdmi_pll_program(struct hdmi_ip_data *ip_data);
-int hdmi_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val);
-void hdmi_basic_configure(struct hdmi_ip_data *ip_data);
+int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
+void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
+int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
+					u8 *pedid, u16 max_length);
+void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
+int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data);
+void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data);
+void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data);
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index c2a98f8..cb3a2d6 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -164,7 +164,7 @@ static int hdmi_set_phy_pwr(struct hdmi_ip_data *ip_data, enum hdmi_phy_pwr val)
 }
 
 /* PLL_PWR_CMD */
-int hdmi_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val)
+static int hdmi_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val)
 {
 	/* Command for power control of HDMI PLL */
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, val, 3, 2);
@@ -194,7 +194,7 @@ static int hdmi_pll_reset(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-int hdmi_pll_program(struct hdmi_ip_data *ip_data)
+int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 
@@ -217,7 +217,12 @@ int hdmi_pll_program(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-int hdmi_phy_init(struct hdmi_ip_data *ip_data)
+void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data)
+{
+	hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
+}
+
+int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 	void __iomem *phy_base = hdmi_phy_base(ip_data);
@@ -254,7 +259,7 @@ int hdmi_phy_init(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-void hdmi_phy_off(struct hdmi_ip_data *ip_data)
+void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
@@ -360,7 +365,8 @@ static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
+int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
+				u8 *pedid, u16 max_length)
 {
 	int r = 0, n = 0, i = 0;
 	int max_ext_blocks = (max_length / 128) - 1;
@@ -613,7 +619,7 @@ static void hdmi_wp_init(struct omap_video_timings *timings,
 
 }
 
-void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
+void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
 {
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
 }
@@ -680,7 +686,7 @@ static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_V, timing_v);
 }
 
-void hdmi_basic_configure(struct hdmi_ip_data *ip_data)
+void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 {
 	/* HDMI */
 	struct omap_video_timings video_timing;
-- 
1.7.5.4


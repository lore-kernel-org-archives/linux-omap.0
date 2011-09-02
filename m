From: <mythripk@ti.com>
Subject: [PATCH v3 07/10] OMAP4: DSS: HDMI: Rename the functions in HDMI IP
Date: Fri, 2 Sep 2011 16:17:47 +0530
Message-ID: <1314960470-2616-8-git-send-email-mythripk@ti.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com>
 <1314960470-2616-3-git-send-email-mythripk@ti.com>
 <1314960470-2616-4-git-send-email-mythripk@ti.com>
 <1314960470-2616-5-git-send-email-mythripk@ti.com>
 <1314960470-2616-6-git-send-email-mythripk@ti.com>
 <1314960470-2616-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933399Ab1IBK4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 06:56:01 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p82AtvmH027238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 05:55:59 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p82AturK016844
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 16:25:57 +0530 (IST)
In-Reply-To: <1314960470-2616-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Functions that are included in HDMI IP driver is renamed to have IP specific
names so that it will not conflict with similar functions from other IP.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |   18 +++++++++---------
 drivers/video/omap2/dss/ti_hdmi.h         |   15 ++++++++-------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   18 ++++++++++++------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 6ff68b8..b6ec4d7 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -365,7 +365,7 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
 
 	if (!hdmi.edid_set)
-		ret = read_edid(&hdmi.hdmi_data, hdmi.edid,
+		ret = ti_hdmi_4xxx_read_edid(&hdmi.hdmi_data, hdmi.edid,
 						HDMI_EDID_MAX_LENGTH);
 	if (!ret) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
@@ -479,16 +479,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &hdmi.hdmi_data.pll_data);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
+	ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_program(&hdmi.hdmi_data);
+	r = ti_hdmi_4xxx_pll_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = hdmi_phy_init(&hdmi.hdmi_data);
+	r = ti_hdmi_4xxx_phy_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -496,7 +496,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.hdmi_data.cfg.cm.mode = hdmi.mode;
 	hdmi.hdmi_data.cfg.cm.code = hdmi.code;
-	hdmi_basic_configure(&hdmi.hdmi_data);
+	ti_hdmi_4xxx_basic_configure(&hdmi.hdmi_data);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
@@ -518,7 +518,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 1);
+	ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 1);
 
 	return 0;
 err:
@@ -530,9 +530,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
-	hdmi_phy_off(&hdmi.hdmi_data);
-	hdmi_set_pll_pwr(&hdmi.hdmi_data, HDMI_PLLPWRCMD_ALLOFF);
+	ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
+	ti_hdmi_4xxx_phy_disable(&hdmi.hdmi_data);
+	ti_hdmi_4xxx_pll_disable(&hdmi.hdmi_data);
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
index 4659704..2fa4824 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -193,7 +193,7 @@ static int hdmi_pll_reset(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-int hdmi_pll_program(struct hdmi_ip_data *ip_data)
+int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 
@@ -216,7 +216,12 @@ int hdmi_pll_program(struct hdmi_ip_data *ip_data)
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
@@ -253,7 +258,7 @@ int hdmi_phy_init(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-void hdmi_phy_off(struct hdmi_ip_data *ip_data)
+void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
@@ -359,7 +364,8 @@ static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
+int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
+				u8 *pedid, u16 max_length)
 {
 	int r = 0, n = 0, i = 0;
 	int max_ext_blocks = (max_length / 128) - 1;
@@ -612,7 +618,7 @@ static void hdmi_wp_init(struct omap_video_timings *timings,
 
 }
 
-void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
+void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
 {
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
 }
@@ -679,7 +685,7 @@ static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_V, timing_v);
 }
 
-void hdmi_basic_configure(struct hdmi_ip_data *ip_data)
+void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 {
 	/* HDMI */
 	struct omap_video_timings video_timing;
-- 
1.7.5.4


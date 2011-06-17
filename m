From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 6/8] OMAP4: DSS: HDMI: Rename the functions in HDMI IP
Date: Fri, 17 Jun 2011 13:47:15 +0530
Message-ID: <1308298637-29753-7-git-send-email-mythripk@ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
 <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com>
 <1308298637-29753-5-git-send-email-mythripk@ti.com>
 <1308298637-29753-6-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757153Ab1FQIY0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 04:24:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5H8OMZn024482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 03:24:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5H8OMM2001795
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 13:54:22 +0530 (IST)
In-Reply-To: <1308298637-29753-6-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Functions that are included in the generic video include of HDMI TI OMAP4, TI8xx
etc IP library is renamed to have IP specific names so that it will not conflict
with similar function from other IP.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |   18 +++++++++---------
 drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c |   18 +++++++++---------
 include/video/hdmi_ti_4xxx_ip.h           |   14 +++++++-------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 1bd98d9..d42bb5d 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -395,7 +395,7 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
 
 	if (!hdmi.edid_set)
-		ret = read_edid(&hdmi.hdmi_data, hdmi.edid,
+		ret = read_ti_4xxx_edid(&hdmi.hdmi_data, hdmi.edid,
 						HDMI_EDID_MAX_LENGTH);
 	if (!ret) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
@@ -508,16 +508,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &pll_data);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
+	hdmi_ti_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_program(&hdmi.hdmi_data, &pll_data);
+	r = hdmi_ti_4xxx_pll_program(&hdmi.hdmi_data, &pll_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = hdmi_phy_init(&hdmi.hdmi_data);
+	r = hdmi_ti_4xxx_phy_init(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -525,7 +525,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.cfg.cm.mode = hdmi.mode;
 	hdmi.cfg.cm.code = hdmi.code;
-	hdmi_basic_configure(&hdmi.hdmi_data, &hdmi.cfg);
+	hdmi_ti_4xxx_basic_configure(&hdmi.hdmi_data, &hdmi.cfg);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
@@ -547,7 +547,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 1);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 1);
+	hdmi_ti_4xxx_wp_video_start(&hdmi.hdmi_data, 1);
 
 	return 0;
 err:
@@ -559,9 +559,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
 
-	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
-	hdmi_phy_off(&hdmi.hdmi_data);
-	hdmi_set_pll_pwr(&hdmi.hdmi_data, HDMI_PLLPWRCMD_ALLOFF);
+	hdmi_ti_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
+	hdmi_ti_4xxx_phy_off(&hdmi.hdmi_data);
+	hdmi_ti_4xxx_set_pll_pwr(&hdmi.hdmi_data, HDMI_PLLPWRCMD_ALLOFF);
 	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
diff --git a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c b/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
index b4e8875..51dc2a8 100644
--- a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
+++ b/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
@@ -165,7 +165,7 @@ static int hdmi_set_phy_pwr(struct hdmi_ip_data *ip_data, enum hdmi_phy_pwr val)
 }
 
 /* PLL_PWR_CMD */
-int hdmi_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val)
+int hdmi_ti_4xxx_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val)
 {
 	/* Command for power control of HDMI PLL */
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, val, 3, 2);
@@ -195,17 +195,17 @@ static int hdmi_pll_reset(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-int hdmi_pll_program(struct hdmi_ip_data *ip_data,
+int hdmi_ti_4xxx_pll_program(struct hdmi_ip_data *ip_data,
 				struct hdmi_pll_info *fmt)
 {
 	u16 r = 0;
 	enum hdmi_clk_refsel refsel;
 
-	r = hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
+	r = hdmi_ti_4xxx_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
 	if (r)
 		return r;
 
-	r = hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
+	r = hdmi_ti_4xxx_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
 	if (r)
 		return r;
 
@@ -222,7 +222,7 @@ int hdmi_pll_program(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-int hdmi_phy_init(struct hdmi_ip_data *ip_data)
+int hdmi_ti_4xxx_phy_init(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 
@@ -260,7 +260,7 @@ int hdmi_phy_init(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-void hdmi_phy_off(struct hdmi_ip_data *ip_data)
+void hdmi_ti_4xxx_phy_off(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
@@ -376,7 +376,7 @@ static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
+int read_ti_4xxx_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
 {
 	int r = 0, n = 0, i = 0;
 	int max_ext_blocks = (max_length / 128) - 1;
@@ -627,7 +627,7 @@ static void hdmi_wp_init(struct omap_video_timings *timings,
 
 }
 
-void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
+void hdmi_ti_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
 {
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
 }
@@ -694,7 +694,7 @@ static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_V, timing_v);
 }
 
-void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
+void hdmi_ti_4xxx_basic_configure(struct hdmi_ip_data *ip_data,
 			struct hdmi_config *cfg)
 {
 	/* HDMI */
diff --git a/include/video/hdmi_ti_4xxx_ip.h b/include/video/hdmi_ti_4xxx_ip.h
index 3355f40..d354280 100644
--- a/include/video/hdmi_ti_4xxx_ip.h
+++ b/include/video/hdmi_ti_4xxx_ip.h
@@ -82,13 +82,13 @@ struct hdmi_pll_info {
 	u16 dcofreq;
 };
 
-int hdmi_phy_init(struct hdmi_ip_data *ip_data);
-void hdmi_phy_off(struct hdmi_ip_data *ip_data);
-int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length);
-void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
-int hdmi_pll_program(struct hdmi_ip_data *ip_data,
+int hdmi_ti_4xxx_phy_init(struct hdmi_ip_data *ip_data);
+void hdmi_ti_4xxx_phy_off(struct hdmi_ip_data *ip_data);
+int read_ti_4xxx_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length);
+void hdmi_ti_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
+int hdmi_ti_4xxx_pll_program(struct hdmi_ip_data *ip_data,
 			struct hdmi_pll_info *fmt);
-int hdmi_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val);
-void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
+int hdmi_ti_4xxx_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val);
+void hdmi_ti_4xxx_basic_configure(struct hdmi_ip_data *ip_data,
 			struct hdmi_config *cfg);
 #endif
-- 
1.7.5.4


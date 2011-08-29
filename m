From: <mythripk@ti.com>
Subject: [PATCH v2 02/10] OMAP4: DSS: HDMI: Move pll and video configuration
Date: Mon, 29 Aug 2011 11:44:52 +0530
Message-ID: <1314598500-24005-3-git-send-email-mythripk@ti.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab1H2GXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 02:23:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T6N91O002999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 01:23:11 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T6N8bS021125
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:53:08 +0530 (IST)
In-Reply-To: <1314598500-24005-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

As the pll and the video configuration info are part of the ip_data those
structures are moved to the ip_data strtucure.Also the functions are modified
accordingly to take care of this movement.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   34 +++++++++++++++-------------------
 drivers/video/omap2/dss/hdmi.h |   18 ++++++++++--------
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 544f93e..084a47e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -59,7 +59,6 @@ static struct {
 	u8 edid[HDMI_EDID_MAX_LENGTH];
 	u8 edid_set;
 	bool custom_set;
-	struct hdmi_config cfg;
 
 	struct clk *sys_clk;
 } hdmi;
@@ -230,11 +229,11 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
 }
 
 static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
-		enum hdmi_clk_refsel refsel, int dcofreq,
-		struct hdmi_pll_info *fmt, u16 sd)
+			enum hdmi_clk_refsel refsel)
 {
 	u32 r;
 	void __iomem *pll_base = hdmi_pll_base(ip_data);
+	struct hdmi_pll_info *fmt = &ip_data->pll_data;
 
 	/* PLL start always use manual mode */
 	REG_FLD_MOD(pll_base, PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
@@ -251,9 +250,9 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
 	r = FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
 	r = FLD_MOD(r, 0x0, 14, 14); /* PHY_CLKINEN de-assert during locking */
 
-	if (dcofreq) {
+	if (fmt->dcofreq) {
 		/* divider programming for frequency beyond 1000Mhz */
-		REG_FLD_MOD(pll_base, PLLCTRL_CFG3, sd, 17, 10);
+		REG_FLD_MOD(pll_base, PLLCTRL_CFG3, fmt->regsd, 17, 10);
 		r = FLD_MOD(r, 0x4, 3, 1); /* 1000MHz and 2000MHz */
 	} else {
 		r = FLD_MOD(r, 0x2, 3, 1); /* 500MHz and 1000MHz */
@@ -379,8 +378,7 @@ static int hdmi_phy_init(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
-				struct hdmi_pll_info *fmt)
+static int hdmi_pll_program(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 	enum hdmi_clk_refsel refsel;
@@ -399,7 +397,7 @@ static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
 
 	refsel = HDMI_REFSEL_SYSCLK;
 
-	r = hdmi_pll_init(ip_data, refsel, fmt->dcofreq, fmt, fmt->regsd);
+	r = hdmi_pll_init(ip_data, refsel);
 	if (r)
 		return r;
 
@@ -1015,8 +1013,7 @@ static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_V, timing_v);
 }
 
-static void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
-			struct hdmi_config *cfg)
+static void hdmi_basic_configure(struct hdmi_ip_data *ip_data)
 {
 	/* HDMI */
 	struct omap_video_timings video_timing;
@@ -1026,6 +1023,7 @@ static void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
 	struct hdmi_core_infoframe_avi avi_cfg;
 	struct hdmi_core_video_config v_core_cfg;
 	struct hdmi_core_packet_enable_repeat repeat_cfg;
+	struct hdmi_config *cfg = &ip_data->cfg;
 
 	hdmi_wp_init(&video_timing, &video_format,
 		&video_interface);
@@ -1034,8 +1032,7 @@ static void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
 		&avi_cfg,
 		&repeat_cfg);
 
-	hdmi_wp_video_init_format(&video_format,
-			&video_timing, cfg);
+	hdmi_wp_video_init_format(&video_format, &video_timing, cfg);
 
 	hdmi_wp_video_config_timing(ip_data, &video_timing);
 
@@ -1161,7 +1158,6 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 static int hdmi_power_on(struct omap_dss_device *dssdev)
 {
 	int r, code = 0;
-	struct hdmi_pll_info pll_data;
 	struct omap_video_timings *p;
 	unsigned long phy;
 
@@ -1183,16 +1179,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	}
 	code = get_timings_index();
 	dssdev->panel.timings = cea_vesa_timings[code].timings;
-	update_hdmi_timings(&hdmi.cfg, p, code);
+	update_hdmi_timings(&hdmi.hdmi_data.cfg, p, code);
 
 	phy = p->pixel_clock;
 
-	hdmi_compute_pll(dssdev, phy, &pll_data);
+	hdmi_compute_pll(dssdev, phy, &hdmi.hdmi_data.pll_data);
 
 	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_program(&hdmi.hdmi_data, &pll_data);
+	r = hdmi_pll_program(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
@@ -1204,9 +1200,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	hdmi.cfg.cm.mode = hdmi.mode;
-	hdmi.cfg.cm.code = hdmi.code;
-	hdmi_basic_configure(&hdmi.hdmi_data, &hdmi.cfg);
+	hdmi.hdmi_data.cfg.cm.mode = hdmi.mode;
+	hdmi.hdmi_data.cfg.cm.code = hdmi.code;
+	hdmi_basic_configure(&hdmi.hdmi_data);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index ee37bd9..c0f4c2a 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -558,14 +558,6 @@ struct hdmi_video_interface {
 	int	tm;	/* Timing mode */
 };
 
-struct hdmi_ip_data {
-	void __iomem	*base_wp;	/* HDMI wrapper */
-	unsigned long	core_sys_offset;
-	unsigned long	core_av_offset;
-	unsigned long	pll_offset;
-	unsigned long	phy_offset;
-};
-
 struct hdmi_cm {
 	int	code;
 	int	mode;
@@ -577,6 +569,16 @@ struct hdmi_config {
 	struct hdmi_cm cm;
 };
 
+struct hdmi_ip_data {
+	void __iomem	*base_wp;	/* HDMI wrapper */
+	unsigned long	core_sys_offset;
+	unsigned long	core_av_offset;
+	unsigned long	pll_offset;
+	unsigned long	phy_offset;
+	struct hdmi_config cfg;
+	struct hdmi_pll_info pll_data;
+};
+
 struct hdmi_audio_format {
 	enum hdmi_stereo_channels		stereo_channels;
 	u8					active_chnnls_msk;
-- 
1.7.5.4


From: <mythripk@ti.com>
Subject: [PATCH v4 02/11] OMAP4: DSS: HDMI: Move pll and video configuration
Date: Tue, 6 Sep 2011 17:28:46 +0530
Message-ID: <1315310335-26054-3-git-send-email-mythripk@ti.com>
References: <1315310335-26054-1-git-send-email-mythripk@ti.com>
 <1315310335-26054-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52218 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928Ab1IFMHG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 08:07:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p86C7218014482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Sep 2011 07:07:04 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p86C71in001248
	for <linux-omap@vger.kernel.org>; Tue, 6 Sep 2011 17:37:02 +0530 (IST)
In-Reply-To: <1315310335-26054-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

As the pll and the video configuration info are part of the ip_data those
structures are moved to the ip_data structure. Also the functions are modified
accordingly to take care of this movement.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.h  |    8 +++++++
 drivers/video/omap2/dss/hdmi.c |   41 +++++++++++++++++----------------------
 drivers/video/omap2/dss/hdmi.h |   25 +++++++++--------------
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a095a62..4cb264e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -150,6 +150,13 @@ struct dsi_clock_info {
 	bool use_sys_clk;
 };
 
+enum hdmi_clk_refsel {
+	HDMI_REFSEL_PCLK = 0,
+	HDMI_REFSEL_REF1 = 1,
+	HDMI_REFSEL_REF2 = 2,
+	HDMI_REFSEL_SYSCLK = 3
+};
+
 /* HDMI PLL structure */
 struct hdmi_pll_info {
 	u16 regn;
@@ -158,6 +165,7 @@ struct hdmi_pll_info {
 	u16 regm2;
 	u16 regsd;
 	u16 dcofreq;
+	enum hdmi_clk_refsel refsel;
 };
 
 struct seq_file;
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index bfd113c..9074123 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -59,7 +59,6 @@ static struct {
 	u8 edid[HDMI_EDID_MAX_LENGTH];
 	u8 edid_set;
 	bool custom_set;
-	struct hdmi_config cfg;
 
 	struct clk *sys_clk;
 } hdmi;
@@ -229,12 +228,11 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
-		enum hdmi_clk_refsel refsel, int dcofreq,
-		struct hdmi_pll_info *fmt, u16 sd)
+static int hdmi_pll_init(struct hdmi_ip_data *ip_data)
 {
 	u32 r;
 	void __iomem *pll_base = hdmi_pll_base(ip_data);
+	struct hdmi_pll_info *fmt = &ip_data->pll_data;
 
 	/* PLL start always use manual mode */
 	REG_FLD_MOD(pll_base, PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
@@ -251,9 +249,9 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
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
@@ -379,11 +377,9 @@ static int hdmi_phy_init(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
-				struct hdmi_pll_info *fmt)
+static int hdmi_pll_program(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
-	enum hdmi_clk_refsel refsel;
 
 	r = hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
 	if (r)
@@ -397,9 +393,7 @@ static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
 	if (r)
 		return r;
 
-	refsel = HDMI_REFSEL_SYSCLK;
-
-	r = hdmi_pll_init(ip_data, refsel, fmt->dcofreq, fmt, fmt->regsd);
+	r = hdmi_pll_init(ip_data);
 	if (r)
 		return r;
 
@@ -1015,8 +1009,7 @@ static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_V, timing_v);
 }
 
-static void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
-			struct hdmi_config *cfg)
+static void hdmi_basic_configure(struct hdmi_ip_data *ip_data)
 {
 	/* HDMI */
 	struct omap_video_timings video_timing;
@@ -1026,6 +1019,7 @@ static void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
 	struct hdmi_core_infoframe_avi avi_cfg;
 	struct hdmi_core_video_config v_core_cfg;
 	struct hdmi_core_packet_enable_repeat repeat_cfg;
+	struct hdmi_config *cfg = &ip_data->cfg;
 
 	hdmi_wp_init(&video_timing, &video_format,
 		&video_interface);
@@ -1034,8 +1028,7 @@ static void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
 		&avi_cfg,
 		&repeat_cfg);
 
-	hdmi_wp_video_init_format(&video_format,
-			&video_timing, cfg);
+	hdmi_wp_video_init_format(&video_format, &video_timing, cfg);
 
 	hdmi_wp_video_config_timing(ip_data, &video_timing);
 
@@ -1154,6 +1147,9 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	pi->dcofreq = phy > 1000 * 100;
 	pi->regsd = ((pi->regm * clkin / 10) / ((pi->regn + 1) * 250) + 5) / 10;
 
+	/* Set the reference clock to sysclk reference */
+	pi->refsel = HDMI_REFSEL_SYSCLK;
+
 	DSSDBG("M = %d Mf = %d\n", pi->regm, pi->regmf);
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
 }
@@ -1161,7 +1157,6 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 static int hdmi_power_on(struct omap_dss_device *dssdev)
 {
 	int r, code = 0;
-	struct hdmi_pll_info pll_data;
 	struct omap_video_timings *p;
 	unsigned long phy;
 
@@ -1183,16 +1178,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	}
 	code = get_timings_index();
 	dssdev->panel.timings = cea_vesa_timings[code].timings;
-	update_hdmi_timings(&hdmi.cfg, p, code);
+	update_hdmi_timings(&hdmi.ip_data.cfg, p, code);
 
 	phy = p->pixel_clock;
 
-	hdmi_compute_pll(dssdev, phy, &pll_data);
+	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
 
 	hdmi_wp_video_start(&hdmi.ip_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_program(&hdmi.ip_data, &pll_data);
+	r = hdmi_pll_program(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
@@ -1204,9 +1199,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	hdmi.cfg.cm.mode = hdmi.mode;
-	hdmi.cfg.cm.code = hdmi.code;
-	hdmi_basic_configure(&hdmi.ip_data, &hdmi.cfg);
+	hdmi.ip_data.cfg.cm.mode = hdmi.mode;
+	hdmi.ip_data.cfg.cm.code = hdmi.code;
+	hdmi_basic_configure(&hdmi.ip_data);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index ee37bd9..d2913f8 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -218,13 +218,6 @@ enum hdmi_pll_pwr {
 	HDMI_PLLPWRCMD_BOTHON_NOPHYCLK = 3
 };
 
-enum hdmi_clk_refsel {
-	HDMI_REFSEL_PCLK = 0,
-	HDMI_REFSEL_REF1 = 1,
-	HDMI_REFSEL_REF2 = 2,
-	HDMI_REFSEL_SYSCLK = 3
-};
-
 enum hdmi_core_inputbus_width {
 	HDMI_INPUT_8BIT = 0,
 	HDMI_INPUT_10BIT = 1,
@@ -558,14 +551,6 @@ struct hdmi_video_interface {
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
@@ -577,6 +562,16 @@ struct hdmi_config {
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


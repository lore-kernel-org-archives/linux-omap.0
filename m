From: <mythripk@ti.com>
Subject: [PATCH v2 09/10] MAP4: DSS: HDMI: Rename the functions in HDMI IP
Date: Mon, 29 Aug 2011 11:44:59 +0530
Message-ID: <1314598500-24005-10-git-send-email-mythripk@ti.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com>
 <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com>
 <1314598500-24005-5-git-send-email-mythripk@ti.com>
 <1314598500-24005-6-git-send-email-mythripk@ti.com>
 <1314598500-24005-7-git-send-email-mythripk@ti.com>
 <1314598500-24005-8-git-send-email-mythripk@ti.com>
 <1314598500-24005-9-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44539 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848Ab1H2GXN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 02:23:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T6NAOn014867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 01:23:12 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T6N9Rh021164
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:53:09 +0530 (IST)
In-Reply-To: <1314598500-24005-9-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Functions that are included in the generic video include of HDMI TI OMAP4, TI8xx
etc IP library is renamed to have IP specific names so that it will not conflict
with similar function from other IP.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |   14 +++++++-------
 drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c |   15 ++++++++-------
 include/video/omaphdmi.h                  |   15 ++++++++-------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index edf2929..c1ef0d6 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -434,13 +434,13 @@ const struct omap_hdmi_ip_driver *omap_hdmi_functions;
 /* HDMI OMAP4 Functions*/
 const struct omap_hdmi_ip_driver omap4_hdmi_functions = {
 
-	.video_configure	=	hdmi_basic_configure,
-	.phy_enable		=	hdmi_phy_enable,
-	.phy_disable		=	hdmi_phy_disable,
-	.read_edid		=	read_edid,
-	.pll_enable		=	hdmi_pll_enable,
-	.pll_disable		=	hdmi_pll_disable,
-	.video_enable		=	hdmi_wp_video_start,
+	.video_configure	=	hdmi_ti_4xxx_basic_configure,
+	.phy_enable		=	hdmi_ti_4xxx_phy_enable,
+	.phy_disable		=	hdmi_ti_4xxx_phy_disable,
+	.read_edid		=	hdmi_ti_4xxx_read_edid,
+	.pll_enable		=	hdmi_ti_4xxx_pll_enable,
+	.pll_disable		=	hdmi_ti_4xxx_pll_disable,
+	.video_enable		=	hdmi_ti_4xxx_wp_video_start,
 };
 
 void dss_hdmi_features_init(struct hdmi_ip_data *ip_data)
diff --git a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c b/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
index f64e06c..3ce99b0 100644
--- a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
+++ b/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
@@ -194,7 +194,7 @@ static int hdmi_pll_reset(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-int hdmi_pll_enable(struct hdmi_ip_data *ip_data)
+int hdmi_ti_4xxx_pll_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 	enum hdmi_clk_refsel refsel;
@@ -220,12 +220,12 @@ int hdmi_pll_enable(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-void hdmi_pll_disable(struct hdmi_ip_data *ip_data)
+void hdmi_ti_4xxx_pll_disable(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
 }
 
-int hdmi_phy_enable(struct hdmi_ip_data *ip_data)
+int hdmi_ti_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 	void __iomem *phy_base = hdmi_phy_base(ip_data);
@@ -262,7 +262,7 @@ int hdmi_phy_enable(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-void hdmi_phy_disable(struct hdmi_ip_data *ip_data)
+void hdmi_ti_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
@@ -368,7 +368,8 @@ static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
+int hdmi_ti_4xxx_read_edid(struct hdmi_ip_data *ip_data,
+				u8 *pedid, u16 max_length)
 {
 	int r = 0, n = 0, i = 0;
 	int max_ext_blocks = (max_length / 128) - 1;
@@ -621,7 +622,7 @@ static void hdmi_wp_init(struct omap_video_timings *timings,
 
 }
 
-void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
+void hdmi_ti_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
 {
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
 }
@@ -688,7 +689,7 @@ static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_V, timing_v);
 }
 
-void hdmi_basic_configure(struct hdmi_ip_data *ip_data)
+void hdmi_ti_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 {
 	/* HDMI */
 	struct omap_video_timings video_timing;
diff --git a/include/video/omaphdmi.h b/include/video/omaphdmi.h
index a740237..9548284 100644
--- a/include/video/omaphdmi.h
+++ b/include/video/omaphdmi.h
@@ -84,11 +84,12 @@ struct hdmi_ip_data {
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 };
-int hdmi_phy_enable(struct hdmi_ip_data *ip_data);
-void hdmi_phy_disable(struct hdmi_ip_data *ip_data);
-int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length);
-void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
-int hdmi_pll_enable(struct hdmi_ip_data *ip_data);
-void hdmi_pll_disable(struct hdmi_ip_data *ip_data);
-void hdmi_basic_configure(struct hdmi_ip_data *ip_data);
+int hdmi_ti_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
+void hdmi_ti_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
+int hdmi_ti_4xxx_read_edid(struct hdmi_ip_data *ip_data,
+					u8 *pedid, u16 max_length);
+void hdmi_ti_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
+int hdmi_ti_4xxx_pll_enable(struct hdmi_ip_data *ip_data);
+void hdmi_ti_4xxx_pll_disable(struct hdmi_ip_data *ip_data);
+void hdmi_ti_4xxx_basic_configure(struct hdmi_ip_data *ip_data);
 #endif
-- 
1.7.5.4


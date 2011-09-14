From: Archit Taneja <archit@ti.com>
Subject: [PATCH 07/10] v3 OMAP2PLUS: DSS2: Get correct pixel clock for TV manager
Date: Wed, 14 Sep 2011 17:55:11 +0530
Message-ID: <1316003114-24291-4-git-send-email-archit@ti.com>
References: <1316003114-24291-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60006 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab1INMY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 08:24:26 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECOPL6030286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:25 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8ECOP2S015194
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:25 -0500 (CDT)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECOP0J001345
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:25 -0500 (CDT)
In-Reply-To: <1316003114-24291-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dispc_mgr_pclk_rate() is used to calculate minimum required functional clock for
scaling in calc_fclk() and calc_fclk_five_taps(). This function returns the
correct pixel clock for LCD and LCD2 managers, but not for TV manager. Extend
this function so that it gets the correct pixel clock for TV manager.

This also prevents the crash we get when we try to scale overlays connected to
TV manager. The current code leads to a BUG() being executed if we call
dispc_mgr_pclk_rate() for the TV manager.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   37 +++++++++++++++++++++++++++++--------
 drivers/video/omap2/dss/dss.h   |   12 ++++++++++++
 drivers/video/omap2/dss/hdmi.c  |    6 ++++++
 drivers/video/omap2/dss/venc.c  |    8 +++++---
 4 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0bae6be..1a8a12c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -429,6 +429,14 @@ static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
 		return false;
 }
 
+static struct omap_dss_device *dispc_mgr_get_device(enum omap_channel channel)
+{
+	struct omap_overlay_manager *mgr =
+		omap_dss_get_overlay_manager(channel);
+
+	return mgr ? mgr->device : NULL;
+}
+
 bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	int bit;
@@ -1643,7 +1651,6 @@ static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
 		enum omap_color_mode color_mode)
 {
 	u32 fclk = 0;
-	/* FIXME venc pclk? */
 	u64 tmp, pclk = dispc_mgr_pclk_rate(channel);
 
 	if (height > out_height) {
@@ -1700,7 +1707,6 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 	else
 		vf = 1;
 
-	/* FIXME venc pclk? */
 	return dispc_mgr_pclk_rate(channel) * vf * hf;
 }
 
@@ -2437,17 +2443,32 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 {
-	int pcd;
 	unsigned long r;
-	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISORo(channel));
+	if (dispc_mgr_is_lcd(channel)) {
+		int pcd;
+		u32 l;
 
-	pcd = FLD_GET(l, 7, 0);
+		l = dispc_read_reg(DISPC_DIVISORo(channel));
 
-	r = dispc_mgr_lclk_rate(channel);
+		pcd = FLD_GET(l, 7, 0);
 
-	return r / pcd;
+		r = dispc_mgr_lclk_rate(channel);
+
+		return r / pcd;
+	} else {
+		struct omap_dss_device *dssdev =
+			dispc_mgr_get_device(channel);
+
+		switch (dssdev->type) {
+		case OMAP_DISPLAY_TYPE_VENC:
+			return venc_get_pixel_clock();
+		case OMAP_DISPLAY_TYPE_HDMI:
+			return hdmi_get_pixel_clock();
+		default:
+			BUG();
+		}
+	}
 }
 
 void dispc_dump_clocks(struct seq_file *s)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c303a71..a37aef2 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -450,6 +450,7 @@ int venc_init_platform_driver(void);
 void venc_uninit_platform_driver(void);
 void venc_dump_regs(struct seq_file *s);
 int venc_init_display(struct omap_dss_device *display);
+unsigned long venc_get_pixel_clock(void);
 #else
 static inline int venc_init_platform_driver(void)
 {
@@ -458,6 +459,11 @@ static inline int venc_init_platform_driver(void)
 static inline void venc_uninit_platform_driver(void)
 {
 }
+static inline unsigned long venc_get_pixel_clock(void)
+{
+	WARN("%s: VENC not compiled in, returning pclk as 0\n", __func__);
+	return 0;
+}
 #endif
 
 /* HDMI */
@@ -465,6 +471,7 @@ static inline void venc_uninit_platform_driver(void)
 int hdmi_init_platform_driver(void);
 void hdmi_uninit_platform_driver(void);
 int hdmi_init_display(struct omap_dss_device *dssdev);
+unsigned long hdmi_get_pixel_clock(void);
 #else
 static inline int hdmi_init_display(struct omap_dss_device *dssdev)
 {
@@ -477,6 +484,11 @@ static inline int hdmi_init_platform_driver(void)
 static inline void hdmi_uninit_platform_driver(void)
 {
 }
+static inline unsigned long hdmi_get_pixel_clock(void)
+{
+	WARN("%s: HDMI not compiled in, returning pclk as 0\n", __func__);
+	return 0;
+}
 #endif
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 7818670..2f554ae 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -266,6 +266,12 @@ static void update_hdmi_timings(struct hdmi_config *cfg,
 	cfg->timings.hsync_pol = cea_vesa_timings[code].hsync_pol;
 }
 
+unsigned long hdmi_get_pixel_clock(void)
+{
+	/* HDMI Pixel Clock in Mhz */
+	return hdmi.ip_data.cfg.timings.timings.pixel_clock * 10000;
+}
+
 static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 		struct hdmi_pll_info *pi)
 {
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 5331958..7533458 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -463,9 +463,11 @@ static void venc_power_off(struct omap_dss_device *dssdev)
 	regulator_disable(venc.vdda_dac_reg);
 }
 
-
-
-
+unsigned long venc_get_pixel_clock(void)
+{
+	/* VENC Pixel Clock in Mhz */
+	return 13500000;
+}
 
 /* driver */
 static int venc_panel_probe(struct omap_dss_device *dssdev)
-- 
1.7.1


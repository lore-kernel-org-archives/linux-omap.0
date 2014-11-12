From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/22] OMAPDSS: HDMI: store WP pointer to hdmi_pll_data
Date: Wed, 12 Nov 2014 13:52:20 +0200
Message-ID: <1415793144-11723-19-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36457 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbaKLLxM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:12 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

HDMI PLL code needs the pointer to the WP block so that it can manage
its power. Currently this is passed as a function parameter to
hdmi_pll_enable and hdmi_pll_disable. To make the PLL function adhere to
the DSS PLL API, we need to remove the WP parameter.

This patch stores the WP pointer to hdmi_pll_data in hdmi_pll_init, so
that it's available when needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h     |  9 ++++++---
 drivers/video/fbdev/omap2/dss/hdmi4.c    |  8 ++++----
 drivers/video/fbdev/omap2/dss/hdmi5.c    |  8 ++++----
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 12 +++++++++---
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 4b9bf0804a48..03761ecb81a6 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -248,6 +248,8 @@ struct hdmi_wp_data {
 struct hdmi_pll_data {
 	void __iomem *base;
 
+	struct hdmi_wp_data *wp;
+
 	struct hdmi_pll_info info;
 };
 
@@ -312,12 +314,13 @@ void hdmi_wp_init_vid_fmt_timings(struct hdmi_video_format *video_fmt,
 int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp);
 
 /* HDMI PLL funcs */
-int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
-void hdmi_pll_disable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
+int hdmi_pll_enable(struct hdmi_pll_data *pll);
+void hdmi_pll_disable(struct hdmi_pll_data *pll);
 void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s);
 void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
 	unsigned long target_tmds);
-int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll);
+int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll,
+	struct hdmi_wp_data *wp);
 
 /* HDMI PHY funcs */
 int hdmi_phy_configure(struct hdmi_phy_data *phy, unsigned long hfbitclk,
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 1f2fbccaff1f..2094b6eae99e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -197,7 +197,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), p->pixelclock);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_enable(&hdmi.pll, &hdmi.wp);
+	r = hdmi_pll_enable(&hdmi.pll);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err_pll_enable;
@@ -241,7 +241,7 @@ err_vid_enable:
 err_phy_cfg:
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 err_phy_pwr:
-	hdmi_pll_disable(&hdmi.pll, &hdmi.wp);
+	hdmi_pll_disable(&hdmi.pll);
 err_pll_enable:
 	hdmi_power_off_core(dssdev);
 	return -EIO;
@@ -259,7 +259,7 @@ static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 
-	hdmi_pll_disable(&hdmi.pll, &hdmi.wp);
+	hdmi_pll_disable(&hdmi.pll);
 
 	hdmi_power_off_core(dssdev);
 }
@@ -688,7 +688,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	r = hdmi_pll_init(pdev, &hdmi.pll);
+	r = hdmi_pll_init(pdev, &hdmi.pll, &hdmi.wp);
 	if (r)
 		return r;
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index e8ca9106c8af..fb8c14507a4d 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -215,7 +215,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 			hdmi_wp_get_irqstatus(&hdmi.wp));
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_enable(&hdmi.pll, &hdmi.wp);
+	r = hdmi_pll_enable(&hdmi.pll);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err_pll_enable;
@@ -259,7 +259,7 @@ err_vid_enable:
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 err_phy_pwr:
 err_phy_cfg:
-	hdmi_pll_disable(&hdmi.pll, &hdmi.wp);
+	hdmi_pll_disable(&hdmi.pll);
 err_pll_enable:
 	hdmi_power_off_core(dssdev);
 	return -EIO;
@@ -277,7 +277,7 @@ static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 
-	hdmi_pll_disable(&hdmi.pll, &hdmi.wp);
+	hdmi_pll_disable(&hdmi.pll);
 
 	hdmi_power_off_core(dssdev);
 }
@@ -717,7 +717,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	r = hdmi_pll_init(pdev, &hdmi.pll);
+	r = hdmi_pll_init(pdev, &hdmi.pll, &hdmi.wp);
 	if (r)
 		return r;
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index 0942bdc8dfa6..190bede1dcb9 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -166,8 +166,9 @@ static int hdmi_pll_config(struct hdmi_pll_data *pll)
 	return 0;
 }
 
-int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp)
+int hdmi_pll_enable(struct hdmi_pll_data *pll)
 {
+	struct hdmi_wp_data *wp = pll->wp;
 	u16 r = 0;
 
 	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_ALLOFF);
@@ -185,8 +186,10 @@ int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp)
 	return 0;
 }
 
-void hdmi_pll_disable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp)
+void hdmi_pll_disable(struct hdmi_pll_data *pll)
 {
+	struct hdmi_wp_data *wp = pll->wp;
+
 	hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_ALLOFF);
 }
 
@@ -245,11 +248,14 @@ static int hdmi_pll_init_features(struct platform_device *pdev)
 	return 0;
 }
 
-int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll)
+int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll,
+	struct hdmi_wp_data *wp)
 {
 	int r;
 	struct resource *res;
 
+	pll->wp = wp;
+
 	r = hdmi_pll_init_features(pdev);
 	if (r)
 		return r;
-- 
2.1.3


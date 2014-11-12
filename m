From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/22] OMAPDSS: HDMI: split PLL enable & config
Date: Wed, 12 Nov 2014 13:52:21 +0200
Message-ID: <1415793144-11723-20-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36458 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611AbaKLLxN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:13 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

At the moment we have one function, hdmi_pll_enable, which enables the
PLL and writes the PLL configuration to registers.

To make the HDMI PLL ahere to the DSS PLL API, split the hdmi_pll_enable
into two parts: hdmi_pll_enable which enables the PLL HW, and
hdmi_pll_set_config which writes the config.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h     |  1 +
 drivers/video/fbdev/omap2/dss/hdmi4.c    | 10 ++++++++--
 drivers/video/fbdev/omap2/dss/hdmi5.c    | 10 ++++++++--
 drivers/video/fbdev/omap2/dss/hdmi_pll.c |  6 +-----
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 03761ecb81a6..7595274a9bcf 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -316,6 +316,7 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp);
 /* HDMI PLL funcs */
 int hdmi_pll_enable(struct hdmi_pll_data *pll);
 void hdmi_pll_disable(struct hdmi_pll_data *pll);
+int hdmi_pll_set_config(struct hdmi_pll_data *pll);
 void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s);
 void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
 	unsigned long target_tmds);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 2094b6eae99e..98aa910241b8 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -196,13 +196,18 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 
 	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), p->pixelclock);
 
-	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
 	r = hdmi_pll_enable(&hdmi.pll);
 	if (r) {
-		DSSDBG("Failed to lock PLL\n");
+		DSSERR("Failed to enable PLL\n");
 		goto err_pll_enable;
 	}
 
+	r = hdmi_pll_set_config(&hdmi.pll);
+	if (r) {
+		DSSERR("Failed to configure PLL\n");
+		goto err_pll_cfg;
+	}
+
 	r = hdmi_phy_configure(&hdmi.phy, hdmi.pll.info.clkdco,
 		hdmi.pll.info.clkout);
 	if (r) {
@@ -241,6 +246,7 @@ err_vid_enable:
 err_phy_cfg:
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 err_phy_pwr:
+err_pll_cfg:
 	hdmi_pll_disable(&hdmi.pll);
 err_pll_enable:
 	hdmi_power_off_core(dssdev);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index fb8c14507a4d..facc4e070520 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -214,13 +214,18 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	hdmi_wp_set_irqstatus(&hdmi.wp,
 			hdmi_wp_get_irqstatus(&hdmi.wp));
 
-	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
 	r = hdmi_pll_enable(&hdmi.pll);
 	if (r) {
-		DSSDBG("Failed to lock PLL\n");
+		DSSERR("Failed to enable PLL\n");
 		goto err_pll_enable;
 	}
 
+	r = hdmi_pll_set_config(&hdmi.pll);
+	if (r) {
+		DSSERR("Failed to configure PLL\n");
+		goto err_pll_cfg;
+	}
+
 	r = hdmi_phy_configure(&hdmi.phy, hdmi.pll.info.clkdco,
 		hdmi.pll.info.clkout);
 	if (r) {
@@ -259,6 +264,7 @@ err_vid_enable:
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 err_phy_pwr:
 err_phy_cfg:
+err_pll_cfg:
 	hdmi_pll_disable(&hdmi.pll);
 err_pll_enable:
 	hdmi_power_off_core(dssdev);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index 190bede1dcb9..c14c3d132513 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -103,7 +103,7 @@ void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
 	pi->clkout = clkout;
 }
 
-static int hdmi_pll_config(struct hdmi_pll_data *pll)
+int hdmi_pll_set_config(struct hdmi_pll_data *pll)
 {
 	u32 r;
 	struct hdmi_pll_info *fmt = &pll->info;
@@ -179,10 +179,6 @@ int hdmi_pll_enable(struct hdmi_pll_data *pll)
 	if (r)
 		return r;
 
-	r = hdmi_pll_config(pll);
-	if (r)
-		return r;
-
 	return 0;
 }
 
-- 
2.1.3


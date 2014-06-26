From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 03/12] OMAPDSS: hdmi_wp: Add function for getting hdmi_wp physical base address
Date: Thu, 26 Jun 2014 22:20:54 +0300
Message-ID: <71e703f319eacd5a7196d8b34601b52e32b946d3.1403807781.git.jsarha@ti.com>
References: <cover.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48805 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaFZTVf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2014 15:21:35 -0400
In-Reply-To: <cover.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

The hdmi_wp physical base address is needed for hdmi audio dma.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h    |    2 ++
 drivers/video/fbdev/omap2/dss/hdmi_wp.c |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 1f01068..927cb4d 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -250,6 +250,7 @@ struct hdmi_core_audio_config {
 
 struct hdmi_wp_data {
 	void __iomem *base;
+	phys_addr_t phys_base;
 };
 
 struct hdmi_pll_data {
@@ -317,6 +318,7 @@ void hdmi_wp_video_config_timing(struct hdmi_wp_data *wp,
 void hdmi_wp_init_vid_fmt_timings(struct hdmi_video_format *video_fmt,
 		struct omap_video_timings *timings, struct hdmi_config *param);
 int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp);
+phys_addr_t hdmi_wp_get_phys_addr(struct hdmi_wp_data *wp);
 
 /* HDMI PLL funcs */
 int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
index 496327e..eadd4ed 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
@@ -247,6 +247,7 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 		DSSERR("can't get WP mem resource\n");
 		return -EINVAL;
 	}
+	wp->phys_base = res->start;
 
 	wp->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(wp->base)) {
@@ -256,3 +257,8 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 
 	return 0;
 }
+
+phys_addr_t hdmi_wp_get_phys_addr(struct hdmi_wp_data *wp)
+{
+	return wp->phys_base;
+}
-- 
1.7.9.5


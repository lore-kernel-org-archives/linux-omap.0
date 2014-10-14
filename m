From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 04/18] OMAPDSS: hdmi_wp: Add function for getting audio dma address
Date: Tue, 14 Oct 2014 20:29:23 +0300
Message-ID: <f56679af8371c78e901a29e37398f050a17b1c6c.1413306131.git.jsarha@ti.com>
References: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46963 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755370AbaJNR3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2014 13:29:51 -0400
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The audio dma port is found in the hdmi_wp physical address space.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h    |    2 ++
 drivers/video/fbdev/omap2/dss/hdmi_wp.c |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 03726b5..9ba7c1a 100644
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
+phys_addr_t hdmi_wp_get_audio_dma_addr(struct hdmi_wp_data *wp);
 
 /* HDMI PLL funcs */
 int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
index f1b53de..5154120 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
@@ -245,6 +245,7 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 		DSSERR("can't get WP mem resource\n");
 		return -EINVAL;
 	}
+	wp->phys_base = res->start;
 
 	wp->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(wp->base)) {
@@ -254,3 +255,8 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 
 	return 0;
 }
+
+phys_addr_t hdmi_wp_get_audio_dma_addr(struct hdmi_wp_data *wp)
+{
+	return wp->phys_base + HDMI_WP_AUDIO_DATA;
+}
-- 
1.7.9.5


From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 04/13] OMAPDSS: hdmi_wp: Add function for getting hdmi_wp physical base address
Date: Fri, 23 May 2014 22:07:53 +0300
Message-ID: <0b45f07e37fc622e18fb441897ac8749fb954c07.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55983 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbaEWTI3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 May 2014 15:08:29 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The hdmi_wp physical base address is needed for hdmi audio dma.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h    |    2 ++
 drivers/video/fbdev/omap2/dss/hdmi_wp.c |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index fbee078..f644bc8 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -341,6 +341,7 @@ struct hdmi_core_infoframe_avi {
 
 struct hdmi_wp_data {
 	void __iomem *base;
+	phys_addr_t phys_base;
 };
 
 struct hdmi_pll_data {
@@ -410,6 +411,7 @@ void hdmi_wp_video_config_timing(struct hdmi_wp_data *wp,
 void hdmi_wp_init_vid_fmt_timings(struct hdmi_video_format *video_fmt,
 		struct omap_video_timings *timings, struct hdmi_config *param);
 int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp);
+phys_addr_t hdmi_wp_get_phys_addr(struct hdmi_wp_data *wp);
 
 /* HDMI PLL funcs */
 int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
index a16a190..bee6df3 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
@@ -264,6 +264,7 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 		temp_res.end = temp_res.start + WP_SIZE - 1;
 		res = &temp_res;
 	}
+	wp->phys_base = res->start;
 
 	wp->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!wp->base) {
@@ -273,3 +274,8 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 
 	return 0;
 }
+
+phys_addr_t hdmi_wp_get_phys_addr(struct hdmi_wp_data *wp)
+{
+	return wp->phys_base;
+}
-- 
1.7.9.5


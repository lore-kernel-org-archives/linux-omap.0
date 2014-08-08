From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 03/14] OMAPDSS: hdmi_common: hdmi_compute_acr is needed for OMAP5 HDMI audio too
Date: Fri, 8 Aug 2014 16:23:44 +0300
Message-ID: <22827f3eccc3180024785869b4cc7c860cc9a043.1407503813.git.jsarha@ti.com>
References: <cover.1407503813.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44003 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662AbaHHNYS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2014 09:24:18 -0400
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_common.c b/drivers/video/fbdev/omap2/dss/hdmi_common.c
index 7d5f103..2e48d90 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_common.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_common.c
@@ -48,7 +48,7 @@ int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	return 0;
 }
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
-- 
1.7.9.5


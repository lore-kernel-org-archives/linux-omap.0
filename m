From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 03/15] OMAPDSS: hdmi4_core: Remove unused hdmi4_audio_get_dma_port()
Date: Tue, 16 Sep 2014 13:04:17 +0300
Message-ID: <cd9362738e188412220f0ee320efc9bb6402cb59.1410860765.git.jsarha@ti.com>
References: <cover.1410860765.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32943 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbaIPKEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2014 06:04:48 -0400
In-Reply-To: <cover.1410860765.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

hdmi4_audio_get_dma_port() is unused and and broken.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4_core.c |    9 ---------
 drivers/video/fbdev/omap2/dss/hdmi4_core.h |    2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index 3b448d9..7eafea5 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -874,15 +874,6 @@ void hdmi4_audio_stop(struct hdmi_core_data *core, struct hdmi_wp_data *wp)
 	hdmi_wp_audio_core_req_enable(wp, false);
 }
 
-int hdmi4_audio_get_dma_port(u32 *offset, u32 *size)
-{
-	if (!offset || !size)
-		return -EINVAL;
-	*offset = HDMI_WP_AUDIO_DATA;
-	*size = 4;
-	return 0;
-}
-
 int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
 {
 	struct resource *res;
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.h b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
index c1959f7..a069f96 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
@@ -270,6 +270,4 @@ int hdmi4_audio_start(struct hdmi_core_data *core, struct hdmi_wp_data *wp);
 void hdmi4_audio_stop(struct hdmi_core_data *core, struct hdmi_wp_data *wp);
 int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		struct omap_dss_audio *audio, u32 pclk);
-int hdmi4_audio_get_dma_port(u32 *offset, u32 *size);
-
 #endif
-- 
1.7.9.5


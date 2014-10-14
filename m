From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 02/18] OMAPDSS: hdmi: Remove most of OMAP[45]_DSS_HDMI_AUDIO ifdefs
Date: Tue, 14 Oct 2014 20:29:21 +0300
Message-ID: <7828fe827cada19ad03a9965744cc9175af7327e.1413306131.git.jsarha@ti.com>
References: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44324 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348AbaJNR3u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2014 13:29:50 -0400
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

It does not waste too many bytes to compile all audio related core
functions always in with HDMI support. It should help readability and
in keeping the audio code in working shape. Leave the options just for
disabling and enabling the functionality in hdmi[45].c.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h        |    3 +--
 drivers/video/fbdev/omap2/dss/hdmi4_core.c  |    5 -----
 drivers/video/fbdev/omap2/dss/hdmi4_core.h  |    2 --
 drivers/video/fbdev/omap2/dss/hdmi5_core.c  |    6 ------
 drivers/video/fbdev/omap2/dss/hdmi5_core.h  |    2 --
 drivers/video/fbdev/omap2/dss/hdmi_common.c |    2 --
 drivers/video/fbdev/omap2/dss/hdmi_wp.c     |    2 --
 7 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 1f01068..03726b5 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -335,7 +335,7 @@ int hdmi_phy_parse_lanes(struct hdmi_phy_data *phy, const u32 *lanes);
 int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	struct hdmi_phy_data *phy);
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+/* Audio funcs */
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts);
 int hdmi_wp_audio_enable(struct hdmi_wp_data *wp, bool enable);
 int hdmi_wp_audio_core_req_enable(struct hdmi_wp_data *wp, bool enable);
@@ -348,4 +348,3 @@ static inline bool hdmi_mode_has_audio(int mode)
 	return mode == HDMI_HDMI ? true : false;
 }
 #endif
-#endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index 4ad39cf..3b448d9 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -31,10 +31,8 @@
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 #include <sound/asound.h>
 #include <sound/asoundef.h>
-#endif
 
 #include "hdmi4_core.h"
 #include "dss_features.h"
@@ -530,7 +528,6 @@ void hdmi4_core_dump(struct hdmi_core_data *core, struct seq_file *s)
 	DUMPCOREAV(HDMI_CORE_AV_CEC_ADDR_ID);
 }
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 static void hdmi_core_audio_config(struct hdmi_core_data *core,
 					struct hdmi_core_audio_config *cfg)
 {
@@ -886,8 +883,6 @@ int hdmi4_audio_get_dma_port(u32 *offset, u32 *size)
 	return 0;
 }
 
-#endif
-
 int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
 {
 	struct resource *res;
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.h b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
index 827909e..c1959f7 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
@@ -266,12 +266,10 @@ void hdmi4_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 void hdmi4_core_dump(struct hdmi_core_data *core, struct seq_file *s);
 int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core);
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 int hdmi4_audio_start(struct hdmi_core_data *core, struct hdmi_wp_data *wp);
 void hdmi4_audio_stop(struct hdmi_core_data *core, struct hdmi_wp_data *wp);
 int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		struct omap_dss_audio *audio, u32 pclk);
 int hdmi4_audio_get_dma_port(u32 *offset, u32 *size);
-#endif
 
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index 83acbf7..8eab25b 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -30,10 +30,8 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <drm/drm_edid.h>
-#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
 #include <sound/asound.h>
 #include <sound/asoundef.h>
-#endif
 
 #include "hdmi5_core.h"
 
@@ -644,9 +642,6 @@ void hdmi5_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	hdmi_core_enable_interrupts(core);
 }
 
-
-#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
-
 static void hdmi5_core_audio_config(struct hdmi_core_data *core,
 			struct hdmi_core_audio_config *cfg)
 {
@@ -894,7 +889,6 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 
 	return 0;
 }
-#endif
 
 int hdmi5_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
 {
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.h b/drivers/video/fbdev/omap2/dss/hdmi5_core.h
index ce7e9f3..f2f1022 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.h
@@ -299,8 +299,6 @@ void hdmi5_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 			struct hdmi_config *cfg);
 int hdmi5_core_init(struct platform_device *pdev, struct hdmi_core_data *core);
 
-#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
 int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 			struct omap_dss_audio *audio, u32 pclk);
 #endif
-#endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_common.c b/drivers/video/fbdev/omap2/dss/hdmi_common.c
index 7d5f103..1b8fcc6 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_common.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_common.c
@@ -48,7 +48,6 @@ int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	return 0;
 }
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
@@ -147,4 +146,3 @@ int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 
 	return 0;
 }
-#endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
index 496327e..f1b53de 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
@@ -185,7 +185,6 @@ void hdmi_wp_init_vid_fmt_timings(struct hdmi_video_format *video_fmt,
 	timings->interlace = param->timings.interlace;
 }
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
 void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
 		struct hdmi_audio_format *aud_fmt)
 {
@@ -236,7 +235,6 @@ int hdmi_wp_audio_core_req_enable(struct hdmi_wp_data *wp, bool enable)
 
 	return 0;
 }
-#endif
 
 int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 {
-- 
1.7.9.5


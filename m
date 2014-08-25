From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 07/15] OMAPDSS: hdmi: Make hdmi_mode_has_audio() more user friedly
Date: Mon, 25 Aug 2014 22:04:15 +0300
Message-ID: <454a98cc407ff9a1f0216985bee8e1ad0d344800.1408993242.git.jsarha@ti.com>
References: <cover.1408993242.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45680 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933360AbaHYTEl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Aug 2014 15:04:41 -0400
In-Reply-To: <cover.1408993242.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index c357057..bfee7162 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -345,9 +345,9 @@ void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
 		struct hdmi_audio_format *aud_fmt);
 void hdmi_wp_audio_config_dma(struct hdmi_wp_data *wp,
 		struct hdmi_audio_dma *aud_dma);
-static inline bool hdmi_mode_has_audio(int mode)
+static inline bool hdmi_mode_has_audio(struct hdmi_config *cfg)
 {
-	return mode == HDMI_HDMI ? true : false;
+	return cfg->hdmi_dvi_mode == HDMI_HDMI ? true : false;
 }
 
 /* HDMI DRV data */
-- 
1.7.9.5


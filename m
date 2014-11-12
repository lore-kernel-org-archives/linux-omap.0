From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7 12/20] OMAPDSS: hdmi: Make hdmi_mode_has_audio() more user friedly
Date: Wed, 12 Nov 2014 12:49:14 +0200
Message-ID: <97efa2bcd059396141c672971e22660c95d889c6.1415786458.git.jsarha@ti.com>
References: <cover.1415786458.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbaKLKtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 05:49:46 -0500
In-Reply-To: <cover.1415786458.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index a6e08ff..6d129f2 100644
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


From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 11/18] OMAPDSS: hdmi: Make hdmi_mode_has_audio() more user friedly
Date: Tue, 14 Oct 2014 20:29:30 +0300
Message-ID: <444fd20a0320a215be4cb69055b617d1b3f385c9.1413306131.git.jsarha@ti.com>
References: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36084 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421AbaJNRaB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 13:30:01 -0400
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

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


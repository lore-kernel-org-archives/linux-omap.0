From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 2/5] OMAPDSS: HDMI5: Set valid sample order
Date: Wed, 22 Apr 2015 16:22:58 +0300
Message-ID: <134b187ace26d0a604d097966c797f961612f7cf.1429705991.git.jsarha@ti.com>
References: <cover.1429705991.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34246 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089AbbDVNXX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 09:23:23 -0400
In-Reply-To: <cover.1429705991.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

As per TRM, HDMI_WP_AUDIO_CFG[2] LEFT_BEFORE = 0 is reserved,
so it must always be set to 1 (the first sample is the left).

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index a3cfe3d..7a80beb 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -870,6 +870,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	audio_format.samples_per_word = HDMI_AUDIO_ONEWORD_TWOSAMPLES;
 	audio_format.sample_size = HDMI_AUDIO_SAMPLE_16BITS;
 	audio_format.justification = HDMI_AUDIO_JUSTIFY_LEFT;
+	audio_format.sample_order = HDMI_AUDIO_SAMPLE_LEFT_FIRST;
 
 	/* only LPCM atm */
 	audio_format.type = HDMI_AUDIO_TYPE_LPCM;
-- 
1.9.1


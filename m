From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7.1 02/19] OMAPDSS: hdmi5_core: Initialize mandatory sample_order parameter
Date: Wed, 12 Nov 2014 16:40:53 +0200
Message-ID: <89ed6487617455c4ec5dd039df488292e1e170d0.1415803065.git.jsarha@ti.com>
References: <cover.1415803064.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbaKLOlU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 09:41:20 -0500
In-Reply-To: <cover.1415803064.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

The hdmi_wp_audio_config_format() expects sample_order of struct
hdmi_audio_format to be initialized. The only allowed value is
HDMI_AUDIO_SAMPLE_LEFT_FIRST.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index 83acbf7..9ffa805 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -879,6 +879,9 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	/* only LPCM atm */
 	audio_format.type = HDMI_AUDIO_TYPE_LPCM;
 
+	/* only allowed option */
+	audio_format.sample_order = HDMI_AUDIO_SAMPLE_LEFT_FIRST;
+
 	/* disable start/stop signals of IEC 60958 blocks */
 	audio_format.en_sig_blk_strt_end = HDMI_AUDIO_BLOCK_SIG_STARTEND_ON;
 
-- 
1.7.9.5


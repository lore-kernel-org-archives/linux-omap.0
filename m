From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 1/5] OMAPDSS: HDMI4: Set correct CC for 8-channels layout
Date: Wed, 22 Apr 2015 16:22:57 +0300
Message-ID: <9929c18e983efaa6fc66b4c56e701530fd93968f.1429705991.git.jsarha@ti.com>
References: <cover.1429705991.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34244 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755473AbbDVNXW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 09:23:22 -0400
In-Reply-To: <cover.1429705991.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

OMAP4 HDMI IP uses the 8-channel layout with 8-channel speaker
allocation mask when transmitting more than two channels.  But
the channel count field (CC) of the Audio InfoFrame's DB1 is
not updated for 8-channels.

As per HDMI Compliance Test 7.31 "Audio InfoFrame", CC = 7 is
required for 8-channels CA masks (0x13 and 0x1F).

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index 7eafea5..2b8bd22 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -795,7 +795,9 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 
 	/*
 	 * the HDMI IP needs to enable four stereo channels when transmitting
-	 * more than 2 audio channels
+	 * more than 2 audio channels.  Similarly, the channel count in the
+	 * Audio InfoFrame has to match the sample_present bits (some channels
+	 * are padded with zeroes)
 	 */
 	if (channel_count == 2) {
 		audio_format.stereo_channels = HDMI_AUDIO_STEREO_ONECHANNEL;
@@ -807,6 +809,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 				HDMI_AUDIO_I2S_SD1_EN | HDMI_AUDIO_I2S_SD2_EN |
 				HDMI_AUDIO_I2S_SD3_EN;
 		acore.layout = HDMI_AUDIO_LAYOUT_8CH;
+		audio->cea->db1_ct_cc = 7;
 	}
 
 	acore.en_spdif = false;
-- 
1.9.1


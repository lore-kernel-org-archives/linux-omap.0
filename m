From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 5/9] ASoC: hdmi-codec: Add SNDRV_PCM_FMTBIT_32_LE playback format
Date: Tue, 19 Nov 2013 14:12:25 +0200
Message-ID: <ccbca51db46f6f38e3a1233cbdc058dbe0906bfe.1384862950.git.jsarha@ti.com>
References: <cover.1384862950.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51550 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab3KSMNY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 07:13:24 -0500
In-Reply-To: <cover.1384862950.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The new playback format is needed for tda998x HDMI audio support. At
the moment the only other user of this codec is omap-hdmi-audio. This
change should not break anything because omap-hdmi-audio-dai, the
cpu-dai of omap-hdmi-audio, enforces sufficient constraints to
available sample formats.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/hdmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index 6d2fcf1..9cb1c7d 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -45,7 +45,7 @@ static struct snd_soc_dai_driver hdmi_codec_dai = {
 			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
 			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S24_LE,
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
 	},
 	.capture = {
 		.stream_name = "Capture",
-- 
1.7.9.5


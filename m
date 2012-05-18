From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 08/11] ASoC: OMAP: HDMI: Expand capabilities of the HDMI DAI
Date: Fri, 18 May 2012 01:42:40 -0500
Message-ID: <1337323363-11449-9-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60240 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759638Ab2ERGnW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 02:43:22 -0400
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

According to the HDMI specification, a source is permitted to
transmit L-PCM audio in the following sample rates: 32kHz, 44.1kHz,
48kHz, 88.2kHz, 96kHz, 176.4kHz or 192kHz.

It also supports up to 8 audio channels.

The sink may not necessarily support all these sample rates and
channels. However, as this CPU DAI describes the HDMI source, it
makes sense to include them. The limitation of capabilities as
supported by the sink should be done in the ASoC HDMI codec.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c |    2 +-
 sound/soc/omap/omap-hdmi.h |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index ec7c7e6..a08245d 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -253,7 +253,7 @@ static const struct snd_soc_dai_ops omap_hdmi_dai_ops = {
 static struct snd_soc_dai_driver omap_hdmi_dai = {
 	.playback = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 8,
 		.rates = OMAP_HDMI_RATES,
 		.formats = OMAP_HDMI_FORMATS,
 	},
diff --git a/sound/soc/omap/omap-hdmi.h b/sound/soc/omap/omap-hdmi.h
index 34c298d..6ad2bf4 100644
--- a/sound/soc/omap/omap-hdmi.h
+++ b/sound/soc/omap/omap-hdmi.h
@@ -28,7 +28,9 @@
 #define OMAP_HDMI_AUDIO_DMA_PORT 0x8c
 
 #define OMAP_HDMI_RATES	(SNDRV_PCM_RATE_32000 | \
-				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
+				SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
+				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
 
 #define OMAP_HDMI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 				SNDRV_PCM_FMTBIT_S24_LE)
-- 
1.7.5.4


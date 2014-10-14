From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 07/18] ASoC: codecs/hdmi: Mark the maximum significant bits to HDMI codec
Date: Tue, 14 Oct 2014 20:29:26 +0300
Message-ID: <9d3aa456eb4d753c38fc642bf0a8cd5fdc5af54a.1413306131.git.jsarha@ti.com>
References: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36077 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbaJNR3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 13:29:55 -0400
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

HDMI audio can not have more than 24 bits even if on i2s bus there
would be 32 bit samples. Mark this by adding .sig_bits = 24 to
playback stream definition.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/hdmi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index 1087fd5..2a52b90 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -47,6 +47,7 @@ static struct snd_soc_dai_driver hdmi_codec_dai = {
 			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 24,
 	},
 	.capture = {
 		.stream_name = "Capture",
-- 
1.7.9.5


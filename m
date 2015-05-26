From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 4/7] ASoC: hdmi-codec: Add ELD based audio pcm rules DO NOT MERGE
Date: Tue, 26 May 2015 21:59:08 +0300
Message-ID: <1432666751-24794-5-git-send-email-jsarha@ti.com>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59020 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbbEZTAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2015 15:00:03 -0400
In-Reply-To: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, moinejf@free.fr, rmk+kernel@arm.linux.org.uk, Jyri Sarha <jsarha@ti.com>

This patch is mostly just a copy paste from Russel King's generic
patchs[1] for the same thing. The patche is included only for testing
purposes. Do not merge!

[1] http://lists.freedesktop.org/archives/dri-devel/2015-April/080525.html

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/hdmi-codec.c | 104 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index c208cef..2d26ce8 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -78,6 +78,103 @@ static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static const uint8_t *eld_sad(const uint8_t *eld)
+{
+	unsigned int ver, mnl;
+
+	ver = (eld[DRM_ELD_VER] & DRM_ELD_VER_MASK) >> DRM_ELD_VER_SHIFT;
+	if (ver != 2 && ver != 31)
+		return NULL;
+
+	mnl = drm_eld_mnl(eld);
+	if (mnl > 16)
+		return NULL;
+
+	return eld + DRM_ELD_CEA_SAD(mnl, 0);
+}
+
+static const unsigned int eld_rates[] = {
+	32000,
+	44100,
+	48000,
+	88200,
+	96000,
+	176400,
+	192000,
+};
+
+static int eld_limit_rates(struct snd_pcm_hw_params *params,
+			   struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r = hw_param_interval(params, rule->var);
+	unsigned int rate_mask = 7, i;
+	const u8 *sad, *eld = rule->private;
+
+	sad = eld_sad(eld);
+	if (sad) {
+		for (i = drm_eld_sad_count(eld); i > 0; i--, sad += 3) {
+			unsigned channels = 1 + (sad[0] & 7);
+
+			/*
+			 * Exclude SADs which do not include the
+			 * requested number of channels.
+			 */
+			if (params_channels(params) == channels)
+				rate_mask |= sad[1];
+		}
+	}
+
+	return snd_interval_list(r, ARRAY_SIZE(eld_rates), eld_rates,
+				 rate_mask);
+}
+
+static int eld_limit_channels(struct snd_pcm_hw_params *params,
+			      struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *var = hw_param_interval(params, rule->var);
+	struct snd_interval t = { .min = 1, .max = 2, .integer = 1, };
+	unsigned int i, j;
+	const u8 *sad, *eld = rule->private;
+	int rate = params_rate(params);
+
+	sad = eld_sad(eld);
+	if (!sad)
+		return 0;
+
+	for (i = drm_eld_sad_count(eld); i > 0; i--, sad += 3) {
+		for (j = 0; j < ARRAY_SIZE(eld_rates); j++) {
+			if ((sad[1] & (1<<j)) && rate == eld_rates[j]) {
+				switch (sad[0] & 0x78) {
+				case 0x08:
+					t.max = max(t.max, (sad[0] & 7) + 1u);
+					break;
+				}
+			}
+		}
+	}
+
+	return snd_interval_refine(var, &t);
+}
+
+static int hdmi_codec_constraint_eld(struct snd_pcm_runtime *runtime, void *eld)
+{
+	int ret;
+
+	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  eld_limit_rates, eld,
+				  SNDRV_PCM_HW_PARAM_RATE,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  eld_limit_channels, eld,
+				  SNDRV_PCM_HW_PARAM_CHANNELS,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+
+	return ret;
+}
+
 static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -104,7 +201,12 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	if (hcp->hcd.ops->get_eld) {
 		hcp->eld = hcp->hcd.ops->get_eld(hcp->hcd.dev);
 
-		/* Call snd_pcm_hw_constraint_eld here */
+		if (hcp->eld) {
+			ret = hdmi_codec_constraint_eld(substream->runtime,
+							hcp->eld);
+			if (ret)
+				return ret;
+		}
 	}
 	return 0;
 }
-- 
1.9.1


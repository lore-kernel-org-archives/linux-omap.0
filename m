From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 5/5] ASoC: tlv320aic3x: Improve tdm support
Date: Wed, 9 Sep 2015 21:27:46 +0300
Message-ID: <fd757436a42258131e9b671149893f8578dafd8b.1441806963.git.jsarha@ti.com>
References: <cover.1441806963.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1441806963.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, misael.lopez-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Before this patch the set_tdm_slots() callback did not store the value
of slot width anywhere. The tdm support only worked if selected slot
width was equal to the sample width. With this patch all sample widths
that fit into the slot width are supported. There unused bits are
filled unnecessarily in the capture direction, but the other end of
the i2s bus should be able to ignore them.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/tlv320aic3x.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 1a82b19..f1c9fff 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -80,6 +80,7 @@ struct aic3x_priv {
 	unsigned int sysclk;
 	unsigned int dai_fmt;
 	unsigned int tdm_delay;
+	unsigned int slot_width;
 	struct list_head list;
 	int master;
 	int gpio_reset;
@@ -1025,10 +1026,14 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	u8 data, j, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
 	u16 d, pll_d = 1;
 	int clk;
+	int width = aic3x->slot_width;
+
+	if (!width)
+		width = params_width(params);
 
 	/* select data word length */
 	data = snd_soc_read(codec, AIC3X_ASD_INTF_CTRLB) & (~(0x3 << 4));
-	switch (params_width(params)) {
+	switch (width) {
 	case 16:
 		break;
 	case 20:
@@ -1170,12 +1175,16 @@ static int aic3x_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int delay = 0;
+	int width = aic3x->slot_width;
+
+	if (!width)
+		width = substream->runtime->sample_bits;
 
 	/* TDM slot selection only valid in DSP_A/_B mode */
 	if (aic3x->dai_fmt == SND_SOC_DAIFMT_DSP_A)
-		delay += (aic3x->tdm_delay + 1);
+		delay += (aic3x->tdm_delay*width + 1);
 	else if (aic3x->dai_fmt == SND_SOC_DAIFMT_DSP_B)
-		delay += aic3x->tdm_delay;
+		delay += aic3x->tdm_delay*width;
 
 	/* Configure data delay */
 	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLC, delay);
@@ -1296,7 +1305,20 @@ static int aic3x_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	aic3x->tdm_delay = lsb * slot_width;
+	switch (slot_width) {
+	case 16:
+	case 20:
+	case 24:
+	case 32:
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported slot width %d\n", slot_width);
+		return -EINVAL;
+	}
+
+
+	aic3x->tdm_delay = lsb;
+	aic3x->slot_width = slot_width;
 
 	/* DOUT in high-impedance on inactive bit clocks */
 	snd_soc_update_bits(codec, AIC3X_ASD_INTF_CTRLA,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv2 5/7] ASoC: TWL6030: Add support for low-power mode
Date: Fri, 25 Sep 2009 21:03:30 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A391E3@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44572 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbZIZCDc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:03:32 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

TWL6030 codec supports two power modes: low-power and high
performance.

In low-power mode, headset downlink must be the only path enabled
and components in that path (headset DAC and driver) should be in
that mode too. In this mode, codec can stream audio at 44.1 and
48 kHz if sys clock from CLK32K is configured to 17.64 and 19.2
MHz using low-power PLL, respectively.

In high-performance mode, codec can only work at 19.2 MHz from
high-performance PLL. All paths supported in the codec can be used
but audio can be streamed only at 48 kHz.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl6030.c |  214 ++++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/twl6030.h |   17 ++++
 2 files changed, 202 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index f1e333f..032619d 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -46,6 +46,7 @@
 struct twl6030_data {
 	struct snd_soc_codec codec;
 	int codec_powered;
+	unsigned int sysclk;
 };
 
 /*
@@ -305,6 +306,29 @@ static void twl6030_power_down(struct snd_soc_codec *codec)
 	mdelay(10);
 }
 
+/* set headset dac and driver power mode */
+static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
+{
+	int hslctl, hsrctl;
+	int mask = TWL6030_HSDRVMODEL | TWL6030_HSDACMODEL;
+
+	hslctl = twl6030_read_reg_cache(codec, TWL6030_REG_HSLCTL);
+	hsrctl = twl6030_read_reg_cache(codec, TWL6030_REG_HSRCTL);
+
+	if (high_perf) {
+		hslctl &= ~mask;
+		hsrctl &= ~mask;
+	} else {
+		hslctl |= mask;
+		hsrctl |= mask;
+	}
+
+	twl6030_write(codec, TWL6030_REG_HSLCTL, hslctl);
+	twl6030_write(codec, TWL6030_REG_HSRCTL, hsrctl);
+
+	return 0;
+}
+
 /*
  * MICATT volume control:
  * from -6 to 0 dB in 6 dB steps
@@ -598,6 +622,7 @@ static int twl6030_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl6030_data *priv = codec->private_data;
 	int rate, format;
 
 	/* hardware dai (McPDM) requires bit stream of twice
@@ -607,7 +632,20 @@ static int twl6030_hw_params(struct snd_pcm_substream *substream,
 	rate = params_rate(params);
 	switch (rate) {
 	case 44100:
+		if (priv->sysclk != 17640000) {
+			dev_err(codec->dev,
+				"rate %d not supported at current sysclk %d\n",
+				rate, priv->sysclk);
+			return -EINVAL;
+		}
+		break;
 	case 48000:
+		if (priv->sysclk != 19200000) {
+			dev_err(codec->dev,
+				"rate %d not supported at current sysclk %d\n",
+				rate, priv->sysclk);
+			return -EINVAL;
+		}
 		break;
 	default:
 		dev_err(codec->dev, "unknown rate %d\n", rate);
@@ -630,46 +668,163 @@ static int twl6030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl6030_data *priv = codec->private_data;
 	u8 hppll, lppll;
 
+	lppll = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
 	hppll = twl6030_read_reg_cache(codec, TWL6030_REG_HPPLLCTL);
-	hppll &= TWL6030_HPLLRST;
-
-	switch (freq) {
-	case 12000000:
-		/* MCLK input, PLL enabled */
-		hppll = TWL6030_MCLK_12000KHZ
-			| TWL6030_HPLLSQRBP
-			| TWL6030_HPLLENA;
-		break;
-	case 19200000:
-		/* MCLK input, PLL disabled */
-		hppll = TWL6030_MCLK_19200KHZ
-			| TWL6030_HPLLSQRBP
-			| TWL6030_HPLLBP;
+
+	switch (clk_id) {
+	case TWL6030_SYSCLK_SEL_LPPLL:
+		if (freq != 32768) {
+			dev_err(codec->dev, "invalid sysclk freq %d\n", freq);
+			return -EINVAL;
+		}
+
+		/* CLK32K input requires low-power PLL */
+		lppll |= TWL6030_LPLLENA | TWL6030_LPLLSEL;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+		mdelay(5);
+		lppll &= ~TWL6030_HPLLSEL;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+
+		/* headset dac and driver must be in low-power mode */
+		headset_power_mode(codec, 0);
+
+		hppll &= ~TWL6030_HPLLENA;
+		twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppll);
 		break;
-	case 26000000:
-		/* MCLK input, PLL enabled */
-		hppll = TWL6030_MCLK_26000KHZ
-			| TWL6030_HPLLSQRBP
-			| TWL6030_HPLLENA;
+	case TWL6030_SYSCLK_SEL_HPPLL:
+		switch (freq) {
+		case 12000000:
+			hppll = TWL6030_MCLK_12000KHZ;
+			break;
+		case 26000000:
+			hppll = TWL6030_MCLK_26000KHZ;
+			break;
+		default:
+			dev_err(codec->dev, "invalid sysclk freq %d\n", freq);
+			return -EINVAL;
+		}
+
+		/* 12 and 26 MHz freqs require high-performance PLL */
+		hppll |= TWL6030_HPLLSQRBP | TWL6030_HPLLENA;
+		twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppll);
+		udelay(500);
+
+		/* headset dac and driver must be in high-performance mode */
+		headset_power_mode(codec, 1);
+
+		lppll |= TWL6030_HPLLSEL;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+		lppll &= ~TWL6030_LPLLENA;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+
+		/* only 19.2 MHz can be generated by HPPLL */
+		priv->sysclk = 19200000;
 		break;
-	case 38400000:
-		/* clk slicer input, PLL disabled */
-		hppll = TWL6030_MCLK_38400KHZ
-			| TWL6030_HPLLSQRENA
-			| TWL6030_HPLLBP;
+	case TWL6030_SYSCLK_SEL_MCLK:
+		switch (freq) {
+		case 19200000:
+			hppll = TWL6030_MCLK_19200KHZ | TWL6030_HPLLSQRBP;
+			break;
+		case 38400000:
+			hppll = TWL6030_MCLK_38400KHZ;
+			break;
+		default:
+			dev_err(codec->dev, "invalid sysclk freq %d\n", freq);
+			return -EINVAL;
+		}
+
+		/* 19.2 and 38.4 MHz freqs don't require PLL */
+		hppll |= TWL6030_HPLLBP;
+		twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppll);
+		udelay(500);
+
+		/* headset dac and driver must be in high-performance mode */
+		headset_power_mode(codec, 1);
+
+		lppll |= TWL6030_HPLLSEL;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+		lppll &= ~TWL6030_LPLLENA;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+
+		/* only 19.2 MHz can be generated by MCLK */
+		priv->sysclk = 19200000;
 		break;
 	default:
-		dev_err(codec->dev, "unknown sysclk rate %d\n", freq);
+		dev_err(codec->dev, "unknown clk_id %d\n", clk_id);
 		return -EINVAL;
 	}
 
-	twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppll);
+	return 0;
+}
+
+static int twl6030_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+				unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl6030_data *priv = codec->private_data;
+	int div;
+	u8 ldoctl, lppllctl, hppllctl;
+
+	ldoctl = twl6030_read_reg_cache(codec, TWL6030_REG_LDOCTL);
+	lppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
+	hppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_HPPLLCTL);
+
+	if (freq_in && freq_out) {
+		/* div = round(freq_out / freq_in) */
+		div = (freq_out + (freq_in >> 2)) / freq_in;
+
+		switch (pll_id) {
+		case TWL6030_LPPLL_ID:
+			if (div < 512) {
+				dev_err(codec->dev, "invalid pll div %d\n",
+					div);
+				return -EINVAL;
+			}
+			twl6030_write(codec, TWL6030_REG_LPPLLDIV, div - 512);
+			lppllctl |= TWL6030_LPLLENA;
+			twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+
+			priv->sysclk = freq_out;
+			break;
+		case TWL6030_HPPLL_ID:
+			hppllctl |= TWL6030_HPLLENA;
+			twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppllctl);
+			break;
+		default:
+			dev_err(codec->dev, "unknown pll id %d\n", pll_id);
+			return -EINVAL;
+		}
 
-	/* Disable LPPLL and select HPPLL */
-	lppll = TWL6030_HPLLSEL;
-	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+		/* switch to pll */
+		ldoctl &= ~TWL6030_OSCENA;
+		twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+		udelay(10);
+	} else {
+		/* switch to internal oscillator */
+		ldoctl |= TWL6030_OSCENA;
+		twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+		udelay(10);
+
+		/* turn-off pll */
+		switch (pll_id) {
+		case TWL6030_HPPLL_ID:
+			hppllctl &= ~TWL6030_HPLLENA;
+			twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppllctl);
+			break;
+		case TWL6030_LPPLL_ID:
+			lppllctl &= ~TWL6030_LPLLENA;
+			twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+			break;
+		default:
+			dev_err(codec->dev, "unknown pll id %d\n", pll_id);
+			return -EINVAL;
+		}
+
+		priv->sysclk = 0;
+	}
 
 	return 0;
 }
@@ -689,6 +844,7 @@ static int twl6030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static struct snd_soc_dai_ops twl6030_dai_ops = {
 	.hw_params	= twl6030_hw_params,
 	.set_sysclk	= twl6030_set_dai_sysclk,
+	.set_pll	= twl6030_set_dai_pll,
 	.set_fmt	= twl6030_set_dai_fmt,
 };
 
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index 7375ae8..15d3e1b 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -92,6 +92,10 @@
 #define TWL6030_MCLK_38400KHZ		(3 << 5)
 #define TWL6030_MCLK_MSK		0x60
 
+#define TWL6030_SYSCLK_SEL_LPPLL	1
+#define TWL6030_SYSCLK_SEL_HPPLL	2
+#define TWL6030_SYSCLK_SEL_MCLK		3
+
 /* LPPLLCTL (0x08) fields */
 
 #define TWL6030_LPLLENA			0x01
@@ -100,6 +104,19 @@
 #define TWL6030_LPLLFIN			0x08
 #define TWL6030_HPLLSEL			0x10
 
+#define TWL6030_HPPLL_ID		1
+#define TWL6030_LPPLL_ID		2
+
+/* HSLCTL (0x10) fields */
+
+#define TWL6030_HSDACMODEL		0x02
+#define TWL6030_HSDRVMODEL		0x08
+
+/* HSRCTL (0x11) fields */
+
+#define TWL6030_HSDACMODER		0x02
+#define TWL6030_HSDRVMODER		0x08
+
 /* ACCCTL (0x2D) fields */
 
 #define TWL6030_RESETSPLIT		0x04
-- 
1.5.4.3

From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 2/3] ASoC: TWL6030: Add support for low-power
	mode
Date: Mon, 14 Sep 2009 12:00:34 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90432708@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Lopez Cruz,
	Misael" <x0052729@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

TWL6030 codec supports two power modes: low-power and
high-performance.

In low-power mode, headset downlink must be the only path
enabled and components in that path (headset DAC and driver)
should be in that mode too. In this mode, codec can
stream audio at 44.1 and 48 kHz if sys clock is configured
to 17.64 and 19.2 MHz from CLK32K using Low-Power PLL,
respectively.

In high-performance mode, codec can only work at 19.2 MHz
from High-Performance PLL. All paths supported in the
codec can be used but the audio can be streamed only
at 48 kHz.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl6030.c |  192 +++++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/twl6030.h |   19 ++++-
 2 files changed, 181 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index c5e76fa..0f2269e 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -41,6 +41,11 @@
 #define TWL6030_RATES	 (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 #define TWL6030_FORMATS	 (SNDRV_PCM_FMTBIT_S32_LE)
 
+/* codec private data */
+struct twl6030_priv_data {
+	unsigned int sysclk;
+};
+
 /*
  * twl6030 register cache & default register settings
  */
@@ -177,6 +182,29 @@ static void twl6030_power_down(struct snd_soc_codec *codec)
 	twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL, 0x00);
 }
 
+/* set headset dac and driver power mode */
+static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
+{
+	int hslctl, hsrctl;
+	int  mask = TWL6030_HSDRVMODEL | TWL6030_HSDACMODEL;
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
@@ -419,6 +447,10 @@ static int twl6030_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl6030_priv_data *twl6030_priv = codec->private_data;
 	int rate, format;
 
 	/* hardware dai (McPDM) requires bit stream of twice
@@ -428,7 +460,20 @@ static int twl6030_hw_params(struct snd_pcm_substream *substream,
 	rate = params_rate(params);
 	switch (rate) {
 	case 44100:
+		if (twl6030_priv->sysclk != 17640000) {
+			dev_err(codec->dev,
+				"rate %d not supported at current sysclk %d\n",
+				rate, twl6030_priv->sysclk);
+			return -EINVAL;
+		}
+		break;
 	case 48000:
+		if (twl6030_priv->sysclk != 19200000) {
+			dev_err(codec->dev,
+				"rate %d not supported at current sysclk %d\n",
+				rate, twl6030_priv->sysclk);
+			return -EINVAL;
+		}
 		break;
 	default:
 		dev_err(codec->dev, "unknown rate %d\n", rate);
@@ -451,46 +496,120 @@ static int twl6030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl6030_priv_data *twl6030_priv = codec->private_data;
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
+		twl6030_priv->sysclk = 19200000;
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
+		twl6030_priv->sysclk = 19200000;
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
+	struct twl6030_priv_data *twl6030_priv = codec->private_data;
+	int div;
+
+	if (!freq_in || !freq_out)
+		return -EINVAL;
+
+	/* div = round(freq_out / freq_in) */
+	div = (freq_out + (freq_in >> 2)) / freq_in;
 
-	/* Disable LPPLL and select HPPLL */
-	lppll = TWL6030_HPLLSEL;
-	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppll);
+	if (pll_id == TWL6030_LPPLL_ID) {
+		if (div < 512) {
+			dev_err(codec->dev, "invalid pll divider %d\n", div);
+			return -EINVAL;
+		}
+
+		twl6030_write(codec, TWL6030_REG_LPPLLDIV, div - 512);
+		twl6030_priv->sysclk = freq_out;
+	}
 
 	return 0;
 }
@@ -510,6 +629,7 @@ static int twl6030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static struct snd_soc_dai_ops twl6030_dai_ops = {
 	.hw_params	= twl6030_hw_params,
 	.set_sysclk	= twl6030_set_dai_sysclk,
+	.set_pll	= twl6030_set_dai_pll,
 	.set_fmt	= twl6030_set_dai_fmt,
 };
 
@@ -614,12 +734,21 @@ static int twl6030_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec;
+	struct twl6030_priv_data *twl6030_priv;
+	int ret;
 
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
 
+	twl6030_priv = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (twl6030_priv == NULL) {
+		ret = -ENOMEM;
+		goto priv_err;
+	}
+
 	codec->dev = &pdev->dev;
+	codec->private_data = twl6030_priv;
 	socdev->card->codec = codec;
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -629,6 +758,10 @@ static int twl6030_probe(struct platform_device *pdev)
 	twl6030_init(socdev);
 
 	return 0;
+
+priv_err:
+	kfree(codec);
+	return ret;
 }
 
 static int twl6030_remove(struct platform_device *pdev)
@@ -640,6 +773,7 @@ static int twl6030_remove(struct platform_device *pdev)
 	twl6030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
+	kfree(codec->private_data);
 	kfree(codec);
 
 	return 0;
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index a83f9e7..9e49c85 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -77,14 +77,31 @@
 #define TWL6030_MCLK_38400KHZ		(3 << 5)
 #define TWL6030_MCLK_MSK		0x60
 
+#define TWL6030_SYSCLK_SEL_LPPLL	1
+#define TWL6030_SYSCLK_SEL_HPPLL	2
+#define TWL6030_SYSCLK_SEL_MCLK		3
+
 /* LPPLLCTL (0x08) fields */
 
 #define TWL6030_LPLLENA			0x01
 #define TWL6030_LPLLRST			0x02
 #define TWL6030_LPLLSEL			0x04
-#define TWL6030_FIN			0x08
+#define TWL6030_LPLLFIN			0x08
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
 extern struct snd_soc_dai twl6030_dai;
 extern struct snd_soc_codec_device soc_codec_dev_twl6030;
 
-- 
1.5.4.3

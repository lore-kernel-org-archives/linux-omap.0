From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv3 4/7] ASoC: TWL6030: Add support for low-power
	PLL
Date: Tue, 6 Oct 2009 02:30:00 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90C2F64B@dlee04.ent.ti.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

TWL6030 codec sysclk can be provided by: low-power or high
performance PLL.

The low-power PLL takes a low-frequency input at 32,768 Hz and
generates an approximate of 17.64 or 19.2 MHz.

The high-performance PLL generates an exact 19.2 MHz clock signal
from high-frequency input at 12/19.2/26/38.4 MHz.

For the particular case of headset path, PLL being used defines the
headset power mode: low-power, high-performance. Headset DAC and
output driver should be configured according to the selected mode.
17.64 MHz sysclk is recommended only for headset low-power playback
mode.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl6030.c |  232 +++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/twl6030.h |   16 +++
 2 files changed, 215 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index f97dec2..9fc4795 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -39,7 +39,7 @@
 
 #include "twl6030.h"
 
-#define TWL6030_RATES	 (SNDRV_PCM_RATE_48000)
+#define TWL6030_RATES	 (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 #define TWL6030_FORMATS	 (SNDRV_PCM_FMTBIT_S32_LE)
 
 /* codec private data */
@@ -47,6 +47,9 @@ struct twl6030_data {
 	struct snd_soc_codec codec;
 	int audpwron;
 	int codec_powered;
+	int pll;
+	unsigned int sysclk;
+	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 };
 
 /*
@@ -326,6 +329,29 @@ static void twl6030_power_down(struct snd_soc_codec *codec)
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
@@ -607,55 +633,195 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+/* set of rates for each pll: low-power and high-performance */
+
+static unsigned int lp_rates[] = {
+	44100,
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list lp_constraints = {
+	.count	= ARRAY_SIZE(lp_rates),
+	.list	= lp_rates,
+};
+
+static unsigned int hp_rates[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list hp_constraints = {
+	.count	= ARRAY_SIZE(hp_rates),
+	.list	= hp_rates,
+};
+
+static int twl6030_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl6030_data *priv = codec->private_data;
+
+	if (!priv->sysclk) {
+		dev_err(codec->dev,
+			"no mclk configured, call set_sysclk() on init\n");
+		return -EINVAL;
+	}
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE,
+				priv->sysclk_constraints);
+
+	return 0;
+}
+
+static int twl6030_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl6030_data *priv = codec->private_data;
+	u8 lppllctl;
+	int rate;
+
+	/* nothing to do for high-perf pll, it supports only 48 kHz */
+	if (priv->pll == TWL6030_HPPLL_ID)
+		return 0;
+
+	lppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
+
+	rate = params_rate(params);
+	switch (rate) {
+	case 44100:
+		lppllctl |= TWL6030_LPLLFIN;
+		priv->sysclk = 17640000;
+		break;
+	case 48000:
+		lppllctl &= ~TWL6030_LPLLFIN;
+		priv->sysclk = 19200000;
+		break;
+	default:
+		dev_err(codec->dev, "unsupported rate %d\n", rate);
+		return -EINVAL;
+	}
+
+	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+
+	return 0;
+}
+
 static int twl6030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl6030_data *priv = codec->private_data;
 	u8 hppllctl, lppllctl;
 
 	hppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_HPPLLCTL);
-	hppllctl &= ~TWL6030_MCLK_MSK;
-
-	switch (freq) {
-	case 12000000:
-		/* mclk input, pll enabled */
-		hppllctl |= TWL6030_MCLK_12000KHZ |
-			    TWL6030_HPLLSQRBP |
-			    TWL6030_HPLLENA;
-		break;
-	case 19200000:
-		/* mclk input, pll disabled */
-		hppllctl |= TWL6030_MCLK_19200KHZ |
-			    TWL6030_HPLLSQRBP |
-			    TWL6030_HPLLBP;
-		break;
-	case 26000000:
-		/* mclk input, pll enabled */
-		hppllctl |= TWL6030_MCLK_26000KHZ |
-			    TWL6030_HPLLSQRBP |
-			    TWL6030_HPLLENA;
+	lppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
+
+	switch (clk_id) {
+	case TWL6030_SYSCLK_SEL_LPPLL:
+		switch (freq) {
+		case 32768:
+			/* headset dac and driver must be in low-power mode */
+			headset_power_mode(codec, 0);
+
+			/* clk32k input requires low-power pll */
+			lppllctl |= TWL6030_LPLLENA;
+			twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+			mdelay(5);
+			lppllctl &= ~TWL6030_HPLLSEL;
+			twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+			hppllctl &= ~TWL6030_HPLLENA;
+			twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppllctl);
+			break;
+		default:
+			dev_err(codec->dev, "unknown mclk freq %d\n", freq);
+			return -EINVAL;
+		}
+
+		/* lppll divider */
+		switch (priv->sysclk) {
+		case 17640000:
+			lppllctl |= TWL6030_LPLLFIN;
+			break;
+		case 19200000:
+			lppllctl &= ~TWL6030_LPLLFIN;
+			break;
+		default:
+			/* sysclk not yet configured */
+			lppllctl &= ~TWL6030_LPLLFIN;
+			priv->sysclk = 19200000;
+			break;
+		}
+
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+
+		priv->pll = TWL6030_LPPLL_ID;
+		priv->sysclk_constraints = &lp_constraints;
 		break;
-	case 38400000:
-		/* clk slicer, pll disabled */
-		hppllctl |= TWL6030_MCLK_38400KHZ |
-			    TWL6030_HPLLSQRENA |
-			    TWL6030_HPLLBP;
+	case TWL6030_SYSCLK_SEL_HPPLL:
+		hppllctl &= ~TWL6030_MCLK_MSK;
+
+		switch (freq) {
+		case 12000000:
+			/* mclk input, pll enabled */
+			hppllctl |= TWL6030_MCLK_12000KHZ |
+				    TWL6030_HPLLSQRBP |
+				    TWL6030_HPLLENA;
+			break;
+		case 19200000:
+			/* mclk input, pll disabled */
+			hppllctl |= TWL6030_MCLK_19200KHZ |
+				    TWL6030_HPLLSQRBP |
+				    TWL6030_HPLLBP;
+			break;
+		case 26000000:
+			/* mclk input, pll enabled */
+			hppllctl |= TWL6030_MCLK_26000KHZ |
+				    TWL6030_HPLLSQRBP |
+				    TWL6030_HPLLENA;
+			break;
+		case 38400000:
+			/* clk slicer, pll disabled */
+			hppllctl |= TWL6030_MCLK_38400KHZ |
+				    TWL6030_HPLLSQRENA |
+				    TWL6030_HPLLBP;
+			break;
+		default:
+			dev_err(codec->dev, "unknown mclk freq %d\n", freq);
+			return -EINVAL;
+		}
+
+		/* headset dac and driver must be in high-performance mode */
+		headset_power_mode(codec, 1);
+
+		twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppllctl);
+		udelay(500);
+		lppllctl |= TWL6030_HPLLSEL;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+		lppllctl &= ~TWL6030_LPLLENA;
+		twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+
+		/* high-performance pll can provide only 19.2 MHz */
+		priv->pll = TWL6030_HPPLL_ID;
+		priv->sysclk = 19200000;
+		priv->sysclk_constraints = &hp_constraints;
 		break;
 	default:
-		dev_err(codec->dev, "unknown sysclk freq %d\n", freq);
+		dev_err(codec->dev, "unknown clk_id %d\n", clk_id);
 		return -EINVAL;
 	}
 
-	twl6030_write(codec, TWL6030_REG_HPPLLCTL, hppllctl);
-
-	/* Disable LPPLL and select HPPLL */
-	lppllctl = TWL6030_HPLLSEL;
-	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
-
 	return 0;
 }
 
 static struct snd_soc_dai_ops twl6030_dai_ops = {
+	.startup	= twl6030_startup,
+	.hw_params	= twl6030_hw_params,
 	.set_sysclk	= twl6030_set_dai_sysclk,
 };
 
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index 7375ae8..87f1e1e 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -100,10 +100,26 @@
 #define TWL6030_LPLLFIN			0x08
 #define TWL6030_HPLLSEL			0x10
 
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
 
+#define TWL6030_SYSCLK_SEL_LPPLL	1
+#define TWL6030_SYSCLK_SEL_HPPLL	2
+
+#define TWL6030_HPPLL_ID		1
+#define TWL6030_LPPLL_ID		2
+
 extern struct snd_soc_dai twl6030_dai;
 extern struct snd_soc_codec_device soc_codec_dev_twl6030;
 
-- 
1.5.4.3

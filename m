From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv3 6/7] ASoC: TWL6030: Enable audio interrupt
Date: Tue, 6 Oct 2009 02:30:09 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90C2F64D@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45261 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283AbZJFHau convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 03:30:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

NAUDINT interrupt line is provided by the TWL6030 codec to signal
externally events like headset plug/unplug, hook, power-up sequence
completion, etc.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl6030.c |   70 ++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/twl6030.h |   14 +++++++++
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index 8548442..56fe136 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -46,6 +46,7 @@
 struct twl6030_data {
 	struct snd_soc_codec codec;
 	int audpwron;
+	int naudint;
 	int codec_powered;
 	int pll;
 	int non_lp;
@@ -61,7 +62,7 @@ static const u8 twl6030_reg[TWL6030_CACHEREGNUM] = {
 	0x4B, /* TWL6030_ASICID (ro)	0x01	*/
 	0x00, /* TWL6030_ASICREV (ro)	0x02	*/
 	0x00, /* TWL6030_INTID		0x03	*/
-	0x7B, /* TWL6030_INTMR		0x04	*/
+	0x00, /* TWL6030_INTMR		0x04	*/
 	0x00, /* TWL6030_NCPCTRL	0x05	*/
 	0x00, /* TWL6030_LDOCTL		0x06	*/
 	0x00, /* TWL6030_HPPLLCTL	0x07	*/
@@ -367,6 +368,39 @@ static int twl6030_power_mode_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+/* audio interrupt handler */
+static irqreturn_t twl6030_naudint_handler(int irq, void *data)
+{
+	struct snd_soc_codec *codec = data;
+	u8 intid;
+
+	twl_i2c_read_u8(TWL6030_MODULE_AUDIO, &intid, TWL6030_REG_INTID);
+
+	switch (intid) {
+	case TWL6030_THINT:
+		dev_alert(codec->dev, "die temp over-limit detection\n");
+		break;
+	case TWL6030_PLUGINT:
+	case TWL6030_UNPLUGINT:
+	case TWL6030_HOOKINT:
+		break;
+	case TWL6030_HFINT:
+		dev_alert(codec->dev, "hf drivers over current detection\n");
+		break;
+	case TWL6030_VIBINT:
+		dev_alert(codec->dev, "vib drivers over current detection\n");
+		break;
+	case TWL6030_READYINT:
+		dev_alert(codec->dev, "codec is ready\n");
+		break;
+	default:
+		dev_err(codec->dev, "unknown audio interrupt %d\n", intid);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
 /*
  * MICATT volume control:
  * from -6 to 0 dB in 6 dB steps
@@ -993,19 +1027,23 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 	struct twl_codec_data *twl_codec = pdev->dev.platform_data;
 	struct snd_soc_codec *codec;
 	struct twl6030_data *priv;
-	int audpwron;
+	int audpwron, naudint;
 	int ret = 0;
 
 	priv = kzalloc(sizeof(struct twl6030_data), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
-	if (twl_codec)
+	if (twl_codec) {
 		audpwron = twl_codec->audpwron_gpio;
-	else
+		naudint = twl_codec->naudint_irq;
+	} else {
 		audpwron = -EINVAL;
+		naudint = 0;
+	}
 
 	priv->audpwron = audpwron;
+	priv->naudint = naudint;
 
 	codec = &priv->codec;
 	codec->dev = &pdev->dev;
@@ -1043,13 +1081,28 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 		priv->codec_powered = 0;
 	}
 
+	if (naudint) {
+		/* audio interrupt */
+		ret = request_threaded_irq(naudint, NULL,
+				twl6030_naudint_handler,
+				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				"twl6030_codec", codec);
+		if (ret)
+			goto gpio2_err;
+	} else {
+		dev_warn(codec->dev,
+			"no naudint irq, audio interrupts disabled\n");
+		twl6030_write_reg_cache(codec, TWL6030_REG_INTMR,
+					TWL6030_ALLINT_MSK);
+	}
+
 	/* init vio registers */
 	twl6030_init_vio_regs(codec);
 
 	/* power on device */
 	ret = twl6030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	if (ret)
-		goto gpio2_err;
+		goto irq_err;
 
 	ret = snd_soc_register_codec(codec);
 	if (ret)
@@ -1068,6 +1121,9 @@ dai_err:
 	twl6030_codec = NULL;
 reg_err:
 	twl6030_set_bias_level(codec, SND_SOC_BIAS_OFF);
+irq_err:
+	if (naudint)
+		free_irq(naudint, codec);
 gpio2_err:
 	if (gpio_is_valid(audpwron))
 		gpio_free(audpwron);
@@ -1082,10 +1138,14 @@ static int __devexit twl6030_codec_remove(struct platform_device *pdev)
 {
 	struct twl6030_data *priv = twl6030_codec->private_data;
 	int audpwron = priv->audpwron;
+	int naudint = priv->naudint;
 
 	if (gpio_is_valid(audpwron))
 		gpio_free(audpwron);
 
+	if (naudint)
+		free_irq(naudint, twl6030_codec);
+
 	snd_soc_unregister_dai(&twl6030_dai);
 	snd_soc_unregister_codec(twl6030_codec);
 
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index 87f1e1e..786fd80 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -67,6 +67,20 @@
 #define TWL6030_VIOREGNUM		18
 #define TWL6030_VDDREGNUM		21
 
+/* INTID (0x03) fields */
+
+#define TWL6030_THINT			0x01
+#define TWL6030_PLUGINT			0x02
+#define TWL6030_UNPLUGINT		0x04
+#define TWL6030_HOOKINT			0x08
+#define TWL6030_HFINT			0x10
+#define TWL6030_VIBINT			0x20
+#define TWL6030_READYINT		0x40
+
+/* INTMR (0x04) fields */
+
+#define TWL6030_ALLINT_MSK		0x7B
+
 /* NCPCTL (0x05) fields */
 
 #define TWL6030_NCPENA			0x01
-- 
1.5.4.3

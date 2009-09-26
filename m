From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv2 6/7] ASoC: TWL6030: Enable audio interrupt
Date: Fri, 25 Sep 2009 21:03:41 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A391E4@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57210 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104AbZIZCDn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:03:43 -0400
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
 sound/soc/codecs/twl6030.c |   78 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/twl6030.h |   10 ++++++
 2 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index 032619d..5cf2099 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -47,6 +47,7 @@ struct twl6030_data {
 	struct snd_soc_codec codec;
 	int codec_powered;
 	unsigned int sysclk;
+	struct work_struct audint_work;
 };
 
 /*
@@ -329,6 +330,58 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 	return 0;
 }
 
+/* audio interrupt handler */
+irqreturn_t twl6030_naudint_handler(int irq, void *data)
+{
+	struct snd_soc_codec *codec = data;
+	struct twl6030_data *priv = codec->private_data;
+
+	schedule_work(&priv->audint_work);
+
+	/* disable audint irq to let workqueue to execute */
+	disable_irq_nosync(irq);
+
+	return IRQ_HANDLED;
+}
+
+void twl6030_naudint_work(struct work_struct *work)
+{
+	struct twl_codec_data *twl_codec;
+	struct snd_soc_codec *codec;
+	struct twl6030_data *priv;
+	u8 intid;
+
+	priv = container_of(work, struct twl6030_data, audint_work);
+	codec = &priv->codec;
+	twl_codec = codec->control_data;
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
+	enable_irq(twl_codec->naudint_irq);
+}
+
 /*
  * MICATT volume control:
  * from -6 to 0 dB in 6 dB steps
@@ -610,6 +663,7 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 		priv->codec_powered = 0;
 		break;
 	}
+
 	codec->bias_level = level;
 
 	return 0;
@@ -954,8 +1008,15 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 	struct twl6030_data *priv;
 	struct snd_soc_codec *codec;
 	int audpwron_gpio = twl_codec->audpwron_gpio;
+	int naudint_irq = twl_codec->naudint_irq;
 	int ret = 0;
 
+	/* prerequisites */
+	if (!naudint_irq) {
+		dev_err(&pdev->dev, "no audio interrupt irq supplied\n");
+		return -EINVAL;
+	}
+
 	priv = kzalloc(sizeof(struct twl6030_data), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
@@ -998,6 +1059,17 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 		priv->codec_powered = 0;
 	}
 
+	/* audio interrupt */
+	INIT_WORK(&priv->audint_work, twl6030_naudint_work);
+
+	ret = request_irq(naudint_irq,
+			twl6030_naudint_handler,
+			IRQF_TRIGGER_LOW | IRQF_DISABLED,
+			"twl6030-codec",
+			codec);
+	if (ret)
+		goto gpio2_err;
+
 	/* init vio registers */
 	twl6030_init_vio_regs(codec);
 
@@ -1006,7 +1078,7 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_codec(codec);
 	if (ret)
-		goto gpio2_err;
+		goto reg_err;
 
 	twl6030_codec = codec;
 
@@ -1019,6 +1091,8 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 dai_err:
 	snd_soc_unregister_codec(codec);
 	twl6030_codec = NULL;
+reg_err:
+	free_irq(naudint_irq, twl_codec);
 gpio2_err:
 	if (gpio_is_valid(audpwron_gpio))
 		gpio_free(audpwron_gpio);
@@ -1036,6 +1110,8 @@ static int __devexit twl6030_codec_remove(struct platform_device *pdev)
 	if (gpio_is_valid(twl_codec->audpwron_gpio))
 		gpio_free(twl_codec->audpwron_gpio);
 
+	free_irq(twl_codec->naudint_irq, twl6030_codec);
+
 	snd_soc_unregister_dai(&twl6030_dai);
 	snd_soc_unregister_codec(twl6030_codec);
 
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index 15d3e1b..8a106f2 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -67,6 +67,16 @@
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
 /* NCPCTL (0x05) fields */
 
 #define TWL6030_NCPENA			0x01
-- 
1.5.4.3

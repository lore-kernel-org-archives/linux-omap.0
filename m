From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv4 7/7] ASoC: TWL6030: Detect power-up sequence completion
Date: Tue, 23 Feb 2010 18:10:54 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD1B19@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32923 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab0BXALA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 19:11:00 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

From: Misael Lopez Cruz <x0052729@ti.com>

When the codec is powered-up through external AUDPWRON line it starts
its power-up sequence. The completion of the sequence is signaled
through the audio interrupt, and then codec is operational.

If NAUDINT irq is provided, CODEC driver starts a wait_for_completion
just after AUDPWRON line transitions from low to high. It's signaled as
complete when servicing READYINT interrupt.

If AUDPWRON gpio line is provided but NAUDINT irq is not, then CODEC
driver enables READYINT and polls on INTID register. If none of them are
provided, then CODEC uses manual power sequences and disables all audio
interrupts.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6030.c |   61 +++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/twl6030.h |    1 +
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index b8dd5ae..2847f1b 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -52,6 +52,7 @@ struct twl6030_data {
 	int non_lp;
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
+	struct completion ready;
 };
 
 /*
@@ -372,6 +373,7 @@ static int twl6030_power_mode_event(struct snd_soc_dapm_widget *w,
 static irqreturn_t twl6030_naudint_handler(int irq, void *data)
 {
 	struct snd_soc_codec *codec = data;
+	struct twl6030_data *priv = codec->private_data;
 	u8 intid;
 
 	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid, TWL6030_REG_INTID);
@@ -391,7 +393,7 @@ static irqreturn_t twl6030_naudint_handler(int irq, void *data)
 		dev_alert(codec->dev, "vib drivers over current detection\n");
 		break;
 	case TWL6030_READYINT:
-		dev_alert(codec->dev, "codec is ready\n");
+		complete(&priv->ready);
 		break;
 	default:
 		dev_err(codec->dev, "unknown audio interrupt %d\n", intid);
@@ -626,11 +628,45 @@ static int twl6030_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int twl6030_power_up_completion(struct snd_soc_codec *codec,
+					int naudint)
+{
+	struct twl6030_data *priv = codec->private_data;
+	int time_left;
+	u8 intid;
+
+	if (naudint) {
+		/* wait for ready interrupt with 48 ms timeout */
+		time_left = wait_for_completion_timeout(&priv->ready,
+					msecs_to_jiffies(48));
+	} else {
+		/* retry 3 times only */
+		for (time_left = 3; time_left > 0; time_left--) {
+			mdelay(16);
+			twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid,
+					TWL6030_REG_INTID);
+			if (intid & TWL6030_READYINT)
+				break;
+		}
+	}
+
+	if (!time_left) {
+		dev_err(codec->dev, "timeout waiting for READYINT\n");
+		return -ETIMEDOUT;
+	}
+
+	priv->codec_powered = 1;
+
+	return 0;
+}
+
 static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
 	struct twl6030_data *priv = codec->private_data;
 	int audpwron = priv->audpwron;
+	int naudint = priv->naudint;
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -643,8 +679,10 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 			/* use AUDPWRON line */
 			gpio_set_value(audpwron, 1);
 
-			/* power-up sequence latency */
-			mdelay(16);
+			/* wait for power-up completion */
+			ret = twl6030_power_up_completion(codec, naudint);
+			if (ret)
+				return ret;
 
 			/* sync registers updated during power-up sequence */
 			twl6030_read(codec, TWL6030_REG_NCPCTL);
@@ -653,12 +691,11 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 		} else {
 			/* use manual power-up sequence */
 			twl6030_power_up(codec);
+			priv->codec_powered = 1;
 		}
 
 		/* initialize vdd/vss registers with reg_cache */
 		twl6030_init_vdd_regs(codec);
-
-		priv->codec_powered = 1;
 		break;
 	case SND_SOC_BIAS_OFF:
 		if (!priv->codec_powered)
@@ -1067,6 +1104,7 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
+	init_completion(&priv->ready);
 
 	if (gpio_is_valid(audpwron)) {
 		ret = gpio_request(audpwron, "audpwron");
@@ -1089,10 +1127,15 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 		if (ret)
 			goto gpio2_err;
 	} else {
-		dev_warn(codec->dev,
-			"no naudint irq, audio interrupts disabled\n");
-		twl6030_write_reg_cache(codec, TWL6030_REG_INTMR,
-					TWL6030_ALLINT_MSK);
+		if (gpio_is_valid(audpwron)) {
+			/* enable only codec ready interrupt */
+			twl6030_write_reg_cache(codec, TWL6030_REG_INTMR,
+					~TWL6030_READYMSK & TWL6030_ALLINT_MSK);
+		} else {
+			/* no interrupts at all */
+			twl6030_write_reg_cache(codec, TWL6030_REG_INTMR,
+						TWL6030_ALLINT_MSK);
+		}
 	}
 
 	/* init vio registers */
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index 90b8a44..d591be1 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -79,6 +79,7 @@
 
 /* INTMR (0x04) fields */
 
+#define TWL6030_READYMSK		0x40
 #define TWL6030_ALLINT_MSK		0x7B
 
 /* NCPCTL (0x05) fields */
-- 
1.6.1.3


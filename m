From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv2 7/7] ASoC: TWL6030: Power-up seq completion through audio
 interrupt
Date: Fri, 25 Sep 2009 21:03:45 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A391E5@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33591 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbZIZCDq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:03:46 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

When the codec is powered-up through external AUDPWRON line it starts
its power-up sequence. The completion of the sequence is signaled
through the audio interrupt, and then codec is operational.

CODEC driver starts a wait_for_completion just after AUDPWRON line
transitions from low to high. It's signaled as complete when servicing
READYINT interrupt.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl6030.c |   46 ++++++++++++++++++++++++++++---------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index 5cf2099..f8bd8ee 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -48,6 +48,7 @@ struct twl6030_data {
 	int codec_powered;
 	unsigned int sysclk;
 	struct work_struct audint_work;
+	struct completion ready_completion;
 };
 
 /*
@@ -58,7 +59,7 @@ static const u8 twl6030_reg[TWL6030_CACHEREGNUM] = {
 	0x4B, /* TWL6030_ASICID (ro)	0x01	*/
 	0x00, /* TWL6030_ASICREV (ro)	0x02	*/
 	0x00, /* TWL6030_INTID		0x03	*/
-	0x41, /* TWL6030_INTMR		0x04	*/
+	0x00, /* TWL6030_INTMR		0x04	*/
 	0x00, /* TWL6030_NCPCTRL	0x05	*/
 	0x00, /* TWL6030_LDOCTL		0x06	*/
 	0x00, /* TWL6030_HPPLLCTL	0x07	*/
@@ -186,6 +187,23 @@ static inline void twl6030_write_reg_cache(struct snd_soc_codec *codec,
 }
 
 /*
+ * read from twl6030 hardware register
+ */
+static int twl6030_read(struct snd_soc_codec *codec,
+			unsigned int reg)
+{
+	u8 value;
+
+	if (reg > TWL6030_CACHEREGNUM)
+		return -EIO;
+
+	twl_i2c_read_u8(TWL6030_MODULE_AUDIO, &value, reg);
+	twl6030_write_reg_cache(codec, reg, value);
+
+	return value;
+}
+
+/*
  * write to the twl6030 register space
  */
 static int twl6030_write(struct snd_soc_codec *codec,
@@ -372,7 +390,8 @@ void twl6030_naudint_work(struct work_struct *work)
 		dev_alert(codec->dev, "vib drivers over current detection\n");
 		break;
 	case TWL6030_READYINT:
-		dev_alert(codec->dev, "codec is ready\n");
+		priv->codec_powered = 1;
+		complete(&priv->ready_completion);
 		break;
 	default:
 		dev_err(codec->dev, "unknown audio interrupt %d\n", intid);
@@ -617,25 +636,21 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 			/* use AUDPWRON line */
 			gpio_set_value(audpwron_gpio, 1);
 
-			/* power-up sequence latency */
-			mdelay(16);
+			/* wait for ready interrupt */
+			wait_for_completion(&priv->ready_completion);
 
 			/* sync registers updated during power-up sequence */
-			twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL,
-						0x81);
-			twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL,
-						0x45);
-			twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL,
-						0x01);
+			twl6030_read(codec, TWL6030_REG_NCPCTL);
+			twl6030_read(codec, TWL6030_REG_LDOCTL);
+			twl6030_read(codec, TWL6030_REG_LPPLLCTL);
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
@@ -649,10 +664,8 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 			udelay(500);
 
 			/* sync registers updated during power-down sequence */
-			twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL,
-						0x00);
-			twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL,
-						0x00);
+			twl6030_read(codec, TWL6030_REG_NCPCTL);
+			twl6030_read(codec, TWL6030_REG_LDOCTL);
 			twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL,
 						0x00);
 		} else {
@@ -1061,6 +1074,7 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 
 	/* audio interrupt */
 	INIT_WORK(&priv->audint_work, twl6030_naudint_work);
+	init_completion(&priv->ready_completion);
 
 	ret = request_irq(naudint_irq,
 			twl6030_naudint_handler,
-- 
1.5.4.3

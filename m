From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 3/3] ASoC: TWL6030: Handle power-up seq
 completion thru audio interrupt
Date: Mon, 14 Sep 2009 12:00:42 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90432709@dlee04.ent.ti.com>
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

NAUDINT interrupt line is provided by the TWL6030 codec to
signal externally events like headset plug/unplug, hook,
power-up sequence completion, etc.

When the codec is powered-up through external AUDPWRON line it
will start its power-up sequence. The completion of the sequence
is signaled through the audio interrupt, and then codec is
operational.

CODEC driver starts a wait_for_completion just after calling
external power-up callback. It's signaled as complete when
servicing READYINT interrupt.

MACHINE drivers should request IRQ line used in corresponding
hardware platform and initialize workqueue and completion structs
of twl6030_setup_data as well.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl6030.c |  103 +++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/twl6030.h |   17 +++++++
 2 files changed, 113 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index 0f2269e..dc85399 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -43,6 +43,7 @@
 
 /* codec private data */
 struct twl6030_priv_data {
+	int codec_powered;
 	unsigned int sysclk;
 };
 
@@ -54,7 +55,7 @@ static const u8 twl6030_reg[TWL6030_CACHEREGNUM] = {
 	0x4B, /* TWL6030_ASICID (ro)	0x01	*/
 	0x00, /* TWL6030_ASICREV (ro)	0x02	*/
 	0x00, /* TWL6030_INTID		0x03	*/
-	0x41, /* TWL6030_INTMR		0x04	*/
+	0x00, /* TWL6030_INTMR		0x04	*/
 	0x00, /* TWL6030_NCPCTRL	0x05	*/
 	0x00, /* TWL6030_LDOCTL		0x06	*/
 	0x00, /* TWL6030_HPPLLCTL	0x07	*/
@@ -127,6 +128,23 @@ static inline void twl6030_write_reg_cache(struct snd_soc_codec *codec,
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
@@ -159,27 +177,89 @@ static void twl6030_init_chip(struct snd_soc_codec *codec)
 static void twl6030_power_up(struct snd_soc_codec *codec)
 {
 	struct snd_soc_device *socdev = codec->socdev;
+	struct twl6030_priv_data *priv = codec->private_data;
 	struct twl6030_setup_data *setup = socdev->codec_data;
 
+	if (priv->codec_powered)
+		return;
+
 	setup->codec_enable(1);
 
+	/* wait for ready interrupt */
+	wait_for_completion(&setup->ready_completion);
+
 	/* sync registers updated during power-up sequence */
-	twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL, 0x81);
-	twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL, 0x45);
-	twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL, 0x01);
+	twl6030_read(codec, TWL6030_REG_NCPCTL);
+	twl6030_read(codec, TWL6030_REG_LDOCTL);
+	twl6030_read(codec, TWL6030_REG_LPPLLCTL);
 }
 
 static void twl6030_power_down(struct snd_soc_codec *codec)
 {
 	struct snd_soc_device *socdev = codec->socdev;
+	struct twl6030_priv_data *priv = codec->private_data;
 	struct twl6030_setup_data *setup = socdev->codec_data;
 
 	setup->codec_enable(0);
+	udelay(500);
 
 	/* sync registers updated during power-down sequence */
-	twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL, 0x00);
-	twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL, 0x00);
-	twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL, 0x00);
+	twl6030_read(codec, TWL6030_REG_NCPCTL);
+	twl6030_read(codec, TWL6030_REG_LDOCTL);
+	twl6030_read(codec, TWL6030_REG_LPPLLCTL);
+
+	priv->codec_powered = 0;
+}
+
+/* audio interrupt handler */
+irqreturn_t twl6030_naudint_handler(int irq, void *data)
+{
+	struct twl6030_setup_data *setup = data;
+
+	schedule_work(&setup->audint_work);
+
+	/* disable audint irq to let workqueue to execute */
+	disable_irq_nosync(irq);
+
+	return IRQ_HANDLED;
+}
+
+void twl6030_naudint_work(struct work_struct *work)
+{
+	struct snd_soc_codec *codec;
+	struct twl6030_setup_data *setup;
+	struct twl6030_priv_data *priv;
+	u8 intid;
+
+	setup = container_of(work, struct twl6030_setup_data, audint_work);
+	codec = setup->codec;
+	priv = codec->private_data;
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
+		priv->codec_powered = 1;
+		complete(&setup->ready_completion);
+		break;
+	default:
+		dev_err(codec->dev, "unknown twl6030 audio interrupt\n");
+	}
+
+	enable_irq(setup->irq);
 }
 
 /* set headset dac and driver power mode */
@@ -679,6 +759,7 @@ static int twl6030_resume(struct platform_device *pdev)
 static int twl6030_init(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl6030_setup_data *setup = socdev->codec_data;
 	int ret = 0;
 
 	dev_info(codec->dev, "TWL6030 Audio Codec init\n");	
@@ -703,6 +784,14 @@ static int twl6030_init(struct snd_soc_device *socdev)
 		goto pcm_err;
 	}
 
+	/* platform setup data is required for power-off/off the device */
+	if (setup == NULL) {
+		printk(KERN_ERR "twl6030: platform setup data missing\n");
+		goto pcm_err;
+	}
+
+	setup->codec = codec;
+
 	/* power on device */
 	twl6030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index 9e49c85..1e1fb3f 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -64,6 +64,16 @@
 
 #define TWL6030_CACHEREGNUM		(TWL6030_REG_STATUS + 1)
 
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
 /* HPPLLCTL (0x07) fields */
 
 #define TWL6030_HPLLENA			0x01
@@ -105,8 +115,15 @@
 extern struct snd_soc_dai twl6030_dai;
 extern struct snd_soc_codec_device soc_codec_dev_twl6030;
 
+irqreturn_t twl6030_naudint_handler(int irq, void *data);
+void twl6030_naudint_work(struct work_struct *work);
+
 struct twl6030_setup_data {
 	void (*codec_enable)(int enable);
+	int irq;
+	struct work_struct audint_work;
+	struct completion ready_completion;
+	struct snd_soc_codec *codec;
 };
 
 #endif /* End of __TWL6030_H__ */
-- 
1.5.4.3

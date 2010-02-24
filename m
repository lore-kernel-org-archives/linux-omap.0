From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv4 3/7] ASoC: TWL6030: Manual power-up/down sequences
Date: Tue, 23 Feb 2010 18:10:31 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD1B15@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46301 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793Ab0BXAKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 19:10:39 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

From: Misael Lopez Cruz <x0052729@ti.com>

TWL6030 codec device can be powered-up/down through a specific register
writes sequence. These sequences can be used when no gpio line is
provided for AUDPWRON.

When the codec is powered-up in this way, automatic power-down sequence
(triggered by thermal shutdown) is not possible.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6030.c |  112 ++++++++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/twl6030.h |   16 ++++++
 2 files changed, 115 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index 8b52aa1..ec838b1 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -244,6 +244,88 @@ static void twl6030_init_vdd_regs(struct snd_soc_codec *codec)
 	}
 }
 
+/* twl6030 codec manual power-up sequence */
+static void twl6030_power_up(struct snd_soc_codec *codec)
+{
+	u8 ncpctl, ldoctl, lppllctl, accctl;
+
+	ncpctl = twl6030_read_reg_cache(codec, TWL6030_REG_NCPCTL);
+	ldoctl = twl6030_read_reg_cache(codec, TWL6030_REG_LDOCTL);
+	lppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
+	accctl = twl6030_read_reg_cache(codec, TWL6030_REG_ACCCTL);
+
+	/* enable reference system */
+	ldoctl |= TWL6030_REFENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	mdelay(10);
+	/* enable internal oscillator */
+	ldoctl |= TWL6030_OSCENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	udelay(10);
+	/* enable high-side ldo */
+	ldoctl |= TWL6030_HSLDOENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	udelay(244);
+	/* enable negative charge pump */
+	ncpctl |= TWL6030_NCPENA | TWL6030_NCPOPEN;
+	twl6030_write(codec, TWL6030_REG_NCPCTL, ncpctl);
+	udelay(488);
+	/* enable low-side ldo */
+	ldoctl |= TWL6030_LSLDOENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	udelay(244);
+	/* enable low-power pll */
+	lppllctl |= TWL6030_LPLLENA;
+	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+	/* reset state machine */
+	accctl |= TWL6030_RESETSPLIT;
+	twl6030_write(codec, TWL6030_REG_ACCCTL, accctl);
+	mdelay(5);
+	accctl &= ~TWL6030_RESETSPLIT;
+	twl6030_write(codec, TWL6030_REG_ACCCTL, accctl);
+	/* disable internal oscillator */
+	ldoctl &= ~TWL6030_OSCENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+}
+
+/* twl6030 codec manual power-down sequence */
+static void twl6030_power_down(struct snd_soc_codec *codec)
+{
+	u8 ncpctl, ldoctl, lppllctl, accctl;
+
+	ncpctl = twl6030_read_reg_cache(codec, TWL6030_REG_NCPCTL);
+	ldoctl = twl6030_read_reg_cache(codec, TWL6030_REG_LDOCTL);
+	lppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
+	accctl = twl6030_read_reg_cache(codec, TWL6030_REG_ACCCTL);
+
+	/* enable internal oscillator */
+	ldoctl |= TWL6030_OSCENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	udelay(10);
+	/* disable low-power pll */
+	lppllctl &= ~TWL6030_LPLLENA;
+	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
+	/* disable low-side ldo */
+	ldoctl &= ~TWL6030_LSLDOENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	udelay(244);
+	/* disable negative charge pump */
+	ncpctl &= ~(TWL6030_NCPENA | TWL6030_NCPOPEN);
+	twl6030_write(codec, TWL6030_REG_NCPCTL, ncpctl);
+	udelay(488);
+	/* disable high-side ldo */
+	ldoctl &= ~TWL6030_HSLDOENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	udelay(244);
+	/* disable internal oscillator */
+	ldoctl &= ~TWL6030_OSCENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	/* disable reference system */
+	ldoctl &= ~TWL6030_REFENA;
+	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
+	mdelay(10);
+}
+
 /*
  * MICATT volume control:
  * from -6 to 0 dB in 6 dB steps
@@ -480,12 +562,15 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 
 			/* power-up sequence latency */
 			mdelay(16);
-		}
 
-		/* sync registers updated during power-up sequence */
-		twl6030_read(codec, TWL6030_REG_NCPCTL);
-		twl6030_read(codec, TWL6030_REG_LDOCTL);
-		twl6030_read(codec, TWL6030_REG_LPPLLCTL);
+			/* sync registers updated during power-up sequence */
+			twl6030_read(codec, TWL6030_REG_NCPCTL);
+			twl6030_read(codec, TWL6030_REG_LDOCTL);
+			twl6030_read(codec, TWL6030_REG_LPPLLCTL);
+		} else {
+			/* use manual power-up sequence */
+			twl6030_power_up(codec);
+		}
 
 		/* initialize vdd/vss registers with reg_cache */
 		twl6030_init_vdd_regs(codec);
@@ -502,12 +587,16 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 
 			/* power-down sequence latency */
 			udelay(500);
-		}
 
-		/* sync registers updated during power-down sequence */
-		twl6030_read(codec, TWL6030_REG_NCPCTL);
-		twl6030_read(codec, TWL6030_REG_LDOCTL);
-		twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL, 0x00);
+			/* sync registers updated during power-down sequence */
+			twl6030_read(codec, TWL6030_REG_NCPCTL);
+			twl6030_read(codec, TWL6030_REG_LDOCTL);
+			twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL,
+						0x00);
+		} else {
+			/* use manual power-down sequence */
+			twl6030_power_down(codec);
+		}
 
 		priv->codec_powered = 0;
 		break;
@@ -722,9 +811,6 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 			goto gpio2_err;
 
 		priv->codec_powered = 0;
-	} else {
-		/* if no gpio is provided, then assume its always on */
-		priv->codec_powered = 1;
 	}
 
 	/* init vio registers */
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index 7fba60e..81d25f6 100644
--- a/sound/soc/codecs/twl6030.h
+++ b/sound/soc/codecs/twl6030.h
@@ -67,6 +67,18 @@
 #define TWL6030_VIOREGNUM		18
 #define TWL6030_VDDREGNUM		21
 
+/* NCPCTL (0x05) fields */
+
+#define TWL6030_NCPENA			0x01
+#define TWL6030_NCPOPEN			0x40
+
+/* LDOCTL (0x06) fields */
+
+#define TWL6030_LSLDOENA		0x01
+#define TWL6030_HSLDOENA		0x04
+#define TWL6030_REFENA			0x40
+#define TWL6030_OSCENA			0x80
+
 /* HPPLLCTL (0x07) fields */
 
 #define TWL6030_HPLLENA			0x01
@@ -88,6 +100,10 @@
 #define TWL6030_LPLLFIN			0x08
 #define TWL6030_HPLLSEL			0x10
 
+/* ACCCTL (0x2D) fields */
+
+#define TWL6030_RESETSPLIT		0x04
+
 extern struct snd_soc_dai twl6030_dai;
 extern struct snd_soc_codec_device soc_codec_dev_twl6030;
 
-- 
1.6.1.3


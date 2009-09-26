From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv2 4/7] ASoC: TWL6030: Manual power-up/down sequences
Date: Fri, 25 Sep 2009 21:03:08 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A391E2@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40956 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978AbZIZCDL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:03:11 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

TWL6030 codec device can be powered-up/down through a specific
register writes sequence. These sequences can be used when no
gpio line is provided for AUDPWRON.

When the codec is powered-up in this way, automatic power-down
sequence (triggered by thermal shutdown) is not possible.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl6030.c |  117 +++++++++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/twl6030.h |   16 ++++++
 2 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index 92797e7..f1e333f 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -223,6 +223,88 @@ static void twl6030_init_vdd_regs(struct snd_soc_codec *codec)
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
@@ -460,12 +542,18 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 
 			/* power-up sequence latency */
 			mdelay(16);
-		}
 
-		/* sync registers updated during power-up sequence */
-		twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL, 0x81);
-		twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL, 0x45);
-		twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL, 0x01);
+			/* sync registers updated during power-up sequence */
+			twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL,
+						0x81);
+			twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL,
+						0x45);
+			twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL,
+						0x01);
+		} else {
+			/* use manual power-up sequence */
+			twl6030_power_up(codec);
+		}
 
 		/* initialize vdd/vss registers with reg_cache */
 		twl6030_init_vdd_regs(codec);
@@ -482,12 +570,18 @@ static int twl6030_set_bias_level(struct snd_soc_codec *codec,
 
 			/* power-down sequence latency */
 			udelay(500);
-		}
 
-		/* sync registers updated during power-down sequence */
-		twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL, 0x00);
-		twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL, 0x00);
-		twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL, 0x00);
+			/* sync registers updated during power-down sequence */
+			twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL,
+						0x00);
+			twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL,
+						0x00);
+			twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL,
+						0x00);
+		} else {
+			/* use manual power-down sequence */
+			twl6030_power_down(codec);
+		}
 
 		priv->codec_powered = 0;
 		break;
@@ -746,9 +840,6 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
 			goto gpio2_err;
 
 		priv->codec_powered = 0;
-	} else {
-		/* if no gpio is provided, then assume its always on */
-		priv->codec_powered = 1;
 	}
 
 	/* init vio registers */
diff --git a/sound/soc/codecs/twl6030.h b/sound/soc/codecs/twl6030.h
index d99d469..7375ae8 100644
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
1.5.4.3

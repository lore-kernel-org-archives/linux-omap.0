From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 2/5] ASoC: tlv320aic31xx: Add codec driver to Makefile and Kconfig
Date: Wed, 26 Feb 2014 11:14:26 +0200
Message-ID: <e5ddd051ac319649d50da0da804750c1c6619edb.1393405575.git.jsarha@ti.com>
References: <cover.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46513 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbaBZJOs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 04:14:48 -0500
In-Reply-To: <cover.1393405575.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/Kconfig  |    4 ++++
 sound/soc/codecs/Makefile |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 983d087a..ead9dc5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -74,6 +74,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC32X4 if I2C
+	select SND_SOC_TLV320AIC31XX if I2C
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -364,6 +365,9 @@ config SND_SOC_TLV320AIC26
 config SND_SOC_TLV320AIC32X4
 	tristate
 
+config SND_SOC_TLV320AIC31XX
+        tristate
+
 config SND_SOC_TLV320AIC3X
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bc12676..23f8042 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -64,6 +64,7 @@ snd-soc-stac9766-objs := stac9766.o
 snd-soc-tas5086-objs := tas5086.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
+snd-soc-tlv320aic31xx-objs := tlv320aic31xx.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320aic32x4-objs := tlv320aic32x4.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
@@ -194,6 +195,7 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
+obj-$(CONFIG_SND_SOC_TLV320AIC31XX)     += snd-soc-tlv320aic31xx.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     += snd-soc-tlv320aic32x4.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
-- 
1.7.9.5


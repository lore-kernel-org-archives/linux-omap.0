From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 1/2] ASoC: tlv320aic32x4: Sort Makefile in alphabetic order
Date: Fri, 7 Mar 2014 14:58:32 +0200
Message-ID: <63050ed5e0a7f696bb1719457301ca3601da18e7.1394195429.git.jsarha@ti.com>
References: <cover.1394195429.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45943 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbaCGM6u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 07:58:50 -0500
In-Reply-To: <cover.1394195429.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The tlv320aic32x4 related lines were wrongly placed after tlv320aic3x lines.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4c9b70a..90ab24b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -75,8 +75,8 @@ snd-soc-stac9766-objs := stac9766.o
 snd-soc-tas5086-objs := tas5086.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
-snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320aic32x4-objs := tlv320aic32x4.o
+snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
@@ -215,8 +215,8 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
-obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     += snd-soc-tlv320aic32x4.o
+obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
-- 
1.7.9.5


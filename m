From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 4/5] ASoC: davinci: HDMI audio build for AM33XX and TDA998x
Date: Tue, 16 Sep 2014 23:40:17 +0300
Message-ID: <270f1e048d9a5a17a7f367ecabc509475b8c1145.1410898073.git.jsarha@ti.com>
References: <cover.1410898073.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49302 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929AbaIPUke (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 16:40:34 -0400
In-Reply-To: <cover.1410898073.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com, Jyri Sarha <jsarha@ti.com>

Adds configuration option for HDMI audio support for AM33XX based
boards with NXP TDA998x HDMI transmitter. The audio is connected to
NXP TDA998x trough McASP running in i2s mode.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index d69510c..0c8f143 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -43,6 +43,18 @@ config SND_AM33XX_SOC_EVM
 	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
 	  setup.
 
+config SND_AM335X_SOC_NXPTDA_EVM
+	tristate "HDMI Audio for the AM33XX chip based boards with TDA998x"
+	depends on SND_EDMA_SOC && SOC_AM33XX && DRM_I2C_NXP_TDA998X
+	select SND_SOC_HDMI_CODEC
+	select SND_DAVINCI_SOC_MCASP
+	select SND_DAVINCI_SOC_GENERIC_EVM
+	help
+	  Say Y or M if you want to add support for HDMI SoC audio on
+	  AM33XX boards with NXP TDA998x HDMI transmitter. For example
+	  BeagleBoneBack. The audio is connected to NXP TDA998x trough
+	  McASP running in i2s mode.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC && I2C
-- 
1.7.9.5


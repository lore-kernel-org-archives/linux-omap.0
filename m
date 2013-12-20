From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 REPOST 5/8] ASoC: davinci: HDMI audio build for AM33XX and TDA998x
Date: Fri, 20 Dec 2013 12:40:54 +0200
Message-ID: <aa27717c56f024eb2f381fd5ee3fcd0938e7c0bd.1387535303.git.jsarha@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36356 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab3LTKlX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 05:41:23 -0500
In-Reply-To: <cover.1387535299.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, Jyri Sarha <jsarha@ti.com>

Adds configuration option for HDMI audio support for AM33XX based
boards with NXP TDA998x HDMI transmitter. The audio is connected to
NXP TDA998x trough McASP running in i2s mode.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig  |   12 ++++++++++++
 sound/soc/davinci/Makefile |    1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index a8ec1fc..40dd5d1 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -26,6 +26,18 @@ config SND_AM33XX_SOC_EVM
 	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
 	  setup.
 
+config SND_AM335X_SOC_NXPTDA_EVM
+	tristate "HDMI Audio for the AM33XX chip based boards with TDA998x"
+	depends on SND_DAVINCI_SOC && SOC_AM33XX
+	depends on DRM_TILCDC && DRM_I2C_NXP_TDA998X
+	select SND_SOC_HDMI_CODEC
+	select SND_DAVINCI_SOC_MCASP
+	help
+	  Say Y or M if you want to add support for HDMI SoC audio on
+	  AM33XX boards with NXP TDA998x HDMI transmitter. For example
+	  BeagleBoneBack. The audio is connected to NXP TDA998x trough
+	  McASP running in i2s mode.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 744d4d9..7587a70 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 snd-soc-evm-objs := davinci-evm.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_AM335X_SOC_NXPTDA_EVM) += snd-soc-evm.o
-- 
1.7.9.5


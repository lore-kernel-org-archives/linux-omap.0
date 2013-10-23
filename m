From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 1/4] ASoC: davinci: Add support for AM33xx SoC Audio
Date: Wed, 23 Oct 2013 15:30:13 +0300
Message-ID: <f1892d46be8790665faabc7e992abd43a020d4b1.1382529191.git.jsarha@ti.com>
References: <cover.1382529191.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54202 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab3JWMaa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Oct 2013 08:30:30 -0400
In-Reply-To: <cover.1382529191.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, joelf@ti.com, tony@atomide.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>, Jyri Sarha <jsarha@ti.com>

From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

AM33xx uses same McASP IP as the Davinci Platform. This patch updates
Kconfig and makefile to enable build for McASP, PCM & Codec drivers.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig  |   18 +++++++++++++++---
 sound/soc/davinci/Makefile |    1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index c82f89c..95970f5 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,9 +1,10 @@
 config SND_DAVINCI_SOC
-	tristate "SoC Audio for the TI DAVINCI chip"
-	depends on ARCH_DAVINCI
+	tristate "SoC Audio for the TI DAVINCI or AM33XX chip"
+	depends on ARCH_DAVINCI || SOC_AM33XX
 	help
+	  Platform driver for daVinci or AM33xx
 	  Say Y or M if you want to add support for codecs attached to
-	  the DAVINCI AC97 or I2S interface. You will also need
+	  the DAVINCI AC97, I2S, or McASP interface. You will also need
 	  to select the audio interfaces to support below.
 
 config SND_DAVINCI_SOC_I2S
@@ -15,6 +16,17 @@ config SND_DAVINCI_SOC_MCASP
 config SND_DAVINCI_SOC_VCIF
 	tristate
 
+config SND_AM33XX_SOC_EVM
+	tristate "SoC Audio for the AM33XX chip based boards"
+	depends on SND_DAVINCI_SOC && SOC_AM33XX
+	select SND_SOC_TLV320AIC3X
+	select SND_DAVINCI_SOC_MCASP
+	help
+	  Say Y or M if you want to add support for SoC audio on AM33XX
+	  boards using McASP and TLV320AIC3X codec. For example AM335X-EVM,
+	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
+	  setup.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a396ab6..bc81e79 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 snd-soc-evm-objs := davinci-evm.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_AM33XX_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA850_SOC_EVM) += snd-soc-evm.o
-- 
1.7.9.5


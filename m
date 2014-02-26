From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 5/5] ASoC: davinci: Add SND_AM43XX_SOC_EPOS_EVM build option
Date: Wed, 26 Feb 2014 11:14:29 +0200
Message-ID: <90589ff8a1aa2749caec44dc03ad7aa9c7c2fddc.1393405575.git.jsarha@ti.com>
References: <cover.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbaBZJOv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 04:14:51 -0500
In-Reply-To: <cover.1393405575.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Add support for am335x and am43x based boards with tlv320aic31xx
compatible codec connected to McASP.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig  |   12 ++++++++++++
 sound/soc/davinci/Makefile |    1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index a8ec1fc..e1e3663 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -26,6 +26,18 @@ config SND_AM33XX_SOC_EVM
 	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
 	  setup.
 
+config SND_AM43XX_SOC_EPOS_EVM
+	tristate "SoC Audio for the AM33XX/AM43XX and TLV320AIC31XX based board"
+	depends on SND_DAVINCI_SOC
+	depends on SOC_AM33XX || SOC_AM43XX
+	select SND_SOC_TLV320AIC31XX
+	select SND_DAVINCI_SOC_MCASP
+	help
+	  Say Y or M if you want to add support for SoC audio on
+	  AM335X/AM43XX boards using McASP to connect to a codec of
+	  TLV320AIC31XX series. For example AM43XX-EPOS-EVM has such a
+	  setup.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 744d4d9..d61998f 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 snd-soc-evm-objs := davinci-evm.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_AM43XX_SOC_EPOS_EVM) += snd-soc-evm.o
-- 
1.7.9.5


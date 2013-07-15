From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: omap: Enable COMPILE_TEST build for DT platforms
Date: Mon, 15 Jul 2013 16:57:56 +0100
Message-ID: <1373903876-26370-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:39836 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635Ab3GOP6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 11:58:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

The DT platforms don't have any source dependency on any OMAP stuff so
allow them to be built when COMPILE_TEST is enabled.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/omap/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 9f5d55e..68dfc0a 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,6 +1,6 @@
 config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
-	depends on ARCH_OMAP && DMA_OMAP
+	depends on (ARCH_OMAP && DMA_OMAP) || COMPILE_TEST
 	select SND_SOC_DMAENGINE_PCM
 
 config SND_OMAP_SOC_DMIC
@@ -26,7 +26,7 @@ config SND_OMAP_SOC_N810
 
 config SND_OMAP_SOC_RX51
 	tristate "SoC Audio support for Nokia RX-51"
-	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
+	depends on SND_OMAP_SOC && (MACH_NOKIA_RX51 || COMPILE_TEST)
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_TPA6130A2
@@ -87,7 +87,7 @@ config SND_OMAP_SOC_OMAP_TWL4030
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL6040_CORE && SND_OMAP_SOC && ARCH_OMAP4
+	depends on TWL6040_CORE && SND_OMAP_SOC && (ARCH_OMAP4 || COMPILE_TEST)
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
-- 
1.8.3.2


From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 01/12] ASoC: davinci: Fix AM33xx SoC Audio support
Date: Fri, 18 Oct 2013 18:37:40 +0300
Message-ID: <7289635e982532bb1a53865ae09cb7b17d866525.1382110089.git.jsarha@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37519 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab3JRPiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 11:38:05 -0400
In-Reply-To: <cover.1382110089.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Jyri Sarha <jsarha@ti.com>

SND_DAVINCI_SOC is a platform driver for Davinci and AM33XX SoCs, not
a machine driver. Make SND_AM33XX_SOC_EVM dependent of SND_DAVINCI_SOC
instead of selecting it and add dependecy to SOC_AM33XX.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6c8e687..95970f5 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -2,7 +2,7 @@ config SND_DAVINCI_SOC
 	tristate "SoC Audio for the TI DAVINCI or AM33XX chip"
 	depends on ARCH_DAVINCI || SOC_AM33XX
 	help
-	  Machine driver for DAVINCI audio.
+	  Platform driver for daVinci or AM33xx
 	  Say Y or M if you want to add support for codecs attached to
 	  the DAVINCI AC97, I2S, or McASP interface. You will also need
 	  to select the audio interfaces to support below.
@@ -18,7 +18,7 @@ config SND_DAVINCI_SOC_VCIF
 
 config SND_AM33XX_SOC_EVM
 	tristate "SoC Audio for the AM33XX chip based boards"
-	select SND_DAVINCI_SOC
+	depends on SND_DAVINCI_SOC && SOC_AM33XX
 	select SND_SOC_TLV320AIC3X
 	select SND_DAVINCI_SOC_MCASP
 	help
-- 
1.7.9.5


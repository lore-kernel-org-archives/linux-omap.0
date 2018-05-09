From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Convert to use the sdma-pcm
	instead of omap-pcm" to the asoc tree
Date: Wed,  9 May 2018 09:53:56 +0100 (BST)
Message-ID: <20180509085356.B8D6844007A@finisterre.ee.mobilebroadband>
References: <20180507085000.6414-7-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180507085000.6414-7-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap-mcbsp: Convert to use the sdma-pcm instead of omap-pcm

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 53126d737116c7e86aa6d979e6379d842c84c871 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 7 May 2018 11:49:59 +0300
Subject: [PATCH] ASoC: omap-mcbsp: Convert to use the sdma-pcm instead of
 omap-pcm

Use the new platform driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/Kconfig      | 14 +++++++-------
 sound/soc/omap/omap-mcbsp.c |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 9d20c9b94477..10a9ed6b1fd7 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -29,7 +29,7 @@ config SND_OMAP_SOC_HDMI_AUDIO
 
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
-	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
+	depends on SND_SDMA_SOC && MACH_NOKIA_N810 && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	help
@@ -37,7 +37,7 @@ config SND_OMAP_SOC_N810
 
 config SND_OMAP_SOC_RX51
 	tristate "SoC Audio support for Nokia N900 (RX-51)"
-	depends on SND_OMAP_SOC && ARM && I2C
+	depends on SND_SDMA_SOC && ARM && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_TPA6130A2
@@ -48,7 +48,7 @@ config SND_OMAP_SOC_RX51
 
 config SND_OMAP_SOC_AMS_DELTA
 	tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
-	depends on SND_OMAP_SOC && MACH_AMS_DELTA && TTY
+	depends on SND_SDMA_SOC && MACH_AMS_DELTA && TTY
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_CX20442
 	help
@@ -67,7 +67,7 @@ config SND_OMAP_SOC_AMS_DELTA
 
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
-	depends on SND_OMAP_SOC && MACH_OMAP_OSK && I2C
+	depends on SND_SDMA_SOC && MACH_OMAP_OSK && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC23_I2C
 	help
@@ -75,7 +75,7 @@ config SND_OMAP_SOC_OSK5912
 
 config SND_OMAP_SOC_AM3517EVM
 	tristate "SoC Audio support for OMAP3517 / AM3517 EVM"
-	depends on SND_OMAP_SOC && MACH_OMAP3517EVM && I2C
+	depends on SND_SDMA_SOC && MACH_OMAP3517EVM && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC23_I2C
 	help
@@ -84,7 +84,7 @@ config SND_OMAP_SOC_AM3517EVM
 
 config SND_OMAP_SOC_OMAP_TWL4030
 	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
-	depends on TWL4030_CORE && SND_OMAP_SOC
+	depends on TWL4030_CORE && SND_SDMA_SOC
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
@@ -117,7 +117,7 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 
 config SND_OMAP_SOC_OMAP3_PANDORA
 	tristate "SoC Audio support for OMAP3 Pandora"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
+	depends on TWL4030_CORE && SND_SDMA_SOC && MACH_OMAP3_PANDORA
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6b40bdbef336..d0ebb6b9bfac 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -34,11 +34,11 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <sound/omap-pcm.h>
 
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
+#include "sdma-pcm.h"
 
 #define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
 
@@ -868,7 +868,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return omap_pcm_platform_register(&pdev->dev);
+	return sdma_pcm_platform_register(&pdev->dev, NULL, NULL);
 }
 
 static int asoc_mcbsp_remove(struct platform_device *pdev)
-- 
2.17.0

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 6/7] ASoC: omap-mcbsp: Convert to use the
	sdma-pcm instead of omap-pcm
Date: Mon, 7 May 2018 11:49:59 +0300
Message-ID: <20180507085000.6414-7-peter.ujfalusi@ti.com>
References: <20180507085000.6414-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180507085000.6414-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Use the new platform driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/Kconfig      | 14 +++++++-------
 sound/soc/omap/omap-mcbsp.c |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 292e53cfc02b..a8319aaba97d 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -35,7 +35,7 @@ config SND_OMAP_SOC_HDMI_AUDIO
 
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
-	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
+	depends on SND_SDMA_SOC && MACH_NOKIA_N810 && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	help
@@ -43,7 +43,7 @@ config SND_OMAP_SOC_N810
 
 config SND_OMAP_SOC_RX51
 	tristate "SoC Audio support for Nokia N900 (RX-51)"
-	depends on SND_OMAP_SOC && ARM && I2C
+	depends on SND_SDMA_SOC && ARM && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_TPA6130A2
@@ -54,7 +54,7 @@ config SND_OMAP_SOC_RX51
 
 config SND_OMAP_SOC_AMS_DELTA
 	tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
-	depends on SND_OMAP_SOC && MACH_AMS_DELTA && TTY
+	depends on SND_SDMA_SOC && MACH_AMS_DELTA && TTY
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_CX20442
 	help
@@ -73,7 +73,7 @@ config SND_OMAP_SOC_AMS_DELTA
 
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
-	depends on SND_OMAP_SOC && MACH_OMAP_OSK && I2C
+	depends on SND_SDMA_SOC && MACH_OMAP_OSK && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC23_I2C
 	help
@@ -81,7 +81,7 @@ config SND_OMAP_SOC_OSK5912
 
 config SND_OMAP_SOC_AM3517EVM
 	tristate "SoC Audio support for OMAP3517 / AM3517 EVM"
-	depends on SND_OMAP_SOC && MACH_OMAP3517EVM && I2C
+	depends on SND_SDMA_SOC && MACH_OMAP3517EVM && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC23_I2C
 	help
@@ -90,7 +90,7 @@ config SND_OMAP_SOC_AM3517EVM
 
 config SND_OMAP_SOC_OMAP_TWL4030
 	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
-	depends on TWL4030_CORE && SND_OMAP_SOC
+	depends on TWL4030_CORE && SND_SDMA_SOC
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
@@ -123,7 +123,7 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 
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
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

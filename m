From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 5/7] ASoC: omap-mcpdm: Convert to use the
	sdma-pcm instead of omap-pcm
Date: Mon, 7 May 2018 11:49:58 +0300
Message-ID: <20180507085000.6414-6-peter.ujfalusi@ti.com>
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
 sound/soc/omap/Kconfig      | 2 +-
 sound/soc/omap/omap-mcpdm.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 9ecc1d336396..292e53cfc02b 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -105,7 +105,7 @@ config SND_OMAP_SOC_OMAP_TWL4030
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL6040_CORE && SND_OMAP_SOC && SND_SDMA_SOC && COMMON_CLK
+	depends on TWL6040_CORE && SND_SDMA_SOC && COMMON_CLK
 	depends on ARCH_OMAP4 || (SOC_OMAP5 && MFD_PALMAS) || COMPILE_TEST
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 04f4f3cb0f46..3f3e7c4ee175 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -41,9 +41,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <sound/omap-pcm.h>
 
 #include "omap-mcpdm.h"
+#include "sdma-pcm.h"
 
 struct mcpdm_link_config {
 	u32 link_mask; /* channel mask for the direction */
@@ -565,7 +565,7 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return omap_pcm_platform_register(&pdev->dev);
+	return sdma_pcm_platform_register(&pdev->dev, "dn_link", "up_link");
 }
 
 static const struct of_device_id omap_mcpdm_of_match[] = {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/7] ASoC: davinci-mcasp: Convert to use the
	sdma-pcm instead of omap-pcm
Date: Mon, 30 Apr 2018 14:19:53 +0300
Message-ID: <20180430111958.31289-3-peter.ujfalusi@ti.com>
References: <20180430111958.31289-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430111958.31289-1-peter.ujfalusi@ti.com>
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

Use the new platform driver in case of sDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig         | 2 +-
 sound/soc/davinci/davinci-mcasp.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 21bf301ba87a..792b75a25951 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -24,7 +24,7 @@ config SND_DAVINCI_SOC_I2S
 
 config SND_DAVINCI_SOC_MCASP
 	tristate "TI Multichannel Audio Serial Port (McASP) support"
-	depends on SND_OMAP_SOC || SND_EDMA_SOC
+	depends on SND_SDMA_SOC || SND_EDMA_SOC
 	help
 	  Say Y or M here if you want to have support for McASP IP found in
 	  various Texas Instruments SoCs like:
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ba4da45902b8..90edd5a6880c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -36,10 +36,10 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <sound/omap-pcm.h>
 #include <dt-bindings/sound/ti-mcasp.h>
 
 #include "edma-pcm.h"
+#include "../omap/sdma-pcm.h"
 #include "davinci-mcasp.h"
 
 #define MCASP_MAX_AFIFO_DEPTH	64
@@ -2069,10 +2069,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 #endif
 		break;
 	case PCM_SDMA:
-#if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
+#if IS_BUILTIN(CONFIG_SND_SDMA_SOC) || \
 	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
-	 IS_MODULE(CONFIG_SND_OMAP_SOC))
-		ret = omap_pcm_platform_register(&pdev->dev);
+	 IS_MODULE(CONFIG_SND_SDMA_SOC))
+		ret = sdma_pcm_platform_register(&pdev->dev, NULL, NULL);
 #else
 		dev_err(&pdev->dev, "Missing SND_SDMA_SOC\n");
 		ret = -EINVAL;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

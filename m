From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Convert to use the
	sdma-pcm instead of omap-pcm" to the asoc tree
Date: Fri, 11 May 2018 03:38:51 +0100 (BST)
Message-ID: <20180511023851.CAA1A44007A@finisterre.ee.mobilebroadband>
References: <20180509110356.26473-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180509110356.26473-2-peter.ujfalusi@ti.com>
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

   ASoC: davinci-mcasp: Convert to use the sdma-pcm instead of omap-pcm

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

>From 077a403d86207080a32b5e5d60e33ee0cb628cf6 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 9 May 2018 14:03:55 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Convert to use the sdma-pcm instead of
 omap-pcm

Use the new platform driver in case of sDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/Kconfig         | 2 +-
 sound/soc/davinci/davinci-mcasp.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6b732d8e5896..778faff28e0e 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -24,7 +24,7 @@ config SND_DAVINCI_SOC_I2S
 
 config SND_DAVINCI_SOC_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
-	depends on SND_OMAP_SOC || SND_EDMA_SOC
+	depends on SND_SDMA_SOC || SND_EDMA_SOC
 	help
 	  Say Y or M here if you want to have support for McASP IP found in
 	  various Texas Instruments SoCs like:
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 03ba218160ca..79fc4aa2fa29 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -36,9 +36,9 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <sound/omap-pcm.h>
 
 #include "edma-pcm.h"
+#include "../omap/sdma-pcm.h"
 #include "davinci-mcasp.h"
 
 #define MCASP_MAX_AFIFO_DEPTH	64
@@ -2048,10 +2048,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
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
2.17.0

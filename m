From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: remove compat dma probing" to the asoc tree
Date: Wed, 13 Mar 2019 15:38:44 +0000 (GMT)
Message-ID: <20190313153844.311A31128B98@debutante.sirena.org.uk>
References: <20190307151646.1016966-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307151646.1016966-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.orgPeter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: ti: remove compat dma probing

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

>From 642aafea8889b712fe8e57aaa706d6c05d295059 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Mar 2019 16:16:08 +0100
Subject: [PATCH] ASoC: ti: remove compat dma probing

After running into a link error:

sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'

I checked all users of this, and they have new-style 'dma_slave_map' tables,
so none of them should still need it. Removing the associated lines
simplifies the code and avoids the build-time dependency on the
respective dmaengine drivers.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/edma-pcm.c | 5 +----
 sound/soc/ti/sdma-pcm.c | 9 +++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/ti/edma-pcm.c b/sound/soc/ti/edma-pcm.c
index 59e588abe54b..fdffb801b185 100644
--- a/sound/soc/ti/edma-pcm.c
+++ b/sound/soc/ti/edma-pcm.c
@@ -23,7 +23,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/edma.h>
 
 #include "edma-pcm.h"
 
@@ -43,14 +42,12 @@ static const struct snd_pcm_hardware edma_pcm_hardware = {
 static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
 	.pcm_hardware = &edma_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = edma_filter_fn,
 	.prealloc_buffer_size = 128 * 1024,
 };
 
 int edma_pcm_platform_register(struct device *dev)
 {
-	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config,
-					SND_DMAENGINE_PCM_FLAG_COMPAT);
+	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL_GPL(edma_pcm_platform_register);
 
diff --git a/sound/soc/ti/sdma-pcm.c b/sound/soc/ti/sdma-pcm.c
index 21a9c2499d48..a236350beb10 100644
--- a/sound/soc/ti/sdma-pcm.c
+++ b/sound/soc/ti/sdma-pcm.c
@@ -11,7 +11,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/omap-dmaengine.h>
 
 #include "sdma-pcm.h"
 
@@ -31,7 +30,6 @@ static const struct snd_pcm_hardware sdma_pcm_hardware = {
 static const struct snd_dmaengine_pcm_config sdma_dmaengine_pcm_config = {
 	.pcm_hardware = &sdma_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = omap_dma_filter_fn,
 	.prealloc_buffer_size = 128 * 1024,
 };
 
@@ -39,13 +37,12 @@ int sdma_pcm_platform_register(struct device *dev,
 			       char *txdmachan, char *rxdmachan)
 {
 	struct snd_dmaengine_pcm_config *config;
-	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
+	unsigned int flags = 0;
 
 	/* Standard names for the directions: 'tx' and 'rx' */
 	if (!txdmachan && !rxdmachan)
 		return devm_snd_dmaengine_pcm_register(dev,
-						&sdma_dmaengine_pcm_config,
-						flags);
+						&sdma_dmaengine_pcm_config, 0);
 
 	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
 	if (!config)
@@ -65,7 +62,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	config->chan_names[0] = txdmachan;
 	config->chan_names[1] = rxdmachan;
 
-	return devm_snd_dmaengine_pcm_register(dev, config, flags);
+	return devm_snd_dmaengine_pcm_register(dev, config, 0);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
 
-- 
2.20.1

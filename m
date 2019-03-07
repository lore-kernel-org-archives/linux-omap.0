From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] ASoC: ti: remove compat dma probing
Date: Thu,  7 Mar 2019 16:16:08 +0100
Message-ID: <20190307151646.1016966-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

After running into a link error:

sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'

I checked all users of this, and they have new-style 'dma_slave_map' tables,
so none of them should still need it. Removing the associated lines
simplifies the code and avoids the build-time dependency on the
respective dmaengine drivers.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove header inclusions as well

I added the two dmaengine patches to the series this time, but
we probably want to have those merged separately through the
dmaengine tree, while this one should get merged as a bugfix
through ASoC.
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
2.20.0

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/7] ASoC: omap: Introduce the
	generic_dmaengine_pcm based sdma-pcm
Date: Wed, 25 Apr 2018 09:18:31 +0300
Message-ID: <20180425061837.14145-2-peter.ujfalusi@ti.com>
References: <20180425061837.14145-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180425061837.14145-1-peter.ujfalusi@ti.com>
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

With the generic dmaengine_pcm support the omap-cpm can be replaced with a
much smaller wrapper.

CPU DAI drivers can use the:
int sdma_pcm_platform_register(struct device *dev,
			       char *txdmachan, char *rxdmachan);

To register the platform driver, txdmachan/rxdmachan is only needed to be
provided if the DMA channel names are not standard tx/rx, like in case of
McPDM, or the DAI is only capable of one audio direction (DMIC, HDMI).

This patch only introduces the source file and changes to the
Kconfig/Makefile, but does not change any of the DAI drivers to use it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig    |  6 ++++
 sound/soc/omap/Makefile   |  2 ++
 sound/soc/omap/sdma-pcm.c | 68 +++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/sdma-pcm.h | 21 ++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 sound/soc/omap/sdma-pcm.c
 create mode 100644 sound/soc/omap/sdma-pcm.h

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index ba56d71c3ca7..656031401d58 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -2,6 +2,12 @@ config SND_OMAP_SOC
 	tristate "SoC Audio for Texas Instruments OMAP chips"
 	depends on (ARCH_OMAP && DMA_OMAP) || (ARM && COMPILE_TEST)
 	select SND_DMAENGINE_PCM
+	select SND_SDMA_SOC
+
+config SND_SDMA_SOC
+	tristate "SoC Audio for Texas Instruments chips using sDMA"
+	depends on DMA_OMAP
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_OMAP_SOC_DMIC
 	tristate "TI Digital Microphone Module (DMIC) support"
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index a6785dc4fc90..0619a5b3bd9f 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,12 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 # OMAP Platform Support
 snd-soc-omap-objs := omap-pcm.o
+snd-soc-sdma-objs := sdma-pcm.o
 snd-soc-omap-dmic-objs := omap-dmic.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 snd-soc-omap-hdmi-audio-objs := omap-hdmi-audio.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
+obj-$(CONFIG_SND_SDMA_SOC) += snd-soc-sdma.o
 obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
diff --git a/sound/soc/omap/sdma-pcm.c b/sound/soc/omap/sdma-pcm.c
new file mode 100644
index 000000000000..f7b2b5b69d27
--- /dev/null
+++ b/sound/soc/omap/sdma-pcm.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ */
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+#include <linux/omap-dma.h>
+
+#include "sdma-pcm.h"
+
+static const struct snd_pcm_hardware sdma_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP |
+				  SNDRV_PCM_INFO_INTERLEAVED,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 64 * 1024,
+	.buffer_bytes_max	= 128 * 1024,
+	.periods_min		= 2,
+	.periods_max		= 255,
+};
+
+static const struct snd_dmaengine_pcm_config sdma_dmaengine_pcm_config = {
+	.pcm_hardware = &sdma_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.compat_filter_fn = omap_dma_filter_fn,
+	.prealloc_buffer_size = 128 * 1024,
+};
+
+int sdma_pcm_platform_register(struct device *dev,
+			       char *txdmachan, char *rxdmachan)
+{
+	struct snd_dmaengine_pcm_config *config;
+	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
+
+	/* Standard names for the directions: 'tx' and 'rx' */
+	if (!txdmachan && !rxdmachan)
+		return devm_snd_dmaengine_pcm_register(dev,
+						&sdma_dmaengine_pcm_config,
+						flags);
+
+	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	*config = sdma_dmaengine_pcm_config;
+
+	if (!txdmachan || !rxdmachan) {
+		/* One direction only PCM */
+		flags |= SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX;
+		if (!txdmachan) {
+			txdmachan = rxdmachan;
+			rxdmachan = NULL;
+		}
+	}
+
+	config->chan_names[0] = txdmachan;
+	config->chan_names[1] = rxdmachan;
+
+	return devm_snd_dmaengine_pcm_register(dev, config, flags);
+}
+EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
diff --git a/sound/soc/omap/sdma-pcm.h b/sound/soc/omap/sdma-pcm.h
new file mode 100644
index 000000000000..ce13edfc52d8
--- /dev/null
+++ b/sound/soc/omap/sdma-pcm.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ */
+
+#ifndef __SDMA_PCM_H__
+#define __SDMA_PCM_H__
+
+#if IS_ENABLED(CONFIG_SND_SDMA_SOC)
+int sdma_pcm_platform_register(struct device *dev,
+			       char *txdmachan, char *rxdmachan);
+#else
+static inline int sdma_pcm_platform_register(struct device *dev,
+					     char *txdmachan, char *rxdmachan)
+{
+	return 0;
+}
+#endif /* CONFIG_SND_SDMA_SOC */
+
+#endif /* __SDMA_PCM_H__ */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

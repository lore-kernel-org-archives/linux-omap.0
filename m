From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCH 3/3] ASoC: OMAP4: Add McPDM platform driver
Date: Thu, 17 Dec 2009 13:40:33 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D3@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45273 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965471AbZLQTkl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 14:40:41 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

McPDM platform driver is configured to use sDMA in order to transfer
to/from memory. Support for interfacing with ABE will be added later.

McPDM dai currently supports up to 4 downlink channels and 2 uplink
channels simultaneously, as well as 88.2 and 96 KHz, and a sample
size of 32 bits.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Margarita Olaya <x0080101@ti.com>
Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 sound/soc/omap/Makefile     |    2 +-
 sound/soc/omap/omap-mcpdm.c |  248 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-mcpdm.h |   29 +++++
 3 files changed, 278 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/omap/omap-mcpdm.c
 create mode 100644 sound/soc/omap/omap-mcpdm.h

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index bf8b388..d6382fa 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,7 +1,7 @@
 # OMAP Platform Support
 snd-soc-omap-objs := omap-pcm.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o
-snd-soc-omap-mcpdm-objs := mcpdm.o
+snd-soc-omap-mcpdm-objs := mcpdm.o omap-mcpdm.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
new file mode 100644
index 0000000..9dc0ff5
--- /dev/null
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -0,0 +1,248 @@
+/*
+ * omap-mcpdm.c  --  OMAP ALSA SoC DAI driver using McPDM port
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * Author: Misael Lopez Cruz <x0052729@ti.com>
+ * Contact: Jorge Eduardo Candelaria <x0107209@ti.com>
+ *          Margarita Olaya <magi.olaya@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <mach/control.h>
+#include <mach/dma.h>
+#include <mach/mcbsp.h>
+#include "mcpdm.h"
+#include "omap-mcpdm.h"
+#include "omap-pcm.h"
+
+struct omap_mcpdm_data {
+	struct omap_mcpdm_link *links;
+	int active;
+};
+
+static struct omap_mcpdm_link omap_mcpdm_links[] = {
+	/* downlink */
+	{
+		.irq_mask = DN_IRQ_EMTPY | DN_IRQ_FULL,
+		.threshold = 1,
+		.format = PDMOUTFORMAT_LJUST,
+	},
+	/* uplink */
+	{
+		.irq_mask = UP_IRQ_EMPTY | UP_IRQ_FULL,
+		.threshold = 1,
+		.format = PDMOUTFORMAT_LJUST,
+	},
+};
+
+static struct omap_mcpdm_data mcpdm_data = {
+	.links = omap_mcpdm_links,
+	.active = 0,
+};
+
+/*
+ * Stream DMA parameters
+ */
+static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
+	{
+		.name = "Audio downlink",
+		.dma_req = OMAP44XX_DMA_MCPDM_DL,
+		.data_type = OMAP_DMA_DATA_TYPE_S32,
+		.sync_mode = OMAP_DMA_SYNC_ELEMENT,
+		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_DN_DATA,
+	},
+	{
+		.name = "Audio uplink",
+		.dma_req = OMAP44XX_DMA_MCPDM_UP,
+		.data_type = OMAP_DMA_DATA_TYPE_S32,
+		.sync_mode = OMAP_DMA_SYNC_ELEMENT,
+		.port_addr = OMAP44XX_MCPDM_BASE + MCPDM_UP_DATA,
+	},
+};
+
+static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int err = 0;
+
+	if (!cpu_dai->active)
+		err = omap_mcpdm_request();
+
+	return err;
+}
+
+static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	if (!cpu_dai->active)
+		omap_mcpdm_free();
+}
+
+static int omap_mcpdm_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct omap_mcpdm_data *mcpdm_priv = cpu_dai->private_data;
+	int stream = substream->stream;
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (!mcpdm_priv->active++)
+			omap_mcpdm_start(stream);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (!--mcpdm_priv->active)
+			omap_mcpdm_stop(stream);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct omap_mcpdm_data *mcpdm_priv = cpu_dai->private_data;
+	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
+	int stream = substream->stream;
+	int channels, err, link_mask = 0;
+
+	cpu_dai->dma_data = &omap_mcpdm_dai_dma_params[stream];
+
+	channels = params_channels(params);
+	switch (channels) {
+	case 4:
+		if (stream)
+			/* up to 2 channels for uplink */
+			return -EINVAL;
+		link_mask |= 1 << 3;
+	case 3:
+		if (stream)
+			/* up to 2 channels for uplink */
+			return -EINVAL;
+		link_mask |= 1 << 2;
+	case 2:
+		link_mask |= 1 << 1;
+	case 1:
+		link_mask |= 1 << 0;
+		break;
+	default:
+		/* unsupported number of channels */
+		return -EINVAL;
+	}
+
+	if (stream) {
+		mcpdm_links[stream].channels = link_mask << 0;
+		err = omap_mcpdm_set_uplink(&mcpdm_links[stream]);
+	} else {
+		mcpdm_links[stream].channels = link_mask << 3;
+		err = omap_mcpdm_set_downlink(&mcpdm_links[stream]);
+	}
+
+	return err;
+}
+
+static int omap_mcpdm_dai_hw_free(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct omap_mcpdm_data *mcpdm_priv = cpu_dai->private_data;
+	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
+	int err;
+
+	if (substream->stream)
+		err = omap_mcpdm_clr_uplink(&mcpdm_links[substream->stream]);
+	else
+		err = omap_mcpdm_clr_downlink(&mcpdm_links[substream->stream]);
+
+	return err;
+}
+
+static struct snd_soc_dai_ops omap_mcpdm_dai_ops = {
+	.startup	= omap_mcpdm_dai_startup,
+	.shutdown	= omap_mcpdm_dai_shutdown,
+	.trigger	= omap_mcpdm_dai_trigger,
+	.hw_params	= omap_mcpdm_dai_hw_params,
+	.hw_free	= omap_mcpdm_dai_hw_free,
+};
+
+#define OMAP_MCPDM_RATES	(SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+#define OMAP_MCPDM_FORMATS	(SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai omap_mcpdm_dai = {
+	.name = "omap-mcpdm",
+	.id = -1,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 4,
+		.rates = OMAP_MCPDM_RATES,
+		.formats = OMAP_MCPDM_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = OMAP_MCPDM_RATES,
+		.formats = OMAP_MCPDM_FORMATS,
+	},
+	.ops = &omap_mcpdm_dai_ops,
+	.private_data = &mcpdm_data,
+};
+EXPORT_SYMBOL_GPL(omap_mcpdm_dai);
+
+static int __init snd_omap_mcpdm_init(void)
+{
+	return snd_soc_register_dai(&omap_mcpdm_dai);
+}
+module_init(snd_omap_mcpdm_init);
+
+static void __exit snd_omap_mcpdm_exit(void)
+{
+	snd_soc_unregister_dai(&omap_mcpdm_dai);
+}
+module_exit(snd_omap_mcpdm_exit);
+
+MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
+MODULE_DESCRIPTION("OMAP PDM SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap-mcpdm.h b/sound/soc/omap/omap-mcpdm.h
new file mode 100644
index 0000000..73b80d5
--- /dev/null
+++ b/sound/soc/omap/omap-mcpdm.h
@@ -0,0 +1,29 @@
+/*
+ * omap-mcpdm.h
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * Contact: Misael Lopez Cruz <x0052729@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __OMAP_MCPDM_H__
+#define __OMAP_MCPDM_H__
+
+extern struct snd_soc_dai omap_mcpdm_dai;
+
+#endif	/* End of __OMAP_MCPDM_H__ */
-- 
1.6.0.4
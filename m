From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 7/7] ASoC: omap: Delete the obsolete omap-pcm
Date: Mon, 30 Apr 2018 09:57:48 +0300
Message-ID: <20180430065748.3393-8-peter.ujfalusi@ti.com>
References: <20180430065748.3393-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430065748.3393-1-peter.ujfalusi@ti.com>
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

All DAI drivers are now using the new sdma-pcm platform driver. The
omap-pcm can be removed from the tree, but we need to keep the SND_OMAP_SOC
Kconfig option until the relevant defconfigs are updated to avoid
regression due to missing audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/omap-pcm.h  |  30 -----
 sound/soc/omap/Kconfig    |   3 +-
 sound/soc/omap/Makefile   |   2 -
 sound/soc/omap/omap-pcm.c | 262 --------------------------------------
 4 files changed, 1 insertion(+), 296 deletions(-)
 delete mode 100644 include/sound/omap-pcm.h
 delete mode 100644 sound/soc/omap/omap-pcm.c

diff --git a/include/sound/omap-pcm.h b/include/sound/omap-pcm.h
deleted file mode 100644
index c1d2f31d71e9..000000000000
--- a/include/sound/omap-pcm.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * omap-pcm.h - OMAP PCM driver
- *
- * Copyright (C) 2014 Texas Instruments, Inc.
- *
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-
-#ifndef __OMAP_PCM_H__
-#define __OMAP_PCM_H__
-
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC)
-int omap_pcm_platform_register(struct device *dev);
-#else
-static inline int omap_pcm_platform_register(struct device *dev)
-{
-	return 0;
-}
-#endif /* CONFIG_SND_OMAP_SOC */
-
-#endif /* __OMAP_PCM_H__ */
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 4ee7f9e25d71..03f4f4f8a17e 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,7 +1,6 @@
 config SND_OMAP_SOC
-	tristate "SoC Audio for Texas Instruments OMAP chips"
+	tristate "SoC Audio for Texas Instruments OMAP chips (deprecated)"
 	depends on (ARCH_OMAP && DMA_OMAP) || (ARM && COMPILE_TEST)
-	select SND_DMAENGINE_PCM
 	select SND_SDMA_SOC
 
 config SND_SDMA_SOC
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 0619a5b3bd9f..53eba3413485 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,13 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # OMAP Platform Support
-snd-soc-omap-objs := omap-pcm.o
 snd-soc-sdma-objs := sdma-pcm.o
 snd-soc-omap-dmic-objs := omap-dmic.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 snd-soc-omap-hdmi-audio-objs := omap-hdmi-audio.o
 
-obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
 obj-$(CONFIG_SND_SDMA_SOC) += snd-soc-sdma.o
 obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
deleted file mode 100644
index 778cc8f75b6a..000000000000
--- a/sound/soc/omap/omap-pcm.c
+++ /dev/null
@@ -1,262 +0,0 @@
-/*
- * omap-pcm.c  --  ALSA PCM interface for the OMAP SoC
- *
- * Copyright (C) 2008 Nokia Corporation
- *
- * Contact: Jarkko Nikula <jarkko.nikula@bitmer.com>
- *          Peter Ujfalusi <peter.ujfalusi@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/omap-dma.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/dmaengine_pcm.h>
-#include <sound/soc.h>
-#include <sound/omap-pcm.h>
-
-#ifdef CONFIG_ARCH_OMAP1
-#define pcm_omap1510()	cpu_is_omap1510()
-#else
-#define pcm_omap1510()	0
-#endif
-
-static struct snd_pcm_hardware omap_pcm_hardware = {
-	.info			= SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_INTERLEAVED |
-				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME |
-				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
-	.period_bytes_min	= 32,
-	.period_bytes_max	= 64 * 1024,
-	.periods_min		= 2,
-	.periods_max		= 255,
-	.buffer_bytes_max	= 128 * 1024,
-};
-
-/* sDMA supports only 1, 2, and 4 byte transfer elements. */
-static void omap_pcm_limit_supported_formats(void)
-{
-	int i;
-
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		switch (snd_pcm_format_physical_width(i)) {
-		case 8:
-		case 16:
-		case 32:
-			omap_pcm_hardware.formats |= (1LL << i);
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-/* this may get called several times by oss emulation */
-static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct omap_pcm_dma_data *dma_data;
-	struct dma_slave_config config;
-	struct dma_chan *chan;
-	int err = 0;
-
-	memset(&config, 0x00, sizeof(config));
-
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!dma_data)
-		return 0;
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = params_buffer_bytes(params);
-
-	chan = snd_dmaengine_pcm_get_chan(substream);
-	if (!chan)
-		return -EINVAL;
-
-	/* fills in addr_width and direction */
-	err = snd_hwparams_to_dma_slave_config(substream, params, &config);
-	if (err)
-		return err;
-
-	snd_dmaengine_pcm_set_config_from_dai_data(substream,
-			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
-			&config);
-
-	return dmaengine_slave_config(chan, &config);
-}
-
-static int omap_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_set_runtime_buffer(substream, NULL);
-	return 0;
-}
-
-static snd_pcm_uframes_t omap_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	snd_pcm_uframes_t offset;
-
-	if (pcm_omap1510())
-		offset = snd_dmaengine_pcm_pointer_no_residue(substream);
-	else
-		offset = snd_dmaengine_pcm_pointer(substream);
-
-	return offset;
-}
-
-static int omap_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_dmaengine_dai_dma_data *dma_data;
-	int ret;
-
-	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
-
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	/* DT boot: filter_data is the DMA name */
-	if (rtd->cpu_dai->dev->of_node) {
-		struct dma_chan *chan;
-
-		chan = dma_request_slave_channel(rtd->cpu_dai->dev,
-						 dma_data->filter_data);
-		ret = snd_dmaengine_pcm_open(substream, chan);
-	} else {
-		ret = snd_dmaengine_pcm_open_request_chan(substream,
-							  omap_dma_filter_fn,
-							  dma_data->filter_data);
-	}
-	return ret;
-}
-
-static int omap_pcm_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
-			   runtime->dma_addr, runtime->dma_bytes);
-}
-
-static const struct snd_pcm_ops omap_pcm_ops = {
-	.open		= omap_pcm_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= omap_pcm_hw_params,
-	.hw_free	= omap_pcm_hw_free,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= omap_pcm_pointer,
-	.mmap		= omap_pcm_mmap,
-};
-
-static int omap_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
-	int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = omap_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_wc(pcm->card->dev, size, &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-
-	buf->bytes = size;
-	return 0;
-}
-
-static void omap_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-
-		dma_free_wc(pcm->card->dev, buf->bytes, buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
-static int omap_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret;
-
-	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = omap_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = omap_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
-
-out:
-	/* free preallocated buffers in case of error */
-	if (ret)
-		omap_pcm_free_dma_buffers(pcm);
-
-	return ret;
-}
-
-static const struct snd_soc_component_driver omap_soc_component = {
-	.ops		= &omap_pcm_ops,
-	.pcm_new	= omap_pcm_new,
-	.pcm_free	= omap_pcm_free_dma_buffers,
-};
-
-int omap_pcm_platform_register(struct device *dev)
-{
-	omap_pcm_limit_supported_formats();
-	return devm_snd_soc_register_component(dev, &omap_soc_component,
-					       NULL, 0);
-}
-EXPORT_SYMBOL_GPL(omap_pcm_platform_register);
-
-MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
-MODULE_DESCRIPTION("OMAP PCM DMA module");
-MODULE_LICENSE("GPL");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

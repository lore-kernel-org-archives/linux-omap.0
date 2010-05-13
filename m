From: Sergey Lapin <slapin@ossfans.org>
Subject: [PATCH] OMAP: McBSP: Add 32-bit mode support
Date: Thu, 13 May 2010 19:24:08 +0400
Message-ID: <1273764248-14043-1-git-send-email-slapin@ossfans.org>
References: <1273757957-7299-1-git-send-email-slapin@ossfans.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from build.ossfans.org ([67.223.233.67]:57309 "EHLO
	build.ossfans.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab0EMPZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 11:25:00 -0400
In-Reply-To: <1273757957-7299-1-git-send-email-slapin@ossfans.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Sergey Lapin <slapin@ossfans.org>

This patchs should allow to use 32-bit samples on e.g. TLV320AIC3x codec,
or others.

Signed-off-by: Sergey Lapin <slapin@ossfans.org>

---
 sound/soc/omap/omap-mcbsp.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8ad9dc9..a875d5d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -295,8 +295,20 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
 	omap_mcbsp_dai_dma_params[id][substream->stream].port_addr = port;
 	omap_mcbsp_dai_dma_params[id][substream->stream].sync_mode = sync_mode;
-	omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
-							OMAP_DMA_DATA_TYPE_S16;
+	switch(params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
+			 OMAP_DMA_DATA_TYPE_S16;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
+			 OMAP_DMA_DATA_TYPE_S32;
+		break;
+	default:
+		omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
+			 OMAP_DMA_DATA_TYPE_S16;
+		break;
+	}
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream,
 		&omap_mcbsp_dai_dma_params[id][substream->stream]);
@@ -330,6 +342,14 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		regs->xcr2	|= XWDLEN2(OMAP_MCBSP_WORD_16);
 		regs->xcr1	|= XWDLEN1(OMAP_MCBSP_WORD_16);
 		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		/* Set word lengths */
+		wlen = 32;
+		regs->rcr2	|= RWDLEN2(OMAP_MCBSP_WORD_32);
+		regs->rcr1	|= RWDLEN1(OMAP_MCBSP_WORD_32);
+		regs->xcr2	|= XWDLEN2(OMAP_MCBSP_WORD_32);
+		regs->xcr1	|= XWDLEN1(OMAP_MCBSP_WORD_32);
+		break;
 	default:
 		/* Unsupported PCM format */
 		return -EINVAL;
@@ -623,13 +643,15 @@ static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
 		.channels_min = 1,				\
 		.channels_max = 16,				\
 		.rates = OMAP_MCBSP_RATES,			\
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | 		\
+			   SNDRV_PCM_FMTBIT_S32_LE,		\
 	},							\
 	.capture = {						\
 		.channels_min = 1,				\
 		.channels_max = 16,				\
 		.rates = OMAP_MCBSP_RATES,			\
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
+			   SNDRV_PCM_FMTBIT_S32_LE,		\
 	},							\
 	.ops = &omap_mcbsp_dai_ops,				\
 	.private_data = &mcbsp_data[(link_id)].bus_id,		\
-- 
1.7.0.4


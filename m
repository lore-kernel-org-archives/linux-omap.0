From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv4 16/20] ASoC: OMAP: Enable DMA burst mode
Date: Mon, 17 Aug 2009 16:25:00 +0300
Message-ID: <20090817162500.f01772a9.jhnikula@gmail.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
	<1250509879-6703-17-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40680 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbZHQNX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 09:23:29 -0400
In-Reply-To: <1250509879-6703-17-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

This is a multi-part message in MIME format.

--Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2009 14:51:15 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  sound/soc/omap/omap-pcm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index f769a52..f037db0 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -193,6 +193,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
>  				(cpu_is_omap1510() ? OMAP_DMA_LAST_IRQ : 0));
>  
> +	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> +	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> +
>  	return 0;

This seems to be based on first version of Janusz's "[RFC] [PATCH 3/3]
ASoC: OMAP: Enhance OMAP1510 DMA progress software counter".

I Attached a version which is based on "[PATCH 3/3 v3] ASoC: OMAP:
Enhance OMAP1510 DMA progress software counter.


-- 
Jarkko

--Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ
Content-Type: text/x-diff;
 name="0001-ASoC-OMAP-Enable-DMA-burst-mode.patch"
Content-Disposition: attachment;
 filename="0001-ASoC-OMAP-Enable-DMA-burst-mode.patch"
Content-Transfer-Encoding: 7bit

>From a5eb199316c4731c11c7f5f8d02612ede4de7199 Mon Sep 17 00:00:00 2001
From: Eduardo Valentin <eduardo.valentin@nokia.com>
Date: Mon, 17 Aug 2009 14:51:15 +0300
Subject: [PATCH] ASoC: OMAP: Enable DMA burst mode

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index eab4533..b9633d5 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -195,6 +195,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	else
 		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
 
+	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+
 	return 0;
 }
 
-- 
1.6.3.3


--Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ--

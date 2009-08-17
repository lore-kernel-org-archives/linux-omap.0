From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 15/20] ASoC: OMAP: Make DMA 64 aligned
Date: Mon, 17 Aug 2009 17:00:56 +0300
Message-ID: <20090817140055.GX7278@atomide.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com> <1250509879-6703-16-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56390 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZHQOBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 10:01:01 -0400
Content-Disposition: inline
In-Reply-To: <1250509879-6703-16-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Eduardo Valentin <eduardo.valentin@nokia.com> [090817 15:06]:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>

Description?
 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  sound/soc/omap/omap-pcm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index dd9e728..f769a52 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -305,7 +305,7 @@ static struct snd_pcm_ops omap_pcm_ops = {
>  	.mmap		= omap_pcm_mmap,
>  };
>  
> -static u64 omap_pcm_dmamask = DMA_BIT_MASK(32);
> +static u64 omap_pcm_dmamask = DMA_BIT_MASK(64);
>  
>  static int omap_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
>  	int stream)
> @@ -355,7 +355,7 @@ static int omap_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
>  	if (!card->dev->dma_mask)
>  		card->dev->dma_mask = &omap_pcm_dmamask;
>  	if (!card->dev->coherent_dma_mask)
> -		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +		card->dev->coherent_dma_mask = DMA_BIT_MASK(64);
>  
>  	if (dai->playback.channels_min) {
>  		ret = omap_pcm_preallocate_dma_buffer(pcm,
> -- 
> 1.6.2.GIT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 16/20] ASoC: OMAP: Enable DMA burst mode
Date: Mon, 17 Aug 2009 17:01:29 +0300
Message-ID: <20090817140128.GY7278@atomide.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com> <1250509879-6703-17-git-send-email-eduardo.valentin@nokia.com> <20090817162500.f01772a9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56319 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZHQOBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 10:01:36 -0400
Content-Disposition: inline
In-Reply-To: <20090817162500.f01772a9.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Jarkko Nikula <jhnikula@gmail.com> [090817 16:23]:
> On Mon, 17 Aug 2009 14:51:15 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  sound/soc/omap/omap-pcm.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> > index f769a52..f037db0 100644
> > --- a/sound/soc/omap/omap-pcm.c
> > +++ b/sound/soc/omap/omap-pcm.c
> > @@ -193,6 +193,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
> >  	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
> >  				(cpu_is_omap1510() ? OMAP_DMA_LAST_IRQ : 0));
> >  
> > +	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> > +	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> > +
> >  	return 0;
> 
> This seems to be based on first version of Janusz's "[RFC] [PATCH 3/3]
> ASoC: OMAP: Enhance OMAP1510 DMA progress software counter".
> 
> I Attached a version which is based on "[PATCH 3/3 v3] ASoC: OMAP:
> Enhance OMAP1510 DMA progress software counter.

Needs also a patch description.

Tony

> 
> 
> -- 
> Jarkko

> From a5eb199316c4731c11c7f5f8d02612ede4de7199 Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> Date: Mon, 17 Aug 2009 14:51:15 +0300
> Subject: [PATCH] ASoC: OMAP: Enable DMA burst mode
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  sound/soc/omap/omap-pcm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index eab4533..b9633d5 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -195,6 +195,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  	else
>  		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
>  
> +	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> +	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> +
>  	return 0;
>  }
>  
> -- 
> 1.6.3.3
> 


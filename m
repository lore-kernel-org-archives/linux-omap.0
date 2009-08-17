From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv4 16/20] ASoC: OMAP: Enable DMA burst mode
Date: Mon, 17 Aug 2009 17:39:56 +0300
Message-ID: <20090817143956.GE8831@esdhcp037198.research.nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
 <1250509879-6703-17-git-send-email-eduardo.valentin@nokia.com>
 <20090817162500.f01772a9.jhnikula@gmail.com>
 <20090817140128.GY7278@atomide.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57594 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbZHQOxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 10:53:46 -0400
Content-Disposition: inline
In-Reply-To: <20090817140128.GY7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Tony

On Mon, Aug 17, 2009 at 04:01:29PM +0200, ext Tony Lindgren wrote:
> * Jarkko Nikula <jhnikula@gmail.com> [090817 16:23]:
> > On Mon, 17 Aug 2009 14:51:15 +0300
> > Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> > 
> > > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > > 
> > > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > > ---
> > >  sound/soc/omap/omap-pcm.c |    3 +++
> > >  1 files changed, 3 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> > > index f769a52..f037db0 100644
> > > --- a/sound/soc/omap/omap-pcm.c
> > > +++ b/sound/soc/omap/omap-pcm.c
> > > @@ -193,6 +193,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
> > >  	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
> > >  				(cpu_is_omap1510() ? OMAP_DMA_LAST_IRQ : 0));
> > >  
> > > +	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> > > +	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> > > +
> > >  	return 0;
> > 
> > This seems to be based on first version of Janusz's "[RFC] [PATCH 3/3]
> > ASoC: OMAP: Enhance OMAP1510 DMA progress software counter".
> > 
> > I Attached a version which is based on "[PATCH 3/3 v3] ASoC: OMAP:
> > Enhance OMAP1510 DMA progress software counter.
> 
> Needs also a patch description.

I've added patch description for those which were missing and sent them
in reply to your commented reply. If you prefer I can send version 5 of this series.

BR,

> 
> Tony
> 
> > 
> > 
> > -- 
> > Jarkko
> 
> > From a5eb199316c4731c11c7f5f8d02612ede4de7199 Mon Sep 17 00:00:00 2001
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > Date: Mon, 17 Aug 2009 14:51:15 +0300
> > Subject: [PATCH] ASoC: OMAP: Enable DMA burst mode
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  sound/soc/omap/omap-pcm.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> > index eab4533..b9633d5 100644
> > --- a/sound/soc/omap/omap-pcm.c
> > +++ b/sound/soc/omap/omap-pcm.c
> > @@ -195,6 +195,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
> >  	else
> >  		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
> >  
> > +	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> > +	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 1.6.3.3
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin

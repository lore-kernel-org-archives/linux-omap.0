From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv2 16/20] ASoC: OMAP: Use DMA operating mode of McBSP
Date: Wed, 12 Aug 2009 16:03:51 +0300
Message-ID: <20090812130350.GA9869@esdhcp037198.research.nokia.com>
References: <1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-10-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-11-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-12-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-13-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-14-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-15-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-16-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-17-git-send-email-eduardo.valentin@nokia.com>
 <20090812153838.d71f3c88.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34100 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbZHLNQu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 09:16:50 -0400
Content-Disposition: inline
In-Reply-To: <20090812153838.d71f3c88.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Wed, Aug 12, 2009 at 02:38:38PM +0200, Jarkko Nikula wrote:
> On Tue, 11 Aug 2009 16:05:27 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  sound/soc/omap/omap-mcbsp.c |    8 ++++++--
> >  sound/soc/omap/omap-pcm.c   |   13 +++++++++++--
> >  sound/soc/omap/omap-pcm.h   |    1 +
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> > 
> ...
> > diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> > index 0c1ba0f..d8f52e8 100644
> > --- a/sound/soc/omap/omap-pcm.c
> > +++ b/sound/soc/omap/omap-pcm.c
> > @@ -144,7 +144,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
> >  
> >  	memset(&dma_params, 0, sizeof(dma_params));
> >  
> > -	if (cpu_is_omap34xx())
> > +	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
> > +	if (cpu_is_omap34xx() &&
> > +			(dma_data->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD))
> >  		sync_mode = OMAP_DMA_SYNC_FRAME;
> >  	else
> >  		sync_mode = OMAP_DMA_SYNC_ELEMENT;
> 
> Note, you could avoid the compile error if you move this into
> omap-mcbsp.c and pass only sync_mode here. Probably as easy as
> dma_data->sync_mode since OMAP_DMA_SYNC_ELEMENT is zero.

Yes, it is way better to use dma_data->sync_mode. Good point.

> 
> The McBSP DAI must and can know the DMA parameters (like sync_mode) but
> otherwise (like MCBSP_DMA_MODE_xxx) it sounds unnecessary glue between
> the drivers.


I think these MCBSP_DMA_MODE_xxx references can be moved to omap-mcbsp.c.
Will try it and send more comments.

> 
> > @@ -193,9 +195,16 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> >  	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
> >  	unsigned long flags;
> >  	int ret = 0;
> > -	int samples = snd_pcm_lib_period_bytes(substream) >> 1;
> > +	int samples;
> >  
> >  	spin_lock_irqsave(&prtd->lock, flags);
> > +
> > +	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
> > +	if (dma_data->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
> > +		samples = snd_pcm_lib_period_bytes(substream) >> 1;
> > +	else
> > +		samples = 1;
> > +
> 
> Can these lines in this patch and in patch 15 to be moved into
> omap_mcbsp_trigger? For me it looks it would simplify and remove the
> glue between the drivers.

These sample calculation can be moved to the .set_threshold I've
added. But I'm afraid we can not move this threshold thing to omap_mcbsp_dai_trigger.
At that point, DMA has been started by omap_pcm_trigger, this will generate
a DMA sync error at the begging of stream execution.

> 
> 
> -- 
> Jarkko

-- 
Eduardo Valentin

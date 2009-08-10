From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 16/20] ASoC: OMAP: Use McBSP threshold again
Date: Mon, 10 Aug 2009 11:53:55 +0300
Message-ID: <20090810085355.GA23461@esdhcp037198.research.nokia.com>
References: <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
 <20090805104856.ff3e0f31.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61550 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbZHJJGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 05:06:36 -0400
Content-Disposition: inline
In-Reply-To: <20090805104856.ff3e0f31.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

Hi Jarkko,

On Wed, Aug 05, 2009 at 09:48:56AM +0200, ext Jarkko Nikula wrote:
> On Thu, 30 Jul 2009 15:49:39 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > Now this patch implements again the McBSP threshold
> > usage for OMAP ASoC.
> > 
> > We figured out that there is no need to have so much
> > SW control in order to have DMA in idle state during
> > audio streaming. Configuring McBSP threshold value
> > and DMA to FRAME_SYNC are sufficient.
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  sound/soc/omap/omap-pcm.c |   37 +++++++++++++++++++++++++++++++++++--
> >  1 files changed, 35 insertions(+), 2 deletions(-)
> > 
> > @@ -192,6 +203,12 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> >  	case SNDRV_PCM_TRIGGER_RESUME:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> >  		prtd->period_index = 0;
> > +		/* Configure McBSP internal buffer usage */
> > +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +			omap_mcbsp_set_tx_threshold(bus_id, samples - 1);
> > +		else
> > +			omap_mcbsp_set_rx_threshold(bus_id, samples - 1);
> > +
> >  		omap_start_dma(prtd->dma_ch);
> >  		break;
> >  
> Oops, didn't notice this before. This will hard glue the DMA and McBSP
> together. Even currently there is only McBSP based DAI link driver,
> there can be others as well. EAC DAI for OMAP2420 would be necessary
> for instance if one wants to develop ASoC support for Nokia N800. Nokia
> N810 could use that too.

True. And the same comment is valid for the patch which adds op mode selection.
My idea to un-glue them is to put some callbacks in omap_mcbsp_data of omap-mcbsp.c,
and share it as something more generic, so that they can be called from omap-pcm.c.

Something like:

struct omap_dma_data {
	unsigned int			bus_id;
	unsigned int			fmt;
	/*
	 * Flags indicating is the bus already activated and configured by
	 * another substream
	 */
	int				active;
	int				configured;
	/* threshold callbacks can be added then here */
	void				*data; /* struct omap_mcbsp_reg_cfg	regs; can go here */
};

And this goes in omap-pcm.h.

what do you think??

> 
> 
> -- 
> Jarkko

-- 
Eduardo Valentin

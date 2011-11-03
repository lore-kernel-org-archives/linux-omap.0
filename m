From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP2+: DMA: Workaround for invalid source position
Date: Thu, 3 Nov 2011 14:29:01 -0700
Message-ID: <20111103212901.GA31337@atomide.com>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
 <1320070817-9638-2-git-send-email-peter.ujfalusi@ti.com>
 <20111103212756.GZ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42668 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752279Ab1KCV3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 17:29:05 -0400
Content-Disposition: inline
In-Reply-To: <20111103212756.GZ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

* Tony Lindgren <tony@atomide.com> [111103 13:53]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [111031 06:46]:
> > If the DMA source position has been asked before the
> > first actual data transfer has been done, the CSAC
> > register does not contain valid information.
> > We can identify this situation by checking the CDAC
> > register:
> > CDAC != 0 indicates that the DMA transfer on the channel has
> > been started already.
> > When CDAC == 0 we can not trust the CSAC value since it has
> > not been updated, and can contain random number.
> > Return the start address in case the DMA has not jet started.
> > 
> > Note: The CDAC register has been initialized to 0 at dma_start
> > time.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >  arch/arm/plat-omap/dma.c |   15 +++++++++++++--
> >  1 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index c22217c..38b0d44 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -1024,12 +1024,23 @@ EXPORT_SYMBOL(omap_set_dma_callback);
> >   */
> >  dma_addr_t omap_get_dma_src_pos(int lch)
> >  {
> > +	u32 cdac;
> >  	dma_addr_t offset = 0;
> >  
> >  	if (cpu_is_omap15xx())
> >  		offset = p->dma_read(CPC, lch);
> > -	else
> > -		offset = p->dma_read(CSAC, lch);
> > +	else {
> > +		/*
> > +		 * CDAC == 0 indicates that the DMA transfer on the channel has
> > +		 * not been started (no data has been transferred so far).
> > +		 * Return the programmed source start address in this case.
> > +		 */
> > +		cdac = p->dma_read(CDAC, lch);
> > +		if (likely(cdac))
> > +			offset = p->dma_read(CSAC, lch);
> > +		else
> > +			offset = p->dma_read(CSSA, lch);
> > +	}
> >  
> >  	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
> >  		offset = p->dma_read(CSAC, lch);
> 
> Should these tests be done only after the errata re-read for both
> src and dst patches? Otherwise the errata will not be handled?

Also, please Cc linux-arm-kernel list too so I don't have to repost :)

Tony

From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] usb: musb: fix bug in musbhsdma programming
Date: Fri, 23 Jan 2009 10:36:04 -0800
Message-ID: <200901231036.04376.david-b@pacbell.net>
References: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com> <20090123101812.GP9233@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:28119 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753544AbZAWSgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2009 13:36:08 -0500
In-Reply-To: <20090123101812.GP9233@scadufax.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 23 January 2009, Felipe Balbi wrote:
> On Thu, Jan 08, 2009 at 06:01:36PM +0530, Ajay Kumar Gupta wrote:
> > Mode bit should be set based on function parameter "mode" of
> > configure_channel() function.
> > 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

NAK -- interpretation of the MODE parameter is correct
(though it's not clear to me that the callers set it right),
but this won't apply to current GIT since the code differs.

I don't know what this is *against* but it's not mainline
or the OMAP tree...

        csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
                | (1 << MUSB_HSDMA_ENABLE_SHIFT)
                | (1 << MUSB_HSDMA_IRQENABLE_SHIFT)
                | (musb_channel->transmit
                                ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT)
                                : 0);

Ajay, if this needs to merge to mainline (e.g. so it can be
pulled down to omap-git and fix DMA there) please re-issue.

- Dave

> 
> > ---
> >  drivers/usb/musb/musbhsdma.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > index a23d005..d87c6c7 100644
> > --- a/drivers/usb/musb/musbhsdma.c
> > +++ b/drivers/usb/musb/musbhsdma.c
> > @@ -225,13 +225,14 @@ static void configure_channel(struct dma_channel *channel,
> >  			csr |= MUSB_HSDMA_BURSTMODE_INCR4;
> >  
> >  		csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
> > -			| MUSB_HSDMA_MODE1
> >  			| MUSB_HSDMA_ENABLE
> >  			| MUSB_HSDMA_IRQENABLE
> >  			| (musb_channel->transmit
> >  					? MUSB_HSDMA_TRANSMIT
> >  					: 0);
> >  
> > +		if (mode)
> > +			csr |= MUSB_HSDMA_MODE1;
> >  		/* address/count */
> >  		musb_write_hsdma_addr(mbase, bchannel, dma_addr);
> >  		musb_write_hsdma_count(mbase, bchannel, len);
> > -- 
> > 1.5.6
> 
> -- 
> balbi
> 
> 



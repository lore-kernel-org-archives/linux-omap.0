From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] usb: gadget: omap_udc: remove useless print
Date: Fri, 1 Jun 2012 04:45:20 -0700
Message-ID: <20120601114520.GQ12766@atomide.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
 <1338293761-9457-3-git-send-email-balbi@ti.com>
 <20120601110123.GK12766@atomide.com>
 <20120601110751.GM15957@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15551 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919Ab2FALpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 07:45:22 -0400
Content-Disposition: inline
In-Reply-To: <20120601110751.GM15957@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [120601 04:13]:
> Hi,
> 
> On Fri, Jun 01, 2012 at 04:01:24AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [120529 05:22]:
> > > that print isn't needed at all. Remove it
> > > and move the use_dma reinitialization to
> > > probe() function.
> > > 
> > > Note that ideally we would drop all
> > > cpu_is_* and machine_is_* checks from
> > > this driver instead. Later patches will
> > > come to get rid of those.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  drivers/usb/gadget/omap_udc.c |   13 +++----------
> > >  1 file changed, 3 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> > > index aa2d174..5e7b891 100644
> > > --- a/drivers/usb/gadget/omap_udc.c
> > > +++ b/drivers/usb/gadget/omap_udc.c
> > > @@ -2800,6 +2800,9 @@ static int __init omap_udc_probe(struct platform_device *pdev)
> > >  	struct clk		*dc_clk = NULL;
> > >  	struct clk		*hhc_clk = NULL;
> > >  
> > > +	if (cpu_is_omap7xx())
> > > +		use_dma = 0;
> > > +
> > >  	/* NOTE:  "knows" the order of the resources! */
> > >  	if (!request_mem_region(pdev->resource[0].start,
> > >  			pdev->resource[0].end - pdev->resource[0].start + 1,
> > 
> > I think this would break omap_udc for 7xx as it then tries to use
> > DMA as USED_MA is set by default?
> 
> I'm clearing it in the start of probe function. There's not functional
> changes at all. use_dma is ON by default, then our probe gets called and
> first thing we do is clear use_dma to zero when we're running on
> omap7xx. I don't see the issue, maybe I'm missing something.

OK thanks for clarifying, sounds like it should work then.

Tony


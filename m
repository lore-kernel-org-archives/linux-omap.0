From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
Date: Fri, 2 Mar 2012 11:20:58 -0800
Message-ID: <20120302192058.GP18901@atomide.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-12-git-send-email-b-cousson@ti.com>
 <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16149 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab2CBTVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 14:21:03 -0500
Content-Disposition: inline
In-Reply-To: <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, sameo@linux.intel.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

* Felipe Balbi <balbi@ti.com> [120302 09:43]:
> Hi,
> 
> On Fri, Mar 02, 2012 at 05:50:23PM +0100, Benoit Cousson wrote:
> > Card detect IRQ from the TWL6030 used to be provided to the MMC
> > controller code using a statically allocated IRQ scheme:
> > 
> >   card_detect_irq = TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;
> > 
> > This is no longer valid in a SPARSE_IRQ context since there is no more
> > pre-defined TWL6030_IRQ_BASE.
> > 
> > Return the proper card detect IRQ value in the twl6030_mmc_card_detect_config
> > that will be called from the MMC controller.
> > 
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> > ---
> >  drivers/mfd/twl6030-irq.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> > index a1c7183..4a63de2 100644
> > --- a/drivers/mfd/twl6030-irq.c
> > +++ b/drivers/mfd/twl6030-irq.c
> > @@ -308,7 +308,8 @@ int twl6030_mmc_card_detect_config(void)
> >  									ret);
> >  		return ret;
> >  	}
> > -	return 0;
> > +
> > +	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
> >  }
> >  EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
> 
> At some point this twl6030_mmc_card_detect_config() needs to vanish in
> favor of a better mechanism. Maybe passing the GPIO number an requiring
> the driver to request the GPIO, set its direction and use it as IRQ
> line.
> 
> the only problem would arise if we end up hooking the Card Detect pin to
> a real IRQ line, but then we can use a flag to differentiate.

I'm trying to leave out the need for this callback to pdata..
See mmc: omap_hsmmc: Simplify init for twl6030 MMC card detect
that does pretty much the same as Benoit's patch plus removes
the need for the callback.

Tony

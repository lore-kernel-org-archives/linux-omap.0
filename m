From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPFB: fix printing of reserved memory
Date: Fri, 24 Oct 2008 12:26:56 -0700
Message-ID: <20081024192655.GI16354@atomide.com>
References: <20080912102716.23245.73291.stgit@tubuntu> <20081017214530.GD18573@atomide.com> <1224513918.23383.14.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64043 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbYJXT06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 15:26:58 -0400
Content-Disposition: inline
In-Reply-To: <1224513918.23383.14.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [081020 11:50]:
> On Fri, 2008-10-17 at 14:45 -0700, ext Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@nokia.com> [080912 03:27]:
> > > Print reserved memory only if it was actually reserved.
> > 
> > Can you reply with your Signed-off-by?
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Thanks, pushing.

Tony

> 
> > 
> > Thanks,
> > 
> > Tony
> > 
> > > ---
> > > 
> > >  arch/arm/plat-omap/fb.c |    5 +++--
> > >  1 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
> > > index f9927a7..63c82ef 100644
> > > --- a/arch/arm/plat-omap/fb.c
> > > +++ b/arch/arm/plat-omap/fb.c
> > > @@ -207,9 +207,10 @@ void __init omapfb_reserve_sdram(void)
> > >  			config_invalid = 1;
> > >  			return;
> > >  		}
> > > -		if (rg.paddr)
> > > +		if (rg.paddr) {
> > >  			reserve_bootmem(rg.paddr, rg.size, BOOTMEM_DEFAULT);
> > > -		reserved += rg.size;
> > > +			reserved += rg.size;
> > > +		}
> > >  		omapfb_config.mem_desc.region[i] = rg;
> > >  		configured_regions++;
> > >  	}
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

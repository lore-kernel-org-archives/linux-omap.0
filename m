From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Fri, 3 Dec 2010 08:41:02 +0000
Message-ID: <20101203084102.GA30957@n2100.arm.linux.org.uk>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk> <20101202215837.GW17222@atomide.com> <20101202221612.GJ10461@n2100.arm.linux.org.uk> <20101202223208.GA17222@atomide.com> <20101203030954.GD3367@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45464 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab0LCIl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 03:41:28 -0500
Content-Disposition: inline
In-Reply-To: <20101203030954.GD3367@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 03, 2010 at 12:09:55PM +0900, Paul Mundt wrote:
> On Thu, Dec 02, 2010 at 02:32:08PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 14:06]:
> > > On Thu, Dec 02, 2010 at 01:58:38PM -0800, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 13:04]:
> > > > > This has been around since October:
> > > > > 
> > > > > drivers/video/omap2/vram.c: In function ???omap_vram_reserve_sdram_memblock???:
> > > > > drivers/video/omap2/vram.c:573: error: ???MEMBLOCK_REAL_LIMIT??? undeclared (first use in this function)
> > > > > drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is reported only once
> > > > > drivers/video/omap2/vram.c:573: error: for each function it appears in.)
> > > > > 
> > > > > This requires a trivial one-liner compile fix:
> > > > > 
> > > > > diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> > > > > index fed2a72..a8973f0 100644
> > > > > --- a/drivers/video/omap2/vram.c
> > > > > +++ b/drivers/video/omap2/vram.c
> > > > > @@ -570,7 +570,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
> > > > >  			return;
> > > > >  		}
> > > > >  	} else {
> > > > > -		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
> > > > > +		paddr = memblock_alloc(size, PAGE_SIZE);
> > > > >  	}
> > > > >  
> > > > >  	omap_vram_add_region(paddr, size);
> > > > > 
> > > > > which restores the old behaviour before the X86 memblock changes went
> > > > > in.  Yes, there may be other changes due to the ioremap stuff, but
> > > > > that's really no excuse for not fixing the compile error itself.
> > > > 
> > > > Great. Adding fbdev and Tomi to Cc.
> > > > 
> > > > Acked-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > http://marc.info/?l=linux-omap&w=2&r=1&s=MEMBLOCK_REAL_LIMIT%20vram&q=b
> > > 
> > > There have been patches posted throughout November to fix this, but
> > > the problem is they're not making it to mainline.  It needs chasing
> > > until someone does the right thing and sends one variant of the above
> > > patch, rather than just leaving it until the ioremap fixes hit
> > > mainline during the next merge window.
> > 
> > Yes this should go in during the -rc for sure.
> > 
> > I suggest you merge this but let's wait a bit and check if Tomi
> > already has a similar fix queued for the -rc series.
> > 
> This has been fixed since -rc2.

So it is.  However, the ioremap fix is wrong.

        } else {
                paddr = memblock_alloc(size, PAGE_SIZE);
        }

        memblock_free(paddr, size);
        memblock_remove(paddr, size);

Didn't I say that such blocks were supposed to be aligned to a 2MB
boundary - and the size also so aligned?

http://lists.arm.linux.org.uk/lurker/message/20101011.152516.893a6088.en.html

It at least needs to be 1MB as that's the section size.

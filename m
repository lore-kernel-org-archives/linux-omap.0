From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2] video: omap: vram: remove from normal memory
Date: Tue, 19 Oct 2010 15:03:05 +0300
Message-ID: <1287489785.2216.10.camel@tubuntu>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	 <1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
	 <1287407452.6781.64.camel@tubuntu> <1287410618.6781.110.camel@tubuntu>
	 <20101018225534.GH13341@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:25260 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758352Ab0JSMDe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 08:03:34 -0400
In-Reply-To: <20101018225534.GH13341@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: ext Felipe Contreras <felipe.contreras@gmail.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, Russell King <linux@arm.linux.org.uk>, "mike@compulab.co.il" <mike@compulab.co.il>

On Tue, 2010-10-19 at 00:55 +0200, ext Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [101018 06:55]:
> > On Mon, 2010-10-18 at 16:10 +0300, Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > On Fri, 2010-10-15 at 14:46 +0200, ext Felipe Contreras wrote:
> > > > So that we can ioremap happily.
> > > > 
> > > > Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > > ---
> > > >  drivers/video/omap2/vram.c |    2 ++
> > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> > > > index f6fdc20..1a99777 100644
> > > > --- a/drivers/video/omap2/vram.c
> > > > +++ b/drivers/video/omap2/vram.c
> > > > @@ -575,6 +575,8 @@ void __init omap_vram_reserve_sdram_memblock(void)
> > > >  		}
> > > >  	} else {
> > > >  		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
> > > > +		memblock_free(paddr, size);
> > > > +		memblock_remove(paddr, size);
> > > >  	}
> > > >  
> > > >  	omap_vram_add_region(paddr, size);
> > > 
> > > I tested this on OMAP3 SDP board, on top of my DSS2 tree. I can boot up
> > > fine, but my test program crashes the kernel (dump below).
> > > 
> > > This crash doesn't happen if I have the "HACK: OMAP: DSS2: OMAPFB: use
> > > phys_to_virt for RAM mappings" patch in (I removed that during testing
> > > this patch).
> > > 
> > > I don't know yet what is crashing the kernel, but I'd guess it's the
> > > fact that my test program reallocates the framebuffer memory with
> > > OMAPFB_SETUP_MEM ioctl.
> > 
> > Ah, sorry, I was missing the patch from Russel which you mentioned in
> > another mail (http://article.gmane.org/gmane.linux.kernel/1047146). With
> > that patch included things seem to work.
> 
> Tomi, I assume you're queuing these? If so, for both:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Yes, I can queue them (when the required memblock stuff is in).

 Tomi



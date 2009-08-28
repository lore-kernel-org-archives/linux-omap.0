From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP SRAM: flush the right address after memcpy in
	omap_sram_push
Date: Fri, 28 Aug 2009 09:03:10 -0700
Message-ID: <20090828160310.GJ25828@atomide.com>
References: <af3ea28a0908280226p69175f97m88b8eac5e0bd2502@mail.gmail.com> <alpine.DEB.2.00.0908280443110.15963@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65327 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZH1QDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 12:03:11 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0908280443110.15963@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: ye janboe <janboe.ye@gmail.com>, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [090828 03:43]:
> On Fri, 28 Aug 2009, ye janboe wrote:
> 
> > the original flush operation is to flush the function address which is
> > copied from.
> > But we do not change the function code and it is not necessary to flush it.
> > 
> > Signed-off-by: janboe <janboe.ye@gmail.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> thanks Janboe.
> 
> Tony, you want to take this one, or do you want me to?

I can add it to my omap-fixes unless you have a fixes series of your
own coming up.

Tony
 
> - Paul
> 
> 
> > ---
> >  arch/arm/plat-omap/sram.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > index f2b0fa6..f549d8a 100644
> > --- a/arch/arm/plat-omap/sram.c
> > +++ b/arch/arm/plat-omap/sram.c
> > @@ -270,7 +270,8 @@ void * omap_sram_push(void * start, unsigned long size)
> >         omap_sram_ceil -= size;
> >         omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
> >         memcpy((void *)omap_sram_ceil, start, size);
> > -       flush_icache_range((unsigned long)start, (unsigned long)(start + size));
> > +       flush_icache_range((unsigned long)omap_sram_ceil,
> > +               (unsigned long)(omap_sram_ceil + size));
> > 
> >         return (void *)omap_sram_ceil;
> >  }
> > 
> 
> 

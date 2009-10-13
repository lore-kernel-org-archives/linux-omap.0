From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Fix 35xx detection (Re: [PATCH] [RFC] omap:
	3630: default cpu_is_omap3630 to zero)
Date: Tue, 13 Oct 2009 12:09:34 -0700
Message-ID: <20091013190934.GX12700@atomide.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com> <20091013171814.GT12700@atomide.com> <20091013173233.GU12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56209 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760514AbZJMTKT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:10:19 -0400
Content-Disposition: inline
In-Reply-To: <20091013173233.GU12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: nm@ti.com, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [091013 11:01]:
> * Tony Lindgren <tony@atomide.com> [091013 10:18]:
> > * Vikram Pandita <vikram.pandita@ti.com> [091012 14:31]:
> > > make default cpu_is_omap3630() return zero
> > > 
> > > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> > > ---
> > >  arch/arm/plat-omap/include/mach/cpu.h |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> > > index da9e8f8..940946e 100644
> > > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > > @@ -322,6 +322,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  #define cpu_is_omap2423()		0
> > >  #define cpu_is_omap2430()		0
> > >  #define cpu_is_omap3430()		0
> > > +#define cpu_is_omap3630()		0
> > >  
> > >  /*
> > >   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
> > > @@ -386,6 +387,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  						(omap3_has_sgx()) &	\
> > >  						(!omap3_has_iva()))
> > >  # define cpu_is_omap3530		(cpu_is_omap3430())
> > > +# undef cpu_is_omap3630()
> > >  # define cpu_is_omap3630()		is_omap363x()
> > >  #endif
> > 
> > This undef should be just undef cpu_is_omap3630 instead of
> > cpu_is_omap3630().
> 
> Also looking at the 35xx detection code, should it not be like this?

I've merged all these fixes into the 35xx and 36xx detection patches
in omap for-next branch, can you guys please check?

Regards,

Tony

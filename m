From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 1/6] ARM: mm: define LoUIS API for cache
	maintenance ops
Date: Thu, 13 Sep 2012 13:57:22 +0100
Message-ID: <20120913125722.GB20420@e102568-lin.cambridge.arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913123604.GH28448@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36256 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757940Ab2IMM51 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 08:57:27 -0400
In-Reply-To: <20120913123604.GH28448@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 01:36:04PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 13, 2012 at 11:20:46AM +0100, Lorenzo Pieralisi wrote:
> > +/*
> > + * Flush caches up to Level of Unification Inner Shareable
> > + */
> > +#ifdef MULTI_CACHE
> > +#define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
> > +#else
> > +#define flush_cache_louis()   __cpuc_flush_kern_all()
> > +#endif
> 
> NAK.  This is broken as you don't seem to understand what MULTI_CACHE
> actually means.  MULTI_CACHE means that we _may_ support more than one
> type of cache, so it not being selected means nothing as far as whether
> to use flush_kern_all() or not.
> 
> Follow the pattern in the rest of the file - that's the _only_ way to do
> this.
> 
> Note that ARMv6 only and ARMv7 only kernels will not have MULTI_CACHE
> defined (I mentioned this on Monday in our call, though not explicitly
> by that name.)

Point taken, I will fix it.

> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index 2d8ff3a..28e91f8 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -293,12 +293,17 @@ ENTRY(\name\()_processor_functions)
> >  	.size	\name\()_processor_functions, . - \name\()_processor_functions
> >  .endm
> >  
> > -.macro define_cache_functions name:req
> > +.macro define_cache_functions name:req, cachelouis=0
> >  	.align 2
> >  	.type	\name\()_cache_fns, #object
> >  ENTRY(\name\()_cache_fns)
> >  	.long	\name\()_flush_icache_all
> >  	.long	\name\()_flush_kern_cache_all
> > +	.if \cachelouis
> > +	.long   \name\()_flush_kern_cache_louis
> > +	.else
> > +	.long   \name\()_flush_kern_cache_all
> > +	.endif
> >  	.long	\name\()_flush_user_cache_all
> >  	.long	\name\()_flush_user_cache_range
> >  	.long	\name\()_coherent_kern_range
> 
> And what the above means is that _every_ cache support file must supply a
> XXX_flush_kern_cache_louis function name.  If there is no separate
> implementation, then name it an alias for the XXX_flush_cache_all function.

I will do that, thanks for the review.

Lorenzo


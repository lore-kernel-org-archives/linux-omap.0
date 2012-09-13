From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 1/6] ARM: mm: define LoUIS API for cache
	maintenance ops
Date: Thu, 13 Sep 2012 13:36:04 +0100
Message-ID: <20120913123604.GH28448@n2100.arm.linux.org.uk>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com> <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60279 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab2IMMgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 08:36:24 -0400
Content-Disposition: inline
In-Reply-To: <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 11:20:46AM +0100, Lorenzo Pieralisi wrote:
> +/*
> + * Flush caches up to Level of Unification Inner Shareable
> + */
> +#ifdef MULTI_CACHE
> +#define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
> +#else
> +#define flush_cache_louis()   __cpuc_flush_kern_all()
> +#endif

NAK.  This is broken as you don't seem to understand what MULTI_CACHE
actually means.  MULTI_CACHE means that we _may_ support more than one
type of cache, so it not being selected means nothing as far as whether
to use flush_kern_all() or not.

Follow the pattern in the rest of the file - that's the _only_ way to do
this.

Note that ARMv6 only and ARMv7 only kernels will not have MULTI_CACHE
defined (I mentioned this on Monday in our call, though not explicitly
by that name.)

> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 2d8ff3a..28e91f8 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -293,12 +293,17 @@ ENTRY(\name\()_processor_functions)
>  	.size	\name\()_processor_functions, . - \name\()_processor_functions
>  .endm
>  
> -.macro define_cache_functions name:req
> +.macro define_cache_functions name:req, cachelouis=0
>  	.align 2
>  	.type	\name\()_cache_fns, #object
>  ENTRY(\name\()_cache_fns)
>  	.long	\name\()_flush_icache_all
>  	.long	\name\()_flush_kern_cache_all
> +	.if \cachelouis
> +	.long   \name\()_flush_kern_cache_louis
> +	.else
> +	.long   \name\()_flush_kern_cache_all
> +	.endif
>  	.long	\name\()_flush_user_cache_all
>  	.long	\name\()_flush_user_cache_range
>  	.long	\name\()_coherent_kern_range

And what the above means is that _every_ cache support file must supply a
XXX_flush_kern_cache_louis function name.  If there is no separate
implementation, then name it an alias for the XXX_flush_cache_all function.

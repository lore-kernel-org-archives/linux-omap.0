From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH 1/6] ARM: mm: define LoUIS API for cache maintenance
 ops
Date: Thu, 13 Sep 2012 12:39:49 +0100
Message-ID: <20120913113949.GC2470@linaro.org>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56806 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab2IMLjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 07:39:55 -0400
Received: by eekc1 with SMTP id c1so1878934eek.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 04:39:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 11:20:46AM +0100, Lorenzo Pieralisi wrote:
> ARM v7 architecture introduced the concept of cache levels and related
> coherency requirements. New processors like A7 and A15 embed an
> L2 unified cache controller that becomes part of the cache level
> hierarchy. Some operations in the kernel like cpu_suspend and __cpu_disable
> does not require a flush of the entire cache hierarchy to DRAM but just the
> cache levels belonging to the Level of Unification Inner Shareable (LoUIS),
> which in most of ARM v7 systems correspond to L1.
> 
> The current cache flushing API used in cpu_suspend and __cpu_disable,
> flush_cache_all(), ends up flushing the whole cache hierarchy since for
> v7 it cleans and invalidates all cache levels up to Level of Coherency
> (LoC) which cripples system performance when used in hot paths like hotplug
> and cpuidle.
> 
> Therefore a new kernel cache maintenance API must be added to the
> cpu_cache_fns structure of pointers to cope with latest ARM system requirements.
> This patch adds flush_cache_louis() to the ARM kernel cache maintenance API.
> 
> This function cleans and invalidates all data cache levels up to the
> level of unification inner shareable (LoUIS) and invalidates the instruction
> cache.
> 
> The cpu_cache_fns struct reflects this change by adding a new function pointer
> that is initialized by arch specific assembly files.
> 
> By default, all existing ARM archs do not instantiate any cache LoUIS function
> pointer, and flush_dcache_louis just falls back to flush_kern_all.
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/include/asm/cacheflush.h | 17 +++++++++++++++++
>  arch/arm/mm/proc-macros.S         |  7 ++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index c6e2ed9..7683316 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -50,6 +50,13 @@
>   *
>   *		Unconditionally clean and invalidate the entire cache.
>   *
> + *     flush_kern_cache_louis()
> + *
> + *             Flush data cache levels up to the level of unification
> + *             inner shareable and invalidate the I-cache.
> + *             Only needed from v7 onwards, falls back to flush_cache_all()
> + *             for all other processor versions.
> + *
>   *	flush_user_all()
>   *
>   *		Clean and invalidate all user space cache entries
> @@ -98,6 +105,7 @@
>  struct cpu_cache_fns {
>  	void (*flush_icache_all)(void);
>  	void (*flush_kern_all)(void);
> +	void (*flush_kern_cache_louis)(void);
>  	void (*flush_user_all)(void);
>  	void (*flush_user_range)(unsigned long, unsigned long, unsigned int);
>  
> @@ -200,6 +208,15 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
>  #define __flush_icache_preferred	__flush_icache_all_generic
>  #endif
>  
> +/*
> + * Flush caches up to Level of Unification Inner Shareable
> + */
> +#ifdef MULTI_CACHE
> +#define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
> +#else
> +#define flush_cache_louis()   __cpuc_flush_kern_all()
> +#endif

So, without MULTI_CACHE, we always fall back to flush_kern_all.

I'm guessing this is done because CPUs can't be relied on to provide
flush_kern_cache_louis.  Shouldn't this be handled directly? 

We could introduce something like CONFIG_ARM_HAVE_CACHEFLUSH_LOUIS, and
do:

<asm/glue-cache.h>
#ifndef MULTI_CACHE
#ifdef CONFIG_HAVE_ARM_CACHEFLUSH_LOUIS
#define __cpuc_flush_kern_cache_louis __glue(_CACHE,_flush_kern_cache_louis)
#else
#define __cpuc_flush_kern_cache_louis __glue(_CACHE,_flush_kern_all)
#endif
#endif

<asm/cacheflush.h>
#ifdef MULTI_CACHE
#define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
#else
#define flush_cache_louis()   __cpuc_flush_kern_cache_louis()
#endif


Any good?

Then the only question is whether this is worth the complexity.

This only works if the __cpuc_ aliases are not used from assembler.
That seems wrong anyway, since on a MULTI_CACHE kernel those would turn
into C struct member references which wouldn't be valid in assembler
anyway.

Cheers
---Dave

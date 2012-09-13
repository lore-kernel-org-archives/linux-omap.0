From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH 4/6] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Thu, 13 Sep 2012 13:53:48 +0100
Message-ID: <20120913125347.GD2470@linaro.org>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44627 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757689Ab2IMMxx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 08:53:53 -0400
Received: by eekc1 with SMTP id c1so1919115eek.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 05:53:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 11:20:49AM +0100, Lorenzo Pieralisi wrote:
> In processors like A15/A7 L2 cache is unified and integrated within the
> processor cache hierarchy, so that it is not considered an outer cache
> anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
> all cache levels up to Level of Coherency (LoC) that includes
> the L2 unified cache.
> 
> When a single CPU is suspended (CPU idle) a complete L2 clean is not
> required, so generic cpu_suspend code must clean the data cache using the
> newly introduced cache LoUIS function.
> 
> The context and stack pointer (context pointer) are cleaned to main memory
> using cache area functions that operate on MVA and guarantee that the data
> is written back to main memory (perform cache cleaning up to the Point of
> Coherency - PoC) so that the processor can fetch the context when the MMU
> is off in the cpu_resume code path.
> 
> outer_cache management remains unchanged.

LoUIS matches the power domain affected by turning a single CPU off
on most (all?) current v7 SoCs where this matters, but only by coincidence.
There is no guarantee of that.

The _louis() API is useful, because this is exactly what you need to to
I-/D-/TLB synchronisation in an SMP OS.  Using it as preparation for
powering a CPU off feels like misuse, at least in theory.

For powerdown, we would logically need a separate function,
flush_cache_cpu() or something, whose job is precisely to flush those
levels which will be affected by the powerdown if that single CPU.

In a multi-cluster system, it's possible that the architectural cache
level this corresponds to is not even the same across all clusters (though
for the foreseeable future it probably will be -- at least for all clusters
participating in SMP).


I don't know how urgent it is to fix this if there are just a few call
sites for flush_cache_louis().  My worry would be that misuse of these
functions propagates before we find that this needs cleaning up...

Cheers
---Dave

> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/kernel/suspend.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
> index 1794cc3..358bca3 100644
> --- a/arch/arm/kernel/suspend.c
> +++ b/arch/arm/kernel/suspend.c
> @@ -17,6 +17,8 @@ extern void cpu_resume_mmu(void);
>   */
>  void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
>  {
> +	u32 *ctx = ptr;
> +
>  	*save_ptr = virt_to_phys(ptr);
>  
>  	/* This must correspond to the LDM in cpu_resume() assembly */
> @@ -26,7 +28,20 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
>  
>  	cpu_do_suspend(ptr);
>  
> -	flush_cache_all();
> +	flush_cache_louis();
> +
> +	/*
> +	 * flush_cache_louis does not guarantee that
> +	 * save_ptr and ptr are cleaned to main memory,
> +	 * just up to the Level of Unification Inner Shareable.
> +	 * Since the context pointer and context itself
> +	 * are to be retrieved with the MMU off that
> +	 * data must be cleaned from all cache levels
> +	 * to main memory using "area" cache primitives.
> +	*/
> +	__cpuc_flush_dcache_area(ctx, ptrsz);
> +	__cpuc_flush_dcache_area(save_ptr, sizeof(*save_ptr));
> +
>  	outer_clean_range(*save_ptr, *save_ptr + ptrsz);
>  	outer_clean_range(virt_to_phys(save_ptr),
>  			  virt_to_phys(save_ptr) + sizeof(*save_ptr));
> -- 
> 1.7.12
> 
> 

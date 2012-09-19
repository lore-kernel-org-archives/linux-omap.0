From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Wed, 19 Sep 2012 14:46:58 +0100
Message-ID: <20120919134658.GA2111@linaro.org>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64843 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab2ISNrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 09:47:13 -0400
Received: by bkwj10 with SMTP id j10so531984bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 06:47:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Tue, Sep 18, 2012 at 05:35:33PM +0100, Lorenzo Pieralisi wrote:
> In processors like A15/A7 L2 cache is unified and integrated within the
> processor cache hierarchy, so that it is not considered an outer cache
> anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
> all cache levels up to Level of Coherency (LoC) that includes
> the L2 unified cache.
> 
> When a single CPU is suspended (CPU idle) a complete L2 clean is not
> required, so generic cpu_suspend code must clean the data cache using the
> newly introduced cache LoUIS function.

For patches 3-5 in this series, we know that the assumption that
flushing LoUIS is sufficient for safely powering the CPU down is not
valid in the general case, though we've agreed it's a sensible
compromise for the CPU variants we know about today.

I think we do need to document this assumption, though.

At this point I don't mind whether it appears in code comments or in the
commit messages.

Cheers
---Dave

> 
> The context and stack pointer (context pointer) are cleaned to main memory
> using cache area functions that operate on MVA and guarantee that the data
> is written back to main memory (perform cache cleaning up to the Point of
> Coherency - PoC) so that the processor can fetch the context when the MMU
> is off in the cpu_resume code path.
> 
> outer_cache management remains unchanged.
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

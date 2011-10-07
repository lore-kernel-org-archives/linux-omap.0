From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Fri, 7 Oct 2011 12:59:03 -0700
Message-ID: <20111007195903.GO6324@atomide.com>
References: <20111007194242.18205.64009.stgit@kaulin.local>
 <20111007194543.18205.36115.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45065 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab1JGT7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 15:59:06 -0400
Content-Disposition: inline
In-Reply-To: <20111007194543.18205.36115.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [111007 12:11]:
> This allows mapping external memory such as SRAM for use.
> 
> This is needed for some small chunks of code, such as reprogramming
> SDRAM memory source clocks that can't be executed in SDRAM. Other
> use cases include some PM related code.
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

FYI this I've sent to Russell's patch system:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7126/1

Regards,

Tony

 

> ---
>  arch/arm/include/asm/io.h |    1 +
>  arch/arm/mm/ioremap.c     |   21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index d66605d..4ff152e 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -80,6 +80,7 @@ extern void __iomem *__arm_ioremap_caller(unsigned long, size_t, unsigned int,
>  
>  extern void __iomem *__arm_ioremap_pfn(unsigned long, unsigned long, size_t, unsigned int);
>  extern void __iomem *__arm_ioremap(unsigned long, size_t, unsigned int);
> +extern void __iomem *__arm_ioremap_exec(unsigned long, size_t, int cached);
>  extern void __iounmap(volatile void __iomem *addr);
>  
>  /*
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index ab50627..a2d94ac 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -289,6 +289,27 @@ __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
>  }
>  EXPORT_SYMBOL(__arm_ioremap);
>  
> +/*
> + * Remap an arbitrary physical address space into the kernel virtual
> + * address space as memory. Needed when the kernel wants to execute
> + * code in external memory. This is needed for reprogramming source
> + * clocks that would affect normal memory for example. Please see
> + * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
> + */
> +void __iomem *
> +__arm_ioremap_exec(unsigned long phys_addr, size_t size, int cached)
> +{
> +	unsigned int mtype;
> +
> +	if (cached)
> +		mtype = MT_MEMORY;
> +	else
> +		mtype = MT_MEMORY_NONCACHED;
> +
> +	return __arm_ioremap_caller(phys_addr, size, mtype,
> +			__builtin_return_address(0));
> +}
> +
>  void __iounmap(volatile void __iomem *io_addr)
>  {
>  	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

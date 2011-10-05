From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Tue, 04 Oct 2011 21:00:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110042059110.9106@xanadu.home>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005004539.26980.52409.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:53956 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab1JEBAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 21:00:02 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSK00G0GIMVUPF0@VL-VM-MR004.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 04 Oct 2011 20:56:56 -0400 (EDT)
In-reply-to: <20111005004539.26980.52409.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 4 Oct 2011, Tony Lindgren wrote:

> This allows mapping external memory such as SRAM for use.
> 
> This is needed for some small chunks of code, such as reprogramming
> SDRAM memory source clocks that can't be executed in SDRAM. Other
> use cases include some PM related code.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

As mentioned, you might consider dropping the export until needed.


> ---
>  arch/arm/include/asm/io.h |    1 +
>  arch/arm/mm/ioremap.c     |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
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
> index ab50627..a813658 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -289,6 +289,28 @@ __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
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
> +EXPORT_SYMBOL(__arm_ioremap_exec);
> +
>  void __iounmap(volatile void __iomem *io_addr)
>  {
>  	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

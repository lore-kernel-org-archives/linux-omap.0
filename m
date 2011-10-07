From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Fri, 07 Oct 2011 12:10:40 +0530
Message-ID: <4E8E9EE8.8010106@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local> <20111005004539.26980.52409.stgit@kaulin.local> <alpine.LFD.2.02.1110042059110.9106@xanadu.home> <20111005220619.GC6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60436 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054Ab1JGGkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 02:40:47 -0400
Received: by mail-yx0-f176.google.com with SMTP id 22so4002083yxn.7
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 23:40:46 -0700 (PDT)
In-Reply-To: <20111005220619.GC6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 06 October 2011 03:36 AM, Tony Lindgren wrote:
> * Nicolas Pitre <nico@fluxnic.net> [111004 17:26]:
>> On Tue, 4 Oct 2011, Tony Lindgren wrote:
>>
>>> This allows mapping external memory such as SRAM for use.
>>>
>>> This is needed for some small chunks of code, such as reprogramming
>>> SDRAM memory source clocks that can't be executed in SDRAM. Other
>>> use cases include some PM related code.
>>>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>>
>> As mentioned, you might consider dropping the export until needed.
> 
> Here's this one updated to drop the export.
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 4 Oct 2011 18:26:27 -0700
> Subject: [PATCH] ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY
> 
> This allows mapping external memory such as SRAM for use.
> 
> This is needed for some small chunks of code, such as reprogramming
> SDRAM memory source clocks that can't be executed in SDRAM. Other
> use cases include some PM related code.
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
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
Why don't we allow user to pass the mtype here ?
We do have a need also to map a page of DDR and SRAM as
strongly ordered for errata fix and this interface can be
used for that.
Ofcourse, SO memory type is not executable memories, so the
API name might be miss-leading.

Regards
Santosh

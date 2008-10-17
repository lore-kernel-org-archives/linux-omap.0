From: Tony Lindgren <tony@atomide.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 16 Oct 2008 17:17:51 -0700
Message-ID: <20081017001750.GE15820@atomide.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com> <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63469 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbYJQARy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 20:17:54 -0400
Content-Disposition: inline
In-Reply-To: <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>

* Nathan Monson <nmonson@gmail.com> [081008 13:22]:
> On Wed, Oct 8, 2008 at 11:36 AM, Nathan Monson <nmonson@gmail.com> wrote:
> > "Felipe Contreras" <felipe.contreras@gmail.com> writes:
> >> irq -33, desc: c0335cf8, depth: 0, count: 0, unhandled: 0
> >
> > On the BeagleBoard list, Pratheesh Gangadhar said that mapping I/O
> > regions as Strongly Ordered suppresses this problem:
> > http://groups.google.com/group/beagleboard/browse_thread/thread/23e1c95b4bfb09b5/70d12dca569ca503?show_docid=70d12dca569ca503
> 
> Pratheesh helped me make a patch against the latest linux-omap git to
> try this.
> 
> With this patch, my IRQ -33 problems with the DSP have disappeared.
> Before, I would end up in IRQ -33 loop after 10 invocations of the DSP
> Bridge 'ping.out' utility.  I just finished running it 50,000 times
> without error.
> 
> As stated before, this patch is just a workaround for testing
> purposes, not a fix.  Who knows what performance side effects it
> has...

OK, pushed this for now until we know if there's a better solution.

Tony

> 
> ---
> diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
> index 9eb936e..5cb4f5f 100644
> --- a/arch/arm/include/asm/mach/map.h
> +++ b/arch/arm/include/asm/mach/map.h
> @@ -25,6 +25,7 @@ struct map_desc {
>  #define MT_HIGH_VECTORS		8
>  #define MT_MEMORY		9
>  #define MT_ROM			10
> +#define MT_MEMORY_SO		11
> 
>  #define MT_NONSHARED_DEVICE	MT_DEVICE_NONSHARED
>  #define MT_IXP2000_DEVICE	MT_DEVICE_IXP2000
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index adbe21f..c11c0e8 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -119,13 +119,13 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
>  		.virtual	= L3_34XX_VIRT,
>  		.pfn		= __phys_to_pfn(L3_34XX_PHYS),
>  		.length		= L3_34XX_SIZE,
> -		.type		= MT_DEVICE
> +		.type		= MT_MEMORY_SO
>  	},
>  	{
>  		.virtual	= L4_34XX_VIRT,
>  		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
>  		.length		= L4_34XX_SIZE,
> -		.type		= MT_DEVICE
> +		.type		= MT_MEMORY_SO
>  	},
>  	{
>  		.virtual	= L4_WK_34XX_VIRT,
> @@ -137,19 +137,19 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
>  		.virtual	= OMAP34XX_GPMC_VIRT,
>  		.pfn		= __phys_to_pfn(OMAP34XX_GPMC_PHYS),
>  		.length		= OMAP34XX_GPMC_SIZE,
> -		.type		= MT_DEVICE
> +		.type		= MT_MEMORY_SO
>  	},
>  	{
>  		.virtual	= OMAP343X_SMS_VIRT,
>  		.pfn		= __phys_to_pfn(OMAP343X_SMS_PHYS),
>  		.length		= OMAP343X_SMS_SIZE,
> -		.type		= MT_DEVICE
> +		.type		= MT_MEMORY_SO
>  	},
>  	{
>  		.virtual	= OMAP343X_SDRC_VIRT,
>  		.pfn		= __phys_to_pfn(OMAP343X_SDRC_PHYS),
>  		.length		= OMAP343X_SDRC_SIZE,
> -		.type		= MT_DEVICE
> +		.type		= MT_MEMORY_SO
>  	},
>  	{
>  		.virtual	= L4_PER_34XX_VIRT,
> @@ -161,7 +161,7 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
>  		.virtual	= L4_EMU_34XX_VIRT,
>  		.pfn		= __phys_to_pfn(L4_EMU_34XX_PHYS),
>  		.length		= L4_EMU_34XX_SIZE,
> -		.type		= MT_DEVICE
> +		.type		= MT_MEMORY_SO
>  	},
>  };
>  #endif
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index a713e40..d5f25ad 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -245,6 +245,10 @@ static struct mem_type mem_types[] = {
>  		.prot_sect = PMD_TYPE_SECT,
>  		.domain    = DOMAIN_KERNEL,
>  	},
> +	[MT_MEMORY_SO] = {
> +		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_UNCACHED,
> +		.domain    = DOMAIN_KERNEL,
> +	},
>  };
> 
>  const struct mem_type *get_mem_type(unsigned int type)
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

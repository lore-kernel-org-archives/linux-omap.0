From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Tue, 5 Aug 2008 12:49:21 +0100
Message-ID: <20080805114920.GC27299@trinity.fluff.org>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:56019 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbYHELtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:49:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, r-woodruff2@ti.com

On Mon, Aug 04, 2008 at 05:40:57PM -0600, Paul Walmsley wrote:
> 
> Add the MT_MEMORY_STRONGLY_ORDERED memory type for ARM strongly ordered
> memory.
> 
> This is used on OMAP3 for on-board SRAM.  On OMAP, SRAM is used for code 
> that changes the SDRAM controller's clock, temporarily blocking access to 
> SDRAM.  During this period, as code executes from SRAM, the ARM cache 
> controller can attempt to write dirty cache lines back to SDRAM to make 
> room for SRAM cache lines, causing the MPU subsystem to hang.  To avoid 
> this, we mark SRAM as strongly- ordered memory.

Is the controller allowed to write dirty cache lines out at any time it
likes? Surely a better fix is to drain the cache of the changes before
changing the clock for the SDRAM?
 
> Problem noted by Richard Woodruff <r-woodruff2@ti.com>.  Fix derived
> from the TI CDP codebase.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> 
>  arch/arm/mm/mmu.c          |    5 +++++
>  include/asm-arm/mach/map.h |   13 +++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 2d6d682..5b56539 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -239,6 +239,11 @@ static struct mem_type mem_types[] = {
>  		.prot_sect = PMD_TYPE_SECT,
>  		.domain    = DOMAIN_KERNEL,
>  	},
> +	[MT_MEMORY_STRONGLY_ORDERED] = {
> +		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE |
> +				PMD_SECT_UNCACHED,
> +		.domain    = DOMAIN_KERNEL,
> +	},
>  };
>  
>  const struct mem_type *get_mem_type(unsigned int type)
> diff --git a/include/asm-arm/mach/map.h b/include/asm-arm/mach/map.h
> index 7ef3c83..8cb46b7 100644
> --- a/include/asm-arm/mach/map.h
> +++ b/include/asm-arm/mach/map.h
> @@ -19,12 +19,13 @@ struct map_desc {
>  };
>  
>  /* types 0-3 are defined in asm/io.h */
> -#define MT_CACHECLEAN		4
> -#define MT_MINICLEAN		5
> -#define MT_LOW_VECTORS		6
> -#define MT_HIGH_VECTORS		7
> -#define MT_MEMORY		8
> -#define MT_ROM			9
> +#define MT_CACHECLEAN			4
> +#define MT_MINICLEAN			5
> +#define MT_LOW_VECTORS			6
> +#define MT_HIGH_VECTORS			7
> +#define MT_MEMORY			8
> +#define MT_ROM				9
> +#define MT_MEMORY_STRONGLY_ORDERED	10
>  
>  #define MT_NONSHARED_DEVICE	MT_DEVICE_NONSHARED
>  #define MT_IXP2000_DEVICE	MT_DEVICE_IXP2000
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


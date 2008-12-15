From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/23] ARM: MMU: add a Non-cacheable Normal executable
	memory type
Date: Mon, 15 Dec 2008 11:06:21 -0800
Message-ID: <20081215190620.GA10664@atomide.com>
References: <1229010762-3150-1-git-send-email-tero.kristo@nokia.com> <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53976 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbYLOTGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:06:24 -0500
Content-Disposition: inline
In-Reply-To: <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

* Tero Kristo <tero.kristo@nokia.com> [081211 07:59]:
> From: Paul Walmsley <paul@pwsan.com>
> 
> Add a Non-cacheable Normal ARM executable memory type,
> MT_MEMORY_NONCACHED.  This is needed for the OMAP3 SDRAM clock change
> code, which must run from SRAM.  The SRAM must be marked as
> non-cacheable memory to avoid dirty cache line writebacks to SDRAM
> while the SDRAM controller is paused.

This should be discussed on LAKML.

Tony

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/include/asm/mach/map.h |    1 +
>  arch/arm/mm/mmu.c               |   23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
> index 39d949b..58cf91f 100644
> --- a/arch/arm/include/asm/mach/map.h
> +++ b/arch/arm/include/asm/mach/map.h
> @@ -26,6 +26,7 @@ struct map_desc {
>  #define MT_HIGH_VECTORS		8
>  #define MT_MEMORY		9
>  #define MT_ROM			10
> +#define MT_MEMORY_NONCACHED	11
>  
>  #ifdef CONFIG_MMU
>  extern void iotable_init(struct map_desc *, int);
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 7f36c82..9ad6413 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -242,6 +242,10 @@ static struct mem_type mem_types[] = {
>  		.prot_sect = PMD_TYPE_SECT,
>  		.domain    = DOMAIN_KERNEL,
>  	},
> +	[MT_MEMORY_NONCACHED] = {
> +		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
> +		.domain    = DOMAIN_KERNEL,
> +	},
>  };
>  
>  const struct mem_type *get_mem_type(unsigned int type)
> @@ -405,9 +409,28 @@ static void __init build_mem_type_table(void)
>  		kern_pgprot |= L_PTE_SHARED;
>  		vecs_pgprot |= L_PTE_SHARED;
>  		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
> +		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
>  #endif
>  	}
>  
> +	/*
> +	 * Non-cacheable Normal - intended for memory areas that must
> +	 * not cause cache line evictions when used
> +	 */
> +	if (cpu_arch >= CPU_ARCH_ARMv6) {
> +		if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
> +			/* Non-cacheable Normal is XCB = 001 */
> +			mem_types[MT_MEMORY_NONCACHED].prot_sect |=
> +				PMD_SECT_BUFFERED;
> +		} else {
> +			/* For both ARMv6 and non-TEX-remapping ARMv7 */
> +			mem_types[MT_MEMORY_NONCACHED].prot_sect |=
> +				PMD_SECT_TEX(1);
> +		}
> +	} else {
> +		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_BUFFERABLE;
> +	}
> +
>  	for (i = 0; i < 16; i++) {
>  		unsigned long v = pgprot_val(protection_map[i]);
>  		protection_map[i] = __pgprot(v | user_pgprot);
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

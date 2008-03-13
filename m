From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/06] Sram Driver Support for 3430
Date: Thu, 13 Mar 2008 13:28:49 +0200
Message-ID: <20080313112849.GD11653@atomide.com>
References: <F6FE727D1D69E340844C253265136D5D0421FFB5@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65298 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYCML3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 07:29:04 -0400
Content-Disposition: inline
In-Reply-To: <F6FE727D1D69E340844C253265136D5D0421FFB5@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasu, Karthik P" <karthik-dp@ti.com>
Cc: linux-omap@vger.kernel.org

* Dasu, Karthik P <karthik-dp@ti.com> [080303 23:54]:
> Sram Driver support for 3430

I've pushed the 34xx SRAM init part of this.

Tony

> Signed-off-by: Karthik Dasu<karthik-dp@ti.com>
> Acked-by: Richard Woodruff <r-woodruff2@ti.com>
> Acked-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/sram.c        |  105 +++++++++++++++++++++++++++++++++++----
>  include/asm-arm/arch-omap/sram.h |    8 ++
>  2 files changed, 103 insertions(+), 10 deletions(-)
> 
> Index: git-latest5/arch/arm/plat-omap/sram.c
> ===================================================================
> --- git-latest5.orig/arch/arm/plat-omap/sram.c	2008-02-29 21:54:22.276024670 +0530
> +++ git-latest5/arch/arm/plat-omap/sram.c	2008-02-29 21:55:31.614787643 +0530
> @@ -39,6 +39,10 @@
>  #define OMAP2_SRAM_PUB_PA	0x4020f800
>  #define OMAP2_SRAM_VA		VMALLOC_END
>  #define OMAP2_SRAM_PUB_VA	(VMALLOC_END + 0x800)
> +#define OMAP3_SRAM_PA           0x40200000
> +#define OMAP3_SRAM_VA           0xd7000000
> +#define OMAP3_SRAM_PUB_PA       0x40208000
> +#define OMAP3_SRAM_PUB_VA       0xd7008000
>  
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  #define SRAM_BOOTLOADER_SZ	0x00
> @@ -46,9 +50,19 @@
>  #define SRAM_BOOTLOADER_SZ	0x80
>  #endif
>  
> +#if defined(CONFIG_ARCH_OMAP34XX)
> +#define VA_REQINFOPERM0         IO_ADDRESS(0x68012848)
> +#define VA_READPERM0            IO_ADDRESS(0x68012850)
> 	+#define VA_WRITEPERM0           IO_ADDRESS(0x68012858)
> +#else
>  #define VA_REQINFOPERM0		IO_ADDRESS(0x68005048)
>  #define VA_READPERM0		IO_ADDRESS(0x68005050)
>  #define VA_WRITEPERM0		IO_ADDRESS(0x68005058)
> +#endif
> +#define VA_ADDR_MATCH2          IO_ADDRESS(0x68012880)
> +#define VA_SMS_RG_ATT0          IO_ADDRESS(0x6C000048)
> +#define VA_CONTROL_STAT         IO_ADDRESS(0x480022F0)
> +
>  #define GP_DEVICE		0x300
>  
>  #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
> @@ -102,6 +116,13 @@
>  			__raw_writel(0xCFDE, VA_READPERM0);  /* all i-read */
>  			__raw_writel(0xCFDE, VA_WRITEPERM0); /* all i-write */
>  		}
> +		if (cpu_is_omap34xx()) {
> +			__raw_writel(0xFFFF, VA_REQINFOPERM0); /* all q-vects */
> +			__raw_writel(0xFFFF, VA_READPERM0);  /* all i-read */
> +			__raw_writel(0xFFFF, VA_WRITEPERM0); /* all i-write */
> +			__raw_writel(0x0, VA_ADDR_MATCH2);
> +			__raw_writel(0xFFFFFFFF, VA_SMS_RG_ATT0);
> +		}
>  		return 0;
>  	} else
>  		return 1; /* assume locked with no PPA or security driver */
> @@ -119,16 +140,28 @@
>  
>  	if (cpu_class_is_omap2()) {
>  		if (is_sram_locked()) {
> -			omap_sram_base = OMAP2_SRAM_PUB_VA;
> -			omap_sram_start = OMAP2_SRAM_PUB_PA;
> -			omap_sram_size = 0x800; /* 2K */
> +			if (cpu_is_omap34xx()) {
> +				omap_sram_base = OMAP3_SRAM_PUB_VA;
> +				omap_sram_start = OMAP3_SRAM_PUB_PA;
> +				omap_sram_size = 0x8000; /* 32K */
> +			} else {
> +				omap_sram_base = OMAP2_SRAM_PUB_VA;
> +				omap_sram_start = OMAP2_SRAM_PUB_PA;
> +				omap_sram_size = 0x800; /* 2K */
> +			}
>  		} else {
> -			omap_sram_base = OMAP2_SRAM_VA;
> -			omap_sram_start = OMAP2_SRAM_PA;
> -			if (cpu_is_omap242x())
> -				omap_sram_size = 0xa0000; /* 640K */
> -			else if (cpu_is_omap243x() || cpu_is_omap34xx())
> +			if (cpu_is_omap34xx()) {
> +				omap_sram_base = OMAP3_SRAM_VA;
> +				omap_sram_start = OMAP3_SRAM_PA;
>  				omap_sram_size = 0x10000; /* 64K */
> +			} else {
> +				omap_sram_base = OMAP2_SRAM_VA;
> +				omap_sram_start = OMAP2_SRAM_PA;
> +				if (cpu_is_omap242x())
> +					omap_sram_size = 0xa0000; /* 640K */
> +				else if (cpu_is_omap243x())
> +					omap_sram_size = 0x10000; /* 64K */
> +			}
>  		}
>  	} else {
>  		omap_sram_base = OMAP1_SRAM_VA;
> @@ -174,7 +207,7 @@
>  	if (omap_sram_size == 0)
>  		return;
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_is_omap24xx()) {
>  		omap_sram_io_desc[0].virtual = OMAP2_SRAM_VA;
>  
>  		base = OMAP2_SRAM_PA;
> @@ -182,6 +215,13 @@
>  		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
>  	}
>  
> +	if (cpu_is_omap34xx()) {
> +		omap_sram_io_desc[0].virtual = OMAP3_SRAM_VA;
> +		base = OMAP3_SRAM_PA;
> +		base = ROUND_DOWN(base, PAGE_SIZE);
> +		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
> +	}
> +
>  	omap_sram_io_desc[0].length = 1024 * 1024;	/* Use section desc */
>  	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
>  
> @@ -336,6 +376,9 @@
>  	return _omap2_sram_reprogram_sdrc(perf_level, dll_val, mem_type);
>  }
>  
> +#endif
> +
> +#if !defined(CONFIG_OMAP3_PM)
>  static u32 (*_omap2_set_prcm)(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
>  
>  u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
> @@ -346,8 +389,38 @@
>  	return _omap2_set_prcm(dpll_ctrl_val, sdrc_rfr_val, bypass);
>  }
>  
> +#endif
> +
> +#if defined(CONFIG_OMAP3_PM)
> +static u32 (*_omap3_configure_core_dpll)(u32 m, u32 n, u32 freqsel, u32 m2);
> +
> +u32 omap3_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2)
> +{
> +	if (!_omap3_configure_core_dpll)
> +		omap_sram_error();
> +	return _omap3_configure_core_dpll(m, n, freqsel, m2);
> +}
> +
> +static u32 (*_omap3_sram_reprogram_gpmc)(u32 perf_level);
> +
> +u32 omap3_sram_reprogram_gpmc(u32 perf_level)
> +{
> +	if (!_omap3_sram_reprogram_gpmc)
> +		omap_sram_error();
> +
> +	return _omap3_sram_reprogram_gpmc(perf_level);
> +}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  int __init omap2_sram_init(void)
>  {
> +#if defined(CONFIG_OMAP3_PM)
> +	_omap3_configure_core_dpll = omap_sram_push(sram_configure_core_dpll,
> +			sram_configure_core_dpll_sz);
> +	_omap3_sram_reprogram_gpmc = omap_sram_push(sram_reprogram_gpmc,
> +			sram_reprogram_gpmc_sz);
> +#else
>  	_omap2_sram_ddr_init = omap_sram_push(sram_ddr_init, sram_ddr_init_sz);
>  
>  	/* Patch in the correct register addresses for multiboot */
> @@ -403,7 +476,7 @@
>  	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_dlla_ctrl,
>  			   _omap2_set_prcm,
>  			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
> -
> +#endif
>  	return 0;
>  }
>  #else
> @@ -422,3 +495,15 @@
>  
>  	return 0;
>  }
> +
> +#if defined(CONFIG_OMAP3_PM)
> +void restore_sram_functions(void)
> +{
> +	omap_sram_ceil = omap_sram_base + omap_sram_size;
> +	_omap3_configure_core_dpll =
> +		omap_sram_push(sram_configure_core_dpll,
> +		sram_configure_core_dpll_sz);
> +	_omap3_sram_reprogram_gpmc = omap_sram_push(sram_reprogram_gpmc,
> +		sram_reprogram_gpmc_sz);
> +}
> +#endif
> Index: git-latest5/include/asm-arm/arch-omap/sram.h
> ===================================================================
> --- git-latest5.orig/include/asm-arm/arch-omap/sram.h	2008-02-29 21:54:22.276024670 +0530
> +++ git-latest5/include/asm-arm/arch-omap/sram.h	2008-02-29 21:55:31.615787611 +0530
> @@ -37,4 +37,12 @@
>  extern void sram_reprogram_sdrc(u32 perf_level, u32 dll_val, u32 mem_type);
>  extern unsigned long sram_reprogram_sdrc_sz;
>  
> +#if defined(CONFIG_ARCH_OMAP34XX)
> +extern u32 sram_reprogram_gpmc(u32 perf_level);
> +extern unsigned long sram_reprogram_gpmc_sz;
> +
> +extern u32 sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2);
> +extern unsigned long sram_configure_core_dpll_sz;
> +#endif
> +
>  #endif
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

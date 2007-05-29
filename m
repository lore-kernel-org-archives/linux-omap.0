From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/11] OMAP 3430 support in include/arm/arch-omap
Date: Tue, 29 May 2007 10:06:17 -0700
Message-ID: <20070529170617.GE26322@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E37@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0E37@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070528 23:23]:
> 
> Adding OMAP3430 support to include/asm-arm/arch-omap
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files Changed:
>  clock.h       |    1
>  cpu.h         |   28 +++++++++++++++++++++++
>  debug-macro.S |   12 ++++++++++
>  dma.h         |   68 +++++++++++++++++++++++++++++-----------------------------
>  entry-macro.S |    6 ++++-
>  hardware.h    |   12 +++++++++-
>  io.h          |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  irqs.h        |   17 ++++++++++++++
>  mcbsp.h       |    2 -
>  memory.h      |    2 -
>  serial.h      |    5 ++++
> 
> =======================================================================
> diff -purN linux-omap/include/asm-arm/arch-omap/clock.h val_3430_GIT/include/asm-arm/arch-omap/clock.h
> --- linux-omap/include/asm-arm/arch-omap/clock.h	2006-11-20 21:56:59.000000000 -0600
> +++ val_3430_GIT/include/asm-arm/arch-omap/clock.h	2007-05-25 22:38:46.000000000 -0500
> @@ -87,5 +87,6 @@ extern int clk_get_usecount(struct clk *
>  #define CLOCK_IN_OMAP16XX	(1 << 24)
>  #define CLOCK_IN_OMAP242X	(1 << 25)
>  #define CLOCK_IN_OMAP243X	(1 << 26)
> +#define CLOCK_IN_OMAP343X	(1 << 27)
>  
>  #endif
> diff -purN linux-omap/include/asm-arm/arch-omap/cpu.h val_3430_GIT/include/asm-arm/arch-omap/cpu.h
> --- linux-omap/include/asm-arm/arch-omap/cpu.h	2006-11-20 21:56:59.000000000 -0600
> +++ val_3430_GIT/include/asm-arm/arch-omap/cpu.h	2007-05-25 22:59:27.000000000 -0500
> @@ -35,6 +35,7 @@ extern unsigned int system_rev;
>   */
>  #undef MULTI_OMAP1
>  #undef MULTI_OMAP2
> +#undef MULTI_OMAP3
>  #undef OMAP_NAME
>  
>  #ifdef CONFIG_ARCH_OMAP730
> @@ -69,6 +70,14 @@ extern unsigned int system_rev;
>  #  define OMAP_NAME omap24xx
>  # endif
>  #endif
> +#ifdef CONFIG_ARCH_OMAP34XX
> +# if (defined(OMAP_NAME) || defined(MULTI_OMAP1) || defined(MULTI_OMAP2))
> +#  error "OMAP1 / OMAP2 / OMAP3 can't be selected at the same time"
> +# else
> +#  undef MULTI_OMAP3
> +#  define OMAP_NAME omap34xx
> +# endif
> +#endif

MULTI_OMAP2 and MULTI_OMAP3 should work the same time unoptimized. I
guess this is OK for now though.

>  
> diff -purN linux-omap/include/asm-arm/arch-omap/dma.h val_3430_GIT/include/asm-arm/arch-omap/dma.h
> --- linux-omap/include/asm-arm/arch-omap/dma.h	2007-05-16 14:33:06.000000000 -0500
> +++ val_3430_GIT/include/asm-arm/arch-omap/dma.h	2007-05-25 22:59:27.000000000 -0500
> @@ -45,22 +45,22 @@
>  #define OMAP_DMA_PCHD_SR		(OMAP_DMA_BASE + 0x4c0)
>  
>  /* Hardware registers for omap2 */
> -#define OMAP24XX_DMA_BASE		(L4_24XX_BASE + 0x56000)
> -#define OMAP_DMA4_REVISION		(OMAP24XX_DMA_BASE + 0x00)
> -#define OMAP_DMA4_GCR_REG		(OMAP24XX_DMA_BASE + 0x78)
> -#define OMAP_DMA4_IRQSTATUS_L0		(OMAP24XX_DMA_BASE + 0x08)
> -#define OMAP_DMA4_IRQSTATUS_L1		(OMAP24XX_DMA_BASE + 0x0c)
> -#define OMAP_DMA4_IRQSTATUS_L2		(OMAP24XX_DMA_BASE + 0x10)
> -#define OMAP_DMA4_IRQSTATUS_L3		(OMAP24XX_DMA_BASE + 0x14)
> -#define OMAP_DMA4_IRQENABLE_L0		(OMAP24XX_DMA_BASE + 0x18)
> -#define OMAP_DMA4_IRQENABLE_L1		(OMAP24XX_DMA_BASE + 0x1c)
> -#define OMAP_DMA4_IRQENABLE_L2		(OMAP24XX_DMA_BASE + 0x20)
> -#define OMAP_DMA4_IRQENABLE_L3		(OMAP24XX_DMA_BASE + 0x24)
> -#define OMAP_DMA4_SYSSTATUS		(OMAP24XX_DMA_BASE + 0x28)
> -#define OMAP_DMA4_CAPS_0		(OMAP24XX_DMA_BASE + 0x64)
> -#define OMAP_DMA4_CAPS_2		(OMAP24XX_DMA_BASE + 0x6c)
> -#define OMAP_DMA4_CAPS_3		(OMAP24XX_DMA_BASE + 0x70)
> -#define OMAP_DMA4_CAPS_4		(OMAP24XX_DMA_BASE + 0x74)
> +#define OMAP_DMA4_BASE			(L4_OMAP_BASE + 0x56000)
> +#define OMAP_DMA4_REVISION		(OMAP_DMA4_BASE + 0x00)
> +#define OMAP_DMA4_GCR_REG		(OMAP_DMA4_BASE + 0x78)
> +#define OMAP_DMA4_IRQSTATUS_L0		(OMAP_DMA4_BASE + 0x08)
> +#define OMAP_DMA4_IRQSTATUS_L1		(OMAP_DMA4_BASE + 0x0c)
> +#define OMAP_DMA4_IRQSTATUS_L2		(OMAP_DMA4_BASE + 0x10)
> +#define OMAP_DMA4_IRQSTATUS_L3		(OMAP_DMA4_BASE + 0x14)
> +#define OMAP_DMA4_IRQENABLE_L0		(OMAP_DMA4_BASE + 0x18)
> +#define OMAP_DMA4_IRQENABLE_L1		(OMAP_DMA4_BASE + 0x1c)
> +#define OMAP_DMA4_IRQENABLE_L2		(OMAP_DMA4_BASE + 0x20)
> +#define OMAP_DMA4_IRQENABLE_L3		(OMAP_DMA4_BASE + 0x24)
> +#define OMAP_DMA4_SYSSTATUS		(OMAP_DMA4_BASE + 0x28)
> +#define OMAP_DMA4_CAPS_0		(OMAP_DMA4_BASE + 0x64)
> +#define OMAP_DMA4_CAPS_2		(OMAP_DMA4_BASE + 0x6c)
> +#define OMAP_DMA4_CAPS_3		(OMAP_DMA4_BASE + 0x70)
> +#define OMAP_DMA4_CAPS_4		(OMAP_DMA4_BASE + 0x74)
>  
>  #ifdef CONFIG_ARCH_OMAP1
>  
> @@ -86,19 +86,19 @@
>  #define OMAP_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
>  
>  /* Common channel specific registers for omap2 */
> -#define OMAP_DMA_CCR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x80)
> -#define OMAP_DMA_CLNK_CTRL_REG(n)	__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x84)
> -#define OMAP_DMA_CICR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x88)
> -#define OMAP_DMA_CSR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x8c)
> -#define OMAP_DMA_CSDP_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x90)
> -#define OMAP_DMA_CEN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x94)
> -#define OMAP_DMA_CFN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x98)
> -#define OMAP_DMA_CSEI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xa4)
> -#define OMAP_DMA_CSFI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xa8)
> -#define OMAP_DMA_CDEI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xac)
> -#define OMAP_DMA_CDFI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xb0)
> -#define OMAP_DMA_CSAC_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xb4)
> -#define OMAP_DMA_CDAC_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xb8)
> +#define OMAP_DMA_CCR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x80)
> +#define OMAP_DMA_CLNK_CTRL_REG(n)	__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x84)
> +#define OMAP_DMA_CICR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x88)
> +#define OMAP_DMA_CSR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x8c)
> +#define OMAP_DMA_CSDP_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x90)
> +#define OMAP_DMA_CEN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x94)
> +#define OMAP_DMA_CFN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x98)
> +#define OMAP_DMA_CSEI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xa4)
> +#define OMAP_DMA_CSFI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xa8)
> +#define OMAP_DMA_CDEI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xac)
> +#define OMAP_DMA_CDFI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xb0)
> +#define OMAP_DMA_CSAC_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xb4)
> +#define OMAP_DMA_CDAC_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xb8)
>  
>  #endif
>  
> @@ -113,11 +113,11 @@
>  #define OMAP1_DMA_LCH_CTRL_REG(n)	__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x2a)
>  
>  /* Channel specific registers only on omap2 */
> -#define OMAP2_DMA_CSSA_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0x9c)
> -#define OMAP2_DMA_CDSA_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xa0)
> -#define OMAP2_DMA_CCEN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xbc)
> -#define OMAP2_DMA_CCFN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xc0)
> -#define OMAP2_DMA_COLOR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + 0xc4)
> +#define OMAP2_DMA_CSSA_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x9c)
> +#define OMAP2_DMA_CDSA_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xa0)
> +#define OMAP2_DMA_CCEN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xbc)
> +#define OMAP2_DMA_CCFN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xc0)
> +#define OMAP2_DMA_COLOR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0xc4)
>  
>  /*----------------------------------------------------------------------------*/
>  

The change to use DMA4_BASE should be a separate pre-3430 patch.


> diff -purN linux-omap/include/asm-arm/arch-omap/entry-macro.S val_3430_GIT/include/asm-arm/arch-omap/entry-macro.S
> --- linux-omap/include/asm-arm/arch-omap/entry-macro.S	2007-05-25 15:52:27.000000000 -0500
> +++ val_3430_GIT/include/asm-arm/arch-omap/entry-macro.S	2007-05-25 22:59:27.000000000 -0500
> @@ -54,9 +54,13 @@
>  1510:
>  		.endm
>  
> -#elif defined(CONFIG_ARCH_OMAP24XX)
> +#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  
> +#if defined(CONFIG_ARCH_OMAP24XX)
>  #include <asm/arch/omap24xx.h>
> +#elif defined(CONFIG_ARCH_OMAP34XX)
> +#include <asm/arch/omap34xx.h>
> +#endif
>  
>  		.macro	disable_fiq
>  		.endm

The #elif should be just #if.


> diff -purN linux-omap/include/asm-arm/arch-omap/io.h val_3430_GIT/include/asm-arm/arch-omap/io.h
> --- linux-omap/include/asm-arm/arch-omap/io.h	2007-05-25 15:52:27.000000000 -0500
> +++ val_3430_GIT/include/asm-arm/arch-omap/io.h	2007-05-28 12:47:13.000000000 -0500
> @@ -105,6 +105,63 @@
>  #define DSP_MMU_24XX_VIRT	0xe2000000
>  #define DSP_MMU_24XX_SIZE	SZ_4K
>  
> +#elif defined(CONFIG_ARCH_OMAP3)
> +
> +/* We map both L3 and L4 on OMAP3 */
> +#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 */
> +#define L3_34XX_VIRT		0xf8000000
> +#define L3_34XX_SIZE		SZ_1M   /* 44kB of 128MB used, want 1MB sect */
> +
> +#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 */
> +#define L4_34XX_VIRT		0xd8000000
> +#define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
> +

Some more clean-up to be done here for multiboot...

Really we should have io mapping structs for 2420, 2430, 3430
and then just set the right one in place in init based on the cpu
detection.

I guess this is OK for now though.

Regards,

Tony

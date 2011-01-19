From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Wed, 19 Jan 2011 10:31:33 -0800
Message-ID: <87vd1ksq2i.fsf@ti.com>
References: <1295352126-29171-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50588 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752356Ab1ASSbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 13:31:37 -0500
Received: by pxi19 with SMTP id 19so185584pxi.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 10:31:36 -0800 (PST)
In-Reply-To: <1295352126-29171-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Tue, 18 Jan 2011 13:02:06 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> The new fncpy API is better suited for copying some
> code to SRAM at runtime. This patch changes the ad-hoc
> code to the more generic fncpy API.
>
> Tested OK on OMAP3 in low power modes (RET/OFF)
> using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.
> Compile tested on OMAP1/2 using omap1_defconfig.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Boot tested on OMAP1 & OMAP2 as well.  Note that neither OMAP1 or OMAP2
has had working suspend/resume for a long time now, so I did not test
suspend/resume.

Kevin

> ---
>  arch/arm/mach-omap1/pm.h               |    6 +++---
>  arch/arm/mach-omap1/sleep.S            |    3 +++
>  arch/arm/mach-omap1/sram.S             |    1 +
>  arch/arm/mach-omap2/pm.h               |    2 +-
>  arch/arm/mach-omap2/sleep24xx.S        |    2 ++
>  arch/arm/mach-omap2/sleep34xx.S        |    2 ++
>  arch/arm/mach-omap2/sram242x.S         |    3 +++
>  arch/arm/mach-omap2/sram243x.S         |    3 +++
>  arch/arm/mach-omap2/sram34xx.S         |    1 +
>  arch/arm/plat-omap/include/plat/sram.h |   14 +++++++++++++-
>  arch/arm/plat-omap/sram.c              |   14 +++++++++-----
>  11 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/pm.h b/arch/arm/mach-omap1/pm.h
> index 56a6479..cd926dc 100644
> --- a/arch/arm/mach-omap1/pm.h
> +++ b/arch/arm/mach-omap1/pm.h
> @@ -123,9 +123,9 @@ extern void allow_idle_sleep(void);
>  extern void omap1_pm_idle(void);
>  extern void omap1_pm_suspend(void);
>  
> -extern void omap7xx_cpu_suspend(unsigned short, unsigned short);
> -extern void omap1510_cpu_suspend(unsigned short, unsigned short);
> -extern void omap1610_cpu_suspend(unsigned short, unsigned short);
> +extern void omap7xx_cpu_suspend(unsigned long, unsigned long);
> +extern void omap1510_cpu_suspend(unsigned long, unsigned long);
> +extern void omap1610_cpu_suspend(unsigned long, unsigned long);
>  extern void omap7xx_idle_loop_suspend(void);
>  extern void omap1510_idle_loop_suspend(void);
>  extern void omap1610_idle_loop_suspend(void);
> diff --git a/arch/arm/mach-omap1/sleep.S b/arch/arm/mach-omap1/sleep.S
> index ef771ce..c875bdc 100644
> --- a/arch/arm/mach-omap1/sleep.S
> +++ b/arch/arm/mach-omap1/sleep.S
> @@ -58,6 +58,7 @@
>   */
>  
>  #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> +	.align	3
>  ENTRY(omap7xx_cpu_suspend)
>  
>  	@ save registers on stack
> @@ -137,6 +138,7 @@ ENTRY(omap7xx_cpu_suspend_sz)
>  #endif /* CONFIG_ARCH_OMAP730 || CONFIG_ARCH_OMAP850 */
>  
>  #ifdef CONFIG_ARCH_OMAP15XX
> +	.align	3
>  ENTRY(omap1510_cpu_suspend)
>  
>  	@ save registers on stack
> @@ -211,6 +213,7 @@ ENTRY(omap1510_cpu_suspend_sz)
>  #endif /* CONFIG_ARCH_OMAP15XX */
>  
>  #if defined(CONFIG_ARCH_OMAP16XX)
> +	.align	3
>  ENTRY(omap1610_cpu_suspend)
>  
>  	@ save registers on stack
> diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
> index 7724e52..692587d 100644
> --- a/arch/arm/mach-omap1/sram.S
> +++ b/arch/arm/mach-omap1/sram.S
> @@ -18,6 +18,7 @@
>  /*
>   * Reprograms ULPD and CKCTL.
>   */
> +	.align	3
>  ENTRY(omap1_sram_reprogram_clock)
>  	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
>  
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 1c1b0ab..39580e6 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -92,7 +92,7 @@ extern void omap24xx_idle_loop_suspend(void);
>  extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
>  					void __iomem *sdrc_power);
>  extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
> -extern void save_secure_ram_context(u32 *addr);
> +extern int save_secure_ram_context(u32 *addr);
>  extern void omap3_save_scratchpad_contents(void);
>  
>  extern unsigned int omap24xx_idle_loop_suspend_sz;
> diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
> index c7780cc..b5071a4 100644
> --- a/arch/arm/mach-omap2/sleep24xx.S
> +++ b/arch/arm/mach-omap2/sleep24xx.S
> @@ -47,6 +47,7 @@
>   * Note: This code get's copied to internal SRAM at boot. When the OMAP
>   *	 wakes up it continues execution at the point it went to sleep.
>   */
> +	.align	3
>  ENTRY(omap24xx_idle_loop_suspend)
>  	stmfd	sp!, {r0, lr}		@ save registers on stack
>  	mov	r0, #0			@ clear for mcr setup
> @@ -82,6 +83,7 @@ ENTRY(omap24xx_idle_loop_suspend_sz)
>   * The DLL load value is not kept in RETENTION or OFF.	It needs to be restored
>   * at wake
>   */
> +	.align	3
>  ENTRY(omap24xx_cpu_suspend)
>  	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
>  	mov	r3, #0x0		@ clear for mcr call
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 98d8232..951a0be 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -118,6 +118,7 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
>  
>  	.text
>  /* Function to call rom code to save secure ram context */
> +	.align	3
>  ENTRY(save_secure_ram_context)
>  	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
>  	adr	r3, api_params		@ r3 points to parameters
> @@ -169,6 +170,7 @@ ENTRY(save_secure_ram_context_sz)
>   *   depending on the low power mode (non-OFF vs OFF modes),
>   *   cf. 'Resume path for xxx mode' comments.
>   */
> +	.align	3
>  ENTRY(omap34xx_cpu_suspend)
>  	stmfd	sp!, {r0-r12, lr}	@ save registers on stack
>  
> diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
> index 055310c..ff9b9db 100644
> --- a/arch/arm/mach-omap2/sram242x.S
> +++ b/arch/arm/mach-omap2/sram242x.S
> @@ -39,6 +39,7 @@
>  
>  	.text
>  
> +	.align	3
>  ENTRY(omap242x_sram_ddr_init)
>  	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
>  
> @@ -143,6 +144,7 @@ ENTRY(omap242x_sram_ddr_init_sz)
>   * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
>   * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
>   */
> +	.align	3
>  ENTRY(omap242x_sram_reprogram_sdrc)
>  	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
>  	mov	r3, #0x0		@ clear for mrc call
> @@ -238,6 +240,7 @@ ENTRY(omap242x_sram_reprogram_sdrc_sz)
>  /*
>   * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
>   */
> +	.align	3
>  ENTRY(omap242x_sram_set_prcm)
>  	stmfd	sp!, {r0-r12, lr}	@ regs to stack
>  	adr	r4, pbegin		@ addr of preload start
> diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
> index f900758..7673020 100644
> --- a/arch/arm/mach-omap2/sram243x.S
> +++ b/arch/arm/mach-omap2/sram243x.S
> @@ -39,6 +39,7 @@
>  
>  	.text
>  
> +	.align	3
>  ENTRY(omap243x_sram_ddr_init)
>  	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
>  
> @@ -143,6 +144,7 @@ ENTRY(omap243x_sram_ddr_init_sz)
>   * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
>   * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
>   */
> +	.align	3
>  ENTRY(omap243x_sram_reprogram_sdrc)
>  	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
>  	mov	r3, #0x0		@ clear for mrc call
> @@ -238,6 +240,7 @@ ENTRY(omap243x_sram_reprogram_sdrc_sz)
>  /*
>   * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
>   */
> +	.align	3
>  ENTRY(omap243x_sram_set_prcm)
>  	stmfd	sp!, {r0-r12, lr}	@ regs to stack
>  	adr	r4, pbegin		@ addr of preload start
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index 7f893a2..25011ca 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -111,6 +111,7 @@
>   * since it will cause the ARM MMU to attempt to walk the page tables.
>   * These crashes may be intermittent.
>   */
> +	.align	3
>  ENTRY(omap3_sram_configure_core_dpll)
>  	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
>  
> diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
> index 9967d5e..d673f2c 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -12,7 +12,19 @@
>  #define __ARCH_ARM_OMAP_SRAM_H
>  
>  #ifndef __ASSEMBLY__
> -extern void * omap_sram_push(void * start, unsigned long size);
> +#include <asm/fncpy.h>
> +
> +extern void *omap_sram_push_address(unsigned long size);
> +
> +/* Macro to push a function to the internal SRAM, using the fncpy API */
> +#define omap_sram_push(funcp, size) ({				\
> +	typeof(&funcp) _res = NULL;				\
> +	void *_sram_address = omap_sram_push_address(size);	\
> +	if (_sram_address)					\
> +		_res = fncpy(_sram_address, &funcp, size);	\
> +	_res;							\
> +})
> +
>  extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
>  
>  extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index e26e504..68fcc7d 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -242,7 +242,14 @@ static void __init omap_map_sram(void)
>  	       omap_sram_size - SRAM_BOOTLOADER_SZ);
>  }
>  
> -void * omap_sram_push(void * start, unsigned long size)
> +/*
> + * Memory allocator for SRAM: calculates the new ceiling address
> + * for pushing a function using the fncpy API.
> + *
> + * Note that fncpy requires the returned address to be aligned
> + * to an 8-byte boundary.
> + */
> +void *omap_sram_push_address(unsigned long size)
>  {
>  	if (size > (omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ))) {
>  		printk(KERN_ERR "Not enough space in SRAM\n");
> @@ -250,10 +257,7 @@ void * omap_sram_push(void * start, unsigned long size)
>  	}
>  
>  	omap_sram_ceil -= size;
> -	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
> -	memcpy((void *)omap_sram_ceil, start, size);
> -	flush_icache_range((unsigned long)omap_sram_ceil,
> -		(unsigned long)(omap_sram_ceil + size));
> +	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, FNCPY_ALIGN);
>  
>  	return (void *)omap_sram_ceil;
>  }

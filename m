From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 11/12] arm: omap3: am35x: Add do_wfi routine for EMIF4
 submodules
Date: Wed, 11 Apr 2012 16:36:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111623110.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-12-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33405 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab2DKWg0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 18:36:26 -0400
In-Reply-To: <1334171147-7517-12-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>, Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi

just a few comments based on a quick look

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> diff --git a/arch/arm/mach-omap2/emif4.h b/arch/arm/mach-omap2/emif4.h
> new file mode 100644
> index 0000000..0126af3
> --- /dev/null
> +++ b/arch/arm/mach-omap2/emif4.h
> @@ -0,0 +1,24 @@
> +/*
> + * SDRC Module, EMIF4 Submodule Definitions
> + *
> + * Author: Mark A. Greer <mgreer@animalcreek.com>
> + *
> + * Copyright (c) 2012 by Animal Creek Technologies, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef ____ASM_ARCH_EMIF4_H
> +#define ____ASM_ARCH_EMIF4_H
> +
> +#ifdef __ASSEMBLER__
> +
> +#define OMAP34XX_EMIF4_REGADDR(reg) \
> +		OMAP2_L3_IO_ADDRESS(OMAP343X_EMIF4_BASE + (reg))
> +
> +#endif
> +
> +#define EMIF4_PWR_MGMT_CTRL	0x38
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 36fa90b..ab1262b 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -85,10 +85,13 @@ extern unsigned int omap24xx_cpu_suspend_sz;
>  /* 3xxx */
>  extern void omap34xx_cpu_suspend(int save_state);
>  
> -/* omap3_do_wfi function pointer and size, for copy to SRAM */
> +/* omap3*_do_wfi function pointers and sizes, for copy to SRAM */
>  extern void omap3_do_wfi(void);
>  extern unsigned int omap3_do_wfi_sz;
> -/* ... and its pointer from SRAM after copy */
> +extern void omap3_emif4_do_wfi(void);
> +extern unsigned int omap3_emif4_do_wfi_sz;
> +/* ... and pointers when in SDRAM and in SRAM after copy */
> +extern void (*omap3_do_wfi_sdram)(void);
>  extern void (*omap3_do_wfi_sram)(void);
>  
>  /* save_secure_ram_context function pointer and size, for copy to SRAM */
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 00c4abe..c1dee25 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -66,6 +66,7 @@ struct power_state {
>  static LIST_HEAD(pwrst_list);
>  
>  static int (*_omap_save_secure_sram)(u32 *addr);
> +void (*omap3_do_wfi_sdram)(void);
>  void (*omap3_do_wfi_sram)(void);
>  
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
> @@ -694,7 +695,15 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>   */
>  void omap_push_sram_idle(void)
>  {
> -	omap3_do_wfi_sram = omap_sram_push(omap3_do_wfi, omap3_do_wfi_sz);
> +	if (omap3_has_sdrc_emif4()) {
> +		omap3_do_wfi_sdram = omap3_emif4_do_wfi;
> +		omap3_do_wfi_sram = omap_sram_push(omap3_emif4_do_wfi,
> +				omap3_emif4_do_wfi_sz);
> +	} else {
> +		omap3_do_wfi_sdram = omap3_do_wfi;
> +		omap3_do_wfi_sram = omap_sram_push(omap3_do_wfi,
> +				omap3_do_wfi_sz);
> +	}
>  
>  	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
>  		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 1f62f23..22aac4c 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -33,6 +33,7 @@
>  #include "cm2xxx_3xxx.h"
>  #include "prm2xxx_3xxx.h"
>  #include "sdrc.h"
> +#include "emif4.h"
>  #include "control.h"
>  
>  /*
> @@ -67,6 +68,8 @@
>  #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  
> +#define PWR_MGMT_CTRL_V		OMAP34XX_EMIF4_REGADDR(EMIF4_PWR_MGMT_CTRL)
> +
>  /*
>   * This file needs be built unconditionally as ARM to interoperate correctly
>   * with non-Thumb-2-capable firmware.
> @@ -163,8 +166,12 @@ ENTRY(omap34xx_cpu_suspend)
>  	 */
>  
>  	/*
> -	 * For OFF mode: save context and jump to WFI in SDRAM (omap3_do_wfi)
> -	 * For non-OFF modes: jump to the WFI code in SRAM (omap3_do_wfi_sram)
> +	 * For OFF mode: save context and jump to WFI in SDRAM
> +	 * (omap3_do_wfi_sdram). For non-OFF modes: jump to the WFI code
> +	 * in SRAM (omap3_do_wfi_sram).  Note that omap_push_sram_idle()
> +	 * will have set omap3_do_wfi_sdram and omap3_do_wfi_sram to the
> +	 * SDRAM and SRAM addresses of either omap3_do_wfi or
> +	 * omap3_emif4_do_wfi depending on the type of SDRC submodule.
>  	 */
>  	ldr	r4, omap3_do_wfi_sram_addr
>  	ldr	r5, [r4]
> @@ -216,11 +223,15 @@ save_context_wfi:
>   THUMB(	nop		)
>  	.arm
>  
> -	b	omap3_do_wfi
> +	ldr	r4, omap3_do_wfi_sdram_addr
> +	ldr	r5, [r4]
> +	bx	r5			@  jump to the WFI code in SRAM
>  
>  /*
>   * Local variables
>   */
> +omap3_do_wfi_sdram_addr:
> +	.word omap3_do_wfi_sdram
>  omap3_do_wfi_sram_addr:
>  	.word omap3_do_wfi_sram
>  kernel_flush:
> @@ -232,8 +243,7 @@ kernel_flush:
>   */
>  
>  /*
> - * Do WFI instruction
> - * Includes the resume path for non-OFF modes
> + * Do WFI instruction (SDRC module has SDRC submodule)
>   *
>   * This code gets copied to internal SRAM and is accessible
>   * from both SDRAM and SRAM:
> @@ -391,6 +401,52 @@ wait_dll_lock_counter:
>  ENTRY(omap3_do_wfi_sz)
>  	.word	. - omap3_do_wfi
>  
> +/*
> + * Do WFI instruction (SDRC module has EMIF4 submodule)
> + *
> + * This code gets copied to internal SRAM and is accessible
> + * from both SDRAM and SRAM:
> + * - executed from SRAM for non-off modes (omap3_emif4_do_wfi_sram),
> + * - executed from SDRAM for OFF mode (omap3_emif4_do_wfi).
> + */
> +	.align	3
> +ENTRY(omap3_emif4_do_wfi)
> +	/* Put EMIF in self-refresh */

Hmm, I guess this comment isn't quite right; it just tells it to go to 
self-refresh when it's "idle" ? (see below)

> +	ldr     r4, pwr_mgmt_ctrl
> +	ldr     r5, [r4]
> +	orr     r5, r5, #0x200

Maybe use a macro here in place of the #0x200 to indicate what it's trying 
to set...

Do you happen to know what "idle" means in the context of SPRUGR0B Section 
9.2.3.4.5.1 "SDRAM Self-Refresh Mode" ?  Is it referring to 
target module-level idle, e.g. SIdleReq; or is it referring to 
an internal definition of idle, e.g., something like "no reads or writes 
from/to the SDRAM" ?  Am wondering if this should just be set once during 
EMIF initialization.

> +	str     r5, [r4]

Might be good to do a readback after this to ensure that the store has 
made it to the EMIF.

Also, scanning SPRUGR0B, it looks like this setting is dependent partially 
on the REG_PM_TIM field in the same register.  Might be good to set 
REG_PM_TIM during EMIF init to avoid any bootloader dependency.

> +
> +	dsb
> +	dmb
> +
> +	wfi
> +
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop

Are these NOPs necessary?  Is the number of NOPs dependent on CPU or bus 
speed or some ARM parameter?

> +
> +	/* Take EMIF out of self-refresh */

Looks like the EMIF will take the RAM out of self-refresh automatically 
upon an access... so maybe this comment might be better put as "Prevent 
EMIF from entering self-refresh" or something similar?

> +	ldr     r4, pwr_mgmt_ctrl
> +	ldr     r5, [r4]
> +	bic     r5, r5, #0x200
> +	str     r5, [r4]
> +
> +	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
> +
> +pwr_mgmt_ctrl:
> +	.word   PWR_MGMT_CTRL_V
> +ENDPROC(omap3_emif4_do_wfi)
> +ENTRY(omap3_emif4_do_wfi_sz)
> +	.word	. - omap3_emif4_do_wfi
> +
>  
>  /*
>   * ==============================
> @@ -564,6 +620,9 @@ l2dis_3630:
>  /*
>   * This function implements the erratum ID i443 WA, applies to 34xx >= ES3.0
>   * Copied to and run from SRAM in order to reconfigure the SDRC parameters.
> + *
> + * Note: Never call this routine when running on an am35x device since it
> + *  has an EMIF4 submodule instead of the standard SDRC submodule.
>   */
>  	.text
>  	.align	3
> diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
> index 0d818ac..3a84520 100644
> --- a/arch/arm/plat-omap/include/plat/omap34xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap34xx.h
> @@ -42,6 +42,7 @@
>  #define OMAP3430_PRM_BASE	0x48306800
>  #define OMAP343X_SMS_BASE	0x6C000000
>  #define OMAP343X_SDRC_BASE	0x6D000000
> +#define OMAP343X_EMIF4_BASE	0x6D000000
>  #define OMAP34XX_GPMC_BASE	0x6E000000
>  #define OMAP343X_SCM_BASE	0x48002000
>  #define OMAP343X_CTRL_BASE	OMAP343X_SCM_BASE
> -- 
> 1.7.9.4
> 


- Paul

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3:PM: Errata 1.176 Fix - Accesses to DDR stall in SDRC after a Warm-reset
Date: Fri, 11 Dec 2009 08:53:12 -0800
Message-ID: <871vj1jvuv.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B69@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50017 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbZLKQxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 11:53:08 -0500
Received: by pwj9 with SMTP id 9so688246pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 08:53:15 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B69@dbde02.ent.ti.com> (Teerth Reddy's message of "Fri\, 11 Dec 2009 18\:00\:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ghorai, Sukumar" <s-ghorai@ti.com>

"Reddy, Teerth" <teerth@ti.com> writes:

> From: Teerth Reddy <teerth@ti.com>
>
> This patch has the workaround for the errata 1.176.
> Accesses to DDR stall in SDRC after a Warm-reset.
> It generates a S/W reset and keeps DDR memory content.
> This patch enables SDRC self refresh on idle request,
> puts SDRC in idle and wait until SDRC goes to idle and then
> generates reset.
> This would need the u-boot/x-loader workaround changes
> as well for the reboot to work correctly.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>

The change log needs a little cleanup for readability.  You should
describe that this change only affects reboots, and not suspend/resume
or idle etc.  The wording of the changelog makes it not terribly
clear.

Also, You have a 'PM' in the subject, but there don't appear to be any
dependencies on the PM branch.

Can you repost against l-o master and change subject prefix of 'OMAP3:
SDRC' insead of PM?  After review, this can go upstream via Paul's
SDRC queue.

Some more comments below...

> ---
>  mach-omap2/prcm.c             |    9 ++++---
>  mach-omap2/sram34xx.S         |   50 ++++++++++++++++++++++++++++++++++++++++++
>  plat-omap/include/plat/sram.h |    7 +++++
>  plat-omap/sram.c              |   19 +++++++++++++++
>  4 files changed, 81 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index b732781..ac5fad5 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -26,6 +26,7 @@
>  #include <plat/prcm.h>
>  #include <plat/irqs.h>
>  #include <plat/control.h>
> +#include <plat/sram.h>
>  
>  #include "clock.h"
>  #include "cm.h"
> @@ -130,9 +131,10 @@ void omap_prcm_arch_reset(char mode)
>  	s16 prcm_offs;
>  	omap2_clk_prepare_for_reboot();
>  
> -	if (cpu_is_omap24xx())
> +	if (cpu_is_omap24xx()) {
>  		prcm_offs = WKUP_MOD;
> -	else if (cpu_is_omap34xx()) {
> +		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
> +	} else if (cpu_is_omap34xx()) {
>  		u32 l;
>  
>  		prcm_offs = OMAP3430_GR_MOD;
> @@ -143,10 +145,9 @@ void omap_prcm_arch_reset(char mode)
>  		 * cf. OMAP34xx TRM, Initialization / Software Booting
>  		 * Configuration. */
>  		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
> +		omap3_configure_core_dpll_warmreset();
>  	} else
>  		WARN_ON(1);
> -
> -	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
>  }
>  
>  static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index 82aa4a3..b60088e 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -33,6 +33,8 @@
>  
>  #include "sdrc.h"
>  #include "cm.h"
> +#include "prcm-common.h"
> +#include "prm.h"
>  
>  	.text
>  
> @@ -68,6 +70,9 @@
>  /* CM_CLKSEL1_PLL bit settings */
>  #define CORE_DPLL_CLKOUT_DIV_SHIFT	0x1b
>  
> +/* PRM_RSTCTRL bit setting */
> +#define EN_DPLL3_RESET                  0x4
> +
>  /*
>   * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
>   *
> @@ -298,3 +303,48 @@ core_m2_mask_val:
>  ENTRY(omap3_sram_configure_core_dpll_sz)
>  	.word	. - omap3_sram_configure_core_dpll
>  
> +
> +/* omap3_sram_configure_core_dpll_warmreset
> +* Enable SDRC self refresh on idle request, put SDRC in idle,
> +* wait until SDRC goes to idle
> +* Enable DPLL3 reset bit in RM_RSTCTRL
> +*/
> +
> +ENTRY(omap3_sram_configure_core_dpll_warmreset)
> +
> +	bl      sdram_in_selfrefresh1
> +	ldr     r11, omap3_reset_cntrl
> +	ldr     r12, [r11]
> +	orr     r12, r12, #EN_DPLL3_RESET       @ Enable DPLL3 reset bit
> +	str     r12, [r11]
> +
> +sdram_in_selfrefresh1:
> +	ldr     r11, omap3_sdrc_power1  @ read the SDRC_POWER register
> +	ldr     r12, [r11]              @ read the contents of SDRC_POWER
> +	mov     r9, r12                 @ keep a copy of SDRC_POWER bits
> +	orr     r12, r12, #SRFRONIDLEREQ_MASK   @ enable self refresh on idle
> +	str     r12, [r11]              @ write back to SDRC_POWER register
> +	ldr     r12, [r11]              @ posted-write barrier for SDRC
> +	ldr     r11, omap3_cm_iclken1_core1     @ read the CM_ICLKEN1_CORE reg
> +	ldr     r12, [r11]
> +	bic     r12, r12, #EN_SDRC_MASK         @ disable iclk bit for SDRC
> +	str     r12, [r11]
> +wait_sdrc_idle2:
> +	ldr     r11, omap3_cm_idlest1_core1
> +	ldr     r12, [r11]
> +	and     r12, r12, #ST_SDRC_MASK         @ check for SDRC idle
> +	cmp     r12, #ST_SDRC_MASK
> +	bne     wait_sdrc_idle2
> +	bx      lr
> +
> +omap3_reset_cntrl:
> +	.word OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, RM_RSTCTRL)
> +omap3_sdrc_power1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> +omap3_cm_idlest1_core1:
> +	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
> +omap3_cm_iclken1_core1:
> +	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
> +
> +ENTRY(omap3_sram_configure_core_dpll_warmreset_sz)
> +	.word   . - omap3_sram_configure_core_dpll_warmreset
> diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
> index 16a1b45..01187d6 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -27,6 +27,9 @@ extern u32 omap3_configure_core_dpll(
>  			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
>  			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
>  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
> +
> +extern u32 omap3_configure_core_dpll_warmreset(void);
> +
>  extern void omap3_sram_restore_context(void);
>  
>  /* Do not use these */
> @@ -69,6 +72,10 @@ extern u32 omap3_sram_configure_core_dpll(
>  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
>  extern unsigned long omap3_sram_configure_core_dpll_sz;
>  
> +extern u32 omap3_sram_configure_core_dpll_warmreset(void);
> +
> +extern unsigned long omap3_sram_configure_core_dpll_warmreset_sz;
> +
>  #ifdef CONFIG_PM
>  extern void omap_push_sram_idle(void);
>  #else
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 3e92366..f88b9c6 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -396,6 +396,16 @@ u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
>  			sdrc_actim_ctrl_b_1, sdrc_mr_1);
>  }
>  
> +/* Function for SDRC config for warm reset */
> +static u32 (*_omap3_sram_configure_core_dpll_warmreset)(void);
> +
> +u32 omap3_configure_core_dpll_warmreset()
> +{
> +	BUG_ON(!_omap3_sram_configure_core_dpll_warmreset);

Don't want to panic the system on reboot because of this. 

Should be 'if (WARN_ON(<cond>)) return;' 

> +	return _omap3_sram_configure_core_dpll_warmreset();
> +}
> +
>  #ifdef CONFIG_PM
>  void omap3_sram_restore_context(void)
>  {
> @@ -404,6 +414,10 @@ void omap3_sram_restore_context(void)
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> +	_omap3_sram_configure_core_dpll_warmreset =
> +	omap_sram_push(omap3_sram_configure_core_dpll_warmreset,
> +			omap3_sram_configure_core_dpll_warmreset_sz);

indentation

>  	omap_push_sram_idle();
>  }
>  #endif /* CONFIG_PM */
> @@ -413,6 +427,11 @@ int __init omap34xx_sram_init(void)
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> +
> +	_omap3_sram_configure_core_dpll_warmreset =
> +	omap_sram_push(omap3_sram_configure_core_dpll_warmreset,
> +			omap3_sram_configure_core_dpll_warmreset_sz);

ditto

>  	omap_push_sram_idle();
>  	return 0;
>  }

Kevin

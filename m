From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
	OMAP34xx
Date: Mon, 23 Mar 2009 18:11:28 -0700
Message-ID: <20090324011128.GN29546@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60519 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZCXBL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 21:11:26 -0400
Content-Disposition: inline
In-Reply-To: <20090310210333.16425.80205.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090310 14:04]:
> From: Juha Yrjola <juha.yrjola@solidboot.com>
> 
> The reboot mode can be communicated to a bootloader (or the
> kernel itself) with a scratchpad register. This functionality
> is especially useful, if userspace is allowed to change
> the reboot mode.
> 
> Patch updated by Tony to also define the BOODMOD registers.

Dropping this from my upstream queue for now, it sounds like
we can apply it as a fix after it's been updated to use cmd
instead of mode.

Tony

 
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/prcm.c                |   14 ++++++++++++--
>  arch/arm/plat-omap/include/mach/control.h |    9 +++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index f945156..12c0e03 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  
>  #include <mach/common.h>
> +#include <mach/control.h>
>  #include <mach/prcm.h>
>  
>  #include "clock.h"
> @@ -43,9 +44,18 @@ void omap_prcm_arch_reset(char mode)
>  
>  	if (cpu_is_omap24xx())
>  		prcm_offs = WKUP_MOD;
> -	else if (cpu_is_omap34xx())
> +	else if (cpu_is_omap34xx()) {
> +		u32 l;
> +
>  		prcm_offs = OMAP3430_GR_MOD;
> -	else
> +		l = ('B' << 24) | ('M' << 16) | mode;
> +		/* Reserve the first word in scratchpad for communicating
> +		 * with the boot ROM. A pointer to a data structure
> +		 * describing the boot process can be stored there,
> +		 * cf. OMAP34xx TRM, Initialization / Software Booting
> +		 * Configuration. */
> +		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
> +	} else
>  		WARN_ON(1);
>  
>  	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
> diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
> index 269147f..1e1bcff 100644
> --- a/arch/arm/plat-omap/include/mach/control.h
> +++ b/arch/arm/plat-omap/include/mach/control.h
> @@ -189,6 +189,15 @@
>  #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
>  #define OMAP2_PBIASLITEVMODE0		(1 << 0)
>  
> +/* CONTROL_IVA2_BOOTMOD bits */
> +#define OMAP3_IVA2_BOOTMOD_SHIFT	0
> +#define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
> +#define OMAP3_IVA2_BOOTMOD_IDLE		(0x1 << 0)
> +
> +#define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
> +#define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
> +#define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
> +
>  #ifndef __ASSEMBLY__
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  extern void __iomem *omap_ctrl_base_get(void);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

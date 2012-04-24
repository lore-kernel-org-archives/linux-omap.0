From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 15/19] ARM: OMAP4430: PM: workaround for DDR corruption
 on second CS
Date: Tue, 24 Apr 2012 13:22:14 -0500
Message-ID: <4F96EF56.5020604@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com> <1334914432-26456-16-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755782Ab2DXSWU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 14:22:20 -0400
In-Reply-To: <1334914432-26456-16-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Tero,

On 04/20/2012 04:33 AM, Tero Kristo wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Work around for Errata ID: i632 "LPDDR2 Corruption After OFF Mode
> Transition When CS1 Is Used On EMIF" which impacts OMAP443x silicon
> The issue occurs when EMIF_SDRAM_CONFIG is restored first before
> EMIF_SDRAM_CONFIG_2 is not yet restored, the register configuration
> is not set properly, we apply the required workaround allowing
> the restore sequence to work properly.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [t-kristo@ti.com: moved workaround from omap-sar.c to pm44xx.c]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../include/mach/ctrl_module_wkup_44xx.h           |    2 +
>  arch/arm/mach-omap2/pm44xx.c                       |   24 ++++++++++++++++++++
>  2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
> index a0af9ba..b763a79 100644
> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
> @@ -28,6 +28,8 @@
>  #define OMAP4_CTRL_MODULE_WKUP_IP_REVISION		0x0000
>  #define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO		0x0004
>  #define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG		0x0010
> +#define OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG	0x0114
> +#define OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG	0x011c
>  #define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0	0x0460
>  #define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1	0x0464
>  #define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2	0x0468
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 0472921..d4d18d9 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -17,6 +17,9 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <asm/system_misc.h>
> +#include <linux/io.h>
> +
> +#include <mach/ctrl_module_wkup_44xx.h>
>  
>  #include "common.h"
>  #include "clockdomain.h"
> @@ -215,6 +218,27 @@ static int __init omap4_pm_init(void)
>  
>  	pr_err("Power Management for TI OMAP4.\n");
>  
> +	/*
> +	 * Work around for OMAP443x Errata i632: "LPDDR2 Corruption After OFF
> +	 * Mode Transition When CS1 Is Used On EMIF":
> +	 * Overwrite EMIF1/EMIF2
> +	 * SECURE_EMIF1_SDRAM_CONFIG2_REG
> +	 * SECURE_EMIF2_SDRAM_CONFIG2_REG
> +	 */
> +	if (cpu_is_omap443x()) {
> +		void __iomem *secure_ctrl_mod;
> +
> +		secure_ctrl_mod = ioremap(OMAP4_CTRL_MODULE_WKUP, SZ_4K);
> +		BUG_ON(!secure_ctrl_mod);
> +
> +		__raw_writel(0x10, secure_ctrl_mod +
> +			     OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG);
> +		__raw_writel(0x10, secure_ctrl_mod +
> +			     OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG);

According to the erratum description the above registers are used to
restore the EMIFx_SDRAM_CONFIG2 registers. So although the value 0x10,
maybe the value being used for EMIFx_SDRAM_CONFIG2 registers, shouldn't
we read the EMIFx_SDRAM_CONFIG2 registers and store them in the above
registers?

Cheers
Jon

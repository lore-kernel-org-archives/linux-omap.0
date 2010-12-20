From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 3/7] OMAP3: remove hardcoded values from the ASM sleep code
Date: Mon, 20 Dec 2010 16:50:30 +0530
Message-ID: <be2c576b16eebdfc1b2b83c31b40a8dc@mail.gmail.com>
References: <1292687087-22983-1-git-send-email-j-pihet@ti.com> <1292687087-22983-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33844 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755464Ab0LTLU1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 06:20:27 -0500
Received: by mail-fx0-f52.google.com with SMTP id 5so2579847fxm.11
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 03:20:26 -0800 (PST)
In-Reply-To: <1292687087-22983-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: jean.pihet@newoldbits.com [mailto:jean.pihet@newoldbits.com]
> Sent: Saturday, December 18, 2010 9:15 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; linux-arm-
> kernel@lists.infradead.org; Jean Pihet; Vishwanath BS
> Subject: [PATCH 3/7] OMAP3: remove hardcoded values from the ASM
> sleep code
>
> From: Jean Pihet <j-pihet@ti.com>
>
> Using macros from existing include files for registers addresses.
>
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
>
> Based on original patch from Vishwa.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Vishwanath BS <vishwanath.bs@ti.com>
Acked-by: Vishwanath BS <vishwanath.bs@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/control.h   |    2 ++
>  arch/arm/mach-omap2/sleep34xx.S |   29
> ++++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-
> omap2/control.h
> index d7911c5..72efefb 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -274,6 +274,8 @@
>  #define OMAP343X_SCRATCHPAD_ROM
> 	(OMAP343X_CTRL_BASE + 0x860)
>  #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE +
> 0x910)
>  #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
> +#define OMAP343X_SCRATCHPAD_REGADDR(reg)
> 	OMAP2_L4_IO_ADDRESS(\
> +						OMAP343X_SCRATCHPAD +
> reg)
>
>  /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
>  #define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 406cd2a..8e9f38f 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -34,20 +34,27 @@
>  #include "sdrc.h"
>  #include "control.h"
>
> -#define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
> -
> -#define PM_PREPWSTST_CORE_P	0x48306AE8
> +/*
> + * Registers access definitions
> + */
> +#define SDRC_SCRATCHPAD_SEM_OFFS	0xc
> +#define SDRC_SCRATCHPAD_SEM_V
> 	OMAP343X_SCRATCHPAD_REGADDR\
> +					(SDRC_SCRATCHPAD_SEM_OFFS)
> +#define PM_PREPWSTST_CORE_P	OMAP3430_PRM_BASE + CORE_MOD
> +\
> +					OMAP3430_PM_PREPWSTST
>  #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD
> + OMAP2_PM_PWSTCTRL
>  #define CM_IDLEST1_CORE_V
> 	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
>  #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD,
> CM_IDLEST)
> -#define SRAM_BASE_P		0x40200000
> -#define CONTROL_STAT		0x480022F0
> -#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
> -					+
> OMAP36XX_CONTROL_MEM_RTA_CTRL)
> -#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
> -				       * available */
> -#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE +
> OMAP343X_CONTROL_MEM_WKUP\
> -						+ SCRATCHPAD_MEM_OFFS)
> +#define SRAM_BASE_P		OMAP3_SRAM_PA
> +#define CONTROL_STAT		OMAP343X_CTRL_BASE +
> OMAP343X_CONTROL_STATUS
> +#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE +\
> +
> 	OMAP36XX_CONTROL_MEM_RTA_CTRL)
> +
> +/* Move this as correct place is available */
> +#define SCRATCHPAD_MEM_OFFS	0x310
> +#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE +\
> +					OMAP343X_CONTROL_MEM_WKUP +\
> +					SCRATCHPAD_MEM_OFFS)
>  #define SDRC_POWER_V
> 	OMAP34XX_SDRC_REGADDR(SDRC_POWER)
>  #define SDRC_SYSCONFIG_P	(OMAP343X_SDRC_BASE +
> SDRC_SYSCONFIG)
>  #define SDRC_MR_0_P		(OMAP343X_SDRC_BASE +
> SDRC_MR_0)
> --
> 1.7.2.3

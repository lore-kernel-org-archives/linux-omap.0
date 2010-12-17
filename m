From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/7] OMAP3: remove hardcoded values from the ASM sleep code
Date: Fri, 17 Dec 2010 16:06:49 +0530
Message-ID: <f5fb4ed5dd869c6f820e9f05f6e35877@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com> <1292580506-4421-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:58144 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753639Ab0LQKgu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 05:36:50 -0500
Received: by gwj22 with SMTP id 22so301043gwj.14
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:36:50 -0800 (PST)
In-Reply-To: <1292580506-4421-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Friday, December 17, 2010 3:38 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.org;
> Jean Pihet; Vishwanath BS
> Subject: [PATCH 3/7] OMAP3: remove hardcoded values from the ASM sleep
> code
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
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/control.h   |    2 ++
>  arch/arm/mach-omap2/sleep34xx.S |   29 ++++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.h
b/arch/arm/mach-omap2/control.h
> index d7911c5..72efefb 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -274,6 +274,8 @@
>  #define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE +
0x860)
>  #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
>  #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
> +#define OMAP343X_SCRATCHPAD_REGADDR(reg)	OMAP2_L4_IO_ADDRESS(\
> +						OMAP343X_SCRATCHPAD + reg)
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
> +#define SDRC_SCRATCHPAD_SEM_V	OMAP343X_SCRATCHPAD_REGADDR\
> +					(SDRC_SCRATCHPAD_SEM_OFFS)
> +#define PM_PREPWSTST_CORE_P	OMAP3430_PRM_BASE + CORE_MOD +\
> +					OMAP3430_PM_PREPWSTST
>  #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD +
> OMAP2_PM_PWSTCTRL
>  #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
>  #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
> -#define SRAM_BASE_P		0x40200000
> -#define CONTROL_STAT		0x480022F0
> -#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
> -					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
> -#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
> -				       * available */
> -#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE +
> OMAP343X_CONTROL_MEM_WKUP\
> -						+ SCRATCHPAD_MEM_OFFS)
> +#define SRAM_BASE_P		OMAP3_SRAM_PA
> +#define CONTROL_STAT		OMAP343X_CTRL_BASE +
OMAP343X_CONTROL_STATUS
> +#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE +\
> +					OMAP36XX_CONTROL_MEM_RTA_CTRL)
> +
> +/* Move this as correct place is available */
> +#define SCRATCHPAD_MEM_OFFS	0x310
> +#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE +\
> +					OMAP343X_CONTROL_MEM_WKUP +\
> +					SCRATCHPAD_MEM_OFFS)
>  #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
>  #define SDRC_SYSCONFIG_P	(OMAP343X_SDRC_BASE + SDRC_SYSCONFIG)
>  #define SDRC_MR_0_P		(OMAP343X_SDRC_BASE + SDRC_MR_0)
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

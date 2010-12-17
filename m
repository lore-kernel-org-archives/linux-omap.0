From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/7] OMAP3: remove hardcoded values from the ASM sleep
 code
Date: Fri, 17 Dec 2010 07:51:48 -0600
Message-ID: <4D0B6AF4.1050600@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com> <1292580506-4421-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60265 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754272Ab0LQNvx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 08:51:53 -0500
Received: by yxt33 with SMTP id 33so326196yxt.17
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 05:51:52 -0800 (PST)
In-Reply-To: <1292580506-4421-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

jean.pihet@newoldbits.com had written, on 12/17/2010 04:08 AM, the 
following:
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
> ---
>  arch/arm/mach-omap2/control.h   |    2 ++
>  arch/arm/mach-omap2/sleep34xx.S |   29 ++++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index d7911c5..72efefb 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -274,6 +274,8 @@
>  #define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
>  #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
>  #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
> +#define OMAP343X_SCRATCHPAD_REGADDR(reg)	OMAP2_L4_IO_ADDRESS(\
> +						OMAP343X_SCRATCHPAD + reg)
+ (reg)) please. I am not convinced that we should call this REGADDR 
though scratchpad region in DDR is still DDR, not a register.

>  
>  /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
>  #define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
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
err.. technically sdrc scratchpad is not really a register ;) nor is 
sram_base ;)
> +#define SDRC_SCRATCHPAD_SEM_OFFS	0xc
> +#define SDRC_SCRATCHPAD_SEM_V	OMAP343X_SCRATCHPAD_REGADDR\
> +					(SDRC_SCRATCHPAD_SEM_OFFS)
> +#define PM_PREPWSTST_CORE_P	OMAP3430_PRM_BASE + CORE_MOD +\
> +					OMAP3430_PM_PREPWSTST
please use () for wrapping up a macro with multiple defines.

>  #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
>  #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
>  #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
> -#define SRAM_BASE_P		0x40200000
> -#define CONTROL_STAT		0x480022F0
> -#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
> -					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
not sure what changed here.
> -#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
> -				       * available */
this change I am guessing is a clean up of /* */ comment - might help if 
you could do formatting changes in a single patch - easier to check if 
there are functionality issues during reviews in the current patch that 
way. my suggestion will be to do the functional changes first followed 
by a formatting cleanup patch at the very end..

> -#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
> -						+ SCRATCHPAD_MEM_OFFS)
again, not sure what changed here.
> +#define SRAM_BASE_P		OMAP3_SRAM_PA
Why not just replace the usage of SRAM_BASE_P with OMAP3_SRAM_PA?

> +#define CONTROL_STAT		OMAP343X_CTRL_BASE + OMAP343X_CONTROL_STATUS
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
Tested-by: Nishanth Menon <nm@ti.com>
Tested on:
SDP3630
SDP3430
Test script:
http://pastebin.mozilla.org/889933


-- 
Regards,
Nishanth Menon

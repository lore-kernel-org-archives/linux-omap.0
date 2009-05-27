From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: PM: update and decouple from OMAP2/3 PM core
Date: Wed, 27 May 2009 16:38:24 -0700
Message-ID: <20090527233823.GH6267@atomide.com>
References: <1243467318-9736-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63823 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835AbZE0Xie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 19:38:34 -0400
Content-Disposition: inline
In-Reply-To: <1243467318-9736-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

* Kevin Hilman <khilman@deeprootsystems.com> [090527 16:35]:
> Update OMAP1-specific PM infrastructure.  This is a sync of what is in
> linux-omap for OMAP1.
> 
> This mostly de-couples OMAP1 PM from OMAP2/3 PM and renames things
> accordingly, and removes omap2/3 specific code from OMAP1 specific
> headers.
> 
> Original OMAP1 decoupling patch for OMAP PM branch by Paul Walmsley.

Thanks, I've pulled your updated pm-upstream with this into omap
for-next branch.

Tony
 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap1/pm.c     |   11 +++--
>  arch/arm/mach-omap1/pm.h     |   85 +++++-------------------------------------
>  arch/arm/mach-omap1/serial.c |    3 -
>  arch/arm/mach-omap1/sleep.S  |    2 +-
>  4 files changed, 17 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 9774c1f..5218943 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -53,11 +53,12 @@
>  #include <mach/clock.h>
>  #include <mach/sram.h>
>  #include <mach/tc.h>
> -#include <mach/pm.h>
>  #include <mach/mux.h>
>  #include <mach/dma.h>
>  #include <mach/dmtimer.h>
>  
> +#include "pm.h"
> +
>  static unsigned int arm_sleep_save[ARM_SLEEP_SAVE_SIZE];
>  static unsigned short dsp_sleep_save[DSP_SLEEP_SAVE_SIZE];
>  static unsigned short ulpd_sleep_save[ULPD_SLEEP_SAVE_SIZE];
> @@ -101,7 +102,7 @@ static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) = NULL;
>   * going idle we continue to do idle even if we get
>   * a clock tick interrupt . .
>   */
> -void omap_pm_idle(void)
> +void omap1_pm_idle(void)
>  {
>  	extern __u32 arm_idlect1_mask;
>  	__u32 use_idlect1 = arm_idlect1_mask;
> @@ -222,7 +223,7 @@ static void omap_pm_wakeup_setup(void)
>  #define EN_APICK	6	/* ARM_IDLECT2 */
>  #define DSP_EN		1	/* ARM_RSTCT1 */
>  
> -void omap_pm_suspend(void)
> +void omap1_pm_suspend(void)
>  {
>  	unsigned long arg0 = 0, arg1 = 0;
>  
> @@ -610,7 +611,7 @@ static int omap_pm_enter(suspend_state_t state)
>  	{
>  	case PM_SUSPEND_STANDBY:
>  	case PM_SUSPEND_MEM:
> -		omap_pm_suspend();
> +		omap1_pm_suspend();
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -683,7 +684,7 @@ static int __init omap_pm_init(void)
>  		return -ENODEV;
>  	}
>  
> -	pm_idle = omap_pm_idle;
> +	pm_idle = omap1_pm_idle;
>  
>  	if (cpu_is_omap730())
>  		setup_irq(INT_730_WAKE_UP_REQ, &omap_wakeup_irq);
> diff --git a/arch/arm/mach-omap1/pm.h b/arch/arm/mach-omap1/pm.h
> index ce6ee79..9ed5e2c 100644
> --- a/arch/arm/mach-omap1/pm.h
> +++ b/arch/arm/mach-omap1/pm.h
> @@ -1,7 +1,7 @@
>  /*
> - * arch/arm/plat-omap/include/mach/pm.h
> + * arch/arm/mach-omap1/pm.h
>   *
> - * Header file for OMAP Power Management Routines
> + * Header file for OMAP1 Power Management Routines
>   *
>   * Author: MontaVista Software, Inc.
>   *	   support@mvista.com
> @@ -31,8 +31,8 @@
>   * 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> -#ifndef __ASM_ARCH_OMAP_PM_H
> -#define __ASM_ARCH_OMAP_PM_H
> +#ifndef __ARCH_ARM_MACH_OMAP1_PM_H
> +#define __ARCH_ARM_MACH_OMAP1_PM_H
>  
>  /*
>   * ----------------------------------------------------------------------------
> @@ -106,8 +106,7 @@
>  
>  #if     !defined(CONFIG_ARCH_OMAP730) && \
>  	!defined(CONFIG_ARCH_OMAP15XX) && \
> -	!defined(CONFIG_ARCH_OMAP16XX) && \
> -	!defined(CONFIG_ARCH_OMAP24XX)
> +	!defined(CONFIG_ARCH_OMAP16XX)
>  #warning "Power management for this processor not implemented yet"
>  #endif
>  
> @@ -115,29 +114,27 @@
>  
>  #include <linux/clk.h>
>  
> +extern struct kset power_subsys;
> +
>  extern void prevent_idle_sleep(void);
>  extern void allow_idle_sleep(void);
>  
> -extern void omap_pm_idle(void);
> -extern void omap_pm_suspend(void);
> +extern void omap1_pm_idle(void);
> +extern void omap1_pm_suspend(void);
> +
>  extern void omap730_cpu_suspend(unsigned short, unsigned short);
>  extern void omap1510_cpu_suspend(unsigned short, unsigned short);
>  extern void omap1610_cpu_suspend(unsigned short, unsigned short);
> -extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
> -					void __iomem *sdrc_power);
>  extern void omap730_idle_loop_suspend(void);
>  extern void omap1510_idle_loop_suspend(void);
>  extern void omap1610_idle_loop_suspend(void);
> -extern void omap24xx_idle_loop_suspend(void);
>  
>  extern unsigned int omap730_cpu_suspend_sz;
>  extern unsigned int omap1510_cpu_suspend_sz;
>  extern unsigned int omap1610_cpu_suspend_sz;
> -extern unsigned int omap24xx_cpu_suspend_sz;
>  extern unsigned int omap730_idle_loop_suspend_sz;
>  extern unsigned int omap1510_idle_loop_suspend_sz;
>  extern unsigned int omap1610_idle_loop_suspend_sz;
> -extern unsigned int omap24xx_idle_loop_suspend_sz;
>  
>  #ifdef CONFIG_OMAP_SERIAL_WAKE
>  extern void omap_serial_wake_trigger(int enable);
> @@ -170,10 +167,6 @@ extern void omap_serial_wake_trigger(int enable);
>  #define MPUI1610_RESTORE(x) omap_writel((mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x]), (x))
>  #define MPUI1610_SHOW(x) mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x]
>  
> -#define OMAP24XX_SAVE(x) omap24xx_sleep_save[OMAP24XX_SLEEP_SAVE_##x] = x
> -#define OMAP24XX_RESTORE(x) x = omap24xx_sleep_save[OMAP24XX_SLEEP_SAVE_##x]
> -#define OMAP24XX_SHOW(x) omap24xx_sleep_save[OMAP24XX_SLEEP_SAVE_##x]
> -
>  /*
>   * List of global OMAP registers to preserve.
>   * More ones like CP and general purpose register values are preserved
> @@ -283,63 +276,5 @@ enum mpui1610_save_state {
>  #endif
>  };
>  
> -enum omap24xx_save_state {
> -	OMAP24XX_SLEEP_SAVE_START = 0,
> -	OMAP24XX_SLEEP_SAVE_INTC_MIR0,
> -	OMAP24XX_SLEEP_SAVE_INTC_MIR1,
> -	OMAP24XX_SLEEP_SAVE_INTC_MIR2,
> -
> -	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_MPU,
> -	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_GFX,
> -	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_DSP,
> -	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_MDM,
> -
> -	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_MPU,
> -	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_CORE,
> -	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_GFX,
> -	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_DSP,
> -	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_MDM,
> -
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST1_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST2_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST3_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST4_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST_GFX,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST_WKUP,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST_CKGEN,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST_DSP,
> -	OMAP24XX_SLEEP_SAVE_CM_IDLEST_MDM,
> -
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE1_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE2_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE3_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE4_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_WKUP,
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_PLL,
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_DSP,
> -	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_MDM,
> -
> -	OMAP24XX_SLEEP_SAVE_CM_FCLKEN1_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_FCLKEN2_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_ICLKEN1_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_ICLKEN2_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_ICLKEN3_CORE,
> -	OMAP24XX_SLEEP_SAVE_CM_ICLKEN4_CORE,
> -	OMAP24XX_SLEEP_SAVE_GPIO1_IRQENABLE1,
> -	OMAP24XX_SLEEP_SAVE_GPIO2_IRQENABLE1,
> -	OMAP24XX_SLEEP_SAVE_GPIO3_IRQENABLE1,
> -	OMAP24XX_SLEEP_SAVE_GPIO4_IRQENABLE1,
> -	OMAP24XX_SLEEP_SAVE_GPIO3_OE,
> -	OMAP24XX_SLEEP_SAVE_GPIO4_OE,
> -	OMAP24XX_SLEEP_SAVE_GPIO3_RISINGDETECT,
> -	OMAP24XX_SLEEP_SAVE_GPIO3_FALLINGDETECT,
> -	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_SPI1_NCS2,
> -	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_MCBSP1_DX,
> -	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_SSI1_FLAG_TX,
> -	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_SYS_NIRQW0,
> -	OMAP24XX_SLEEP_SAVE_SIZE
> -};
> -
>  #endif /* ASSEMBLER */
>  #endif /* __ASM_ARCH_OMAP_PM_H */
> diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
> index 842090b..f754cee 100644
> --- a/arch/arm/mach-omap1/serial.c
> +++ b/arch/arm/mach-omap1/serial.c
> @@ -26,9 +26,6 @@
>  #include <mach/mux.h>
>  #include <mach/gpio.h>
>  #include <mach/fpga.h>
> -#ifdef CONFIG_PM
> -#include <mach/pm.h>
> -#endif
>  
>  static struct clk * uart1_ck;
>  static struct clk * uart2_ck;
> diff --git a/arch/arm/mach-omap1/sleep.S b/arch/arm/mach-omap1/sleep.S
> index f3eac93..22e8568 100644
> --- a/arch/arm/mach-omap1/sleep.S
> +++ b/arch/arm/mach-omap1/sleep.S
> @@ -35,7 +35,7 @@
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>  #include <mach/io.h>
> -#include <mach/pm.h>
> +#include "pm.h"
>  
>  		.text
>  
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

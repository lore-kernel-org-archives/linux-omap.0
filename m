From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: make mach/pm.h OMAP1-specific
Date: Mon, 27 Apr 2009 08:06:40 -0700
Message-ID: <87ws96uoe7.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0904251625240.28378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:60461 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbZD0PGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 11:06:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1841302rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 08:06:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0904251625240.28378@utopia.booyaka.com> (Paul Walmsley's message of "Sat\, 25 Apr 2009 16\:27\:27 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> mach/pm.h is almost completely OMAP1-specific.  Move it to plat-omap1 and
> remove the unused OMAP2xxx-specific defines.  Many files included mach/pm.h
> but did not actually use any symbols; remove those #includes.  Any 
> definitions needed for OMAP2/3 have been moved to mach-omap2/pm.h.
>
> Boot-tested on OMAP3 Beagle as of the 16-April PM branch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap1/pm.c                           |   11 +++--
>  .../{plat-omap/include/mach => mach-omap1}/pm.h    |   46 +++-----------------
>  arch/arm/mach-omap1/serial.c                       |    3 -
>  arch/arm/mach-omap1/sleep.S                        |    2 +-
>  arch/arm/mach-omap2/board-n800-usb.c               |    3 +-
>  arch/arm/mach-omap2/cpuidle34xx.c                  |    1 -
>  arch/arm/mach-omap2/pm.c                           |    1 -
>  arch/arm/mach-omap2/pm.h                           |   24 ++++++++++
>  arch/arm/mach-omap2/pm24xx.c                       |    1 -
>  arch/arm/mach-omap2/pm34xx.c                       |    1 -
>  arch/arm/mach-omap2/sleep24xx.S                    |    1 -
>  arch/arm/mach-omap2/sleep34xx.S                    |    1 -
>  arch/arm/mach-omap2/usb-ehci.c                     |    1 -
>  arch/arm/mach-omap2/usb-musb.c                     |    1 -
>  arch/arm/plat-omap/common.c                        |    1 -
>  drivers/bluetooth/hci_h4p/core.c                   |    1 -
>  drivers/mtd/onenand/omap2.c                        |    1 -
>  17 files changed, 40 insertions(+), 60 deletions(-)
>  rename arch/arm/{plat-omap/include/mach => mach-omap1}/pm.h (86%)
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
> diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/mach-omap1/pm.h
> similarity index 86%
> rename from arch/arm/plat-omap/include/mach/pm.h
> rename to arch/arm/mach-omap1/pm.h
> index 4bf1138..9ed5e2c 100644
> --- a/arch/arm/plat-omap/include/mach/pm.h
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
> @@ -106,9 +106,7 @@
>  
>  #if     !defined(CONFIG_ARCH_OMAP730) && \
>  	!defined(CONFIG_ARCH_OMAP15XX) && \
> -	!defined(CONFIG_ARCH_OMAP16XX) && \
> -	!defined(CONFIG_ARCH_OMAP24XX) && \
> -	!defined(CONFIG_ARCH_OMAP34XX)
> +	!defined(CONFIG_ARCH_OMAP16XX)
>  #warning "Power management for this processor not implemented yet"
>  #endif
>  
> @@ -121,52 +119,22 @@ extern struct kset power_subsys;
>  extern void prevent_idle_sleep(void);
>  extern void allow_idle_sleep(void);
>  
> -/**
> - * clk_deny_idle - Prevents the clock from being idled during MPU idle
> - * @clk: clock signal handle
> - */
> -void clk_deny_idle(struct clk *clk);
> +extern void omap1_pm_idle(void);
> +extern void omap1_pm_suspend(void);
>  
> -/**
> - * clk_allow_idle - Counters previous clk_deny_idle
> - * @clk: clock signal handle
> - */
> -void clk_allow_idle(struct clk *clk);
> -
> -extern void omap_pm_idle(void);
> -extern void omap_pm_suspend(void);
> -extern void omap_sram_idle(void);
> -#ifdef CONFIG_PM
> -extern void omap2_block_sleep(void);
> -extern void omap2_allow_sleep(void);
> -#else
> -static inline void omap2_block_sleep(void) { }
> -static inline void omap2_allow_sleep(void) { }
> -#endif
> -extern int omap3_can_sleep(void);
>  extern void omap730_cpu_suspend(unsigned short, unsigned short);
>  extern void omap1510_cpu_suspend(unsigned short, unsigned short);
>  extern void omap1610_cpu_suspend(unsigned short, unsigned short);
> -extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
> -					void __iomem *sdrc_power);
> -extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
> -extern void save_secure_ram_context(u32 *addr);
>  extern void omap730_idle_loop_suspend(void);
>  extern void omap1510_idle_loop_suspend(void);
>  extern void omap1610_idle_loop_suspend(void);
> -extern void omap24xx_idle_loop_suspend(void);
>  
>  extern unsigned int omap730_cpu_suspend_sz;
>  extern unsigned int omap1510_cpu_suspend_sz;
>  extern unsigned int omap1610_cpu_suspend_sz;
> -extern unsigned int omap24xx_cpu_suspend_sz;
> -extern unsigned int omap34xx_cpu_suspend_sz;
>  extern unsigned int omap730_idle_loop_suspend_sz;
>  extern unsigned int omap1510_idle_loop_suspend_sz;
>  extern unsigned int omap1610_idle_loop_suspend_sz;
> -extern unsigned int omap24xx_idle_loop_suspend_sz;
> -extern unsigned int omap34xx_suspend_sz;
> -extern unsigned int save_secure_ram_context_sz;
>  
>  #ifdef CONFIG_OMAP_SERIAL_WAKE
>  extern void omap_serial_wake_trigger(int enable);
> diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
> index 0002084..6dd5d3c 100644
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
> diff --git a/arch/arm/mach-omap2/board-n800-usb.c b/arch/arm/mach-omap2/board-n800-usb.c
> index e182a93..b16d69f 100644
> --- a/arch/arm/mach-omap2/board-n800-usb.c
> +++ b/arch/arm/mach-omap2/board-n800-usb.c
> @@ -17,7 +17,8 @@
>  #include <linux/gpio.h>
>  #include <linux/usb/musb.h>
>  #include <mach/gpmc.h>
> -#include <mach/pm.h>
> +
> +#include "pm.h"
>  
>  #define TUSB_ASYNC_CS		1
>  #define TUSB_SYNC_CS		4
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 2d09320..0866691 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -24,7 +24,6 @@
>  
>  #include <linux/sched.h>
>  #include <linux/cpuidle.h>
> -#include <mach/pm.h>
>  #include <mach/prcm.h>
>  #include <mach/powerdomain.h>
>  #include <mach/clockdomain.h>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 3711eb3..50d95cd 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -30,7 +30,6 @@
>  #include <asm/mach/time.h>
>  #include <asm/atomic.h>
>  
> -#include <mach/pm.h>
>  #include <mach/powerdomain.h>
>  #include <mach/omapdev.h>
>  #include <mach/resource.h>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index d79ea07..942a990 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -72,4 +72,28 @@ extern int pm_dbg_regset_init(int reg_set);
>  #define pm_dbg_regset_save(reg_set) do {} while (0);
>  #define pm_dbg_regset_init(reg_set) do {} while (0);
>  #endif /* CONFIG_PM_DEBUG */
> +
> +extern void omap24xx_idle_loop_suspend(void);
> +
> +extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
> +					void __iomem *sdrc_power);
> +extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
> +extern void save_secure_ram_context(u32 *addr);
> +extern int omap3_can_sleep(void);
> +
> +extern void omap_sram_idle(void);
> +#ifdef CONFIG_PM
> +extern void omap2_block_sleep(void);
> +extern void omap2_allow_sleep(void);
> +#else
> +static inline void omap2_block_sleep(void) { }
> +static inline void omap2_allow_sleep(void) { }
> +#endif
> +
> +extern unsigned int omap24xx_idle_loop_suspend_sz;
> +extern unsigned int omap34xx_suspend_sz;
> +extern unsigned int save_secure_ram_context_sz;
> +extern unsigned int omap24xx_cpu_suspend_sz;
> +extern unsigned int omap34xx_cpu_suspend_sz;
> +
>  #endif
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index d2bae9c..377188b 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -41,7 +41,6 @@
>  #include <mach/sram.h>
>  #include <mach/control.h>
>  #include <mach/gpio.h>
> -#include <mach/pm.h>
>  #include <mach/mux.h>
>  #include <mach/dma.h>
>  #include <mach/board.h>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7474cfa..2dc695f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -29,7 +29,6 @@
>  
>  #include <mach/gpio.h>
>  #include <mach/sram.h>
> -#include <mach/pm.h>
>  #include <mach/prcm.h>
>  #include <mach/clockdomain.h>
>  #include <mach/powerdomain.h>
> diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
> index bf9e961..130aadb 100644
> --- a/arch/arm/mach-omap2/sleep24xx.S
> +++ b/arch/arm/mach-omap2/sleep24xx.S
> @@ -28,7 +28,6 @@
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>  #include <mach/io.h>
> -#include <mach/pm.h>
>  
>  #include <mach/omap24xx.h>
>  
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 0a58c30..e8b5d5a 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -27,7 +27,6 @@
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>  #include <mach/io.h>
> -#include <mach/pm.h>
>  #include <mach/control.h>
>  
>  #include "cm.h"
> diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
> index 23fe857..38e0251 100644
> --- a/arch/arm/mach-omap2/usb-ehci.c
> +++ b/arch/arm/mach-omap2/usb-ehci.c
> @@ -25,7 +25,6 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> -#include <mach/pm.h>
>  #include <mach/usb.h>
>  
>  static struct resource ehci_resources[] = {
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index da33f95..12a9b0a 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -28,7 +28,6 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> -#include <mach/pm.h>
>  #include <mach/mux.h>
>  #include <mach/usb.h>
>  
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 2866612..772c985 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -11,7 +11,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> -#include <linux/pm.h>
>  #include <linux/console.h>
>  #include <linux/serial.h>
>  #include <linux/tty.h>
> diff --git a/drivers/bluetooth/hci_h4p/core.c b/drivers/bluetooth/hci_h4p/core.c
> index a5b76ad..381794e 100644
> --- a/drivers/bluetooth/hci_h4p/core.c
> +++ b/drivers/bluetooth/hci_h4p/core.c
> @@ -39,7 +39,6 @@
>  #include <mach/hardware.h>
>  #include <mach/board.h>
>  #include <mach/irqs.h>
> -#include <mach/pm.h>
>  
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index c260e2d..c9a42c2 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -39,7 +39,6 @@
>  #include <mach/gpmc.h>
>  #include <mach/onenand.h>
>  #include <mach/gpio.h>
> -#include <mach/pm.h>
>  
>  #include <mach/dma.h>
>  
> -- 
> 1.6.3.rc1.51.gea0b7

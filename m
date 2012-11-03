From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Sat, 3 Nov 2012 22:27:19 +0530
Message-ID: <50954CEF.5080209@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664Ab2KCQ5e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 3 Nov 2012 12:57:34 -0400
In-Reply-To: <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> AM335x supports various low power modes as documented
> in section 8.1.4.3 of the AM335x TRM which is available
> @ http://www.ti.com/litv/pdf/spruh73f
>
> DeepSleep0 mode offers the lowest power mode with limited
> wakeup sources without a system reboot and is mapped as
> the suspend state in the kernel. In this state, MPU and
> PER domains are turned off with the internal RAM held in
> retention to facilitate resume process. As part of the boot
> process, the assembly code is copied over to OCMCRAM using
> the OMAP SRAM code.
>
> AM335x has a Cortex-M3 (WKUP_M3) which assists the MPU
> in DeepSleep0 entry and exit. WKUP_M3 takes care of the
> clockdomain and powerdomain transitions based on the
> intended low power state. MPU needs to load the appropriate
> WKUP_M3 binary onto the WKUP_M3 memory space before it can
> leverage any of the PM features like DeepSleep.
>
> The IPC mechanism between MPU and WKUP_M3 uses a mailbox
> sub-module and 8 IPC registers in the Control module. MPU
> uses the assigned Mailbox for issuing an interrupt to
> WKUP_M3 which then goes and checks the IPC registers for
> the payload. WKUP_M3 has the ability to trigger on interrupt
> to MPU by executing the "sev" instruction.
>
> In the current implementation when the suspend process
> is initiated MPU interrupts the WKUP_M3 to let about the
> intent of entering DeepSleep0 and waits for an ACK. When
> the ACK is received, MPU continues with its suspend process
> to suspend all the drivers and then jumps to assembly in
> OCMC RAM to put the PLLs in bypass, put the external RAM in
> self-refresh mode and then finally execute the WFI instruction.
> The WFI instruction triggers another interrupt to the WKUP_M3
> which then continues wiht the power down sequence wherein the
> clockdomain and powerdomain transition takes place. As part of
> the sleep sequence, WKUP_M3 unmasks the interrupt lines for
> the wakeup sources. When WKUP_M3 executes WFI, the hardware
> disables the main oscillator.
>
> When a wakeup event occurs, WKUP_M3 starts the power-up
> sequence by switching on the power domains and finally
> enabling the clock to MPU. Since the MPU gets powered down
> as part of the sleep sequence, in the resume path ROM code
> starts executing. The ROM code detects a wakeup from sleep
> and then jumps to the resume location in OCMC which was
> populated in one of the IPC registers as part of the suspend
> sequence.
>
> The low level code in OCMC relocks the PLLs, enables access
> to external RAM and then jumps to the cpu_resume code of
> the kernel to finish the resume process.
>
Nice descriptive change log Vaibhav.


> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>   arch/arm/mach-omap2/Makefile        |    2 +
>   arch/arm/mach-omap2/board-generic.c |    1 +
>   arch/arm/mach-omap2/common.h        |   10 +
>   arch/arm/mach-omap2/io.c            |    7 +
>   arch/arm/mach-omap2/pm.h            |    7 +
>   arch/arm/mach-omap2/pm33xx.c        |  429 ++++++++++++++++++++++++++
>   arch/arm/mach-omap2/pm33xx.h        |  100 ++++++
>   arch/arm/mach-omap2/sleep33xx.S     |  571 +++++++++++++++++++++++++++++++++++
>   arch/arm/plat-omap/sram.c           |   10 +-
>   arch/arm/plat-omap/sram.h           |    2 +
>   10 files changed, 1138 insertions(+), 1 deletions(-)
>   create mode 100644 arch/arm/mach-omap2/pm33xx.c
>   create mode 100644 arch/arm/mach-omap2/pm33xx.h
>   create mode 100644 arch/arm/mach-omap2/sleep33xx.S
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index ae87a3e..80736aa 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -71,6 +71,7 @@ endif
>   ifeq ($(CONFIG_PM),y)
>   obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>   obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
> +obj-$(CONFIG_SOC_AM33XX)		+= pm33xx.o sleep33xx.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>   obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
>   obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
> @@ -80,6 +81,7 @@ obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
>   obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
>
>   AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
> +AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>   AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>
>   ifeq ($(CONFIG_PM_VERBOSE),y)
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 601ecdf..23894df 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -109,6 +109,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>   	.reserve	= omap_reserve,
>   	.map_io		= am33xx_map_io,
>   	.init_early	= am33xx_init_early,
> +	.init_late	= am33xx_init_late,
>   	.init_irq	= omap_intc_of_init,
>   	.handle_irq	= omap3_intc_handle_irq,
>   	.init_machine	= omap_generic_init,
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index c925c80..d4319ad 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -109,6 +109,15 @@ static inline int omap3_pm_init(void)
>   }
>   #endif
>
> +#if defined(CONFIG_PM) && defined(CONFIG_SOC_AM33XX)
> +int am33xx_pm_init(void);
> +#else
> +static inline int am33xx_pm_init(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
>   int omap4_pm_init(void);
>   #else
> @@ -157,6 +166,7 @@ void am33xx_init_early(void);
>   void omap4430_init_early(void);
>   void omap5_init_early(void);
>   void omap3_init_late(void);	/* Do not use this one */
> +void am33xx_init_late(void);
>   void omap4430_init_late(void);
>   void omap2420_init_late(void);
>   void omap2430_init_late(void);
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 4fadc78..d06f84a 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -528,6 +528,13 @@ void __init am33xx_init_early(void)
>   	omap_hwmod_init_postsetup();
>   	am33xx_clk_init();
>   }
> +
> +void __init am33xx_init_late(void)
> +{
> +	omap_mux_late_init();
> +	omap2_common_pm_late_init();
> +	am33xx_pm_init();
> +}
>   #endif
>
>   #ifdef CONFIG_ARCH_OMAP4
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 67d6613..d37f20e 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -83,6 +83,13 @@ extern unsigned int omap3_do_wfi_sz;
>   /* ... and its pointer from SRAM after copy */
>   extern void (*omap3_do_wfi_sram)(void);
>
> +/* am33xx_do_wfi function pointer and size, for copy to SRAM */
> +extern void am33xx_do_wfi(void);
> +extern unsigned int am33xx_do_wfi_sz;
> +extern unsigned int am33xx_resume_offset;
> +/* ... and its pointer from SRAM after copy */
> +extern void (*am33xx_do_wfi_sram)(void);
> +
>   /* save_secure_ram_context function pointer and size, for copy to SRAM */
>   extern int save_secure_ram_context(u32 *addr);
>   extern unsigned int save_secure_ram_context_sz;
> diff --git a/arch/arm/mach-omap2/pm33xx.c b/arch/arm/mach-omap2/pm33xx.c
> new file mode 100644
> index 0000000..836af52
> --- /dev/null
> +++ b/arch/arm/mach-omap2/pm33xx.c
> @@ -0,0 +1,429 @@
> +/*
> + * AM33XX Power Management Routines
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + * Vaibhav Bedia <vaibhav.bedia@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/firmware.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/suspend.h>
> +#include <linux/completion.h>
> +#include <linux/module.h>
> +
> +#include <plat/prcm.h>
> +#include <plat/mailbox.h>
> +#include "../plat-omap/sram.h"
> +
> +#include <asm/suspend.h>
> +#include <asm/proc-fns.h>
> +#include <asm/sizes.h>
> +#include <asm/system_misc.h>
> +
> +#include "pm.h"
> +#include "cm33xx.h"
> +#include "pm33xx.h"
> +#include "control.h"
> +#include "clockdomain.h"
> +#include "powerdomain.h"
> +#include "omap_hwmod.h"
> +#include "omap_device.h"
> +#include "soc.h"
> +
In case not checked yet, see if you need
all above headers.

> +void (*am33xx_do_wfi_sram)(void);
> +
> +static void __iomem *am33xx_emif_base;
> +static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm;
> +static struct clockdomain *gfx_l3_clkdm, *gfx_l4ls_clkdm;
> +static struct wkup_m3_context *wkup_m3;
> +
> +static DECLARE_COMPLETION(wkup_m3_sync);
> +
> +#ifdef CONFIG_SUSPEND
> +static int am33xx_do_sram_idle(long unsigned int unused)
> +{
> +	am33xx_do_wfi_sram();
> +	return 0;
> +}
> +
> +static int am33xx_pm_suspend(void)
> +{
> +	int status, ret = 0;
> +
> +	struct omap_hwmod *gpmc_oh, *usb_oh;
> +	struct omap_hwmod *tptc0_oh, *tptc1_oh, *tptc2_oh;
> +
> +	/*
> +	 * By default the following IPs do not have MSTANDBY asserted
> +	 * which is necessary for PER domain transition. If the drivers
> +	 * are not compiled into the kernel HWMOD code will not change the
> +	 * state of the IPs if the IP was not never enabled
> +	 */
> +	usb_oh		= omap_hwmod_lookup("usb_otg_hs");
> +	gpmc_oh		= omap_hwmod_lookup("gpmc");
> +	tptc0_oh	= omap_hwmod_lookup("tptc0");
> +	tptc1_oh	= omap_hwmod_lookup("tptc1");
> +	tptc2_oh	= omap_hwmod_lookup("tptc2");
> +
This look you don't need every suspend.

> +	omap_hwmod_enable(usb_oh);
> +	omap_hwmod_enable(gpmc_oh);
> +	omap_hwmod_enable(tptc0_oh);
> +	omap_hwmod_enable(tptc1_oh);
> +	omap_hwmod_enable(tptc2_oh);
> +
> +	omap_hwmod_idle(usb_oh);
> +	omap_hwmod_idle(gpmc_oh);
> +	omap_hwmod_idle(tptc0_oh);
> +	omap_hwmod_idle(tptc1_oh);
> +	omap_hwmod_idle(tptc2_oh);
> +
Calling omap_hwmod_idle() directly tells me something is not
right. Can these module not idle themself with respective device
drivers ?

> +	/* Put the GFX clockdomains to sleep */
> +	clkdm_sleep(gfx_l3_clkdm);
> +	clkdm_sleep(gfx_l4ls_clkdm);
Can GFX driver suspend code not take care of above ?
Also are these clock domains are not supporting HW supervised
mode ?

> +	/* Try to put GFX to sleep */
> +	pwrdm_set_next_pwrst(gfx_pwrdm, PWRDM_POWER_OFF);
> +
Above as well can be taken care by constraint QOS API by
GFX driver.

> +	ret = cpu_suspend(0, am33xx_do_sram_idle);
> +
> +	status = pwrdm_read_pwrst(gfx_pwrdm);
> +	if (status != PWRDM_POWER_OFF)
> +		pr_err("GFX domain did not transition\n");
> +	else
> +		pr_info("GFX domain entered low power state\n");
> +
> +	/* Needed to ensure L4LS clockdomain transitions properly */
> +	clkdm_wakeup(gfx_l3_clkdm);
> +	clkdm_wakeup(gfx_l4ls_clkdm);
> +
> +	if (ret) {
> +		pr_err("Kernel suspend failure\n");
> +	} else {
> +		status = omap_ctrl_readl(AM33XX_CONTROL_IPC_MSG_REG1);
> +		status &= IPC_RESP_MASK;
> +		status >>= __ffs(IPC_RESP_MASK);
> +
> +		switch (status) {
> +		case 0:
> +			pr_info("Successfully transitioned to low power state\n");
> +			if (wkup_m3->sleep_mode == IPC_CMD_DS0)
> +				/* XXX: Use SOC specific ops for this? */
> +				per_pwrdm->ret_logic_off_counter++;
> +			break;
> +		case 1:
> +			pr_err("Could not enter low power state\n");
> +			ret = -1;
> +			break;
> +		default:
> +			pr_err("Something is terribly wrong :(\nStatus = %d\n",
> +				status);
Sounds terrible :-)

> +			ret = -1;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int am33xx_pm_enter(suspend_state_t suspend_state)
> +{
> +	int ret = 0;
> +
> +	switch (suspend_state) {
> +	case PM_SUSPEND_STANDBY:
> +	case PM_SUSPEND_MEM:
> +		ret = am33xx_pm_suspend();
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int am33xx_pm_begin(suspend_state_t state)
> +{
> +	int ret = 0;
> +
> +	disable_hlt();
> +
> +	/*
> +	 * Physical resume address to be used by ROM code
> +	 */
> +	wkup_m3->resume_addr = (AM33XX_OCMC_END - am33xx_do_wfi_sz +
> +					am33xx_resume_offset + 0x4);
> +
> +	wkup_m3->sleep_mode = IPC_CMD_DS0;
> +	wkup_m3->ipc_data1  = DS_IPC_DEFAULT;
> +	wkup_m3->ipc_data2  = DS_IPC_DEFAULT;
> +
> +	am33xx_ipc_cmd();
> +
> +	wkup_m3->state = M3_STATE_MSG_FOR_LP;
> +
> +	omap_mbox_enable_irq(wkup_m3->mbox, IRQ_RX);
> +
> +	ret = omap_mbox_msg_send(wkup_m3->mbox, 0xABCDABCD);
> +	if (ret) {
> +		pr_err("A8<->CM3 MSG for LP failed\n");
> +		am33xx_m3_state_machine_reset();
> +		ret = -1;
> +	}
> +
> +	if (!wait_for_completion_timeout(&wkup_m3_sync,
> +					msecs_to_jiffies(500))) {

500 is from spec or arbitrary timeout ?

> +/*
> + * Push the minimal suspend-resume code to SRAM
> + */
> +void am33xx_push_sram_idle(void)
> +{
> +	am33xx_do_wfi_sram = (void *)omap_sram_push
> +					(am33xx_do_wfi, am33xx_do_wfi_sz);
> +}
> +
> +static int __init am33xx_map_emif(void)
> +{
> +	am33xx_emif_base = ioremap(AM33XX_EMIF_BASE, SZ_32K);
> +
> +	if (!am33xx_emif_base)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void __iomem *am33xx_get_emif_base(void)
> +{
> +	return am33xx_emif_base;
> +}
> +
> +int __init am33xx_pm_init(void)
> +{
> +	int ret;
> +
> +	if (!soc_is_am33xx())
> +		return -ENODEV;
> +
> +	pr_info("Power Management for AM33XX family\n");
> +
> +	wkup_m3 = kzalloc(sizeof(struct wkup_m3_context), GFP_KERNEL);
> +	if (!wkup_m3) {
> +		pr_err("Memory allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = am33xx_map_emif();
> +
No EMIF driver to handle EMIF MAP, registers etc ?

> +	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
> +
> +	/* CEFUSE domain should be turned off post bootup */
> +	cefuse_pwrdm = pwrdm_lookup("cefuse_pwrdm");
> +	if (cefuse_pwrdm)
> +		pwrdm_set_next_pwrst(cefuse_pwrdm, PWRDM_POWER_OFF);
> +	else
> +		pr_err("Failed to get cefuse_pwrdm\n");
> +
> +	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
> +	per_pwrdm = pwrdm_lookup("per_pwrdm");
> +
> +	gfx_l3_clkdm = clkdm_lookup("gfx_l3_clkdm");
> +	gfx_l4ls_clkdm = clkdm_lookup("gfx_l4ls_gfx_clkdm");
> +
> +	wkup_m3->dev = omap_device_get_by_hwmod_name("wkup_m3");
> +
> +	ret = wkup_m3_init();
> +	if (ret)
> +		pr_err("Could not initialise firmware loading\n");
> +
> +	return ret;
> +}
> diff --git a/arch/arm/mach-omap2/pm33xx.h b/arch/arm/mach-omap2/pm33xx.h
> new file mode 100644
> index 0000000..38f8ae7
> --- /dev/null
> +++ b/arch/arm/mach-omap2/pm33xx.h
> @@ -0,0 +1,100 @@
> +/*
> + * AM33XX Power Management Routines
> + *
> + * Copyright (C) 2012 Texas Instruments Inc.
> + * Vaibhav Bedia <vaibhav.bedia@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_PM33XX_H
> +#define __ARCH_ARM_MACH_OMAP2_PM33XX_H
> +
> +#ifndef __ASSEMBLER__
> +struct wkup_m3_context {
> +	struct device		*dev;
> +	struct firmware		*firmware;
> +	struct omap_mbox	*mbox;
> +	void __iomem		*code;
> +	int			resume_addr;
> +	int			ipc_data1;
> +	int			ipc_data2;
> +	int			sleep_mode;
> +	u8			state;
> +};
> +
> +#ifdef CONFIG_SUSPEND
> +static void am33xx_ipc_cmd(void);
> +static void am33xx_m3_state_machine_reset(void);
> +#else
> +static inline void am33xx_ipc_cmd(void) {}
> +static inline void am33xx_m3_state_machine_reset(void) {}
> +#endif /* CONFIG_SUSPEND */
> +
> +extern void __iomem *am33xx_get_emif_base(void);
> +int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg);
> +#endif
> +
> +#define	IPC_CMD_DS0			0x3
> +#define IPC_CMD_RESET                   0xe
> +#define DS_IPC_DEFAULT			0xffffffff
> +
> +#define IPC_RESP_SHIFT			16
> +#define IPC_RESP_MASK			(0xffff << 16)
> +
> +#define M3_STATE_UNKNOWN		0
> +#define M3_STATE_RESET			1
> +#define M3_STATE_INITED			2
> +#define M3_STATE_MSG_FOR_LP		3
> +#define M3_STATE_MSG_FOR_RESET		4
> +
> +#define AM33XX_OCMC_END			0x40310000
> +#define AM33XX_EMIF_BASE		0x4C000000
> +
> +/*
> + * This a subset of registers defined in drivers/memory/emif.h
> + * Move that to include/linux/?
> + */
> +#define EMIF_MODULE_ID_AND_REVISION			0x0000
> +#define EMIF_STATUS					0x0004
> +#define EMIF_SDRAM_CONFIG				0x0008
> +#define EMIF_SDRAM_CONFIG_2				0x000c
> +#define EMIF_SDRAM_REFRESH_CONTROL			0x0010
> +#define EMIF_SDRAM_REFRESH_CTRL_SHDW			0x0014
> +#define EMIF_SDRAM_TIMING_1				0x0018
> +#define EMIF_SDRAM_TIMING_1_SHDW			0x001c
> +#define EMIF_SDRAM_TIMING_2				0x0020
> +#define EMIF_SDRAM_TIMING_2_SHDW			0x0024
> +#define EMIF_SDRAM_TIMING_3				0x0028
> +#define EMIF_SDRAM_TIMING_3_SHDW			0x002c
> +#define EMIF_LPDDR2_NVM_TIMING				0x0030
> +#define EMIF_LPDDR2_NVM_TIMING_SHDW			0x0034
> +#define EMIF_POWER_MANAGEMENT_CONTROL			0x0038
> +#define EMIF_POWER_MANAGEMENT_CTRL_SHDW			0x003c
> +#define EMIF_PERFORMANCE_COUNTER_1			0x0080
> +#define EMIF_PERFORMANCE_COUNTER_2			0x0084
> +#define EMIF_PERFORMANCE_COUNTER_CONFIG			0x0088
> +#define EMIF_PERFORMANCE_COUNTER_MASTER_REGION_SELECT	0x008c
> +#define EMIF_PERFORMANCE_COUNTER_TIME			0x0090
> +#define EMIF_MISC_REG					0x0094
> +#define EMIF_DLL_CALIB_CTRL				0x0098
> +#define EMIF_DLL_CALIB_CTRL_SHDW			0x009c
> +#define EMIF_SYSTEM_OCP_INTERRUPT_RAW_STATUS		0x00a4
> +#define EMIF_SYSTEM_OCP_INTERRUPT_STATUS		0x00ac
> +#define EMIF_SYSTEM_OCP_INTERRUPT_ENABLE_SET		0x00b4
> +#define EMIF_SYSTEM_OCP_INTERRUPT_ENABLE_CLEAR		0x00bc
> +#define EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG	0x00c8
> +#define EMIF_READ_WRITE_LEVELING_RAMP_WINDOW		0x00d4
> +#define EMIF_READ_WRITE_LEVELING_RAMP_CONTROL		0x00d8
> +#define EMIF_READ_WRITE_LEVELING_CONTROL		0x00dc
> +#define EMIF_DDR_PHY_CTRL_1				0x00e4
> +#define EMIF_DDR_PHY_CTRL_1_SHDW			0x00e8
> +
Above should be part of the EMIF driver, no ?

> +#endif
> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
> new file mode 100644
> index 0000000..f7b34e5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sleep33xx.S
> @@ -0,0 +1,571 @@
> +/*
> + * Low level suspend code for AM33XX SoCs
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + * Vaibhav Bedia <vaibhav.bedia@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/memory.h>
> +#include <asm/assembler.h>
> +
> +#include "cm33xx.h"
> +#include "pm33xx.h"
> +#include "prm33xx.h"
> +#include "control.h"
> +
> +/* replicated define because linux/bitops.h cannot be included in assembly */
> +#define BIT(nr)		(1 << (nr))
> +
> +	.text
> +	.align 3
> +
Sleep code looks pretty big so I will have a closer look at it bit
later. At least from the code it seems, the EMIF registers and hence
memory controller needs to be maneged by SW which is really bad.

Regards
Santosh

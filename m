From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Tue, 31 Mar 2009 17:09:50 -0700
Message-ID: <87ocvhtesx.fsf@deeprootsystems.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:10495 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758305AbZDAAJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 20:09:59 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3288302rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 17:09:57 -0700 (PDT)
In-Reply-To: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com> (Kim Kyuwon's message of "Thu\, 19 Mar 2009 13\:25\:23 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

Kim Kyuwon <chammoru@gmail.com> writes:

> Sometimes, it is necessary to find out "what does wake up my board
> from suspend?". Notifying wake-up source feature may be used to blame
> unexpected wake-up events which increase power consumption. And user
> mode applications can act smartly according to the wake-up event from
> Suspend-to-RAM state to minimize power consumption. Note that this
> driver can't inform wake-up events from idle state. This driver uses
> sysfs interface to give information to user mode applications like:

Hi Kim,

Thanks for addressing my comments.  This is now more streamlined
during the wakeup/resume path as I suggested.  Thanks.  A few more
minor comments below...

> cat /sys/power/omap_resume_irq
> cat /sys/power/omap_resume_event
>
> This driver also privides the unified GPIO wake-up source
> configuration. specific GPIO settings in the board files are:
>
> /* Wakeup source configuration */
> static struct gpio_wake boardname_gpio_wake[] = {
> 	{ 23,	IRQF_TRIGGER_RISING,	"BT_WAKEUP",	1},
> 	{ 24,	IRQF_TRIGGER_RISING,	"USB_DETECT",	1},
> };
>
> static struct omap_wake_platform_data boardname_wake_data = {
> 	.gpio_wakes		= boardname_gpio_wake,
> 	.gpio_wake_num		= ARRAY_SIZE(boardname_gpio_wake),
> };
>
> static struct platform_device boardname_wakeup = {
> 	.name			= "omap-wake",
> 	.id			= -1,
> 	.dev			= {
> 		.platform_data	= &boardname_wake_data,
> 	},
> };
>
> The patch adds Kconfig options "OMAP34xx wakeup source support" under
> "System type"->"TI OMAP implementations" menu.
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    1 +
>  arch/arm/mach-omap2/irq.c              |   21 +-
>  arch/arm/mach-omap2/pm34xx.c           |   12 +
>  arch/arm/mach-omap2/prcm-common.h      |    4 +
>  arch/arm/mach-omap2/prm-regbits-34xx.h |    6 +
>  arch/arm/mach-omap2/wake34xx.c         |  539 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/Kconfig             |    9 +
>  arch/arm/plat-omap/include/mach/irqs.h |    4 +
>  arch/arm/plat-omap/include/mach/pm.h   |   10 +
>  arch/arm/plat-omap/include/mach/wake.h |   30 ++
>  10 files changed, 633 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/wake34xx.c
>  create mode 100644 arch/arm/plat-omap/include/mach/wake.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 16c6fb8..29ad0f1 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> +obj-$(CONFIG_OMAP_WAKE)			+= wake34xx.o
>  endif
>
>  # SmartReflex driver
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index be4b596..6da285e 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -33,9 +33,6 @@
>  #define INTC_MIR_SET0		0x008c
>  #define INTC_PENDING_IRQ0	0x0098
>
> -/* Number of IRQ state bits in each MIR register */
> -#define IRQ_BITS_PER_REG	32
> -
>  /*
>   * OMAP2 has a number of different interrupt controllers, each interrupt
>   * controller is identified as its own "bank". Register definitions are
> @@ -193,6 +190,24 @@ int omap_irq_pending(void)
>  	return 0;
>  }
>
> +void omap_get_pending_irqs(u32 *pending_irqs, unsigned len)
> +{
> +	int i, idx = 0;
> +

minor detail, but how about the more common 'j' instead of idx.

> +	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
> +		struct omap_irq_bank *bank = irq_banks + i;
> +		int irq;
> +
> +		for (irq = 0; irq < bank->nr_irqs && idx < len;
> +						irq += IRQ_BITS_PER_REG) {
> +			int offset = irq & (~(IRQ_BITS_PER_REG - 1));
> +
> +			pending_irqs[idx++] = intc_bank_read_reg(bank,
> +					(INTC_PENDING_IRQ0 + offset));
> +		}
> +	}
> +}
> +
>  void __init omap_init_irq(void)
>  {
>  	unsigned long nr_of_irqs = 0;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9102cee..2d17906 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -91,6 +91,13 @@ static struct prm_setup_times prm_setup = {
>  	.voltsetup2 = 0xff,
>  };
>
> +static struct pm_wakeup_status omap3_pm_wkst;
> +
> +void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst)
> +{
> +	*pm_wkst = &omap3_pm_wkst;
> +}
> +

Can you rename this to omap3_get_last_wake_state()

>  static inline void omap3_per_save_context(void)
>  {
>  	omap3_gpio_save_context();
> @@ -174,6 +181,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>
>  	/* WKUP */
>  	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
> +	omap3_pm_wkst.wkup = wkst;
>  	if (wkst) {
>  		iclk = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
>  		fclk = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
> @@ -187,6 +195,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>
>  	/* CORE */
>  	wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
> +	omap3_pm_wkst.core1 = wkst;
>  	if (wkst) {
>  		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
>  		fclk = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
> @@ -198,6 +207,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>  		cm_write_mod_reg(fclk, CORE_MOD, CM_FCLKEN1);
>  	}
>  	wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
> +	omap3_pm_wkst.core3 = wkst;
>  	if (wkst) {
>  		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
>  		fclk = cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
> @@ -211,6 +221,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>
>  	/* PER */
>  	wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
> +	omap3_pm_wkst.per = wkst;
>  	if (wkst) {
>  		iclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
>  		fclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
> @@ -225,6 +236,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>  	if (omap_rev() > OMAP3430_REV_ES1_0) {
>  		/* USBHOST */
>  		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
> +		omap3_pm_wkst.usbhost = wkst;
>  		if (wkst) {
>  			iclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
>  					       CM_ICLKEN);

I like this is much better.

> diff --git a/arch/arm/mach-omap2/prcm-common.h
> b/arch/arm/mach-omap2/prcm-common.h
> index cb1ae84..1f340aa 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -273,6 +273,10 @@
>  #define OMAP3430_ST_D2D_SHIFT				3
>  #define OMAP3430_ST_D2D_MASK				(1 << 3)
>
> +/* PM_WKST3_CORE, CM_IDLEST3_CORE shared bits */
> +#define OMAP3430_ST_USBTLL_SHIFT			2
> +#define OMAP3430_ST_USBTLL_MASK				(1 << 2)
> +
>  /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
>  #define OMAP3430_EN_GPIO1				(1 << 3)
>  #define OMAP3430_EN_GPIO1_SHIFT				3
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h
> b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index cb648f9..6066032 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -332,6 +332,8 @@
>  /* PM_IVA2GRPSEL1_CORE specific bits */
>
>  /* PM_WKST1_CORE specific bits */
> +#define OMAP3430_ST_MMC3_SHIFT				30
> +#define OMAP3430_ST_MMC3_MASK				(1 << 30)
>
>  /* PM_PWSTCTRL_CORE specific bits */
>  #define OMAP3430_MEM2ONSTATE_SHIFT			18
> @@ -373,6 +375,7 @@
>  /* PM_IVA2GRPSEL_WKUP specific bits */
>
>  /* PM_WKST_WKUP specific bits */
> +#define OMAP3430_ST_IO_CHAIN				(1 << 16)
>  #define OMAP3430_ST_IO					(1 << 8)
>
>  /* PRM_CLKSEL */
> @@ -430,6 +433,9 @@
>
>  /* PM_PREPWSTST_PER specific bits */
>
> +/* PM_WKST_USBHOST specific bits */
> +#define OMAP3430_ST_USBHOST				(1 << 0)
> +
>  /* RM_RSTST_EMU specific bits */
>
>  /* PM_PWSTST_EMU specific bits */
> diff --git a/arch/arm/mach-omap2/wake34xx.c b/arch/arm/mach-omap2/wake34xx.c
> new file mode 100644
> index 0000000..de21f97
> --- /dev/null
> +++ b/arch/arm/mach-omap2/wake34xx.c
> @@ -0,0 +1,539 @@
> +/*
> + * wake34xx.c
> + *
> + * Copyright (c) 2009 Samsung Eletronics
> + *
> + * Author: Kim Kyuwon <q1.kim@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +
> +#include <mach/pm.h>
> +#include <mach/gpio.h>
> +#include <mach/wake.h>
> +
> +#include "prm-regbits-34xx.h"
> +
> +/*
> + * Sometimes, it is necessary to find out "what does wake up my board from
> + * suspend?". Notifying wake-up source feature may be used to blame
> + * unexpected wake-up events which increase power consumption. And user
> + * mode applications can act smartly according to the wake-up event from
> + * Suspend-to-RAM state to minimize power consumption. Note that this
> + * driver can't inform wake-up events from idle state. This driver uses
> + * sysfs interface to give information to user mode applications.
> + */
> +
> +#define WAKE_STR_LEN	64
> +#define WAKE_BUF_LEN	32
> +
> +/* Note: Allowed to use Only in the wakeup_source_show() function */
> +static struct omap_wake *g_wake;
> +
> +static char wakeup_gpio[WAKE_STR_LEN];
> +
> +struct omap_wake {
> +	u32 pending_irqs[INTCPS_NR_MIR_REGS];
> +};
> +
> +struct wake_event {
> +	u32 		mask;
> +	const char 	*name;
> +};
> +
> +static struct wake_event omap3_wkup_events[] = {
> +	{ OMAP3430_ST_IO_CHAIN,			"ST_IO" },
> +	{ OMAP3430_ST_IO,			"ST_SR2" },
> +	{ OMAP3430_ST_SR2_MASK,			"ST_SR2" },
> +	{ OMAP3430_ST_SR1_MASK,			"ST_SR1" },
> +	{ OMAP3430_ST_GPIO1_MASK,		"ST_GPIO1" },
> +	{ OMAP3430_ST_GPT12_MASK,		"ST_GPT12" },
> +	{ OMAP3430_ST_GPT1_MASK,		"ST_GPT1" },
> +};
> +
> +static struct wake_event omap3_per_events[] = {
> +	{ OMAP3430_ST_GPIO6_MASK,		"ST_GPIO6" },
> +	{ OMAP3430_ST_GPIO5_MASK,		"ST_GPIO5" },
> +	{ OMAP3430_ST_GPIO4_MASK,		"ST_GPIO4" },
> +	{ OMAP3430_ST_GPIO3_MASK,		"ST_GPIO3" },
> +	{ OMAP3430_ST_GPIO2_MASK,		"ST_GPIO2" },
> +	{ OMAP3430_ST_UART3_MASK,		"ST_UART3" },
> +	{ OMAP3430_ST_GPT9_MASK,		"ST_GPT9" },
> +	{ OMAP3430_ST_GPT8_MASK,		"ST_GPT8" },
> +	{ OMAP3430_ST_GPT7_MASK,		"ST_GPT7" },
> +	{ OMAP3430_ST_GPT6_MASK,		"ST_GPT6" },
> +	{ OMAP3430_ST_GPT5_MASK,		"ST_GPT5" },
> +	{ OMAP3430_ST_GPT4_MASK,		"ST_GPT4" },
> +	{ OMAP3430_ST_GPT3_MASK,		"ST_GPT3" },
> +	{ OMAP3430_ST_GPT2_MASK,		"ST_GPT2" },
> +	{ OMAP3430_EN_MCBSP4,			"EN_MCBSP4" },
> +	{ OMAP3430_EN_MCBSP3,			"EN_MCBSP3" },
> +	{ OMAP3430_EN_MCBSP2,			"EN_MCBSP2" },
> +};
> +
> +static struct wake_event omap3_core1_events[] = {
> +	{ OMAP3430_ST_MMC3_MASK,		"ST_MMC3" },
> +	{ OMAP3430_ST_MMC2_MASK,		"ST_MMC2" },
> +	{ OMAP3430_ST_MMC1_MASK,		"ST_MMC1" },
> +	{ OMAP3430_ST_MCSPI4_MASK,		"ST_MCSPI4" },
> +	{ OMAP3430_ST_MCSPI3_MASK,		"ST_MCSPI3" },
> +	{ OMAP3430_ST_MCSPI2_MASK,		"ST_MCSPI2" },
> +	{ OMAP3430_ST_MCSPI1_MASK,		"ST_MCSPI1" },
> +	{ OMAP3430_ST_I2C3_MASK,		"ST_I2C3" },
> +	{ OMAP3430_ST_I2C2_MASK,		"ST_I2C2" },
> +	{ OMAP3430_ST_I2C1_MASK,		"ST_I2C1" },
> +	{ OMAP3430_ST_UART1_MASK,		"ST_UART1" },
> +	{ OMAP3430_ST_GPT11_MASK,		"ST_GPT11" },
> +	{ OMAP3430_ST_GPT10_MASK,		"ST_GPT10" },
> +	{ OMAP3430_ST_MCBSP5_MASK,		"ST_MCBSP5" },
> +	{ OMAP3430_ST_MCBSP1_MASK,		"ST_MCBSP1" },
> +};
> +
> +static struct wake_event omap3es1_core1_events[] = {
> +	{ OMAP3430ES1_ST_FSHOSTUSB_MASK,	"ST_FSHOSTUSB" },
> +	{ OMAP3430ES1_ST_HSOTGUSB_MASK,		"ST_HSOTGUSB" },
> +	{ OMAP3430_ST_D2D_MASK,			"ST_D2D" },
> +};
> +
> +static struct wake_event omap3es2_core1_events[] = {
> +	{ OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK,	"ST_HSOTGUSB" },
> +};
> +
> +static struct wake_event omap3_core3_events[] = {
> +	{ OMAP3430_ST_USBTLL_MASK,		"ST_USBTLL" },
> +};
> +
> +static struct wake_event omap3_usbhost_events[] = {
> +	{ OMAP3430_ST_USBHOST,			"ST_USBHOST" },
> +};
> +
> +static ssize_t wakeup_source_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf);
> +
> +/*
> + * Get the first pending MPU IRQ number from 'irq_start'.
> + * If none, return -EINVAL.
> + */
> +int omap_wake_get_pending_irq(struct omap_wake *wake, unsigned int irq_start)
> +{
> +	int i, bits_skip, idx_start;
> +
> +	if (irq_start >= INTCPS_NR_IRQS)
> +		return -EINVAL;
> +
> +	bits_skip = irq_start % IRQ_BITS_PER_REG;
> +	idx_start = irq_start / IRQ_BITS_PER_REG;
> +
> +	for (i = idx_start; i < ARRAY_SIZE(wake->pending_irqs); i++) {
> +		unsigned long val, bit;
> +
> +		val = wake->pending_irqs[i];
> +		if (!val)
> +			continue;
> +
> +		if (idx_start == i)
> +			bit = find_next_bit(&val, IRQ_BITS_PER_REG, bits_skip);
> +		else
> +			bit = find_first_bit(&val, IRQ_BITS_PER_REG);
> +
> +		if (bit < IRQ_BITS_PER_REG)
> +			return i * IRQ_BITS_PER_REG + bit;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void omap_wake_strncat(char *dest, char *src, size_t count)
> +{
> +	int len;
> +
> +	if (!src[0])
> +		return;
> +
> +	if (dest[0])
> +		len = strlen(dest) + strlen(src) + 2;
> +	else
> +		len = strlen(dest) + strlen(src);
> +
> +	if (len > count) {
> +		printk(KERN_ERR "Can't strncat: %s\n", src);

pr_err(...)

> +		return;
> +	}
> +
> +	if (dest[0])
> +		strcat(dest, ", ");
> +	strcat(dest, src);
> +}
> +
> +static int omap_wake_lookup_event(u32 wkst, char *event,
> +				struct wake_event *events, unsigned len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		if (wkst & events[i].mask) {
> +			strncpy(event, events[i].name, WAKE_BUF_LEN - 1);
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +static void omap_wake_detect_wkup(u32 wkst, char *event)
> +{
> +	int error = omap_wake_lookup_event(wkst, event,
> +		omap3_wkup_events, ARRAY_SIZE(omap3_wkup_events));
> +	if (error)
> +		snprintf(event, WAKE_BUF_LEN, "WKUP:0x%08x", wkst);
> +}
> +
> +static void omap_wake_detect_per(u32 wkst, char *event)
> +{
> +	int error = omap_wake_lookup_event(wkst, event,
> +		omap3_per_events, ARRAY_SIZE(omap3_per_events));
> +	if (error)
> +		snprintf(event, WAKE_BUF_LEN, "PER:0x%08x", wkst);
> +}
> +
> +static void omap_wake_detect_core1(u32 wkst, char *event)
> +{
> +	int error;
> +
> +	error = omap_wake_lookup_event(wkst, event,
> +		omap3_core1_events, ARRAY_SIZE(omap3_core1_events));
> +	if (!error)
> +		return;
> +
> +	if (omap_rev() == OMAP3430_REV_ES1_0) {
> +		error = omap_wake_lookup_event(wkst, event,
> +					omap3es1_core1_events,
> +					ARRAY_SIZE(omap3es1_core1_events));
> +	} else {
> +		error = omap_wake_lookup_event(wkst, event,
> +					omap3es2_core1_events,
> +					ARRAY_SIZE(omap3es2_core1_events));
> +	}
> +	if (!error)
> +		return;
> +
> +	snprintf(event, WAKE_BUF_LEN, "CORE1:0x%08x", wkst);
> +}
> +
> +static void omap_wake_detect_core3(u32 wkst, char *event)
> +{
> +	int error = omap_wake_lookup_event(wkst, event,
> +		omap3_core3_events, ARRAY_SIZE(omap3_core3_events));
> +	if (error)
> +		snprintf(event, WAKE_BUF_LEN, "CORE3:0x%08x", wkst);
> +}
> +
> +static void omap_wake_detect_usbhost(u32 wkst, char *event)
> +{
> +	int error = omap_wake_lookup_event(wkst, event,
> +		omap3_usbhost_events, ARRAY_SIZE(omap3_usbhost_events));
> +	if (error)
> +		snprintf(event, WAKE_BUF_LEN, "USBHOST:0x%08x", wkst);
> +}

I'm still not liking this method of multiple functions that are
basically the same.   The only thing different is CORE1 which has some
conditional code based on cpu_rev.

To make this a little cleaner, you could have an array that contains
the WKST, powerdomain name, and CPU rev flags, then have a common
function that walks that array and dumps all.

> +/* Detect wake-up events */
> +static void omap_wake_detect_wakeup(struct omap_wake *wake,
> +					char *wake_irq, char *wake_event,
> +					size_t irq_size, size_t event_size)
> +{

None of these functions really "detect" wakeups.  They are merely
converting the wakeup into a string.  Maybe "show" or "dump" is a
better word than detect.

> +	struct pm_wakeup_status *pm_wkst;
> +	char buf[WAKE_BUF_LEN] = {0, };
> +	int irq, len, gpio_irq = 0, prcm_irq = 0;
> +
> +	/* IRQ */
> +	irq = omap_wake_get_pending_irq(wake, 0);
> +	while (irq >= 0) {
> +		if (irq == INT_34XX_SYS_NIRQ)
> +			omap_wake_strncat(wake_event, "sys_nirq",
> +							event_size - 1);
> +		else if (irq == INT_34XX_PRCM_MPU_IRQ)
> +			prcm_irq = 1;
> +		else if (irq >= INT_34XX_GPIO_BANK1 &&
> +					irq <= INT_34XX_GPIO_BANK6)
> +			gpio_irq = 1;
> +
> +		len = strlen(wake_irq) +
> +			snprintf(buf, WAKE_BUF_LEN, "%d", irq);
> +		if (len > irq_size - 1)
> +			break;
> +
> +		strcat(wake_irq, buf);
> +
> +		irq = omap_wake_get_pending_irq(wake, irq + 1);
> +		if (irq >= 0) {
> +			len = strlen(wake_irq) + 2;
> +			if (len > irq_size - 1)
> +				break;
> +
> +			strcat(wake_irq, ", ");
> +		}
> +	}
> +	if (!wake_irq[0])
> +		strncpy(wake_irq, "Unknown", irq_size - 1);
> +
> +	if (gpio_irq)
> +		omap_wake_strncat(wake_event, wakeup_gpio, event_size - 1);
> +
> +	if (!prcm_irq)
> +		goto end_detect;
> +
> +	omap3_get_wakeup_status(&pm_wkst);
> +
> +	/* WKUP */
> +	if (pm_wkst->wkup) {
> +		omap_wake_detect_wkup(pm_wkst->wkup, buf);
> +		omap_wake_strncat(wake_event, buf, event_size - 1);
> +	}
> +
> +	/* PER */
> +	if (pm_wkst->per) {
> +		omap_wake_detect_per(pm_wkst->per, buf);
> +		omap_wake_strncat(wake_event, buf, event_size - 1);
> +	}
> +
> +	/* CORE */
> +	if (pm_wkst->core1) {
> +		omap_wake_detect_core1(pm_wkst->core1, buf);
> +		omap_wake_strncat(wake_event, buf, event_size - 1);
> +	}
> +	if (pm_wkst->core3) {
> +		omap_wake_detect_core3(pm_wkst->core3, buf);
> +		omap_wake_strncat(wake_event, buf, event_size - 1);
> +	}
> +
> +	/* USBHOST */
> +	if ((omap_rev() > OMAP3430_REV_ES1_0) && (pm_wkst->usbhost)) {
> +		omap_wake_detect_usbhost(pm_wkst->usbhost, buf);
> +		omap_wake_strncat(wake_event, buf, event_size - 1);
> +	}

Here is where you would just walk the array of WKST/domain tuples.

> +end_detect:
> +	if (!wake_event[0])
> +		strncpy(wake_event, "Unknown", event_size - 1);
> +}
> +
> +static struct kobj_attribute wakeup_irq_attr =
> +	__ATTR(omap_resume_irq, 0644, wakeup_source_show, NULL);
> +
> +static struct kobj_attribute wakeup_event_attr =
> +	__ATTR(omap_resume_event, 0644, wakeup_source_show, NULL);
> +
> +static ssize_t wakeup_source_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	char wakeup_irq[WAKE_STR_LEN] = {0, };
> +	char wakeup_event[WAKE_STR_LEN] = {0, };
> +
> +	if (!g_wake)
> +		return -EINVAL;
> +
> +	omap_wake_detect_wakeup(g_wake, wakeup_irq, wakeup_event,
> +				sizeof(wakeup_irq), sizeof(wakeup_event));
> +
> +	if (attr == &wakeup_irq_attr)
> +		return sprintf(buf, "%s\n", wakeup_irq);
> +	else if (attr == &wakeup_event_attr)
> +		return sprintf(buf, "%s\n", wakeup_event);
> +	else
> +		return -EINVAL;
> +}
> +
> +static irqreturn_t omap_wake_detect_gpio(int irq, void *dev_id)
> +{
> +	omap_wake_strncat(wakeup_gpio, dev_id, sizeof(wakeup_gpio) - 1);
> +
> +	return IRQ_HANDLED;
> +}

Again this is not a "detect".  How about omap_wake_gpio_interrupt()

> +static int __devinit omap_wake_probe(struct platform_device *pdev)
> +{
> +	struct omap_wake *wake;
> +	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +	struct gpio_wake *gw;
> +	int i, ret;
> +
> +	wake = kzalloc(sizeof(struct omap_wake), GFP_KERNEL);
> +	if (wake == NULL) {
> +		dev_err(&pdev->dev, "failed to allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, wake);
> +
> +	/*
> +	 * It may be good to configure GPIO wake-up sources in each driver.
> +	 * Buf if the specific device driver doesn't exist, you can use
> +	 * omap-wake driver to configure gpio wake-up sources.
> +	 */
> +	for (i = 0; i < pdata->gpio_wake_num; i++) {
> +		gw = pdata->gpio_wakes + i;
> +
> +		if (gw->request) {
> +			ret = gpio_request(gw->gpio, gw->name);
> +			if (ret) {
> +				dev_err(&pdev->dev, "can't request gpio%d"
> +					", return %d\n", gw->gpio, ret);
> +				goto failed_free_gpio;
> +			}
> +		}
> +		gpio_direction_input(gw->gpio);
> +		enable_irq_wake(gpio_to_irq(gw->gpio));
> +	}
> +
> +	/*
> +	 * In wakeup_source_show(), we can't access platform_device
> +	 * or omap_wake structure without a global variable. so 'g_wake' is
> +	 * needed, but please use it carefully.
> +	 */
> +	g_wake = wake;
> +
> +	ret = sysfs_create_file(power_kobj, &wakeup_irq_attr.attr);
> +	if (ret)
> +		dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
> +					wakeup_irq_attr.attr.name, ret);
> +
> +	ret = sysfs_create_file(power_kobj, &wakeup_event_attr.attr);
> +	if (ret)
> +		dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
> +					wakeup_event_attr.attr.name, ret);
> +
> +	return 0;
> +
> +failed_free_gpio:
> +	for (i--; i >= 0; i--) {
> +		gw = pdata->gpio_wakes + i;
> +
> +		if (gw->request)
> +			gpio_free(gw->gpio);
> +	}
> +	kfree(wake);
> +
> +	return ret;
> +}
> +
> +static int __devexit omap_wake_remove(struct platform_device *pdev)
> +{
> +	struct omap_wake *wake = platform_get_drvdata(pdev);
> +	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +	struct gpio_wake *gw;
> +	int i;
> +
> +	for (i = 0; i < pdata->gpio_wake_num; i++) {
> +		gw = pdata->gpio_wakes + i;
> +
> +		if (gw->request)
> +			gpio_free(gw->gpio);
> +
> +		disable_irq_wake(gpio_to_irq(gw->gpio));
> +	}
> +	kfree(wake);
> +
> +	return 0;
> +}
> +
> +static int omap_wake_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +	struct gpio_wake *gw;
> +	int i, ret;
> +
> +	for (i = 0; i < pdata->gpio_wake_num; i++) {
> +		gw = pdata->gpio_wakes + i;
> +
> +		ret = request_irq(gpio_to_irq(gw->gpio), omap_wake_detect_gpio,
> +			gw->irqflag | IRQF_SHARED, gw->name, (void *)gw->name);
> +		if (ret) {
> +			dev_err(&pdev->dev, "can't get IRQ%d, return %d\n",
> +					gpio_to_irq(gw->gpio), ret);
> +			goto failed_free_irq;
> +		}
> +	}
> +
> +	memset(wakeup_gpio, 0x0, WAKE_STR_LEN);
> +
> +	return 0;
> +
> +failed_free_irq:
> +	for (i--; i >= 0; i--) {
> +		gw = pdata->gpio_wakes + i;
> +		free_irq(gpio_to_irq(gw->gpio),  (void *)gw->name);
> +	}
> +
> +	return ret;
> +}
> +
> +static int omap_wake_resume_early(struct platform_device *pdev)
> +{
> +	struct omap_wake *wake = platform_get_drvdata(pdev);
> +
> +	omap_get_pending_irqs(wake->pending_irqs,
> +					ARRAY_SIZE(wake->pending_irqs));
> +
> +	return 0;
> +}
> +
> +static int omap_wake_resume(struct platform_device *pdev)
> +{
> +	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +	struct gpio_wake *gw;
> +	int i;
> +
> +#ifdef CONFIG_PM_DEBUG
> +	struct omap_wake *wake = platform_get_drvdata(pdev);
> +	char wakeup_irq[WAKE_STR_LEN] = {0, };
> +	char wakeup_event[WAKE_STR_LEN] = {0, };
> +
> +	omap_wake_detect_wakeup(wake, wakeup_irq, wakeup_event,
> +				sizeof(wakeup_irq), sizeof(wakeup_event));
> +	printk(KERN_INFO "OMAP resume IRQ: %s\n", wakeup_irq);
> +	printk(KERN_INFO "OMAP resume event: %s\n", wakeup_event);

pr_info(...)

> +#endif
> +
> +	for (i = 0; i < pdata->gpio_wake_num; i++) {
> +		gw = pdata->gpio_wakes + i;
> +		free_irq(gpio_to_irq(gw->gpio), (void *)gw->name);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver omap_wake_driver = {
> +	.probe          = omap_wake_probe,
> +	.remove		= __devexit_p(omap_wake_remove),
> +	.suspend	= omap_wake_suspend,
> +	.resume_early	= omap_wake_resume_early,
> +	.resume		= omap_wake_resume,
> +	.driver         = {
> +		.name   = "omap-wake",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap_wake_init(void)
> +{
> +	return platform_driver_register(&omap_wake_driver);
> +}
> +
> +module_init(omap_wake_init);
> +
> +static void __exit omap_wake_exit(void)
> +{
> +	platform_driver_unregister(&omap_wake_driver);
> +}
> +module_exit(omap_wake_exit);
> +
> +MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
> +MODULE_DESCRIPTION("OMAP34xx wakeup driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index b8f1298..f89efaa 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -184,6 +184,15 @@ config OMAP_IOMMU
>  	  Say Y here if you want to use OMAP IOMMU support for IVA2 and
>  	  Camera in OMAP3.
>
> +config OMAP_WAKE
> +	tristate "OMAP34xx wakeup source support"
> +	depends on ARCH_OMAP34XX && PM
> +	default n
> +	help
> +	  Select this option if you want to know what kind of wake-up event
> +	  wakes up your board from the low power mode. And this option
> +	  provides the unified GPIO wake-up source configuration.
> +

Update this as well to say that it only affects wakeup from suspend.

>  choice
>          prompt "System timer"
>  	default OMAP_MPU_TIMER
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h
> b/arch/arm/plat-omap/include/mach/irqs.h
> index c9a5b19..ee15402 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -385,9 +385,13 @@
>  #define INTCPS_NR_MIR_REGS	3
>  #define INTCPS_NR_IRQS		96
>
> +/* Number of IRQ state bits in each MIR register */
> +#define IRQ_BITS_PER_REG	32
> +
>  #ifndef __ASSEMBLY__
>  extern void omap_init_irq(void);
>  extern int omap_irq_pending(void);
> +extern void omap_get_pending_irqs(u32 *pending_irqs, unsigned len);
>  void omap3_intc_save_context(void);
>  void omap3_intc_restore_context(void);
>  #endif
> diff --git a/arch/arm/plat-omap/include/mach/pm.h
> b/arch/arm/plat-omap/include/mach/pm.h
> index 9df0175..b10f5b0 100644
> --- a/arch/arm/plat-omap/include/mach/pm.h
> +++ b/arch/arm/plat-omap/include/mach/pm.h
> @@ -175,6 +175,16 @@ extern void omap_serial_wake_trigger(int enable);
>  #define omap_serial_wake_trigger(x)	{}
>  #endif	/* CONFIG_OMAP_SERIAL_WAKE */
>
> +struct pm_wakeup_status {
> +	u32 wkup;
> +	u32 core1;
> +	u32 core3;
> +	u32 per;
> +	u32 usbhost;
> +};
> +
> +extern void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst);
> +

This should probably just go in wake34xx.h since this is all very
OMAP3 specific.  pm.h is for OMAP1/2/3 common code.

>  #define ARM_SAVE(x) arm_sleep_save[ARM_SLEEP_SAVE_##x] = omap_readl(x)
>  #define ARM_RESTORE(x) omap_writel((arm_sleep_save[ARM_SLEEP_SAVE_##x]), (x))
>  #define ARM_SHOW(x) arm_sleep_save[ARM_SLEEP_SAVE_##x]
> diff --git a/arch/arm/plat-omap/include/mach/wake.h
> b/arch/arm/plat-omap/include/mach/wake.h
> new file mode 100644
> index 0000000..7da8ec8
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/wake.h
> @@ -0,0 +1,30 @@
> +/*
> + * wake.h
> + *
> + * Copyright (c) 2009 Samsung Eletronics
> + *
> + * Author: Kim Kyuwon <q1.kim@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _WAKE_H_
> +#define _WAKE_H_
> +
> +struct gpio_wake {
> +	unsigned int 	gpio;
> +	unsigned long	irqflag;
> +	const char 	*name;
> +	int		request;
> +};
> +
> +struct omap_wake_platform_data{
> +	struct gpio_wake	*gpio_wakes;
> +	int			gpio_wake_num;
> +};
> +
> +#endif /* _WAKE_H_ */
> +

Do you need this common wake.h here?  Again, this dir is for common
code accoss OMAP1/2/3 and this code is pretty OMAP3 specific.

Kevin

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v3
Date: Mon, 20 Apr 2009 17:15:13 -0700
Message-ID: <87tz4i981a.fsf@deeprootsystems.com>
References: <4d34a0a70904030343h4f1562b5y3dbc9467aac9967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:4046 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZDUAPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 20:15:21 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2144749rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 17:15:20 -0700 (PDT)
In-Reply-To: <4d34a0a70904030343h4f1562b5y3dbc9467aac9967@mail.gmail.com> (Kim Kyuwon's message of "Fri\, 3 Apr 2009 19\:43\:42 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, riverful@gmail.com

--=-=-=

Kim Kyuwon <chammoru@gmail.com> writes:

> Sometimes, it is necessary to find out "what does wake up my board
> from suspend?". Notifying wake-up source feature may be used to blame
> unexpected wake-up events which increase power consumption. And user
> mode applications can act smartly according to the wake-up event from
> Suspend-to-RAM state to minimize power consumption. Note that this
> driver can't inform wake-up events from idle state. This driver uses
> sysfs interface to give information to user mode applications like:
>
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

Hi Kyuwon,

While I still like the concept of this driver, I'm still not quite
happy about how it is implemented for various reasons.  Most of which
have to do with the fact that this driver does many things that really
should be the job of other layers.  In particular, the list of
omap3_wake_events is a bit troubling.  It really should be handled by
the omapdev layer.  You'll see that you are duplicating the data that
is handled there.  Rather, we should just extend the omapdev data to
handle the wakeup events for that device.

Also, I still think the WKST register reading should be done in the
PRCM interrupt handler.  In your previous attempt, you were seeing a
bunch of non-device wakeup related interrupts.   Can you try again
with the attached patch (thanks to Paul Walmseley) which should help
us debug why you were seeing spurious PRCM interrupts.

Also, I know we discussed this before, but I think the GPIO wakeup
source stuff really belongs in a separate patch, and if you think it
is still useful, and cannot be done by just enabling a GPIO IRQ from
the board file, I suggest you propose a patch to the generic GPIO
layer to add this interface.

> ---
>  arch/arm/mach-omap2/Makefile           |    1 +
>  arch/arm/mach-omap2/irq.c              |   21 +-
>  arch/arm/mach-omap2/prcm-common.h      |    4 +
>  arch/arm/mach-omap2/prm-regbits-34xx.h |    5 +
>  arch/arm/mach-omap2/wake34xx.c         |  681 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/Kconfig             |    9 +
>  arch/arm/plat-omap/include/mach/irqs.h |    4 +
>  arch/arm/plat-omap/include/mach/wake.h |   30 ++
>  8 files changed, 752 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/wake34xx.c
>  create mode 100644 arch/arm/plat-omap/include/mach/wake.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index e693efd..4d7dbca 100644
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
> index 700fc3d..18ac725 100644
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
> +	int i, j = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
> +		struct omap_irq_bank *bank = irq_banks + i;
> +		int irq;
> +
> +		for (irq = 0; irq < bank->nr_irqs && j < len;
> +						irq += IRQ_BITS_PER_REG) {
> +			int offset = irq & (~(IRQ_BITS_PER_REG - 1));
> +
> +			pending_irqs[j++] = intc_bank_read_reg(bank,
> +					(INTC_PENDING_IRQ0 + offset));
> +		}
> +	}
> +}
> +
>  void __init omap_init_irq(void)
>  {
>  	unsigned long nr_of_irqs = 0;
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
> index 06fee29..f0a6395 100644
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
> @@ -432,6 +434,9 @@
>
>  /* PM_PREPWSTST_PER specific bits */
>
> +/* PM_WKST_USBHOST specific bits */
> +#define OMAP3430_ST_USBHOST				(1 << 0)
> +
>  /* RM_RSTST_EMU specific bits */

All these new bit defines should all be 3430ES2_*.

>  /* PM_PWSTST_EMU specific bits */
> diff --git a/arch/arm/mach-omap2/wake34xx.c b/arch/arm/mach-omap2/wake34xx.c
> new file mode 100644
> index 0000000..86aac4f
> --- /dev/null
> +++ b/arch/arm/mach-omap2/wake34xx.c
> @@ -0,0 +1,681 @@
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
> +#define DOMAIN_IS_WKUP		(1 << 0)
> +#define DOMAIN_IS_PER		(1 << 1)
> +#define DOMAIN_IS_CORE1		(1 << 2)
> +#define DOMAIN_IS_CORE3		(1 << 3)
> +#define DOMAIN_IS_USBHOST	(1 << 4)
> +
> +#define WAKE_STR_LEN		64
> +#define WAKE_BUF_LEN		32
> +
> +static char wakeup_gpio[WAKE_STR_LEN];
> +
> +struct pm_wakeup_status {
> +	u32	wkup;
> +	u32	per;
> +	u32	core1;
> +	u32	core3;
> +	u32	usbhost;
> +};
> +
> +struct omap_wake {
> +	u32			pending_irqs[INTCPS_NR_MIR_REGS];
> +
> +	struct pm_wakeup_status	pm_wkst;
> +};
> +
> +struct wake_event {
> +	const u32			mask;
> +	const u32			domain;
> +	const char			*name;
> +
> +	/* OMAP chip types that this wakeup status is valid on */
> +	const struct omap_chip_id	omap_chip;
> +};
> +
> +
> +/* Note: Allowed to use Only in the wakeup_source_show() function */
> +static struct omap_wake *g_wake;
> +
> +static struct wake_event omap3_wake_events[] = {
> +	{	/* WKUP */
> +		.mask = OMAP3430_ST_IO_CHAIN,
> +		.domain = DOMAIN_IS_WKUP,
> +		.name = "ST_IO_CHAIN",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_IO,
> +		.domain = DOMAIN_IS_WKUP,
> +		.name = "ST_IO",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_SR2_MASK,
> +		.domain = DOMAIN_IS_WKUP,
> +		.name = "ST_SR2",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_SR1_MASK,
> +		.domain = DOMAIN_IS_WKUP,
> +		.name = "ST_SR1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPIO1_MASK,
> +		.domain = DOMAIN_IS_WKUP,
> +		.name = "ST_GPIO1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT12_MASK,
> +		.domain = DOMAIN_IS_WKUP,
> +		.name = "ST_GPT12",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT1_MASK,
> +		.domain = DOMAIN_IS_WKUP,
> +		.name = "ST_GPT1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {	/* PER */
> +		.mask = OMAP3430_ST_GPIO6_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPIO6",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPIO5_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPIO5",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPIO4_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPIO4",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPIO3_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPIO3",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPIO2_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPIO2",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_UART3_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_UART3",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT9_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT9",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT8_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT8",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT7_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT7",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT6_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT6",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT5_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT5",
> +		.omap_chip =  OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	},  {
> +		.mask = OMAP3430_ST_GPT4_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT4",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT3_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT3",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT2_MASK,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "ST_GPT2",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_EN_MCBSP4,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "EN_MCBSP4",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_EN_MCBSP3,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "EN_MCBSP3",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_EN_MCBSP2,
> +		.domain = DOMAIN_IS_PER,
> +		.name = "EN_MCBSP2",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {	/* CORE1 */
> +		.mask = OMAP3430_ST_MMC3_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MMC3",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MMC2_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MMC2",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MMC1_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MMC1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MCSPI4_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MCSPI4",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MCSPI3_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MCSPI3",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MCSPI2_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MCSPI2",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MCSPI1_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MCSPI1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_I2C3_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_I2C3",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_I2C2_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_I2C2",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_I2C1_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_I2C1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_UART1_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_UART1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT11_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_GPT11",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_GPT10_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_GPT10",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MCBSP5_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MCBSP5",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430_ST_MCBSP1_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_MCBSP1",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {
> +		.mask = OMAP3430ES1_ST_FSHOSTUSB_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_FSHOSTUSB",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +	}, {
> +		.mask = OMAP3430ES1_ST_HSOTGUSB_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_HSOTGUSB",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +	}, {
> +		.mask = OMAP3430_ST_D2D_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_D2D",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +	}, {
> +		.mask = OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK,
> +		.domain = DOMAIN_IS_CORE1,
> +		.name = "ST_HSOTGUSB",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
> +	}, {	/* CORE3 */
> +		.mask = OMAP3430_ST_USBTLL_MASK,
> +		.domain = DOMAIN_IS_CORE3,
> +		.name = "ST_USBTLL",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	}, {	/* USBHOST */
> +		.mask = OMAP3430_ST_USBHOST,
> +		.domain = DOMAIN_IS_USBHOST,
> +		.name = "ST_USBHOST",
> +		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +	},
> +};

This is the list that should disappear and be handled by exending
omapdev.

[...]

Kevin



--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment;
 filename=0001-OMAP3-PM-improve-PRCM-interrupt-handler.patch

>From 114168fca85ba38421c84a7163ea4ae98b452577 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 20 Apr 2009 17:49:04 -0600
Subject: [PATCH] OMAP3 PM: improve PRCM interrupt handler

This test patch fixes a few obvious bugs in the OMAP3xxx PRCM
interrupt handler.

Clearing wakeup sources is now only done when the PRM indicates a
wakeup source interrupt.  Since we don't handle any other types of
PRCM interrupts right now, warn if we get any other type of PRCM
interrupt.  Either code needs to be added to the PRCM interrupt
handler to react to these, or these other interrupts should be masked
off at init.

Also, PM_WKST register contents should be ANDed with the contents of
the MPUGRPSEL registers.  Otherwise the MPU PRCM interrupt handler
could wind up clearing wakeup events meant for the IVA PRCM interrupt
handler.  For a production version of this patch, we should not read
MPUGRPSEL from the PRM, since those reads are very slow; rather, we
should use a cached version from struct powerdomain (not yet
implemented)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   78 +++++++++++++++++++++++++++++++++--------
 1 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7474cfa..7e78a3b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -194,14 +194,18 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
 	}
 }
 
-/* PRCM Interrupt Handler for wakeups */
-static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
+static int _prcm_int_handle_wakeup(void)
 {
-	u32 wkst, irqstatus_mpu;
-	u32 fclk, iclk;
+	u32 wkst, fclk, iclk;
+	int c = 0;
+
+        /* FIXME: MPUGRPSEL reads beow should be done from an SDRAM
+	 *        local copy in the struct powerdomain since PRM reads
+	 *        are very slow. */
 
 	/* WKUP */
 	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
+	wkst &= prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	if (wkst) {
 		iclk = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
 		fclk = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
@@ -211,10 +215,12 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		while (prm_read_mod_reg(WKUP_MOD, PM_WKST));
 		cm_write_mod_reg(iclk, WKUP_MOD, CM_ICLKEN);
 		cm_write_mod_reg(fclk, WKUP_MOD, CM_FCLKEN);
+		c++;
 	}
 
 	/* CORE */
 	wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+	wkst &= prm_read_mod_reg(CORE_MOD, OMAP3430_PM_MPUGRPSEL1);
 	if (wkst) {
 		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
 		fclk = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
@@ -224,21 +230,32 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		while (prm_read_mod_reg(CORE_MOD, PM_WKST1));
 		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN1);
 		cm_write_mod_reg(fclk, CORE_MOD, CM_FCLKEN1);
+		c++;
 	}
-	wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
-	if (wkst) {
-		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
-		fclk = cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
-		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN3);
-		cm_set_mod_reg_bits(wkst, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
-		prm_write_mod_reg(wkst, CORE_MOD, OMAP3430ES2_PM_WKST3);
-		while (prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3));
-		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN3);
-		cm_write_mod_reg(fclk, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
+		wkst &= prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_MPUGRPSEL3);
+		if (wkst) {
+			iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
+			fclk = cm_read_mod_reg(CORE_MOD,
+					       OMAP3430ES2_CM_FCLKEN3);
+			cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN3);
+			cm_set_mod_reg_bits(wkst, CORE_MOD,
+					    OMAP3430ES2_CM_FCLKEN3);
+			prm_write_mod_reg(wkst, CORE_MOD,
+					  OMAP3430ES2_PM_WKST3);
+			while (prm_read_mod_reg(CORE_MOD,
+						OMAP3430ES2_PM_WKST3));
+			cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN3);
+			cm_write_mod_reg(fclk, CORE_MOD,
+					 OMAP3430ES2_CM_FCLKEN3);
+			c++;
+		}
 	}
 
 	/* PER */
 	wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
+	wkst &= prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 	if (wkst) {
 		iclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
 		fclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
@@ -248,11 +265,14 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		while (prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST));
 		cm_write_mod_reg(iclk, OMAP3430_PER_MOD, CM_ICLKEN);
 		cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
+		c++;
 	}
 
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
 		/* USBHOST */
 		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
+		wkst &= prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+					 OMAP3430_PM_MPUGRPSEL);
 		if (wkst) {
 			iclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
 					       CM_ICLKEN);
@@ -271,12 +291,38 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 			cm_write_mod_reg(fclk, OMAP3430ES2_USBHOST_MOD,
 					 CM_FCLKEN);
 		}
+		c++;
 	}
 
+	return c;
+}
+
+/* PRCM Interrupt Handler for wakeups */
+static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
+{
+	u32 irqstatus_mpu;
+	int c;
+
 	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
 					OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
+
+	if (irqstatus_mpu & OMAP3430_WKUP_ST) {
+		c = _prcm_int_handle_wakeup();
+
+		/*
+		 * Is the MPU PRCM interrupt handler racing with the
+		 * IVA2 PRCM interrupt handler ?
+		 */
+		WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
+		     "but no wakeup sources are marked\n");
+	} else {
+		/* XXX we need to expand our PRCM interrupt handler */
+		WARN(1, "prcm: WARNING: PRCM interrupt received, but no "
+		     "code to handle it (%08x)\n", irqstatus_mpu);
+	}
+
 	prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
-					OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
+			  OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 
 	while (prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET));
 
@@ -969,7 +1015,7 @@ int __init omap3_pm_init(void)
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
 
-	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
+	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,	
 			  (irq_handler_t)prcm_interrupt_handler,
 			  IRQF_DISABLED, "prcm", NULL);
 	if (ret) {
-- 
1.6.2.2


--=-=-=--

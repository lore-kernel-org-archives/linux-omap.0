From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v3
Date: Tue, 14 Apr 2009 14:20:50 +0900
Message-ID: <4d34a0a70904132220l36ab3e7ex5e27a896bb20da5e@mail.gmail.com>
References: <4d34a0a70904030343h4f1562b5y3dbc9467aac9967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:9346 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbZDNFVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 01:21:08 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2487204wff.4
        for <linux-omap@vger.kernel.org>; Mon, 13 Apr 2009 22:21:05 -0700 (PDT)
In-Reply-To: <4d34a0a70904030343h4f1562b5y3dbc9467aac9967@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: OMAP <linux-omap@vger.kernel.org>

Hi Kevin,

Have you had chance to review this new version of wakeup driver? :)

Regards,
Kyuwon

On Fri, Apr 3, 2009 at 7:43 PM, Kim Kyuwon <chammoru@gmail.com> wrote:
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
>        { 23,   IRQF_TRIGGER_RISING,    "BT_WAKEUP",    1},
>        { 24,   IRQF_TRIGGER_RISING,    "USB_DETECT",   1},
> };
>
> static struct omap_wake_platform_data boardname_wake_data = {
>        .gpio_wakes             = boardname_gpio_wake,
>        .gpio_wake_num          = ARRAY_SIZE(boardname_gpio_wake),
> };
>
> static struct platform_device boardname_wakeup = {
>        .name                   = "omap-wake",
>        .id                     = -1,
>        .dev                    = {
>                .platform_data  = &boardname_wake_data,
>        },
> };
>
> The patch adds Kconfig options "OMAP34xx wakeup source support" under
> "System type"->"TI OMAP implementations" menu.
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
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
> @@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_OMAP2)              += pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP24XX)            += sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)               += pm34xx.o sleep34xx.o cpuidle34xx.o
>  obj-$(CONFIG_PM_DEBUG)                 += pm-debug.o
> +obj-$(CONFIG_OMAP_WAKE)                        += wake34xx.o
>  endif
>
>  # SmartReflex driver
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 700fc3d..18ac725 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -33,9 +33,6 @@
>  #define INTC_MIR_SET0          0x008c
>  #define INTC_PENDING_IRQ0      0x0098
>
> -/* Number of IRQ state bits in each MIR register */
> -#define IRQ_BITS_PER_REG       32
> -
>  /*
>  * OMAP2 has a number of different interrupt controllers, each interrupt
>  * controller is identified as its own "bank". Register definitions are
> @@ -193,6 +190,24 @@ int omap_irq_pending(void)
>        return 0;
>  }
>
> +void omap_get_pending_irqs(u32 *pending_irqs, unsigned len)
> +{
> +       int i, j = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
> +               struct omap_irq_bank *bank = irq_banks + i;
> +               int irq;
> +
> +               for (irq = 0; irq < bank->nr_irqs && j < len;
> +                                               irq += IRQ_BITS_PER_REG) {
> +                       int offset = irq & (~(IRQ_BITS_PER_REG - 1));
> +
> +                       pending_irqs[j++] = intc_bank_read_reg(bank,
> +                                       (INTC_PENDING_IRQ0 + offset));
> +               }
> +       }
> +}
> +
>  void __init omap_init_irq(void)
>  {
>        unsigned long nr_of_irqs = 0;
> diff --git a/arch/arm/mach-omap2/prcm-common.h
> b/arch/arm/mach-omap2/prcm-common.h
> index cb1ae84..1f340aa 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -273,6 +273,10 @@
>  #define OMAP3430_ST_D2D_SHIFT                          3
>  #define OMAP3430_ST_D2D_MASK                           (1 << 3)
>
> +/* PM_WKST3_CORE, CM_IDLEST3_CORE shared bits */
> +#define OMAP3430_ST_USBTLL_SHIFT                       2
> +#define OMAP3430_ST_USBTLL_MASK                                (1 << 2)
> +
>  /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
>  #define OMAP3430_EN_GPIO1                              (1 << 3)
>  #define OMAP3430_EN_GPIO1_SHIFT                                3
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h
> b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index 06fee29..f0a6395 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -332,6 +332,8 @@
>  /* PM_IVA2GRPSEL1_CORE specific bits */
>
>  /* PM_WKST1_CORE specific bits */
> +#define OMAP3430_ST_MMC3_SHIFT                         30
> +#define OMAP3430_ST_MMC3_MASK                          (1 << 30)
>
>  /* PM_PWSTCTRL_CORE specific bits */
>  #define OMAP3430_MEM2ONSTATE_SHIFT                     18
> @@ -432,6 +434,9 @@
>
>  /* PM_PREPWSTST_PER specific bits */
>
> +/* PM_WKST_USBHOST specific bits */
> +#define OMAP3430_ST_USBHOST                            (1 << 0)
> +
>  /* RM_RSTST_EMU specific bits */
>
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
> +#define DOMAIN_IS_WKUP         (1 << 0)
> +#define DOMAIN_IS_PER          (1 << 1)
> +#define DOMAIN_IS_CORE1                (1 << 2)
> +#define DOMAIN_IS_CORE3                (1 << 3)
> +#define DOMAIN_IS_USBHOST      (1 << 4)
> +
> +#define WAKE_STR_LEN           64
> +#define WAKE_BUF_LEN           32
> +
> +static char wakeup_gpio[WAKE_STR_LEN];
> +
> +struct pm_wakeup_status {
> +       u32     wkup;
> +       u32     per;
> +       u32     core1;
> +       u32     core3;
> +       u32     usbhost;
> +};
> +
> +struct omap_wake {
> +       u32                     pending_irqs[INTCPS_NR_MIR_REGS];
> +
> +       struct pm_wakeup_status pm_wkst;
> +};
> +
> +struct wake_event {
> +       const u32                       mask;
> +       const u32                       domain;
> +       const char                      *name;
> +
> +       /* OMAP chip types that this wakeup status is valid on */
> +       const struct omap_chip_id       omap_chip;
> +};
> +
> +
> +/* Note: Allowed to use Only in the wakeup_source_show() function */
> +static struct omap_wake *g_wake;
> +
> +static struct wake_event omap3_wake_events[] = {
> +       {       /* WKUP */
> +               .mask = OMAP3430_ST_IO_CHAIN,
> +               .domain = DOMAIN_IS_WKUP,
> +               .name = "ST_IO_CHAIN",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_IO,
> +               .domain = DOMAIN_IS_WKUP,
> +               .name = "ST_IO",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_SR2_MASK,
> +               .domain = DOMAIN_IS_WKUP,
> +               .name = "ST_SR2",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_SR1_MASK,
> +               .domain = DOMAIN_IS_WKUP,
> +               .name = "ST_SR1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPIO1_MASK,
> +               .domain = DOMAIN_IS_WKUP,
> +               .name = "ST_GPIO1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT12_MASK,
> +               .domain = DOMAIN_IS_WKUP,
> +               .name = "ST_GPT12",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT1_MASK,
> +               .domain = DOMAIN_IS_WKUP,
> +               .name = "ST_GPT1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {    /* PER */
> +               .mask = OMAP3430_ST_GPIO6_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPIO6",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPIO5_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPIO5",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPIO4_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPIO4",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPIO3_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPIO3",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPIO2_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPIO2",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_UART3_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_UART3",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT9_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT9",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT8_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT8",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT7_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT7",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT6_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT6",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT5_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT5",
> +               .omap_chip =  OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       },  {
> +               .mask = OMAP3430_ST_GPT4_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT4",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT3_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT3",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT2_MASK,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "ST_GPT2",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_EN_MCBSP4,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "EN_MCBSP4",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_EN_MCBSP3,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "EN_MCBSP3",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_EN_MCBSP2,
> +               .domain = DOMAIN_IS_PER,
> +               .name = "EN_MCBSP2",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {    /* CORE1 */
> +               .mask = OMAP3430_ST_MMC3_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MMC3",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MMC2_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MMC2",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MMC1_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MMC1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MCSPI4_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MCSPI4",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MCSPI3_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MCSPI3",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MCSPI2_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MCSPI2",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MCSPI1_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MCSPI1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_I2C3_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_I2C3",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_I2C2_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_I2C2",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_I2C1_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_I2C1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_UART1_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_UART1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT11_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_GPT11",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_GPT10_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_GPT10",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MCBSP5_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MCBSP5",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430_ST_MCBSP1_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_MCBSP1",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {
> +               .mask = OMAP3430ES1_ST_FSHOSTUSB_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_FSHOSTUSB",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +       }, {
> +               .mask = OMAP3430ES1_ST_HSOTGUSB_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_HSOTGUSB",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +       }, {
> +               .mask = OMAP3430_ST_D2D_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_D2D",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +       }, {
> +               .mask = OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK,
> +               .domain = DOMAIN_IS_CORE1,
> +               .name = "ST_HSOTGUSB",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
> +       }, {    /* CORE3 */
> +               .mask = OMAP3430_ST_USBTLL_MASK,
> +               .domain = DOMAIN_IS_CORE3,
> +               .name = "ST_USBTLL",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +       }, {    /* USBHOST */
> +               .mask = OMAP3430_ST_USBHOST,
> +               .domain = DOMAIN_IS_USBHOST,
> +               .name = "ST_USBHOST",
> +               .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
> +       },
> +};
> +
> +static ssize_t wakeup_source_show(struct kobject *kobj,
> +                               struct kobj_attribute *attr, char *buf);
> +
> +/*
> + * Get the first pending MPU IRQ number from 'irq_start'.
> + * If none, return -EINVAL.
> + */
> +static int omap3_wake_get_pending_irq(struct omap_wake *wake,
> +                                               unsigned int irq_start)
> +{
> +       int i, bits_skip, idx_start;
> +
> +       if (irq_start >= INTCPS_NR_IRQS)
> +               return -EINVAL;
> +
> +       bits_skip = irq_start % IRQ_BITS_PER_REG;
> +       idx_start = irq_start / IRQ_BITS_PER_REG;
> +
> +       for (i = idx_start; i < ARRAY_SIZE(wake->pending_irqs); i++) {
> +               unsigned long val, bit;
> +
> +               val = wake->pending_irqs[i];
> +               if (!val)
> +                       continue;
> +
> +               if (idx_start == i)
> +                       bit = find_next_bit(&val, IRQ_BITS_PER_REG, bits_skip);
> +               else
> +                       bit = find_first_bit(&val, IRQ_BITS_PER_REG);
> +
> +               if (bit < IRQ_BITS_PER_REG)
> +                       return i * IRQ_BITS_PER_REG + bit;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static void omap3_wake_strncat(char *dest, char *src, size_t count)
> +{
> +       int len;
> +
> +       if (!src[0])
> +               return;
> +
> +       if (dest[0])
> +               len = strlen(dest) + strlen(src) + 2;
> +       else
> +               len = strlen(dest) + strlen(src);
> +
> +       if (len > count) {
> +               pr_err("Can't strncat: %s\n", src);
> +               return;
> +       }
> +
> +       if (dest[0])
> +               strcat(dest, ", ");
> +       strcat(dest, src);
> +}
> +
> +static u32 omap3_wake_get_domain_wkst(struct omap_wake *wake, u32 domain)
> +{
> +       struct pm_wakeup_status *pm_wkst = &wake->pm_wkst;
> +
> +       switch (domain) {
> +       case DOMAIN_IS_WKUP:
> +               return pm_wkst->wkup;
> +       case DOMAIN_IS_PER:
> +               return pm_wkst->per;
> +       case DOMAIN_IS_CORE1:
> +               return pm_wkst->core1;
> +       case DOMAIN_IS_CORE3:
> +               return pm_wkst->core3;
> +       case DOMAIN_IS_USBHOST:
> +               return pm_wkst->usbhost;
> +       default:
> +               pr_err("Invalid domain ID: %d\n", domain);
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static void omap3_wake_lookup_event(struct omap_wake *wake, char *event,
> +                                       char *wake_event, size_t count)
> +{
> +       struct wake_event *events = omap3_wake_events;
> +       int i, len = ARRAY_SIZE(omap3_wake_events);
> +       u32 wkst;
> +
> +       for (i = 0; i < len; i++) {
> +               if (!omap_chip_is(events[i].omap_chip))
> +                       continue;
> +
> +               wkst = omap3_wake_get_domain_wkst(wake, events[i].domain);
> +               if (wkst <= 0)
> +                       continue;
> +
> +               if (wkst & events[i].mask) {
> +                       omap3_wake_strncat(wake_event,
> +                                       (char *)events[i].name, count);
> +               }
> +       }
> +}
> +
> +/* Detect wake-up events */
> +static void omap3_wake_dump_wakeup(struct omap_wake *wake,
> +                                       char *wake_irq, char *wake_event,
> +                                       size_t irq_size, size_t event_size)
> +{
> +       char buf[WAKE_BUF_LEN] = {0, };
> +       int irq, len, gpio_irq = 0, prcm_irq = 0;
> +
> +       /* IRQ */
> +       irq = omap3_wake_get_pending_irq(wake, 0);
> +       while (irq >= 0) {
> +               if (irq == INT_34XX_SYS_NIRQ)
> +                       omap3_wake_strncat(wake_event, "sys_nirq",
> +                                                       event_size - 1);
> +               else if (irq == INT_34XX_PRCM_MPU_IRQ)
> +                       prcm_irq = 1;
> +               else if (irq >= INT_34XX_GPIO_BANK1 &&
> +                                       irq <= INT_34XX_GPIO_BANK6)
> +                       gpio_irq = 1;
> +
> +               len = strlen(wake_irq) +
> +                       snprintf(buf, WAKE_BUF_LEN, "%d", irq);
> +               if (len > irq_size - 1)
> +                       break;
> +
> +               strcat(wake_irq, buf);
> +
> +               irq = omap3_wake_get_pending_irq(wake, irq + 1);
> +               if (irq >= 0) {
> +                       len = strlen(wake_irq) + 2;
> +                       if (len > irq_size - 1)
> +                               break;
> +
> +                       strcat(wake_irq, ", ");
> +               }
> +       }
> +       if (gpio_irq)
> +               omap3_wake_strncat(wake_event, wakeup_gpio, event_size - 1);
> +
> +       if (prcm_irq)
> +               omap3_wake_lookup_event(wake, buf, wake_event, event_size - 1);
> +
> +       if (!wake_irq[0])
> +               strncpy(wake_irq, "Unknown", irq_size - 1);
> +
> +       if (!wake_event[0])
> +               strncpy(wake_event, "Unknown", event_size - 1);
> +}
> +
> +static struct kobj_attribute wakeup_irq_attr =
> +       __ATTR(omap_resume_irq, 0644, wakeup_source_show, NULL);
> +
> +static struct kobj_attribute wakeup_event_attr =
> +       __ATTR(omap_resume_event, 0644, wakeup_source_show, NULL);
> +
> +static ssize_t wakeup_source_show(struct kobject *kobj,
> +                               struct kobj_attribute *attr, char *buf)
> +{
> +       char wakeup_irq[WAKE_STR_LEN] = {0, };
> +       char wakeup_event[WAKE_STR_LEN] = {0, };
> +
> +       if (!g_wake)
> +               return -EINVAL;
> +
> +       omap3_wake_dump_wakeup(g_wake, wakeup_irq, wakeup_event,
> +                               sizeof(wakeup_irq), sizeof(wakeup_event));
> +
> +       if (attr == &wakeup_irq_attr)
> +               return sprintf(buf, "%s\n", wakeup_irq);
> +       else if (attr == &wakeup_event_attr)
> +               return sprintf(buf, "%s\n", wakeup_event);
> +       else
> +               return -EINVAL;
> +}
> +
> +static irqreturn_t omap3_wake_gpio_interrupt(int irq, void *dev_id)
> +{
> +       omap3_wake_strncat(wakeup_gpio, dev_id, sizeof(wakeup_gpio) - 1);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int __devinit omap3_wake_probe(struct platform_device *pdev)
> +{
> +       struct omap_wake *wake;
> +       struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +       struct gpio_wake *gw;
> +       int i, ret;
> +
> +       wake = kzalloc(sizeof(struct omap_wake), GFP_KERNEL);
> +       if (wake == NULL) {
> +               dev_err(&pdev->dev, "failed to allocate driver data\n");
> +               return -ENOMEM;
> +       }
> +
> +       platform_set_drvdata(pdev, wake);
> +
> +       /*
> +        * It may be good to configure GPIO wake-up sources in each driver.
> +        * Buf if the specific device driver doesn't exist, you can use
> +        * omap-wake driver to configure gpio wake-up sources.
> +        */
> +       for (i = 0; i < pdata->gpio_wake_num; i++) {
> +               gw = pdata->gpio_wakes + i;
> +
> +               if (gw->request) {
> +                       ret = gpio_request(gw->gpio, gw->name);
> +                       if (ret) {
> +                               dev_err(&pdev->dev, "can't request gpio%d"
> +                                       ", return %d\n", gw->gpio, ret);
> +                               goto failed_free_gpio;
> +                       }
> +               }
> +               gpio_direction_input(gw->gpio);
> +               enable_irq_wake(gpio_to_irq(gw->gpio));
> +       }
> +
> +       /*
> +        * In wakeup_source_show(), we can't access platform_device
> +        * or omap_wake structure without a global variable. so 'g_wake' is
> +        * needed, but please use it carefully.
> +        */
> +       g_wake = wake;
> +
> +       ret = sysfs_create_file(power_kobj, &wakeup_irq_attr.attr);
> +       if (ret)
> +               dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
> +                                       wakeup_irq_attr.attr.name, ret);
> +
> +       ret = sysfs_create_file(power_kobj, &wakeup_event_attr.attr);
> +       if (ret)
> +               dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
> +                                       wakeup_event_attr.attr.name, ret);
> +
> +       return 0;
> +
> +failed_free_gpio:
> +       for (i--; i >= 0; i--) {
> +               gw = pdata->gpio_wakes + i;
> +
> +               if (gw->request)
> +                       gpio_free(gw->gpio);
> +       }
> +       kfree(wake);
> +
> +       return ret;
> +}
> +
> +static int __devexit omap3_wake_remove(struct platform_device *pdev)
> +{
> +       struct omap_wake *wake = platform_get_drvdata(pdev);
> +       struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +       struct gpio_wake *gw;
> +       int i;
> +
> +       for (i = 0; i < pdata->gpio_wake_num; i++) {
> +               gw = pdata->gpio_wakes + i;
> +
> +               if (gw->request)
> +                       gpio_free(gw->gpio);
> +
> +               disable_irq_wake(gpio_to_irq(gw->gpio));
> +       }
> +       kfree(wake);
> +
> +       return 0;
> +}
> +
> +static int omap3_wake_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +       struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +       struct gpio_wake *gw;
> +       int i, ret;
> +
> +       for (i = 0; i < pdata->gpio_wake_num; i++) {
> +               gw = pdata->gpio_wakes + i;
> +
> +               ret = request_irq(gpio_to_irq(gw->gpio),
> +                                               omap3_wake_gpio_interrupt,
> +                                               gw->irqflag | IRQF_SHARED,
> +                                               gw->name, (void *)gw->name);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "can't get IRQ%d, return %d\n",
> +                                               gpio_to_irq(gw->gpio), ret);
> +                       goto failed_free_irq;
> +               }
> +       }
> +
> +       memset(wakeup_gpio, 0x0, WAKE_STR_LEN);
> +
> +       return 0;
> +
> +failed_free_irq:
> +       for (i--; i >= 0; i--) {
> +               gw = pdata->gpio_wakes + i;
> +               free_irq(gpio_to_irq(gw->gpio),  (void *)gw->name);
> +       }
> +
> +       return ret;
> +}
> +
> +static int omap3_wake_resume_early(struct platform_device *pdev)
> +{
> +       struct omap_wake *wake = platform_get_drvdata(pdev);
> +       struct pm_wakeup_status *pm_wkst = &wake->pm_wkst;
> +
> +       omap_get_pending_irqs(wake->pending_irqs,
> +                                       ARRAY_SIZE(wake->pending_irqs));
> +
> +       /* If PRCM interrupt generates this system wake-up event, */
> +       if (wake->pending_irqs[0] & (0x1 << INT_34XX_PRCM_MPU_IRQ)) {
> +               pm_wkst->wkup = prm_read_mod_reg(WKUP_MOD, PM_WKST);
> +               pm_wkst->core1 = prm_read_mod_reg(CORE_MOD, PM_WKST1);
> +               pm_wkst->core3 =
> +                       prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
> +               pm_wkst->per = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
> +               pm_wkst->usbhost =
> +                       prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
> +       }
> +
> +       return 0;
> +}
> +
> +static int omap3_wake_resume(struct platform_device *pdev)
> +{
> +       struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
> +       struct gpio_wake *gw;
> +       int i;
> +
> +#ifdef CONFIG_PM_DEBUG
> +       struct omap_wake *wake = platform_get_drvdata(pdev);
> +       char wakeup_irq[WAKE_STR_LEN] = {0, };
> +       char wakeup_event[WAKE_STR_LEN] = {0, };
> +
> +       omap3_wake_dump_wakeup(wake, wakeup_irq, wakeup_event,
> +                               sizeof(wakeup_irq), sizeof(wakeup_event));
> +       pr_info("OMAP resume IRQ: %s\n", wakeup_irq);
> +       pr_info("OMAP resume event: %s\n", wakeup_event);
> +#endif
> +
> +       for (i = 0; i < pdata->gpio_wake_num; i++) {
> +               gw = pdata->gpio_wakes + i;
> +               free_irq(gpio_to_irq(gw->gpio), (void *)gw->name);
> +       }
> +
> +       return 0;
> +}
> +
> +static struct platform_driver omap3_wake_driver = {
> +       .probe          = omap3_wake_probe,
> +       .remove         = __devexit_p(omap3_wake_remove),
> +       .suspend        = omap3_wake_suspend,
> +       .resume_early   = omap3_wake_resume_early,
> +       .resume         = omap3_wake_resume,
> +       .driver         = {
> +               .name   = "omap-wake",
> +               .owner  = THIS_MODULE,
> +       },
> +};
> +
> +static int __init omap3_wake_init(void)
> +{
> +       return platform_driver_register(&omap3_wake_driver);
> +}
> +
> +module_init(omap3_wake_init);
> +
> +static void __exit omap3_wake_exit(void)
> +{
> +       platform_driver_unregister(&omap3_wake_driver);
> +}
> +module_exit(omap3_wake_exit);
> +
> +MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
> +MODULE_DESCRIPTION("OMAP34xx wakeup driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index c5e8239..ddeeae2 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -211,6 +211,15 @@ config OMAP_IOMMU
>          Say Y here if you want to use OMAP IOMMU support for IVA2 and
>          Camera in OMAP3.
>
> +config OMAP_WAKE
> +       tristate "OMAP34xx wakeup source support"
> +       depends on ARCH_OMAP34XX && PM
> +       default n
> +       help
> +         Select this option if you want to know what kind of wake-up event
> +         wakes up your board from suspend. And this option provides the
> +         unified GPIO wake-up source configuration.
> +
>  choice
>         prompt "System timer"
>        default OMAP_MPU_TIMER
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h
> b/arch/arm/plat-omap/include/mach/irqs.h
> index c9a5b19..ee15402 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -385,9 +385,13 @@
>  #define INTCPS_NR_MIR_REGS     3
>  #define INTCPS_NR_IRQS         96
>
> +/* Number of IRQ state bits in each MIR register */
> +#define IRQ_BITS_PER_REG       32
> +
>  #ifndef __ASSEMBLY__
>  extern void omap_init_irq(void);
>  extern int omap_irq_pending(void);
> +extern void omap_get_pending_irqs(u32 *pending_irqs, unsigned len);
>  void omap3_intc_save_context(void);
>  void omap3_intc_restore_context(void);
>  #endif
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
> +       unsigned int    gpio;
> +       unsigned long   irqflag;
> +       const char      *name;
> +       int             request;
> +};
> +
> +struct omap_wake_platform_data{
> +       struct gpio_wake        *gpio_wakes;
> +       int                     gpio_wake_num;
> +};
> +
> +#endif /* _WAKE_H_ */
> +
> --
> 1.5.2.5
>
>
> --
> Kyuwon
>

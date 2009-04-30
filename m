From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCHv2] ARM: OMAP: gptimer based event monitor driver for oprofile
Date: Thu, 30 Apr 2009 11:38:12 +0530
Message-ID: <006401c9c95a$0e2d76f0$LocalHost@wipultra793>
References: <200901290521.08407.siarhei.siamashka@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbZD3GI5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Apr 2009 02:08:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, oprofile-list@lists.sourceforge.net

Hi Siarhei,

Could you let me know the advantage of the this patch over timer interrupt
based profiling already supported by oprofile. I tested timer interrupt 
based
profiling on omap3 platform and found that it works well.

Thanks
Hemanth

http://oprofile.sourceforge.net/doc/detailed-parameters.html#timer
4.3. OProfile in timer interrupt mode
Note
This section applies to 2.6 kernels and above only.

In 2.6 kernels on CPUs without OProfile support for the hardware performance
counters, the driver falls back to using the timer interrupt for profiling.
Like the RTC mode in 2.4 kernels, this is not able to profile code that has
interrupts disabled. Note that there are no configuration parameters for
setting this, unlike the RTC and hardware performance counter setup.

You can force use of the timer interrupt by using the timer=1 module
parameter (or oprofile.timer=1 on the boot command line if OProfile is
built-in).

----- Original Message ----- 
From: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
To: <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: <linux-omap@vger.kernel.org>; <oprofile-list@lists.sourceforge.net>
Sent: Thursday, January 29, 2009 8:51 AM
Subject: [PATCHv2] ARM: OMAP: gptimer based event monitor driver for 
oprofile


>
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
> ---
>
> A second revision of gptimer oprofile patch
> http://marc.info/?l=linux-omap&m=123143937515088&w=2
> with the fixes suggested by Tony Lindgren
>
> Timers from the CORE domain seem to work best on OMAP3.
> Also tested the patch on Nokia 770 (OMAP1710).
>
> Please let me know if anything else needs to be fixed.
>
> arch/arm/Kconfig                          |    6 ++
> arch/arm/oprofile/Makefile                |    1 +
> arch/arm/oprofile/common.c                |    5 ++
> arch/arm/oprofile/op_arm_model.h          |    2 +
> arch/arm/oprofile/op_model_omap_gptimer.c |   93 
> +++++++++++++++++++++++++++++
> 5 files changed, 107 insertions(+), 0 deletions(-)
> create mode 100644 arch/arm/oprofile/op_model_omap_gptimer.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e7fb201..8774136 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -160,6 +160,12 @@ config GENERIC_HARDIRQS_NO__DO_IRQ
>
> if OPROFILE
>
> +config OPROFILE_OMAP_GPTIMER
> + def_bool y
> + depends on ARCH_OMAP
> + select CONFIG_OMAP_32K_TIMER
> + select CONFIG_OMAP_DM_TIMER
> +
> config OPROFILE_ARMV6
>  def_bool y
>  depends on CPU_V6 && !SMP
> diff --git a/arch/arm/oprofile/Makefile b/arch/arm/oprofile/Makefile
> index 88e31f5..fc2bc02 100644
> --- a/arch/arm/oprofile/Makefile
> +++ b/arch/arm/oprofile/Makefile
> @@ -8,6 +8,7 @@ DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
>
> oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
> oprofile-$(CONFIG_CPU_XSCALE) += op_model_xscale.o
> +oprofile-$(CONFIG_OPROFILE_OMAP_GPTIMER) += op_model_omap_gptimer.o
> oprofile-$(CONFIG_OPROFILE_ARM11_CORE) += op_model_arm11_core.o
> oprofile-$(CONFIG_OPROFILE_ARMV6) += op_model_v6.o
> oprofile-$(CONFIG_OPROFILE_MPCORE) += op_model_mpcore.o
> diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
> index 3fcd752..add3cb4 100644
> --- a/arch/arm/oprofile/common.c
> +++ b/arch/arm/oprofile/common.c
> @@ -133,6 +133,11 @@ int __init oprofile_arch_init(struct 
> oprofile_operations *ops)
>
>  ops->backtrace = arm_backtrace;
>
> +/* comes first, so that it can be overrided by a better implementation */
> +#ifdef CONFIG_OPROFILE_OMAP_GPTIMER
> + spec = &op_omap_gptimer_spec;
> +#endif
> +
> #ifdef CONFIG_CPU_XSCALE
>  spec = &op_xscale_spec;
> #endif
> diff --git a/arch/arm/oprofile/op_arm_model.h 
> b/arch/arm/oprofile/op_arm_model.h
> index 8c4e4f6..db936da 100644
> --- a/arch/arm/oprofile/op_arm_model.h
> +++ b/arch/arm/oprofile/op_arm_model.h
> @@ -24,6 +24,8 @@ struct op_arm_model_spec {
> extern struct op_arm_model_spec op_xscale_spec;
> #endif
>
> +extern struct op_arm_model_spec op_omap_gptimer_spec;
> +
> extern struct op_arm_model_spec op_armv6_spec;
> extern struct op_arm_model_spec op_mpcore_spec;
> extern struct op_arm_model_spec op_armv7_spec;
> diff --git a/arch/arm/oprofile/op_model_omap_gptimer.c 
> b/arch/arm/oprofile/op_model_omap_gptimer.c
> new file mode 100644
> index 0000000..98f7d2b
> --- /dev/null
> +++ b/arch/arm/oprofile/op_model_omap_gptimer.c
> @@ -0,0 +1,93 @@
> +/**
> + * OMAP gptimer based event monitor driver for oprofile
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Author: Siarhei Siamashka <siarhei.siamashka@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <linux/oprofile.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +
> +#include <mach/dmtimer.h>
> +
> +#include "op_counter.h"
> +#include "op_arm_model.h"
> +
> +static struct omap_dm_timer *gptimer;
> +
> +static int gptimer_init(void)
> +{
> + return 0;
> +}
> +
> +static int gptimer_setup(void)
> +{
> + return 0;
> +}
> +
> +static irqreturn_t gptimer_interrupt(int irq, void *arg)
> +{
> + omap_dm_timer_write_status(gptimer, OMAP_TIMER_INT_OVERFLOW);
> + oprofile_add_sample(get_irq_regs(), 0);
> + return IRQ_HANDLED;
> +}
> +
> +static int gptimer_start(void)
> +{
> + int err;
> + u32 count = counter_config[0].count;
> +
> + BUG_ON(gptimer != NULL);
> + /* First try to request timers from CORE power domain for OMAP3 */
> + if (cpu_is_omap34xx()) {
> + gptimer = omap_dm_timer_request_specific(10);
> + if (gptimer == NULL)
> + gptimer = omap_dm_timer_request_specific(11);
> + }
> + /* Just any timer would be fine */
> + if (gptimer == NULL)
> + gptimer = omap_dm_timer_request();
> + if (gptimer == NULL)
> + return -ENODEV;
> +
> + omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
> + err = request_irq(omap_dm_timer_get_irq(gptimer), gptimer_interrupt,
> + IRQF_DISABLED, "oprofile gptimer", NULL);
> + if (err) {
> + omap_dm_timer_free(gptimer);
> + gptimer = NULL;
> + printk(KERN_ERR "oprofile: unable to request gptimer IRQ\n");
> + return err;
> + }
> +
> + if (count < 1)
> + count = 1;
> +
> + omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - count);
> + omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
> + return 0;
> +}
> +
> +static void gptimer_stop(void)
> +{
> + omap_dm_timer_set_int_enable(gptimer, 0);
> + free_irq(omap_dm_timer_get_irq(gptimer), NULL);
> + omap_dm_timer_free(gptimer);
> + gptimer = NULL;
> +}
> +
> +struct op_arm_model_spec op_omap_gptimer_spec = {
> + .init = gptimer_init,
> + .num_counters = 1,
> + .setup_ctrs = gptimer_setup,
> + .start = gptimer_start,
> + .stop = gptimer_stop,
> + .name = "hrtimer",
> +};
> -- 
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> 


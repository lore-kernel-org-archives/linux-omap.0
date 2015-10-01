From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
Date: Thu, 1 Oct 2015 14:58:57 -0700
Message-ID: <CALAqxLU1TiKVfPXmxAONZsHYCTvkcMbR4BXRz9vmUjTitUL4Fw@mail.gmail.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
	<1443559446-26969-10-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-10-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 29, 2015 at 1:44 PM, Felipe Balbi <balbi@ti.com> wrote:
> Introduce a new clocksource driver for Texas
> Instruments 32.768 Hz device which is available
> on most OMAP-like devices.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/clocksource/Kconfig        |   8 +++
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/timer-ti-32k.c | 121 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 drivers/clocksource/timer-ti-32k.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a7726db13abb..0ccfd12a00a3 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -115,6 +115,14 @@ config CLKSRC_PISTACHIO
>         bool
>         select CLKSRC_OF
>
> +config CLKSRC_TI_32K
> +       bool "Texas Instruments 32.768 Hz Clocksource"
> +       depends on OF && ARCH_OMAP2PLUS
> +       select CLKSRC_OF
> +       help
> +         This option enables support for Texas Instruments 32.768 Hz clocksource
> +         available on many OMAP-like platforms.
> +
>  config CLKSRC_STM32
>         bool "Clocksource for STM32 SoCs" if !ARCH_STM32
>         depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 5c00863c3e33..749abc3665b3 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_VF_PIT_TIMER)    += vf_pit_timer.o
>  obj-$(CONFIG_CLKSRC_QCOM)      += qcom-timer.o
>  obj-$(CONFIG_MTK_TIMER)                += mtk_timer.o
>  obj-$(CONFIG_CLKSRC_PISTACHIO) += time-pistachio.o
> +obj-$(CONFIG_CLKSRC_TI_32K)    += timer-ti-32k.o
>
>  obj-$(CONFIG_ARM_ARCH_TIMER)           += arm_arch_timer.o
>  obj-$(CONFIG_ARM_GLOBAL_TIMER)         += arm_global_timer.o
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
> new file mode 100644
> index 000000000000..10ccce2eb645
> --- /dev/null
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -0,0 +1,121 @@
> +/**
> + * timer-ti-32k.c - OMAP2 32k Timer Support
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/time.h>
> +#include <linux/interrupt.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/sched_clock.h>
> +#include <linux/clocksource.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#include <asm/mach/time.h>
> +
> +/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
> +#define OMAP2_32KSYNCNT_REV_OFF                0x0
> +#define OMAP2_32KSYNCNT_REV_SCHEME     (0x3 << 30)
> +#define OMAP2_32KSYNCNT_CR_OFF_LOW     0x10
> +#define OMAP2_32KSYNCNT_CR_OFF_HIGH    0x30
> +
> +/*
> + * 32KHz clocksource ... always available, on pretty most chips except
> + * OMAP 730 and 1510.  Other timers could be used as clocksources, with
> + * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
> + * but systems won't necessarily want to spend resources that way.
> + */
> +static void __iomem *sync32k_cnt_reg;
> +
> +/**
> + * omap_read_persistent_clock64 -  Return time from a persistent clock.
> + *
> + * Reads the time from a source which isn't disabled during PM, the
> + * 32k sync timer.  Convert the cycles elapsed since last read into
> + * nsecs and adds to a monotonically increasing timespec64.
> + */
> +static struct timespec64 persistent_ts;
> +static cycles_t cycles;
> +static unsigned int persistent_mult, persistent_shift;
> +
> +static u64 notrace omap_32k_read_sched_clock(void)
> +{
> +       return readl_relaxed(sync32k_cnt_reg);
> +}
> +
> +static void omap_read_persistent_clock64(struct timespec64 *ts)
> +{
> +       unsigned long long nsecs;
> +       cycles_t last_cycles;
> +
> +       last_cycles = cycles;
> +       cycles = sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
> +
> +       nsecs = clocksource_cyc2ns(cycles - last_cycles,
> +                                       persistent_mult, persistent_shift);
> +
> +       timespec64_add_ns(&persistent_ts, nsecs);
> +
> +       *ts = persistent_ts;
> +}

So this doesn't look to really be a persistent clock (like an RTC),
and is more just a clock that doesn't halt in suspend, right?
(I know some devices used this trick to provide suspend timing w/o an RTC).

That said, we do now support CLOCK_SOURCE_SUSPEND_NONSTOP, which
allows us to do suspend timing from the clocksource itself, so you
should be able to add that flag to the clocksource flags and drop all
the persistent clock bit here.

thanks
-john

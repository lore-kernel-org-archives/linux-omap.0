From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
Date: Thu, 1 Oct 2015 23:59:52 +0200
Message-ID: <560DACD8.8000301@linaro.org>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-10-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-10-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, John Stultz <john.stultz@linaro.org>
List-Id: linux-omap@vger.kernel.org


Hi Felipe,


On 09/29/2015 10:44 PM, Felipe Balbi wrote:
> Introduce a new clocksource driver for Texas
> Instruments 32.768 Hz device which is available
> on most OMAP-like devices.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

[ ... ]

> +config CLKSRC_TI_32K
> +	bool "Texas Instruments 32.768 Hz Clocksource"
> +	depends on OF && ARCH_OMAP2PLUS
> +	select CLKSRC_OF
> +	help
> +	  This option enables support for Texas Instruments 32.768 Hz clock=
source
> +	  available on many OMAP-like platforms.
> +

It is the omap's Kconfig which should select the timer, not the user to=
=20
enable the timer.

It should be something like:

config CLKSRC_TI_32K
	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
	select CLKSRC_OF if OF
	help
	  This option enables support for Texas Instruments 32.768 Hz
	  clocksource available on many OMAP-like platforms.

And in the omap's Kconfig:
	select CLKSRC_TI_32K


>   config CLKSRC_STM32
>   	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
>   	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> index 5c00863c3e33..749abc3665b3 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_VF_PIT_TIMER)	+=3D vf_pit_timer.o
>   obj-$(CONFIG_CLKSRC_QCOM)	+=3D qcom-timer.o
>   obj-$(CONFIG_MTK_TIMER)		+=3D mtk_timer.o
>   obj-$(CONFIG_CLKSRC_PISTACHIO)	+=3D time-pistachio.o
> +obj-$(CONFIG_CLKSRC_TI_32K)	+=3D timer-ti-32k.o
>
>   obj-$(CONFIG_ARM_ARCH_TIMER)		+=3D arm_arch_timer.o
>   obj-$(CONFIG_ARM_GLOBAL_TIMER)		+=3D arm_global_timer.o
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource=
/timer-ti-32k.c
> new file mode 100644
> index 000000000000..10ccce2eb645
> --- /dev/null
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -0,0 +1,121 @@
> +/**
> + * timer-ti-32k.c - OMAP2 32k Timer Support
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti=
=2Ecom
> + *
> + * This program is free software: you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2  o=
f
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/license=
s/>.
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

Can you check all these headers are needed ? I don't think interrupt.h,=
=20
or slab.h or irq.h, etc ... are needed.

A few nits below:

> +/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */

I am not sure this comment gives some interesting indication.

> +#define OMAP2_32KSYNCNT_REV_OFF		0x0
> +#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
> +#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
> +#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
> +
> +/*
> + * 32KHz clocksource ... always available, on pretty most chips exce=
pt
> + * OMAP 730 and 1510.  Other timers could be used as clocksources, w=
ith
> + * higher resolution in free-running counter modes (e.g. 12 MHz xtal=
),
> + * but systems won't necessarily want to spend resources that way.
> + */
> +static void __iomem *sync32k_cnt_reg;
> +
> +/**
> + * omap_read_persistent_clock64 -  Return time from a persistent clo=
ck.
> + *
> + * Reads the time from a source which isn't disabled during PM, the
> + * 32k sync timer.  Convert the cycles elapsed since last read into
> + * nsecs and adds to a monotonically increasing timespec64.
> + */

This comment above should be moved right before the function it=20
describes and in order to comply with the kernel-doc format the=20
parameters must be documented also:
=2E..
* @ts:	....
=2E..


> +static struct timespec64 persistent_ts;
> +static cycles_t cycles;
> +static unsigned int persistent_mult, persistent_shift;
> +
> +static u64 notrace omap_32k_read_sched_clock(void)
> +{
> +	return readl_relaxed(sync32k_cnt_reg);
> +}
> +
> +static void omap_read_persistent_clock64(struct timespec64 *ts)
> +{
> +	unsigned long long nsecs;
> +	cycles_t last_cycles;
> +
> +	last_cycles =3D cycles;
> +	cycles =3D sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;

This test is pointless because 'sync32k_cnt_reg' is always different=20
from zero regarding the init routine, no ?

> +
> +	nsecs =3D clocksource_cyc2ns(cycles - last_cycles,
> +					persistent_mult, persistent_shift);
> +
> +	timespec64_add_ns(&persistent_ts, nsecs);
> +
> +	*ts =3D persistent_ts;
> +}
> +
> +static void __init ti_32k_timer_init(struct device_node *np)
> +{
> +	void __iomem *vbase;
> +	int ret;
> +
> +	vbase =3D of_iomap(np, 0);
> +	if (!vbase) {
> +		pr_err("Can't ioremap 32k timer base\n");
> +		return;
> +	}
> +
> +	/*
> +	 * 32k sync Counter IP register offsets vary between the
> +	 * highlander version and the legacy ones.
> +	 * The 'SCHEME' bits(30-31) of the revision register is used
> +	 * to identify the version.
> +	 */

Please fix comment length.

> +	if (readl_relaxed(vbase + OMAP2_32KSYNCNT_REV_OFF) &
> +						OMAP2_32KSYNCNT_REV_SCHEME)
> +		sync32k_cnt_reg =3D vbase + OMAP2_32KSYNCNT_CR_OFF_HIGH;
> +	else
> +		sync32k_cnt_reg =3D vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
> +
> +	/*
> +	 * 120000 rough estimate from the calculations in
> +	 * __clocksource_update_freq_scale.
> +	 */

=46ix comment length also.

> +	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> +			32768, NSEC_PER_SEC, 120000);
> +
> +	ret =3D clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768=
,
> +				250, 32, clocksource_mmio_readl_up);
> +	if (ret) {
> +		pr_err("32k_counter: can't register clocksource\n");
> +		return;
> +	}
> +
> +	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
> +	register_persistent_clock(NULL, omap_read_persistent_clock64);

I will let John Stultz to have a look at this part because I have doubt=
=20
regarding the usage of the persistent clock.


   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

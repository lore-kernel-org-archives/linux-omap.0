From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 05/12] OMAP: dmtimer: switch-over to platform device driver
Date: Thu, 22 Sep 2011 11:27:47 +0530
Message-ID: <CAC83ZvLZHnSxhVf73-KKdnW8spae43Pcwxpioeoo4oh3x6_0tQ@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-6-git-send-email-tarun.kanti@ti.com>
	<20110922010055.GT2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37361 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964Ab1IVF56 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 01:57:58 -0400
Received: by bkbzv15 with SMTP id zv15so2840852bkb.32
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 22:57:48 -0700 (PDT)
In-Reply-To: <20110922010055.GT2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

[...]
>>
>> =A0 =A0 =A0 /* Ack possibly pending interrupt */
>
> I've left out this is_omap2 change as it really does not improve anyt=
hing.
> Instead it just makes __omap_dm_timer_stop inline function more compl=
ex.
Agreed.

>
> I've also folded in the spinlock fixes in patch 10 into this patch.
Ok, thanks.
--
Tarun
>
> Updated patch below.
>
> Tony
>
>
> From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Date: Tue, 20 Sep 2011 17:00:20 +0530
> Subject: [PATCH] ARM: OMAP: dmtimer: switch-over to platform device d=
river
>
> Register timer devices by going through hwmod database using
> hwmod API. The driver probes each of the registered devices.
> Functionality which are already performed by hwmod framework
> are removed from timer code. New set of timers present on
> OMAP4 are now supported.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>
> [tony@atomide.com: folded in spinlock changes, left out is_omap2]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.=
c
> index b2829ee..9c2f588 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -478,3 +478,23 @@ static int __init omap_timer_init(struct omap_hw=
mod *oh, void *unused)
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
> +
> +/**
> + * omap2_dm_timer_init - top level regular device initialization
> + *
> + * Uses dedicated hwmod api to parse through hwmod database for
> + * given class name and then build and register the timer device.
> + */
> +static int __init omap2_dm_timer_init(void)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D omap_hwmod_for_each_by_class("timer", omap_time=
r_init, NULL);
> + =A0 =A0 =A0 if (unlikely(ret)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: device registration failed.=
\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +arch_initcall(omap2_dm_timer_init);
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtime=
r.c
> index 92d5aff..6019208 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -36,120 +36,22 @@
> =A0*/
>
> =A0#include <linux/io.h>
> -#include <linux/module.h>
> =A0#include <linux/slab.h>
> -#include <mach/hardware.h>
> -#include <plat/dmtimer.h>
> -#include <mach/irqs.h>
> -
> -static int dm_timer_count;
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct omap_dm_timer omap2_dm_timers[] =3D {
> - =A0 =A0 =A0 { .phys_base =3D 0x48028000, .irq =3D INT_24XX_GPTIMER1=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4802a000, .irq =3D INT_24XX_GPTIMER2=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48078000, .irq =3D INT_24XX_GPTIMER3=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4807a000, .irq =3D INT_24XX_GPTIMER4=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4807c000, .irq =3D INT_24XX_GPTIMER5=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4807e000, .irq =3D INT_24XX_GPTIMER6=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48080000, .irq =3D INT_24XX_GPTIMER7=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48082000, .irq =3D INT_24XX_GPTIMER8=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48084000, .irq =3D INT_24XX_GPTIMER9=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48086000, .irq =3D INT_24XX_GPTIMER1=
0 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48088000, .irq =3D INT_24XX_GPTIMER1=
1 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4808a000, .irq =3D INT_24XX_GPTIMER1=
2 },
> -};
> -
> -static const char *omap2_dm_source_names[] __initdata =3D {
> - =A0 =A0 =A0 "sys_ck",
> - =A0 =A0 =A0 "func_32k_ck",
> - =A0 =A0 =A0 "alt_ck",
> - =A0 =A0 =A0 NULL
> -};
> -
> -static struct clk *omap2_dm_source_clocks[3];
> -static const int omap2_dm_timer_count =3D ARRAY_SIZE(omap2_dm_timers=
);
> -
> -#else
> -#define omap2_dm_timers =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0NULL
> -#define omap2_dm_timer_count =A0 =A0 =A0 =A0 =A0 0
> -#define omap2_dm_source_names =A0 =A0 =A0 =A0 =A0NULL
> -#define omap2_dm_source_clocks =A0 =A0 =A0 =A0 NULL
> -#endif /* CONFIG_ARCH_OMAP2 */
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct omap_dm_timer omap3_dm_timers[] =3D {
> - =A0 =A0 =A0 { .phys_base =3D 0x48318000, .irq =3D INT_24XX_GPTIMER1=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x49032000, .irq =3D INT_24XX_GPTIMER2=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x49034000, .irq =3D INT_24XX_GPTIMER3=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x49036000, .irq =3D INT_24XX_GPTIMER4=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x49038000, .irq =3D INT_24XX_GPTIMER5=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4903A000, .irq =3D INT_24XX_GPTIMER6=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4903C000, .irq =3D INT_24XX_GPTIMER7=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4903E000, .irq =3D INT_24XX_GPTIMER8=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x49040000, .irq =3D INT_24XX_GPTIMER9=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48086000, .irq =3D INT_24XX_GPTIMER1=
0 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48088000, .irq =3D INT_24XX_GPTIMER1=
1 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48304000, .irq =3D INT_34XX_GPT12_IR=
Q },
> -};
> -
> -static const char *omap3_dm_source_names[] __initdata =3D {
> - =A0 =A0 =A0 "sys_ck",
> - =A0 =A0 =A0 "omap_32k_fck",
> - =A0 =A0 =A0 NULL
> -};
> -
> -static struct clk *omap3_dm_source_clocks[2];
> -static const int omap3_dm_timer_count =3D ARRAY_SIZE(omap3_dm_timers=
);
> -
> -#else
> -#define omap3_dm_timers =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0NULL
> -#define omap3_dm_timer_count =A0 =A0 =A0 =A0 =A0 0
> -#define omap3_dm_source_names =A0 =A0 =A0 =A0 =A0NULL
> -#define omap3_dm_source_clocks =A0 =A0 =A0 =A0 NULL
> -#endif /* CONFIG_ARCH_OMAP3 */
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -static struct omap_dm_timer omap4_dm_timers[] =3D {
> - =A0 =A0 =A0 { .phys_base =3D 0x4a318000, .irq =3D OMAP44XX_IRQ_GPT1=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48032000, .irq =3D OMAP44XX_IRQ_GPT2=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48034000, .irq =3D OMAP44XX_IRQ_GPT3=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48036000, .irq =3D OMAP44XX_IRQ_GPT4=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x40138000, .irq =3D OMAP44XX_IRQ_GPT5=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4013a000, .irq =3D OMAP44XX_IRQ_GPT6=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4013a000, .irq =3D OMAP44XX_IRQ_GPT7=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4013e000, .irq =3D OMAP44XX_IRQ_GPT8=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4803e000, .irq =3D OMAP44XX_IRQ_GPT9=
 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48086000, .irq =3D OMAP44XX_IRQ_GPT1=
0 },
> - =A0 =A0 =A0 { .phys_base =3D 0x48088000, .irq =3D OMAP44XX_IRQ_GPT1=
1 },
> - =A0 =A0 =A0 { .phys_base =3D 0x4a320000, .irq =3D OMAP44XX_IRQ_GPT1=
2 },
> -};
> -static const char *omap4_dm_source_names[] __initdata =3D {
> - =A0 =A0 =A0 "sys_clkin_ck",
> - =A0 =A0 =A0 "sys_32k_ck",
> - =A0 =A0 =A0 NULL
> -};
> -static struct clk *omap4_dm_source_clocks[2];
> -static const int omap4_dm_timer_count =3D ARRAY_SIZE(omap4_dm_timers=
);
> +#include <linux/err.h>
>
> -#else
> -#define omap4_dm_timers =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0NULL
> -#define omap4_dm_timer_count =A0 =A0 =A0 =A0 =A0 0
> -#define omap4_dm_source_names =A0 =A0 =A0 =A0 =A0NULL
> -#define omap4_dm_source_clocks =A0 =A0 =A0 =A0 NULL
> -#endif /* CONFIG_ARCH_OMAP4 */
> -
> -static struct omap_dm_timer *dm_timers;
> -static const char **dm_source_names;
> -static struct clk **dm_source_clocks;
> +#include <plat/dmtimer.h>
>
> -static spinlock_t dm_timer_lock;
> =A0static LIST_HEAD(omap_timer_list);
> +static DEFINE_SPINLOCK(dm_timer_lock);
>
> -/*
> - * Reads timer registers in posted and non-posted mode. The posted m=
ode bit
> - * is encoded in reg. Note that in posted mode write pending bit mus=
t be
> - * checked. Otherwise a read of a non completed write will produce a=
n error.
> +/**
> + * omap_dm_timer_read_reg - read timer registers in posted and non-p=
osted mode
> + * @timer: =A0 =A0 =A0timer pointer over which read operation to per=
form
> + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> + *
> + * The posted mode bit is encoded in reg. Note that in posted mode w=
rite
> + * pending bit must be checked. Otherwise a read of a non completed =
write
> + * will produce an error.
> =A0*/
> =A0static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *tim=
er, u32 reg)
> =A0{
> @@ -157,11 +59,15 @@ static inline u32 omap_dm_timer_read_reg(struct =
omap_dm_timer *timer, u32 reg)
> =A0 =A0 =A0 =A0return __omap_dm_timer_read(timer, reg, timer->posted)=
;
> =A0}
>
> -/*
> - * Writes timer registers in posted and non-posted mode. The posted =
mode bit
> - * is encoded in reg. Note that in posted mode the write pending bit=
 must be
> - * checked. Otherwise a write on a register which has a pending writ=
e will be
> - * lost.
> +/**
> + * omap_dm_timer_write_reg - write timer registers in posted and non=
-posted mode
> + * @timer: =A0 =A0 =A0timer pointer over which write operation is to=
 perform
> + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> + * @value: =A0 =A0 =A0data to write into the register
> + *
> + * The posted mode bit is encoded in reg. Note that in posted mode t=
he write
> + * pending bit must be checked. Otherwise a write on a register whic=
h has a
> + * pending write will be lost.
> =A0*/
> =A0static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u=
32 reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0u32 value)
> @@ -189,53 +95,65 @@ static void omap_dm_timer_wait_for_reset(struct =
omap_dm_timer *timer)
>
> =A0static void omap_dm_timer_reset(struct omap_dm_timer *timer)
> =A0{
> - =A0 =A0 =A0 int autoidle =3D 0, wakeup =3D 0;
> -
> - =A0 =A0 =A0 if (!cpu_class_is_omap2() || timer !=3D &dm_timers[0]) =
{
> + =A0 =A0 =A0 if (timer->pdev->id !=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TI=
MER_IF_CTRL_REG, 0x06);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_wait_for_reset(timer);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> -
> - =A0 =A0 =A0 /* Enable autoidle on OMAP2+ */
> - =A0 =A0 =A0 if (cpu_class_is_omap2())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 autoidle =3D 1;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Enable wake-up on OMAP2 CPUs.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (cpu_class_is_omap2())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wakeup =3D 1;
>
> - =A0 =A0 =A0 __omap_dm_timer_reset(timer, autoidle, wakeup);
> + =A0 =A0 =A0 __omap_dm_timer_reset(timer, 0, 0);
> =A0 =A0 =A0 =A0timer->posted =3D 1;
> =A0}
>
> -void omap_dm_timer_prepare(struct omap_dm_timer *timer)
> +int omap_dm_timer_prepare(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 timer->fclk =3D clk_get(&timer->pdev->dev, "fck");
> + =A0 =A0 =A0 if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->fclk =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&timer->pdev->dev, ": No fclk h=
andle.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0omap_dm_timer_enable(timer);
> - =A0 =A0 =A0 omap_dm_timer_reset(timer);
> +
> + =A0 =A0 =A0 if (pdata->needs_manual_reset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_reset(timer);
> +
> + =A0 =A0 =A0 ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_=
32_KHZ);
> +
> + =A0 =A0 =A0 timer->posted =3D 1;
> + =A0 =A0 =A0 return ret;
> =A0}
>
> =A0struct omap_dm_timer *omap_dm_timer_request(void)
> =A0{
> - =A0 =A0 =A0 struct omap_dm_timer *timer =3D NULL;
> + =A0 =A0 =A0 struct omap_dm_timer *timer =3D NULL, *t;
> =A0 =A0 =A0 =A0unsigned long flags;
> - =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret =3D 0;
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&dm_timer_lock, flags);
> - =A0 =A0 =A0 for (i =3D 0; i < dm_timer_count; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dm_timers[i].reserved)
> + =A0 =A0 =A0 list_for_each_entry(t, &omap_timer_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->reserved)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer =3D &dm_timers[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer =3D t;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->reserved =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if (timer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_dm_timer_prepare(timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->reserved =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> - =A0 =A0 =A0 if (timer !=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_prepare(timer);
> + =A0 =A0 =A0 if (!timer)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: timer request failed!\n",=
 __func__);
>
> =A0 =A0 =A0 =A0return timer;
> =A0}
> @@ -243,23 +161,30 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
>
> =A0struct omap_dm_timer *omap_dm_timer_request_specific(int id)
> =A0{
> - =A0 =A0 =A0 struct omap_dm_timer *timer;
> + =A0 =A0 =A0 struct omap_dm_timer *timer =3D NULL, *t;
> =A0 =A0 =A0 =A0unsigned long flags;
> + =A0 =A0 =A0 int ret =3D 0;
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&dm_timer_lock, flags);
> - =A0 =A0 =A0 if (id <=3D 0 || id > dm_timer_count || dm_timers[id-1]=
=2Ereserved) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dm_timer_lock, =
flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("BUG: warning at %s:%d/%s(): una=
ble to get timer %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__FILE__, __LINE__, __fu=
nc__, id);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dump_stack();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 list_for_each_entry(t, &omap_timer_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->pdev->id =3D=3D id && !t->reserv=
ed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer =3D t;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->reserved =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 timer =3D &dm_timers[id-1];
> - =A0 =A0 =A0 timer->reserved =3D 1;
> + =A0 =A0 =A0 if (timer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_dm_timer_prepare(timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->reserved =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> - =A0 =A0 =A0 omap_dm_timer_prepare(timer);
> + =A0 =A0 =A0 if (!timer)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: timer%d request failed!\n=
", __func__, id);
>
> =A0 =A0 =A0 =A0return timer;
> =A0}
> @@ -267,9 +192,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific)=
;
>
> =A0void omap_dm_timer_free(struct omap_dm_timer *timer)
> =A0{
> - =A0 =A0 =A0 omap_dm_timer_enable(timer);
> - =A0 =A0 =A0 omap_dm_timer_reset(timer);
> =A0 =A0 =A0 =A0omap_dm_timer_disable(timer);
> + =A0 =A0 =A0 clk_put(timer->fclk);
>
> =A0 =A0 =A0 =A0WARN_ON(!timer->reserved);
> =A0 =A0 =A0 =A0timer->reserved =3D 0;
> @@ -278,15 +202,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
>
> =A0void omap_dm_timer_enable(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> +
> =A0 =A0 =A0 =A0if (timer->enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> - =A0 =A0 =A0 if (cpu_class_is_omap2()) {
> + =A0 =A0 =A0 if (!pdata->needs_manual_reset) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(timer->fclk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(timer->iclk);
> =A0 =A0 =A0 =A0}
> -#endif
>
> =A0 =A0 =A0 =A0timer->enabled =3D 1;
> =A0}
> @@ -294,15 +218,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
>
> =A0void omap_dm_timer_disable(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> +
> =A0 =A0 =A0 =A0if (!timer->enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> - =A0 =A0 =A0 if (cpu_class_is_omap2()) {
> + =A0 =A0 =A0 if (!pdata->needs_manual_reset) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable(timer->iclk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable(timer->fclk);
> =A0 =A0 =A0 =A0}
> -#endif
>
> =A0 =A0 =A0 =A0timer->enabled =3D 0;
> =A0}
> @@ -322,24 +246,29 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
> =A0*/
> =A0__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
> =A0{
> - =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int i =3D 0;
> + =A0 =A0 =A0 struct omap_dm_timer *timer =3D NULL;
> + =A0 =A0 =A0 unsigned long flags;
>
> =A0 =A0 =A0 =A0/* If ARMXOR cannot be idled this function call is unn=
ecessary */
> =A0 =A0 =A0 =A0if (!(inputmask & (1 << 1)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return inputmask;
>
> =A0 =A0 =A0 =A0/* If any active timer is using ARMXOR return modified=
 mask */
> - =A0 =A0 =A0 for (i =3D 0; i < dm_timer_count; i++) {
> + =A0 =A0 =A0 spin_lock_irqsave(&dm_timer_lock, flags);
> + =A0 =A0 =A0 list_for_each_entry(timer, &omap_timer_list, node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 l;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D omap_dm_timer_read_reg(&dm_timers=
[i], OMAP_TIMER_CTRL_REG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D omap_dm_timer_read_reg(timer, OMA=
P_TIMER_CTRL_REG);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (l & OMAP_TIMER_CTRL_ST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (((omap_readl(MOD_C=
ONF_CTRL_1) >> (i * 2)) & 0x03) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0inputm=
ask &=3D ~(1 << 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0inputm=
ask &=3D ~(1 << 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> =A0 =A0 =A0 =A0return inputmask;
> =A0}
> @@ -384,10 +313,10 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
> =A0void omap_dm_timer_stop(struct omap_dm_timer *timer)
> =A0{
> =A0 =A0 =A0 =A0unsigned long rate =3D 0;
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
>
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> - =A0 =A0 =A0 rate =3D clk_get_rate(timer->fclk);
> -#endif
> + =A0 =A0 =A0 if (!pdata->needs_manual_reset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D clk_get_rate(timer->fclk);
>
> =A0 =A0 =A0 =A0__omap_dm_timer_stop(timer, timer->posted, rate);
> =A0}
> @@ -395,15 +324,17 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>
> =A0int omap_dm_timer_set_source(struct omap_dm_timer *timer, int sour=
ce)
> =A0{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> +
> =A0 =A0 =A0 =A0if (source < 0 || source >=3D 3)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> - =A0 =A0 =A0 return __omap_dm_timer_set_source(timer->fclk,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_clocks[source]);
> -#else
> - =A0 =A0 =A0 return 0;
> -#endif
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> + =A0 =A0 =A0 ret =3D pdata->set_timer_src(timer->pdev, source);
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> +
> + =A0 =A0 =A0 return ret;
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
>
> @@ -526,13 +457,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
>
> =A0int omap_dm_timers_active(void)
> =A0{
> - =A0 =A0 =A0 int i;
> -
> - =A0 =A0 =A0 for (i =3D 0; i < dm_timer_count; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_dm_timer *timer;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer =3D &dm_timers[i];
> + =A0 =A0 =A0 struct omap_dm_timer *timer;
>
> + =A0 =A0 =A0 list_for_each_entry(timer, &omap_timer_list, node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!timer->enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> @@ -602,7 +529,6 @@ static int __devinit omap_dm_timer_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0timer->id =3D pdev->id;
> =A0 =A0 =A0 =A0timer->irq =3D irq->start;
> =A0 =A0 =A0 =A0timer->pdev =3D pdev;
> - =A0 =A0 =A0 __omap_dm_timer_init_regs(timer);
>
> =A0 =A0 =A0 =A0/* add the timer element to the list */
> =A0 =A0 =A0 =A0spin_lock_irqsave(&dm_timer_lock, flags);
> @@ -675,73 +601,3 @@ MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver"=
);
> =A0MODULE_LICENSE("GPL");
> =A0MODULE_ALIAS("platform:" DRIVER_NAME);
> =A0MODULE_AUTHOR("Texas Instruments Inc");
> -
> -static int __init omap_dm_timer_init(void)
> -{
> - =A0 =A0 =A0 struct omap_dm_timer *timer;
> - =A0 =A0 =A0 int i, map_size =3D SZ_8K; =A0 =A0 =A0 =A0/* Module 4KB=
 + L4 4KB except on omap1 */
> -
> - =A0 =A0 =A0 if (!cpu_class_is_omap2())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> - =A0 =A0 =A0 spin_lock_init(&dm_timer_lock);
> -
> - =A0 =A0 =A0 if (cpu_is_omap24xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_timers =3D omap2_dm_timers;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_timer_count =3D omap2_dm_timer_count=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_names =3D omap2_dm_source_nam=
es;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_clocks =3D omap2_dm_source_cl=
ocks;
> - =A0 =A0 =A0 } else if (cpu_is_omap34xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_timers =3D omap3_dm_timers;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_timer_count =3D omap3_dm_timer_count=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_names =3D omap3_dm_source_nam=
es;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_clocks =3D omap3_dm_source_cl=
ocks;
> - =A0 =A0 =A0 } else if (cpu_is_omap44xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_timers =3D omap4_dm_timers;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_timer_count =3D omap4_dm_timer_count=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_names =3D omap4_dm_source_nam=
es;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_clocks =3D omap4_dm_source_cl=
ocks;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("dmtimers disabled for omap4 unt=
il hwmod conversion\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (cpu_class_is_omap2())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; dm_source_names[i] !=3D N=
ULL; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_source_clocks[i] =3D=
 clk_get(NULL, dm_source_names[i]);
> -
> - =A0 =A0 =A0 if (cpu_is_omap243x())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dm_timers[0].phys_base =3D 0x49018000;
> -
> - =A0 =A0 =A0 for (i =3D 0; i < dm_timer_count; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer =3D &dm_timers[i];
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Static mapping, never released */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->io_base =3D ioremap(timer->phys_=
base, map_size);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(!timer->io_base);
> -
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_class_is_omap2()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char clk_name[16];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(clk_name, "gpt%=
d_ick", i + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->iclk =3D clk_get=
(NULL, clk_name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(clk_name, "gpt%=
d_fck", i + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->fclk =3D clk_get=
(NULL, clk_name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* One or two timers may be set up earl=
y for sys_timer */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sys_timer_reserved & (1 =A0<< i)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->reserved =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->posted =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_enable(timer);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_init_regs(timer);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_disable(timer);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -arch_initcall(omap_dm_timer_init);
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/pla=
t-omap/include/plat/dmtimer.h
> index 98f186e..2ac7538 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -231,9 +231,8 @@ struct omap_dm_timer {
> =A0 =A0 =A0 =A0unsigned long phys_base;
> =A0 =A0 =A0 =A0int id;
> =A0 =A0 =A0 =A0int irq;
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> =A0 =A0 =A0 =A0struct clk *iclk, *fclk;
> -#endif
> +
> =A0 =A0 =A0 =A0void __iomem =A0 =A0*io_base;
> =A0 =A0 =A0 =A0void __iomem =A0 =A0*sys_stat; =A0 =A0 =A0/* TISTAT ti=
mer status */
> =A0 =A0 =A0 =A0void __iomem =A0 =A0*irq_stat; =A0 =A0 =A0/* TISR/IRQS=
TATUS interrupt status */
> @@ -251,7 +250,7 @@ struct omap_dm_timer {
> =A0};
>
> =A0extern u32 sys_timer_reserved;
> -void omap_dm_timer_prepare(struct omap_dm_timer *timer);
> +int omap_dm_timer_prepare(struct omap_dm_timer *timer);
>
> =A0static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer=
, u32 reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0int posted)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

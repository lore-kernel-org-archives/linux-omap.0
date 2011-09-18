From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip (Re: [PATCH v15
 06/12] OMAP: dmtimer: switch-over to platform device driver)
Date: Sun, 18 Sep 2011 17:57:03 +0530
Message-ID: <CAC83Zv+X+huFrG+_LNadNwi9zRAWHGRvrQnvpAoZJK=30TK0fg@mail.gmail.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
	<CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
	<20110915165810.GA2284@atomide.com>
	<20110915170548.GB2284@atomide.com>
	<CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
	<CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
	<20110917013531.GB2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:56798 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751952Ab1IRM1H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Sep 2011 08:27:07 -0400
Received: by bkbzt12 with SMTP id zt12so6365282bkb.40
        for <linux-omap@vger.kernel.org>; Sun, 18 Sep 2011 05:27:04 -0700 (PDT)
In-Reply-To: <20110917013531.GB2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

[...]
> Well here's what I came up with to deal with the different timer
> registers. We can't use the context registers as those are for
> the value naturally..
>
> But we can map the interrupt registers separately and then have
> the rest start from func_base that is different based on the timer
> version. Rebasing the rest of the dmtimer hwmod patches on this
> should be fairly easy, mostly just need to pass timer instead of
> timer->io_base and use __raw_read/write for the interrupt registers.
I went through the patch. It definitely looks much more simplified now.
I will rebase on top of this change.

>
> Also, I ended up checking the timer revision with if (!(tidr >> 16))
> as it seems that those bits are zero for v1 timers? If that works,
> then we don't need patch 02/12 for the revision number.
Right.
--
Tarun
>
> Afzal, care to check if that works for AM335X/TI816X/TI814X?
> It tried it briefly with omap4 gptimer3 as the clockevent and
> CONFIG_LOCAL_TIMER disabled.
>
> The patch is against the current cleanup branch in linux-omap
> tree.
>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 16 Sep 2011 15:44:20 -0700
> Subject: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip
>
> The registers are slightly different between v1 and v2 ip that
> is available in omap4 and later for some timers.
>
> Add support for v2 ip by mapping the interrupt related registers
> separately and adding func_base for the functional registers.
>
> Also disable dmtimer driver features on omap4 for now as
> those need the hwmod conversion series to deal with enabling
> the timers properly in omap_dm_timer_init.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.=
c
> index cf1de7d..21d34fb 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -78,7 +78,7 @@ static irqreturn_t omap2_gp_timer_interrupt(int irq=
, void *dev_id)
> =A0{
> =A0 =A0 =A0 =A0struct clock_event_device *evt =3D &clockevent_gpt;
>
> - =A0 =A0 =A0 __omap_dm_timer_write_status(clkev.io_base, OMAP_TIMER_=
INT_OVERFLOW);
> + =A0 =A0 =A0 __omap_dm_timer_write_status(&clkev, OMAP_TIMER_INT_OVE=
RFLOW);
>
> =A0 =A0 =A0 =A0evt->event_handler(evt);
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> @@ -93,7 +93,7 @@ static struct irqaction omap2_gp_timer_irq =3D {
> =A0static int omap2_gp_timer_set_next_event(unsigned long cycles,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct clock_event_device *evt)
> =A0{
> - =A0 =A0 =A0 __omap_dm_timer_load_start(clkev.io_base, OMAP_TIMER_CT=
RL_ST,
> + =A0 =A0 =A0 __omap_dm_timer_load_start(&clkev, OMAP_TIMER_CTRL_ST,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A00xffffffff - cycles, 1);
>
> =A0 =A0 =A0 =A0return 0;
> @@ -104,16 +104,16 @@ static void omap2_gp_timer_set_mode(enum clock_=
event_mode mode,
> =A0{
> =A0 =A0 =A0 =A0u32 period;
>
> - =A0 =A0 =A0 __omap_dm_timer_stop(clkev.io_base, 1, clkev.rate);
> + =A0 =A0 =A0 __omap_dm_timer_stop(&clkev, 1, clkev.rate);
>
> =A0 =A0 =A0 =A0switch (mode) {
> =A0 =A0 =A0 =A0case CLOCK_EVT_MODE_PERIODIC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0period =3D clkev.rate / HZ;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0period -=3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Looks like we need to first set the=
 load value separately */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_write(clkev.io_base, OM=
AP_TIMER_LOAD_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_write(&clkev, OMAP_TIME=
R_LOAD_REG,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00xffffffff - period, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_load_start(clkev.io_bas=
e,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_load_start(&clkev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A00xffffffff - period, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -172,6 +172,7 @@ static int __init omap_dm_timer_init_one(struct o=
map_dm_timer *timer,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0omap_hwmod_enable(oh);
> + =A0 =A0 =A0 __omap_dm_timer_init_regs(timer);
>
> =A0 =A0 =A0 =A0sys_timer_reserved |=3D (1 << (gptimer_id - 1));
>
> @@ -189,7 +190,7 @@ static int __init omap_dm_timer_init_one(struct o=
map_dm_timer *timer,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(src);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 __omap_dm_timer_reset(timer->io_base, 1, 1);
> + =A0 =A0 =A0 __omap_dm_timer_reset(timer, 1, 1);
> =A0 =A0 =A0 =A0timer->posted =3D 1;
>
> =A0 =A0 =A0 =A0timer->rate =3D clk_get_rate(timer->fclk);
> @@ -210,7 +211,7 @@ static void __init omap2_gp_clockevent_init(int g=
ptimer_id,
> =A0 =A0 =A0 =A0omap2_gp_timer_irq.dev_id =3D (void *)&clkev;
> =A0 =A0 =A0 =A0setup_irq(clkev.irq, &omap2_gp_timer_irq);
>
> - =A0 =A0 =A0 __omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_IN=
T_OVERFLOW);
> + =A0 =A0 =A0 __omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERF=
LOW);
>
> =A0 =A0 =A0 =A0clockevent_gpt.mult =3D div_sc(clkev.rate, NSEC_PER_SE=
C,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 clockevent_gpt.shift);
> @@ -251,7 +252,7 @@ static struct omap_dm_timer clksrc;
> =A0static DEFINE_CLOCK_DATA(cd);
> =A0static cycle_t clocksource_read_cycles(struct clocksource *cs)
> =A0{
> - =A0 =A0 =A0 return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_=
base, 1);
> + =A0 =A0 =A0 return (cycle_t)__omap_dm_timer_read_counter(&clksrc, 1=
);
> =A0}
>
> =A0static struct clocksource clocksource_gpt =3D {
> @@ -266,7 +267,7 @@ static void notrace dmtimer_update_sched_clock(vo=
id)
> =A0{
> =A0 =A0 =A0 =A0u32 cyc;
>
> - =A0 =A0 =A0 cyc =3D __omap_dm_timer_read_counter(clksrc.io_base, 1)=
;
> + =A0 =A0 =A0 cyc =3D __omap_dm_timer_read_counter(&clksrc, 1);
>
> =A0 =A0 =A0 =A0update_sched_clock(&cd, cyc, (u32)~0);
> =A0}
> @@ -276,7 +277,7 @@ unsigned long long notrace sched_clock(void)
> =A0 =A0 =A0 =A0u32 cyc =3D 0;
>
> =A0 =A0 =A0 =A0if (clksrc.reserved)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cyc =3D __omap_dm_timer_read_counter(cl=
ksrc.io_base, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cyc =3D __omap_dm_timer_read_counter(&c=
lksrc, 1);
>
> =A0 =A0 =A0 =A0return cyc_to_sched_clock(&cd, cyc, (u32)~0);
> =A0}
> @@ -293,7 +294,7 @@ static void __init omap2_gp_clocksource_init(int =
gptimer_id,
> =A0 =A0 =A0 =A0pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gptimer_id, clksrc.rate);
>
> - =A0 =A0 =A0 __omap_dm_timer_load_start(clksrc.io_base,
> + =A0 =A0 =A0 __omap_dm_timer_load_start(&clksrc,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_TIMER_CTRL_ST | O=
MAP_TIMER_CTRL_AR, 0, 1);
> =A0 =A0 =A0 =A0init_sched_clock(&cd, dmtimer_update_sched_clock, 32, =
clksrc.rate);
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtime=
r.c
> index 75a847d..e23b7cf 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -170,7 +170,8 @@ static spinlock_t dm_timer_lock;
> =A0*/
> =A0static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *tim=
er, u32 reg)
> =A0{
> - =A0 =A0 =A0 return __omap_dm_timer_read(timer->io_base, reg, timer-=
>posted);
> + =A0 =A0 =A0 WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
> + =A0 =A0 =A0 return __omap_dm_timer_read(timer, reg, timer->posted);
> =A0}
>
> =A0/*
> @@ -182,15 +183,19 @@ static inline u32 omap_dm_timer_read_reg(struct=
 omap_dm_timer *timer, u32 reg)
> =A0static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u=
32 reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0u32 value)
> =A0{
> - =A0 =A0 =A0 __omap_dm_timer_write(timer->io_base, reg, value, timer=
->posted);
> + =A0 =A0 =A0 WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
> + =A0 =A0 =A0 __omap_dm_timer_write(timer, reg, value, timer->posted)=
;
> =A0}
>
> =A0static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *tim=
er)
> =A0{
> =A0 =A0 =A0 =A0int c;
>
> + =A0 =A0 =A0 if (!timer->sys_stat)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0c =3D 0;
> - =A0 =A0 =A0 while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_S=
TAT_REG) & 1)) {
> + =A0 =A0 =A0 while (!(__raw_readl(timer->sys_stat) & 1)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (c > 100000) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Timer=
 failed to reset\n");
> @@ -219,7 +224,7 @@ static void omap_dm_timer_reset(struct omap_dm_ti=
mer *timer)
> =A0 =A0 =A0 =A0if (cpu_class_is_omap2())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wakeup =3D 1;
>
> - =A0 =A0 =A0 __omap_dm_timer_reset(timer->io_base, autoidle, wakeup)=
;
> + =A0 =A0 =A0 __omap_dm_timer_reset(timer, autoidle, wakeup);
> =A0 =A0 =A0 =A0timer->posted =3D 1;
> =A0}
>
> @@ -401,7 +406,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *tim=
er)
> =A0 =A0 =A0 =A0rate =3D clk_get_rate(timer->fclk);
> =A0#endif
>
> - =A0 =A0 =A0 __omap_dm_timer_stop(timer->io_base, timer->posted, rat=
e);
> + =A0 =A0 =A0 __omap_dm_timer_stop(timer, timer->posted, rate);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>
> @@ -466,7 +471,7 @@ void omap_dm_timer_set_load_start(struct omap_dm_=
timer *timer, int autoreload,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0l |=3D OMAP_TIMER_CTRL_ST;
>
> - =A0 =A0 =A0 __omap_dm_timer_load_start(timer->io_base, l, load, tim=
er->posted);
> + =A0 =A0 =A0 __omap_dm_timer_load_start(timer, l, load, timer->poste=
d);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
>
> @@ -519,7 +524,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
> =A0void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0un=
signed int value)
> =A0{
> - =A0 =A0 =A0 __omap_dm_timer_int_enable(timer->io_base, value);
> + =A0 =A0 =A0 __omap_dm_timer_int_enable(timer, value);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
>
> @@ -527,7 +532,7 @@ unsigned int omap_dm_timer_read_status(struct oma=
p_dm_timer *timer)
> =A0{
> =A0 =A0 =A0 =A0unsigned int l;
>
> - =A0 =A0 =A0 l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG=
);
> + =A0 =A0 =A0 l =3D __raw_readl(timer->irq_stat);
>
> =A0 =A0 =A0 =A0return l;
> =A0}
> @@ -535,13 +540,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
>
> =A0void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsig=
ned int value)
> =A0{
> - =A0 =A0 =A0 __omap_dm_timer_write_status(timer->io_base, value);
> + =A0 =A0 =A0 __omap_dm_timer_write_status(timer, value);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
>
> =A0unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *time=
r)
> =A0{
> - =A0 =A0 =A0 return __omap_dm_timer_read_counter(timer->io_base, tim=
er->posted);
> + =A0 =A0 =A0 return __omap_dm_timer_read_counter(timer, timer->poste=
d);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
>
> @@ -601,6 +606,9 @@ static int __init omap_dm_timer_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dm_timer_count =3D omap4_dm_timer_coun=
t;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dm_source_names =3D omap4_dm_source_na=
mes;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dm_source_clocks =3D omap4_dm_source_c=
locks;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("dmtimers disabled for omap4 unt=
il hwmod conversion\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (cpu_class_is_omap2())
> @@ -630,8 +638,12 @@ static int __init omap_dm_timer_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sys_timer_reserved & (1 =A0<< i)) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->reserved =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->posted =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_enable(timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_init_regs(timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/pla=
t-omap/include/plat/dmtimer.h
> index eb5d16c..a11d0c0 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -98,12 +98,30 @@ int omap_dm_timers_active(void);
> =A0* used by dmtimer.c and sys_timer related code.
> =A0*/
>
> -/* register offsets */
> -#define _OMAP_TIMER_ID_OFFSET =A0 =A0 =A0 =A0 =A00x00
> -#define _OMAP_TIMER_OCP_CFG_OFFSET =A0 =A0 0x10
> -#define _OMAP_TIMER_SYS_STAT_OFFSET =A0 =A00x14
> -#define _OMAP_TIMER_STAT_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x18
> -#define _OMAP_TIMER_INT_EN_OFFSET =A0 =A0 =A00x1c
> +/*
> + * The interrupt registers are different between v1 and v2 ip.
> + * These registers are offsets from timer->iobase.
> + */
> +#define OMAP_TIMER_ID_OFFSET =A0 =A0 =A0 =A0 =A0 0x00
> +#define OMAP_TIMER_OCP_CFG_OFFSET =A0 =A0 =A00x10
> +
> +#define OMAP_TIMER_V1_SYS_STAT_OFFSET =A00x14
> +#define OMAP_TIMER_V1_STAT_OFFSET =A0 =A0 =A00x18
> +#define OMAP_TIMER_V1_INT_EN_OFFSET =A0 =A00x1c
> +
> +#define OMAP_TIMER_V2_IRQSTATUS_RAW =A0 =A00x24
> +#define OMAP_TIMER_V2_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x28
> +#define OMAP_TIMER_V2_IRQENABLE_SET =A0 =A00x2c
> +#define OMAP_TIMER_V2_IRQENABLE_CLR =A0 =A00x30
> +
> +/*
> + * The functional registers have a different base on v1 and v2 ip.
> + * These registers are offsets from timer->func_base. The func_base
> + * is samae as io_base for v1 and io_base + 0x14 for v2 ip.
> + *
> + */
> +#define OMAP_TIMER_V2_FUNC_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A00x14
> +
> =A0#define _OMAP_TIMER_WAKEUP_EN_OFFSET =A0 0x20
> =A0#define _OMAP_TIMER_CTRL_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2=
4
> =A0#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_TIMER_CTRL_GPOCFG =A0 =
=A0 =A0 =A0 =A0(1 << 14)
> @@ -147,21 +165,6 @@ int omap_dm_timers_active(void);
> =A0/* register offsets with the write pending bit encoded */
> =A0#define =A0 =A0 =A0 =A0WPSHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>
> -#define OMAP_TIMER_ID_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(_OMAP_TIMER_ID_OFFSET \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (WP_NONE << WPSHIFT))
> -
> -#define OMAP_TIMER_OCP_CFG_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (_OMA=
P_TIMER_OCP_CFG_OFFSET \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (WP_NONE << WPSHIFT))
> -
> -#define OMAP_TIMER_SYS_STAT_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(_OMAP_TIMER_SYS_STAT_OFFSET \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (WP_NONE << WPSHIFT))
> -
> -#define OMAP_TIMER_STAT_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
_OMAP_TIMER_STAT_OFFSET \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (WP_NONE << WPSHIFT))
> -
> -#define OMAP_TIMER_INT_EN_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(_O=
MAP_TIMER_INT_EN_OFFSET \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (WP_NONE << WPSHIFT))
> -
> =A0#define OMAP_TIMER_WAKEUP_EN_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 (_OMA=
P_TIMER_WAKEUP_EN_OFFSET \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| (WP_NONE << WPSHIFT))
>
> @@ -213,7 +216,14 @@ struct omap_dm_timer {
> =A0#ifdef CONFIG_ARCH_OMAP2PLUS
> =A0 =A0 =A0 =A0struct clk *iclk, *fclk;
> =A0#endif
> - =A0 =A0 =A0 void __iomem *io_base;
> + =A0 =A0 =A0 void __iomem =A0 =A0*io_base;
> + =A0 =A0 =A0 void __iomem =A0 =A0*sys_stat; =A0 =A0 =A0/* TISTAT tim=
er status */
> + =A0 =A0 =A0 void __iomem =A0 =A0*irq_stat; =A0 =A0 =A0/* TISR/IRQST=
ATUS interrupt status */
> + =A0 =A0 =A0 void __iomem =A0 =A0*irq_ena; =A0 =A0 =A0 /* irq enable=
 */
> + =A0 =A0 =A0 void __iomem =A0 =A0*irq_dis; =A0 =A0 =A0 /* irq disabl=
e, only on v2 ip */
> + =A0 =A0 =A0 void __iomem =A0 =A0*pend; =A0 =A0 =A0 =A0 =A0/* write =
pending */
> + =A0 =A0 =A0 void __iomem =A0 =A0*func_base; =A0 =A0 /* function reg=
ister base */
> +
> =A0 =A0 =A0 =A0unsigned long rate;
> =A0 =A0 =A0 =A0unsigned reserved:1;
> =A0 =A0 =A0 =A0unsigned enabled:1;
> @@ -223,35 +233,57 @@ struct omap_dm_timer {
> =A0extern u32 sys_timer_reserved;
> =A0void omap_dm_timer_prepare(struct omap_dm_timer *timer);
>
> -static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
> +static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, =
u32 reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0int posted)
> =A0{
> =A0 =A0 =A0 =A0if (posted)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__raw_readl(base + (OMAP_TIMER_W=
RITE_PEND_REG & 0xff))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (reg =
>> WPSHIFT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__raw_readl(timer->pend) & (reg =
>> WPSHIFT))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
>
> - =A0 =A0 =A0 return __raw_readl(base + (reg & 0xff));
> + =A0 =A0 =A0 return __raw_readl(timer->func_base + (reg & 0xff));
> =A0}
>
> -static inline void __omap_dm_timer_write(void __iomem *base, u32 reg=
, u32 val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int posted)
> +static inline void __omap_dm_timer_write(struct omap_dm_timer *timer=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u32 reg, u32 val, int posted)
> =A0{
> =A0 =A0 =A0 =A0if (posted)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__raw_readl(base + (OMAP_TIMER_W=
RITE_PEND_REG & 0xff))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (reg =
>> WPSHIFT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__raw_readl(timer->pend) & (reg =
>> WPSHIFT))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
>
> - =A0 =A0 =A0 __raw_writel(val, base + (reg & 0xff));
> + =A0 =A0 =A0 __raw_writel(val, timer->func_base + (reg & 0xff));
> +}
> +
> +static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *t=
imer)
> +{
> + =A0 =A0 =A0 u32 tidr;
> +
> + =A0 =A0 =A0 /* Assume v1 ip if bits [31:16] are zero */
> + =A0 =A0 =A0 tidr =3D __raw_readl(timer->io_base);
> + =A0 =A0 =A0 if (!(tidr >> 16)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->sys_stat =3D timer->io_base + OM=
AP_TIMER_V1_SYS_STAT_OFFSET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->irq_stat =3D timer->io_base + OM=
AP_TIMER_V1_STAT_OFFSET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->irq_ena =3D timer->io_base + OMA=
P_TIMER_V1_INT_EN_OFFSET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->irq_dis =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->pend =3D timer->io_base + _OMAP_=
TIMER_WRITE_PEND_OFFSET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->func_base =3D timer->io_base;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->sys_stat =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->irq_stat =3D timer->io_base + OM=
AP_TIMER_V2_IRQSTATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->irq_ena =3D timer->io_base + OMA=
P_TIMER_V2_IRQENABLE_SET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->irq_dis =3D timer->io_base + OMA=
P_TIMER_V2_IRQENABLE_CLR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->pend =3D timer->io_base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _OMAP_TIMER_WRITE_PEND_=
OFFSET + OMAP_TIMER_V2_FUNC_OFFSET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->func_base =3D timer->io_base + O=
MAP_TIMER_V2_FUNC_OFFSET;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0/* Assumes the source clock has been set by caller */
> -static inline void __omap_dm_timer_reset(void __iomem *base, int aut=
oidle,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int wakeup)
> +static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int autoidle, int wakeup)
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> - =A0 =A0 =A0 l =3D __omap_dm_timer_read(base, OMAP_TIMER_OCP_CFG_REG=
, 0);
> + =A0 =A0 =A0 l =3D __raw_readl(timer->io_base + OMAP_TIMER_OCP_CFG_O=
=46FSET);
> =A0 =A0 =A0 =A0l |=3D 0x02 << 3; =A0/* Set to smart-idle mode */
> =A0 =A0 =A0 =A0l |=3D 0x2 << 8; =A0 /* Set clock activity to perserve=
 f-clock on idle */
>
> @@ -261,10 +293,10 @@ static inline void __omap_dm_timer_reset(void _=
_iomem *base, int autoidle,
> =A0 =A0 =A0 =A0if (wakeup)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D 1 << 2;
>
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_OCP_CFG_REG, l, =
0);
> + =A0 =A0 =A0 __raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFF=
SET);
>
> =A0 =A0 =A0 =A0/* Match hardware reset default of posted mode */
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG,
> + =A0 =A0 =A0 __omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0OMAP_TIMER_CTRL_POSTED, 0);
> =A0}
>
> @@ -286,18 +318,18 @@ static inline int __omap_dm_timer_set_source(st=
ruct clk *timer_fck,
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static inline void __omap_dm_timer_stop(void __iomem *base, int post=
ed,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long rate)
> +static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int posted, unsigned long rate)
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> - =A0 =A0 =A0 l =3D __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG, p=
osted);
> + =A0 =A0 =A0 l =3D __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, =
posted);
> =A0 =A0 =A0 =A0if (l & OMAP_TIMER_CTRL_ST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D ~0x1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_=
CTRL_REG, l, posted);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_write(timer, OMAP_TIMER=
_CTRL_REG, l, posted);
> =A0#ifdef CONFIG_ARCH_OMAP2PLUS
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Readback to make sure write has com=
pleted */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_read(base, OMAP_TIMER_C=
TRL_REG, posted);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_read(timer, OMAP_TIMER_=
CTRL_REG, posted);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Wait for functional clock period x =
3.5 to make sure that
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * timer is stopped
> @@ -307,34 +339,34 @@ static inline void __omap_dm_timer_stop(void __=
iomem *base, int posted,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Ack possibly pending interrupt */
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_STAT_REG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_TIMER_INT_OVERFLOW, 0);
> + =A0 =A0 =A0 __raw_writel(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
> =A0}
>
> -static inline void __omap_dm_timer_load_start(void __iomem *base, u3=
2 ctrl,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int load, int posted)
> +static inline void __omap_dm_timer_load_start(struct omap_dm_timer *=
timer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctrl, unsigned int load,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int posted)
> =A0{
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_COUNTER_REG, loa=
d, posted);
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG, ctrl, =
posted);
> + =A0 =A0 =A0 __omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, lo=
ad, posted);
> + =A0 =A0 =A0 __omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl,=
 posted);
> =A0}
>
> -static inline void __omap_dm_timer_int_enable(void __iomem *base,
> +static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *=
timer,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0unsigned int value)
> =A0{
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG, valu=
e, 0);
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG, v=
alue, 0);
> + =A0 =A0 =A0 __raw_writel(value, timer->irq_ena);
> + =A0 =A0 =A0 __omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, =
value, 0);
> =A0}
>
> -static inline unsigned int __omap_dm_timer_read_counter(void __iomem=
 *base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int posted)
> +static inline unsigned int
> +__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted=
)
> =A0{
> - =A0 =A0 =A0 return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_RE=
G, posted);
> + =A0 =A0 =A0 return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_R=
EG, posted);
> =A0}
>
> -static inline void __omap_dm_timer_write_status(void __iomem *base,
> +static inline void __omap_dm_timer_write_status(struct omap_dm_timer=
 *timer,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0unsigned int value)
> =A0{
> - =A0 =A0 =A0 __omap_dm_timer_write(base, OMAP_TIMER_STAT_REG, value,=
 0);
> + =A0 =A0 =A0 __raw_writel(value, timer->irq_stat);
> =A0}
>
> =A0#endif /* __ASM_ARCH_DMTIMER_H */
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

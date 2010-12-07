From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v5 10/12] OMAP: dmtimer: switch-over to platform device driver
Date: Tue, 7 Dec 2010 10:57:58 +0530
Message-ID: <AANLkTik04xqcupa7x1VP0qu0oG1NZOhVCdEx8wPehLEB@mail.gmail.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com> <1291679059-13419-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48053 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754Ab0LGF2j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 00:28:39 -0500
Received: by mail-iw0-f173.google.com with SMTP id 34so1133622iwn.18
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:28:39 -0800 (PST)
In-Reply-To: <1291679059-13419-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

Tarun,

On Tue, Dec 7, 2010 at 05:14, Tarun Kanti DebBarma <tarun.kanti@ti.com>=
 wrote:
> switch-over to platform device driver through following changes:
> (a) call to dmtimer initialization routine from timer-gp.c is
> removed (b) initiate dmtimer early initialization from omap2_init_com=
mon_hw
> in io.c (c) modify plat-omap/dmtimer routines to use new register map=
 and
> platform data.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> ---
> =A0arch/arm/mach-omap2/clock2420_data.c =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/clock2430_data.c =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/dmtimer.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 40 +++=
+
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +
> =A0arch/arm/mach-omap2/timer-gp.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/arm/plat-omap/dmtimer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0323 +=
++++++++--------------------
> =A0arch/arm/plat-omap/include/plat/dmtimer.h | =A0 =A02 -
> =A09 files changed, 148 insertions(+), 228 deletions(-)
>
<<snip>>

> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtime=
r.c
> index ddc875b..ac6a498 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c

<<snip>>
> -static struct omap_dm_timer *dm_timers;
> -static const char **dm_source_names;
> -static struct clk **dm_source_clocks;
> -
> =A0static LIST_HEAD(omap_timer_list);
> =A0static DEFINE_SPINLOCK(dm_timer_lock);
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
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;

Leave one line

> + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offset;
> + =A0 =A0 =A0 else if (reg >=3D OMAP_TIMER_STAT_REG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->intr_offset;
> =A0 =A0 =A0 =A0if (timer->posted)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (readl(timer->io_base + (OMAP_TI=
MER_WRITE_PEND_REG & 0xff))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& (reg=
 >> WPSHIFT))
> @@ -290,15 +195,24 @@ static inline u32 omap_dm_timer_read_reg(struct=
 omap_dm_timer *timer, u32 reg)
> =A0 =A0 =A0 =A0return readl(timer->io_base + (reg & 0xff));
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
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;

Leave one line

> + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offset;
> + =A0 =A0 =A0 else if (reg >=3D OMAP_TIMER_STAT_REG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->intr_offset;
> =A0 =A0 =A0 =A0if (timer->posted)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (readl(timer->io_base + (OMAP_TI=
MER_WRITE_PEND_REG & 0xff))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& (reg=
 >> WPSHIFT))
> @@ -306,6 +220,8 @@ static void omap_dm_timer_write_reg(struct omap_d=
m_timer *timer, u32 reg,
> =A0 =A0 =A0 =A0writel(value, timer->io_base + (reg & 0xff));
> =A0}
>
> +#if defined(CONFIG_ARCH_OMAP1)
> +
> =A0static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *tim=
er)
> =A0{
> =A0 =A0 =A0 =A0int c;
> @@ -324,54 +240,77 @@ static void omap_dm_timer_reset(struct omap_dm_=
timer *timer)
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> - =A0 =A0 =A0 if (!cpu_class_is_omap2() || timer !=3D &dm_timers[0]) =
{
> + =A0 =A0 =A0 if (!cpu_class_is_omap2() || timer->pdev->id !=3D 1) {

Should this be '&&' instead of '||' ?

Not required to check the cpu_class as this function is under CONFIG_AR=
CH_OMAP1.
Also I think, it is better to use cpu_class is checks than using
CONFIG_ARCH_OMAP1 checks.
I guess that this function can be considered to be moved to mach-omap1/=
*

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TI=
MER_IF_CTRL_REG, 0x06);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_wait_for_reset(timer);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>
> =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG=
_REG);
> =A0 =A0 =A0 =A0l |=3D 0x02 << 3; =A0/* Set to smart-idle mode */
> =A0 =A0 =A0 =A0l |=3D 0x2 << 8; =A0 /* Set clock activity to perserve=
 f-clock on idle */
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Enable wake-up on OMAP2 CPUs.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (cpu_class_is_omap2())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 1 << 2;
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG,=
 l);
>
> - =A0 =A0 =A0 /* Match hardware reset default of posted mode */
> - =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_TIMER_CTRL_POSTED)=
;
> - =A0 =A0 =A0 timer->posted =3D 1;
> =A0}
> +#endif
>
> =A0static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 u32 l;
> +
> + =A0 =A0 =A0 timer->fclk =3D clk_get(&timer->pdev->dev, "fck");
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(timer->fclk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("omap_timer: failed to acquire =
fclk handle.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);

Embed warning message in WARN_ON  and remove pr_info usage.
Give proper warning message in all other places where WARN_ON(1) is bei=
ng used

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0omap_dm_timer_enable(timer);
> +
> +#if defined(CONFIG_ARCH_OMAP1)
> =A0 =A0 =A0 =A0omap_dm_timer_reset(timer);
> +#endif
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Enable wake-up on OMAP2420, OMAP2430 and OMAP3430 =
CPUs.
> + =A0 =A0 =A0 =A0* FIXME: SYSC_HAS_ENAWAKEUP flag is already set in h=
wmod.
> + =A0 =A0 =A0 =A0* But on OMAP2 code does not work without following =
configuration.
> + =A0 =A0 =A0 =A0* Need to investigate why this is happening.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (is_omap2430() || is_omap2420() || is_omap3430()) {

Do not use these checks in plat-omap/*.
Prefer using cpu_is* checks instead of is_omap2420().

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D omap_dm_timer_read_reg(timer, OMA=
P_TIMER_OCP_CFG_REG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 1 << 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIM=
ER_OCP_CFG_REG, l);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +
> + =A0 =A0 =A0 /* Match hardware reset default of posted mode */
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_TIMER_CTRL_POSTED)=
;
> + =A0 =A0 =A0 timer->posted =3D 1;
> =A0}

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

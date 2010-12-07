From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 10/12] OMAP: dmtimer: switch-over to platform device
 driver
Date: Tue, 7 Dec 2010 11:19:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03736F5092@dbde02.ent.ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-11-git-send-email-tarun.kanti@ti.com>
 <AANLkTik04xqcupa7x1VP0qu0oG1NZOhVCdEx8wPehLEB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43961 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab0LGFtc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 00:49:32 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB75nT8B023051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 23:49:31 -0600
In-Reply-To: <AANLkTik04xqcupa7x1VP0qu0oG1NZOhVCdEx8wPehLEB@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Tuesday, December 07, 2010 10:58 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v5 10/12] OMAP: dmtimer: switch-over to platform
> device driver
>=20
> Tarun,
>=20
> On Tue, Dec 7, 2010 at 05:14, Tarun Kanti DebBarma <tarun.kanti@ti.co=
m>
> wrote:
> > switch-over to platform device driver through following changes:
> > (a) call to dmtimer initialization routine from timer-gp.c is
> > removed (b) initiate dmtimer early initialization from
> omap2_init_common_hw
> > in io.c (c) modify plat-omap/dmtimer routines to use new register m=
ap
> and
> > platform data.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> > Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/clock2420_data.c =A0 =A0 =A0| =A0 =A02 +-
> > =A0arch/arm/mach-omap2/clock2430_data.c =A0 =A0 =A0| =A0 =A02 +-
> > =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0| =A0 =A02 +-
> > =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0| =A0 =A02 +-
> > =A0arch/arm/mach-omap2/dmtimer.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 40 +=
+++
> > =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +
> > =A0arch/arm/mach-omap2/timer-gp.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 -
> > =A0arch/arm/plat-omap/dmtimer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0323=
 +++++++++-------------
> -------
> > =A0arch/arm/plat-omap/include/plat/dmtimer.h | =A0 =A02 -
> > =A09 files changed, 148 insertions(+), 228 deletions(-)
> >
> <<snip>>
>=20
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmti=
mer.c
> > index ddc875b..ac6a498 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
>=20
> <<snip>>
> > -static struct omap_dm_timer *dm_timers;
> > -static const char **dm_source_names;
> > -static struct clk **dm_source_clocks;
> > -
> > =A0static LIST_HEAD(omap_timer_list);
> > =A0static DEFINE_SPINLOCK(dm_timer_lock);
> >
> > -/*
> > - * Reads timer registers in posted and non-posted mode. The posted=
 mode
> bit
> > - * is encoded in reg. Note that in posted mode write pending bit m=
ust
> be
> > - * checked. Otherwise a read of a non completed write will produce=
 an
> error.
> > +/**
> > + * omap_dm_timer_read_reg - read timer registers in posted and non=
-
> posted mode
> > + * @timer: =A0 =A0 =A0timer pointer over which read operation to p=
erform
> > + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> > + *
> > + * The posted mode bit is encoded in reg. Note that in posted mode
> write
> > + * pending bit must be checked. Otherwise a read of a non complete=
d
> write
> > + * will produce an error.
> > =A0*/
> > =A0static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *t=
imer,
> u32 reg)
> > =A0{
> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev-
> >dev.platform_data;
>=20
> Leave one line
Ok.

>=20
> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offset;
> > + =A0 =A0 =A0 else if (reg >=3D OMAP_TIMER_STAT_REG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->intr_offset;
> > =A0 =A0 =A0 =A0if (timer->posted)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (readl(timer->io_base + (OMAP_=
TIMER_WRITE_PEND_REG
> & 0xff))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& (r=
eg >> WPSHIFT))
> > @@ -290,15 +195,24 @@ static inline u32 omap_dm_timer_read_reg(stru=
ct
> omap_dm_timer *timer, u32 reg)
> > =A0 =A0 =A0 =A0return readl(timer->io_base + (reg & 0xff));
> > =A0}
> >
> > -/*
> > - * Writes timer registers in posted and non-posted mode. The poste=
d
> mode bit
> > - * is encoded in reg. Note that in posted mode the write pending b=
it
> must be
> > - * checked. Otherwise a write on a register which has a pending wr=
ite
> will be
> > - * lost.
> > +/**
> > + * omap_dm_timer_write_reg - write timer registers in posted and n=
on-
> posted mode
> > + * @timer: =A0 =A0 =A0timer pointer over which write operation is =
to perform
> > + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> > + * @value: =A0 =A0 =A0data to write into the register
> > + *
> > + * The posted mode bit is encoded in reg. Note that in posted mode=
 the
> write
> > + * pending bit must be checked. Otherwise a write on a register wh=
ich
> has a
> > + * pending write will be lost.
> > =A0*/
> > =A0static void omap_dm_timer_write_reg(struct omap_dm_timer *timer,=
 u32
> reg,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 value)
> > =A0{
> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev-
> >dev.platform_data;
>=20
> Leave one line
Ok.

>=20
> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offset;
> > + =A0 =A0 =A0 else if (reg >=3D OMAP_TIMER_STAT_REG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->intr_offset;
> > =A0 =A0 =A0 =A0if (timer->posted)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (readl(timer->io_base + (OMAP_=
TIMER_WRITE_PEND_REG
> & 0xff))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& (r=
eg >> WPSHIFT))
> > @@ -306,6 +220,8 @@ static void omap_dm_timer_write_reg(struct
> omap_dm_timer *timer, u32 reg,
> > =A0 =A0 =A0 =A0writel(value, timer->io_base + (reg & 0xff));
> > =A0}
> >
> > +#if defined(CONFIG_ARCH_OMAP1)
> > +
> > =A0static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *t=
imer)
> > =A0{
> > =A0 =A0 =A0 =A0int c;
> > @@ -324,54 +240,77 @@ static void omap_dm_timer_reset(struct
> omap_dm_timer *timer)
> > =A0{
> > =A0 =A0 =A0 =A0u32 l;
> >
> > - =A0 =A0 =A0 if (!cpu_class_is_omap2() || timer !=3D &dm_timers[0]=
) {
> > + =A0 =A0 =A0 if (!cpu_class_is_omap2() || timer->pdev->id !=3D 1) =
{
>=20
> Should this be '&&' instead of '||' ?
>=20
> Not required to check the cpu_class as this function is under
> CONFIG_ARCH_OMAP1.
Yes, the check is no longer needed. Thanks.

> Also I think, it is better to use cpu_class is checks than using
> CONFIG_ARCH_OMAP1 checks.
In case this piece of code is kept here I will use cpu_class.

> I guess that this function can be considered to be moved to mach-omap=
1/*
Sounds good! In this case we have to introduce a function pointer in
Platform data structure guarded by a macro. This can then be called
=46rom omap_dm_timer_prepare() with cpu_class check. Thanks.

>=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_=
TIMER_IF_CTRL_REG,
> 0x06);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_wait_for_reset(timer);
> > =A0 =A0 =A0 =A0}
> > - =A0 =A0 =A0 omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ=
);
> >
> > =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_C=
=46G_REG);
> > =A0 =A0 =A0 =A0l |=3D 0x02 << 3; =A0/* Set to smart-idle mode */
> > =A0 =A0 =A0 =A0l |=3D 0x2 << 8; =A0 /* Set clock activity to perser=
ve f-clock on
> idle */
> >
> > - =A0 =A0 =A0 /*
> > - =A0 =A0 =A0 =A0* Enable wake-up on OMAP2 CPUs.
> > - =A0 =A0 =A0 =A0*/
> > - =A0 =A0 =A0 if (cpu_class_is_omap2())
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 1 << 2;
> > =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_RE=
G, l);
> >
> > - =A0 =A0 =A0 /* Match hardware reset default of posted mode */
> > - =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG=
,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_TIMER_CTRL_POSTE=
D);
> > - =A0 =A0 =A0 timer->posted =3D 1;
> > =A0}
> > +#endif
> >
> > =A0static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
> > =A0{
> > + =A0 =A0 =A0 u32 l;
> > +
> > + =A0 =A0 =A0 timer->fclk =3D clk_get(&timer->pdev->dev, "fck");
> > + =A0 =A0 =A0 if (IS_ERR_OR_NULL(timer->fclk)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("omap_timer: failed to acquir=
e fclk handle.\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
>=20
> Embed warning message in WARN_ON  and remove pr_info usage.
> Give proper warning message in all other places where WARN_ON(1) is b=
eing
> used
Ok.
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0omap_dm_timer_enable(timer);
> > +
> > +#if defined(CONFIG_ARCH_OMAP1)
> > =A0 =A0 =A0 =A0omap_dm_timer_reset(timer);
> > +#endif
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Enable wake-up on OMAP2420, OMAP2430 and OMAP343=
0 CPUs.
> > + =A0 =A0 =A0 =A0* FIXME: SYSC_HAS_ENAWAKEUP flag is already set in=
 hwmod.
> > + =A0 =A0 =A0 =A0* But on OMAP2 code does not work without followin=
g
> configuration.
> > + =A0 =A0 =A0 =A0* Need to investigate why this is happening.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (is_omap2430() || is_omap2420() || is_omap3430()) =
{
>=20
> Do not use these checks in plat-omap/*.
Yes, there is FIXME message. Need to figure out why this is happening.

> Prefer using cpu_is* checks instead of is_omap2420().
Ok.
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D omap_dm_timer_read_reg(timer,
> OMAP_TIMER_OCP_CFG_REG);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 1 << 2;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_T=
IMER_OCP_CFG_REG,
> l);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ=
);
> > +
> > + =A0 =A0 =A0 /* Match hardware reset default of posted mode */
> > + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG=
,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_TIMER_CTRL_POSTE=
D);
> > + =A0 =A0 =A0 timer->posted =3D 1;
> > =A0}
>=20
> <<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

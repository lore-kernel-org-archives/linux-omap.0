From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platform device
 driver
Date: Mon, 22 Nov 2010 17:38:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0372E40154@dbde02.ent.ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
 <AANLkTik6PVX5XjX0T2GHhiEm4nb+P=V4UwXLWUr0XQNj@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0372E40047@dbde02.ent.ti.com>
 <AANLkTi=ao+J_3bs91F3YDXewkpOvY=e9rrGXYQC_yOu1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52611 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416Ab0KVMIZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 07:08:25 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAMC8MGp018906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 06:08:24 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAMC8LxA008851
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 17:38:22 +0530 (IST)
In-Reply-To: <AANLkTi=ao+J_3bs91F3YDXewkpOvY=e9rrGXYQC_yOu1@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Monday, November 22, 2010 5:30 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platform d=
evice
> driver
>=20
> On Mon, Nov 22, 2010 at 14:44, DebBarma, Tarun Kanti <tarun.kanti@ti.=
com>
> wrote:
> >> -----Original Message-----
> >> From: Varadarajan, Charulatha
> >> Sent: Monday, November 22, 2010 12:15 PM
> >> To: DebBarma, Tarun Kanti
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platfor=
m
> device
> >> driver
> >>
> >> <<snip>>
> >>
> >> > -/*
> >> > - * Reads timer registers in posted and non-posted mode. The pos=
ted
> mode
> >> bit
> >> > - * is encoded in reg. Note that in posted mode write pending bi=
t
> must
> >> be
> >> > - * checked. Otherwise a read of a non completed write will prod=
uce
> an
> >> error.
> >> > +/**
> >> > + * omap_dm_timer_read_reg - read timer registers in posted and =
non-
> >> posted mode
> >> > + * @timer: =A0 =A0 =A0timer pointer over which read operation t=
o perform
> >> > + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> >> > + *
> >> > + * The posted mode bit is encoded in reg. Note that in posted m=
ode
> >> write
> >> > + * pending bit must be checked. Otherwise a read of a non compl=
eted
> >> write
> >> > + * will produce an error.
> >> > =A0*/
> >> > =A0static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer
> *timer,
> >> u32 reg)
> >> > =A0{
> >> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pde=
v-
> >> >dev.platform_data;
> >> > +
> >> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
> >> > +
> >> > =A0 =A0 =A0 =A0if (timer->posted)
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> (OMAP_TIMER_WRITE_PEND_REG
> >> & 0xff))
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =
(reg >> WPSHIFT))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRITE=
_PEND_REG + pdata-
> >func_offst)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =
0xff)) & (reg >> WPSHIFT))
> >>
> >> You may add a timeout in this.
> > There are few reasons why I have not done:
> > (1) This was in this way from the beginning and I thought some anal=
ysis
> > Was done already for not adding timeout and so did not wish to alte=
r
> that.
> > (2) wanted to keep low level functions as simple as possible by avo=
iding
> > As many checks as possible unless really needed.
> > (3) The client driver can take care of timeout. Even if timeout is
> > Introduced in this api, the client driver anyways have to check for=
 the
> > Timeout.
>=20
> I don't think that client driver should take care of this. The client
> driver should
> check only for the return value. If timeout, return error.
So what I am saying is it can add the timeout instead of checking for t=
he
Return value. This would keep the low level function simple.
Please try to understand that this is  a common function called by all =
the
Client drivers associated with all the timers. If you can reduce a chec=
k
The benefit is tremendous.=20

--
Tarun

>=20
> In your case, one of the calls to omap_dm_timer_write_reg() is as giv=
en
> below:
> omap2_gp_timer_init()
>     -> omap2_gp_clockevent_init()
>           -> omap_dm_timer_request_specific()
>               -> omap_dm_timer_prepare()
>                  -> omap_dm_timer_write_reg()
>=20
> Here timeout is not taken care.
>=20
> >
> > --
> > Tarun
> >>
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> >> > =A0 =A0 =A0 =A0return readl(timer->io_base + (reg & 0xff));
> >> > =A0}
> >> >
> >> > -/*
> >> > - * Writes timer registers in posted and non-posted mode. The po=
sted
> >> mode bit
> >> > - * is encoded in reg. Note that in posted mode the write pendin=
g bit
> >> must be
> >> > - * checked. Otherwise a write on a register which has a pending
> write
> >> will be
> >> > - * lost.
> >> > +/**
> >> > + * omap_dm_timer_write_reg - write timer registers in posted an=
d
> non-
> >> posted mode
> >> > + * @timer: =A0 =A0 =A0timer pointer over which write operation =
is to
> perform
> >> > + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> >> > + * @value: =A0 =A0 =A0data to write into the register
> >> > + *
> >> > + * The posted mode bit is encoded in reg. Note that in posted m=
ode
> the
> >> write
> >> > + * pending bit must be checked. Otherwise a write on a register
> which
> >> has a
> >> > + * pending write will be lost.
> >> > =A0*/
> >> > =A0static void omap_dm_timer_write_reg(struct omap_dm_timer *tim=
er, u32
> >> reg,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 value)
> >> > =A0{
> >> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pde=
v-
> >> >dev.platform_data;
> >> > +
> >> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
> >> > +
> >> > =A0 =A0 =A0 =A0if (timer->posted)
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> (OMAP_TIMER_WRITE_PEND_REG
> >> & 0xff))
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =
(reg >> WPSHIFT))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRITE=
_PEND_REG + pdata-
> >func_offst)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =
0xff)) & (reg >> WPSHIFT))
> >>
> >> Ditto.
> >>
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> >> > =A0 =A0 =A0 =A0writel(value, timer->io_base + (reg & 0xff));
> >> > =A0}
> >>
> >>
> >> <<snip>>
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

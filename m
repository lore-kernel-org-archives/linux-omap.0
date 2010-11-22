From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platform device
 driver
Date: Mon, 22 Nov 2010 14:44:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0372E40047@dbde02.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab0KVJOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 04:14:15 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAM9EB8J002182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:14:14 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAM9EB94023178
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 14:44:11 +0530 (IST)
In-Reply-To: <AANLkTik6PVX5XjX0T2GHhiEm4nb+P=V4UwXLWUr0XQNj@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Monday, November 22, 2010 12:15 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platform d=
evice
> driver
>=20
> <<snip>>
>=20
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
> > +
> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
> > +
> > =A0 =A0 =A0 =A0if (timer->posted)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base + (OMAP_T=
IMER_WRITE_PEND_REG
> & 0xff))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (re=
g >> WPSHIFT))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRITE_PE=
ND_REG + pdata->func_offst)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & 0xf=
f)) & (reg >> WPSHIFT))
>=20
> You may add a timeout in this.
There are few reasons why I have not done:
(1) This was in this way from the beginning and I thought some analysis
Was done already for not adding timeout and so did not wish to alter th=
at.
(2) wanted to keep low level functions as simple as possible by avoidin=
g
As many checks as possible unless really needed.
(3) The client driver can take care of timeout. Even if timeout is=20
Introduced in this api, the client driver anyways have to check for the
Timeout.

--
Tarun
>=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
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
> > +
> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
> > +
> > =A0 =A0 =A0 =A0if (timer->posted)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base + (OMAP_T=
IMER_WRITE_PEND_REG
> & 0xff))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (re=
g >> WPSHIFT))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRITE_PE=
ND_REG + pdata->func_offst)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & 0xf=
f)) & (reg >> WPSHIFT))
>=20
> Ditto.
>=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> > =A0 =A0 =A0 =A0writel(value, timer->io_base + (reg & 0xff));
> > =A0}
>=20
>=20
> <<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

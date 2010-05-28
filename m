From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v4 1/3] omap3 gpmc: functionality enhancement
Date: Sat, 29 May 2010 00:22:32 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DB24320@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030DAA0662@dbde02.ent.ti.com>
 	<AANLkTilOF0IW4mJiydPjaut6S-45mtm8EysAF6pepWTn@mail.gmail.com>
 	<2A3DCF3DA181AD40BDE86A3150B27B6B030DB24311@dbde02.ent.ti.com>
 <AANLkTikttiNLDYfTPIwLWJYsfLIuPcRdk8EMfJNnKi-B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37671 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab0E1Swk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 14:52:40 -0400
In-Reply-To: <AANLkTikttiNLDYfTPIwLWJYsfLIuPcRdk8EMfJNnKi-B@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
> Sent: Saturday, May 29, 2010 12:20 AM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v4 1/3] omap3 gpmc: functionality enhancement
>=20
> On Fri, May 28, 2010 at 11:50 PM, Ghorai, Sukumar <s-ghorai@ti.com> w=
rote:
> >
> >
> >> -----Original Message-----
> >> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
> >> Sent: Friday, May 28, 2010 9:14 PM
> >> To: Ghorai, Sukumar
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH v4 1/3] omap3 gpmc: functionality enhancement
> >>
> >> On Fri, May 28, 2010 at 12:03 PM, Ghorai, Sukumar <s-ghorai@ti.com=
>
> wrote:
> >> >
> >> >> -----Original Message-----
> >> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> >> owner@vger.kernel.org] On Behalf Of Vimal Singh
> >> >> Sent: Thursday, May 27, 2010 11:56 PM
> >> >> To: Ghorai, Sukumar
> >> >> Cc: linux-omap@vger.kernel.org
> >> >> Subject: Re: [PATCH v4 1/3] omap3 gpmc: functionality enhanceme=
nt
> >> >>
> >> >> On Thu, May 27, 2010 at 6:54 PM, Sukumar Ghorai <s-ghorai@ti.co=
m>
> >> wrote:
> >> >> [...]
> >> >> > -static unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_cs_map;
> >> >> > +static unsigned =A0 =A0 =A0 =A0int gpmc_cs_map; =A0 =A0 =A0 =
=A0/* flag for cs
> which
> >> are
> >> >> initialized */
> >> >>
> >> >> Tab should be after 'int', not before.
> >> >>
> >> >> [...]
> >> >> > @@ -456,13 +565,22 @@ EXPORT_SYMBOL(gpmc_prefetch_enable);
> >> >> > =A0/**
> >> >> > =A0* gpmc_prefetch_reset - disables and stops the prefetch en=
gine
> >> >> > =A0*/
> >> >> > -void gpmc_prefetch_reset(void)
> >> >> > +int gpmc_prefetch_reset(int cs)
> >> >> > =A0{
> >> >> > + =A0 =A0 =A0 u32 config1;
> >> >> > +
> >> >> > + =A0 =A0 =A0 /* check if the same module/cs is trying to res=
et */
> >> >> > + =A0 =A0 =A0 config1 =3D gpmc_read_reg(GPMC_PREFETCH_CONFIG1=
);
> >> >> > + =A0 =A0 =A0 if (((config1 >> CS_NUM_SHIFT) & 0x7) !=3D cs)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> >> > +
> >> >>
> >> >> You really do not need this.
> >> >> Prefetch has just one instance at a time and 'reset' will be ca=
ll
> only
> >> >> when driver has got access to prefetch (for either read or writ=
e
> >> >> access), from the driver.
> >> > [Ghorai] Agree. And.. NAND may not be good example. But if tomor=
row
> i/o
> >> operation need to cancel for some other type of device and for big=
 size
> of
> >> IO on progress. So is not this API required that case?
> >> >
> >>
> >> First of all, this prefetch engine is dedicated for only NAND.
> > [Ghorai] ok. Does not this below response is contradicting previous
> statement?
> >> Then, if user wants to 'cancel', say a big write operation; since
> >> there is no 'cancel' command provided by chip (nand), FS has to ha=
ndle
> >> it. And, I guess, best way will be to complete current chunck of
> >> request (in this case writing of current page or sub-page) and the=
n
> >> cancel any further pending transfer.
> >> And in that case again, prefetch 'reset' will get called for
> >> completion of current page/sub-page operation.
> >
> > [Ghorai]
> > 1. In this case why we checks - prefetch engine busy or not, if we =
are
> waiting to complete one request to be completed before another? As we
> reset the prefetch-engine at the end of the io?
> >
> Since there could be other request (for read/write) from another
> driver instance (in case we have more than one NAND chip on board).
>=20
> > 2. The only possible scenario is - when two driver(say for two sepa=
rate
> nand chip) trying to access the prefetch-engine. In that case who
> accessing the prefetch engine he should only reset the engine. And to
> avoid confusion and mistake of the user of this API, it has been adde=
d
> 'cs' number as a function parameter for reset and the same is used to
> check before reset.
> >
>=20
> In this scenario, when second driver instance fails to get prefetch,
> it completes the request by cpu transfer method. And there is no
> chance for prefetch reset to get called from this driver instance.
> Note that we are not calling reset explicitly, but a driver (instance=
)
> resets the prefetch only if it gets first.
[Ghorai] I says.. And to avoid confusion and mistake of the user of thi=
s API, it has been added 'cs' number as a function parameter for reset =
and the same is used to check before reset.
What's wrong?
>=20
> --
> Regards,
> Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: hwmod: remove OMAP_CHIP*
Date: Wed, 14 Sep 2011 05:54:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109140546300.27954@utopia.booyaka.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com> <CANOLnOOkz2ZkhPSafTLxUUH2bSVoRrYA44-C1+yku8naYaRz3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1584965051-1316001286=:27954"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33779 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab1INLyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 07:54:47 -0400
In-Reply-To: <CANOLnOOkz2ZkhPSafTLxUUH2bSVoRrYA44-C1+yku8naYaRz3w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1584965051-1316001286=:27954
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Gra=B8vydas,

On Mon, 5 Sep 2011, Grazvydas Ignotas wrote:

> On Mon, Sep 5, 2011 at 5:43 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
> > index 84cc0bd..d7138070 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> <snip>
>=20
> >
> > =A0int __init omap3xxx_hwmod_init(void)
> > =A0{
> > - =A0 =A0 =A0 return omap_hwmod_register(omap3xxx_hwmods);
> > + =A0 =A0 =A0 int r;
> > + =A0 =A0 =A0 struct omap_hwmod **h =3D NULL;
> > +
> > + =A0 =A0 =A0 /* Register hwmods common to all OMAP3 */
> > + =A0 =A0 =A0 r =3D omap_hwmod_register(omap3xxx_hwmods);
> > + =A0 =A0 =A0 if (!r)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Register hwmods common to individual OMAP3 families,=
 all
> > + =A0 =A0 =A0 =A0* silicon revisions (e.g., 34xx, or AM3505/3517, or 36=
xx)
> > + =A0 =A0 =A0 =A0* All possible revisions should be included in this co=
nditional.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (omap_rev() =3D=3D OMAP3430_REV_ES1_0 ||
> > + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES2_0 ||
> > + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES2_1 ||
> > + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES3_0 ||
> > + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES3_1 ||
> > + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES3_1_2) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =3D omap34xx_hwmods;
> > + =A0 =A0 =A0 } else if (omap_rev() & OMAP3505_REV(0)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =3D am35xx_hwmods;
>=20
> This check will be always true I think?

Thanks for the review; you are absolutely right and this will be fixed.

> Why not just use cpu_is_omap3xxx() for these tests, since it does same
> omap_rev() call but only once per family?

cpu_is_omap*() doesn't do what one would expect :-(

For example, cpu_is_omap34xx() returns 1 on not only 34xx, but also 36xx=20
and 3517/3505.  Unfortunately, we don't currently do a good job of=20
separating SoC family detection from individual SoC detection.

If your objection is to the multiple calls to omap_rev(), those do indeed=
=20
appear in the source to be potentially expensive function calls --=20
although the compiler should inline them.  Just to be sure, the=20
next revision will use a variable.

regards


- Paul
--155748971-1584965051-1316001286=:27954--

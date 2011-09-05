From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2+: hwmod: remove OMAP_CHIP*
Date: Mon, 5 Sep 2011 18:19:47 +0300
Message-ID: <20110905151947.GA3548@atomide.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
 <CANOLnOOkz2ZkhPSafTLxUUH2bSVoRrYA44-C1+yku8naYaRz3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26183 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754521Ab1IEPTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 11:19:49 -0400
Content-Disposition: inline
In-Reply-To: <CANOLnOOkz2ZkhPSafTLxUUH2bSVoRrYA44-C1+yku8naYaRz3w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [110905 13:54]:
> On Mon, Sep 5, 2011 at 5:43 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2=
/omap_hwmod.c
> > index 84cc0bd..d7138070 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> <snip>
>=20
> >
> > =C2=A0int __init omap3xxx_hwmod_init(void)
> > =C2=A0{
> > - =C2=A0 =C2=A0 =C2=A0 return omap_hwmod_register(omap3xxx_hwmods);
> > + =C2=A0 =C2=A0 =C2=A0 int r;
> > + =C2=A0 =C2=A0 =C2=A0 struct omap_hwmod **h =3D NULL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /* Register hwmods common to all OMAP3 */
> > + =C2=A0 =C2=A0 =C2=A0 r =3D omap_hwmod_register(omap3xxx_hwmods);
> > + =C2=A0 =C2=A0 =C2=A0 if (!r)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Register hwmods common to individual=
 OMAP3 families, all
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* silicon revisions (e.g., 34xx, or AM=
3505/3517, or 36xx)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* All possible revisions should be inc=
luded in this conditional.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> > + =C2=A0 =C2=A0 =C2=A0 if (omap_rev() =3D=3D OMAP3430_REV_ES1_0 ||
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_rev() =3D=3D OMAP3430_REV=
_ES2_0 ||
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_rev() =3D=3D OMAP3430_REV=
_ES2_1 ||
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_rev() =3D=3D OMAP3430_REV=
_ES3_0 ||
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_rev() =3D=3D OMAP3430_REV=
_ES3_1 ||
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_rev() =3D=3D OMAP3430_REV=
_ES3_1_2) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D omap34xx_h=
wmods;
> > + =C2=A0 =C2=A0 =C2=A0 } else if (omap_rev() & OMAP3505_REV(0)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D am35xx_hwm=
ods;
>=20
> This check will be always true I think?
>=20
> Why not just use cpu_is_omap3xxx() for these tests, since it does sam=
e
> omap_rev() call but only once per family?

=46or SoC family based ES revision and GP/HS detection
we should set up minimal macros. Ideally we would not
need cpu_is_omapxxxx during early_init at all.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

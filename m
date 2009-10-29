From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap2: mux: intoduce omap_mux_{read,write}, v2
Date: Thu, 29 Oct 2009 13:30:14 -0700
Message-ID: <20091029203013.GP7180@atomide.com>
References: <cover.1256734115.git.mike@compulab.co.il> <afa6b6ded8db35578a200c71938174a61eaa4ef9.1256734115.git.mike@compulab.co.il> <20091029155010.GI7180@atomide.com> <20091029165119.GM7180@atomide.com> <f870da180910291328t60f96895v3b760e6172748a3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51451 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbZJ2Ua1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 16:30:27 -0400
Content-Disposition: inline
In-Reply-To: <f870da180910291328t60f96895v3b760e6172748a3e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

* Mike Rapoport <mike.rapoport@gmail.com> [091029 13:28]:
> On Thu, Oct 29, 2009 at 6:51 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Tony Lindgren <tony@atomide.com> [091029 08:50]:
> >> * Mike Rapoport <mike@compulab.co.il> [091028 06:17]:
> >> > Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> >> > ---
> >> > =A0arch/arm/mach-omap2/mux.c | =A0 25 +++++++++++++++++++------
> >> > =A01 files changed, 19 insertions(+), 6 deletions(-)
> >> >
> >> > +static inline void omap_mux_write(u16 val, u16 reg)
> >> > +{
> >> > + =A0 if (cpu_is_omap24xx())
> >> > + =A0 =A0 =A0 =A0 =A0 return omap_ctrl_writeb(val, reg);
> >> > + =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 return omap_ctrl_writew(val, reg);
> >> > +}
> >> > +
> >>
> >> The void function should not return any values above..
>=20
> damn copy-paset :)
>=20
> >> I suggest we standardize on:
> >
> > Here's an updated version of your patch, what do you think?
>=20
> I'm fine with ioremap and the offsets. Just one thing below:
>=20
> > @@ -627,8 +644,27 @@ static int __init_or_module omap34xx_cfg_reg(c=
onst struct pin_config *cfg)
> >  #define omap34xx_cfg_reg	NULL
> >  #endif
> >
> > +#define OMAP2
> > +#define OMAP2_CONTROL_PADCONF_MUX_PBASE	0x48002030LU
> > +#define OMAP3_CONTROL_PADCONF_MUX_PBASE	0x48002030LU
>=20
> what are these for?

Oops, more copy-patse :) Removed now. Will send you my patches
now for you to check them out.

Tony
=20
> >  int __init omap2_mux_init(void)
> >  {
> > +	u32 mux_pbase;
> > +
> > +	if (cpu_is_omap2420())
> > +		mux_pbase =3D OMAP2420_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
> > +	else if (cpu_is_omap2430())
> > +		mux_pbase =3D OMAP243X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
> > +	else if (cpu_is_omap34xx())
> > +		mux_pbase =3D OMAP343X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
> > +
>=20
>=20
> > Tony
> >
>=20
>=20
>=20
> --=20
> 	Sincerely Yours,
> 		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

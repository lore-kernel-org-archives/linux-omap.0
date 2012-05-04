From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: igep0020: Specify the VPLL2 regulator
 unconditionally
Date: Fri, 4 May 2012 12:46:16 -0700
Message-ID: <20120504194616.GR5613@atomide.com>
References: <1335185338-22006-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <CAFqH_53s3Vf5822yy8YU-dOq3P_miBD1uG1d+5NqefF=3__zGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60313 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab2EDTqT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 15:46:19 -0400
Content-Disposition: inline
In-Reply-To: <CAFqH_53s3Vf5822yy8YU-dOq3P_miBD1uG1d+5NqefF=3__zGQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?utf-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

* Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [120427 02:30]:
> 2012/4/23 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> > The supply is connected to the DSS DO-D5 pins and is thus needed fo=
r
> > both serial and parallel display interfaces on the igep0030 as well=
 as
> > the igep0020.
> >
> > If the igep0030 module isn't connected to a display, no DSI or DPI
> > display will be specified in board code, and the DSS driver won't e=
nable
> > to VPLL2 regulator anyway.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 10 +++++-----
> > =C2=A01 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-o=
map2/board-igep0020.c
> > index a59ace0..242cdff 100644
> > --- a/arch/arm/mach-omap2/board-igep0020.c
> > +++ b/arch/arm/mach-omap2/board-igep0020.c
> > @@ -539,7 +539,10 @@ static void __init igep_i2c_init(void)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> >
> > - =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_config(&igep_twldata, TWL_COM=
MON_PDATA_USB, 0);
> > + =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_config(&igep_twldata, TWL_COM=
MON_PDATA_USB,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TWL_COMMON_REGULATOR_VPLL2);
> > + =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2->constraints.apply_uV =3D=
 true;
> > + =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2->constraints.name =3D "VD=
VI";
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (machine_is_igep0020()) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > @@ -553,10 +556,7 @@ static void __init igep_i2c_init(void)
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_twldata=
=2Ekeypad =C2=A0 =C2=A0 =3D &igep2_keypad_pdata;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get commo=
n pmic data */
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_c=
onfig(&igep_twldata, TWL_COMMON_PDATA_AUDIO,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TWL_COMMON_=
REGULATOR_VPLL2);
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpl=
l2->constraints.apply_uV =3D true;
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpl=
l2->constraints.name =3D "VDVI";
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_c=
onfig(&igep_twldata, TWL_COMMON_PDATA_AUDIO, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_pmic_init("twl4030", &igep_twldata=
);
> > --
> > Regards,
> >
> > Laurent Pinchart
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>=20
> Seems good to me.
>=20
> Tony, as this is a fix ,may be included ?
>=20
> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Yes seems like a valid fix to me so applying into fixes.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

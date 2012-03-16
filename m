From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to add IVA OPP
Date: Fri, 16 Mar 2012 16:47:15 +0100
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56D6BE@dolphin.TIGRIS.local>
References: <20120316142034.GA22234@senorita.am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-cBy60B/KSqI83ZGU2/6i"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:44387 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422818Ab2CPPr1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 11:47:27 -0400
Received: from [77.186.39.8] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=0422343688=maximilian.schwerin@tigris.de>)
	id 1S8ZNE-0000Bm-Mj
	for linux-omap@vger.kernel.org; Fri, 16 Mar 2012 16:47:24 +0100
In-Reply-To: <20120316142034.GA22234@senorita.am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

--=-cBy60B/KSqI83ZGU2/6i
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: Nishanth Menon [mailto:nm@ti.com]=20
> Gesendet: Freitag, 16. M=E4rz 2012 15:21
> An: Maximilian Schwerin
> Cc: Kevin Hilman; linux-omap@vger.kernel.org;=20
> linux-arm-kernel@lists.infradead.org; Steve Sakoman
> Betreff: Re: [PATCH] OMAP3: OPP: Test for IVA subsystem=20
> before attempting to add IVA OPP
>=20
> On 10:26-20120316, Maximilian Schwerin wrote:
> [...]
> > > >>> +
> > > >>> + =A0 =A0 =A0 =A0 =A0 =A0 if =
((strcmp(opp_def->hwmod_name,"iva") =3D=3D=20
> > > 0) && !omap3_has_iva())
> > > >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> > > >>> +
> > > >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh =3D =
omap_hwmod_lookup(opp_def->hwmod_name);
> > > >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh || !oh->od) {
> > > >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: no =
hwmod or odev=20
> for %s, [%d] "
> > > >>
> > > >> Wouldn't the one-liner below do the same thing?
> > > >>
> > > >> Actually, your patch makes it less noisy at boot time,=20
> avoiding the
> > > >> pr_warn(), so is probably better.
> > > >
> > > > The only issue i have with current patch is that it=20
> > > focusses to solve
> > > > a specific device IVA.
> > > > we could have similar variances if we had SGX/AESS device etc
> > > > registered in the common
> > > > table. a generic solution might be preferable - could=20
> we reduce the
> > > > severity of pr_warn to pr_debug and do a continue instead?
> > >=20
> > > I agree, that would be a better generic solution.
> > >=20
> > > Kevin
> > >
> >=20
> > This is a pragmatic and simple solution for a well=20
> understood problem with no side effects. Why not fix the=20
> problem now and do the generic solution later on?=20
> >=20
> > I'm not a fulltime kernel dev. I have about two weeks to=20
> get my new board out to my customer... Every time I set up a=20
> new board, I have to fix problems using known patches that=20
> are sometimes years old. Every patch I have to find costs me=20
> hours of time I really don't have.=20
> >=20
> > Just my two cents (euro cents of course :-), Maximilian
> ok, so lets fix it generically - here is the patch for it. Let us know
> if this works for you
>=20
>=20
> From 5275d09c9f1a16c8f0814745e1c313c6cca049f6 Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Fri, 16 Mar 2012 09:13:24 -0500
> Subject: [PATCH] OMAP2+: OPP: allow OPP enumeration to=20
> continue if device is not present
>=20
> On platforms such as OMAP3, certain variants may not have IVA, SGX
> or some specific component. We currently have a check to aid fixing
> wrong population of OPP entries for issues such as typos. This however
> causes a conflict with valid requirement where the SoC variant does
> not actually have the module present.
>=20
> So, reduce the severity of the print to a debug statement and skip
> registering that specific OPP, but continue down the list.
>=20
> Reported-by: Steve Sakoman <steve@sakoman.com>
> Reported-by: Maximilian Schwerin <mvs@tigris.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/opp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 9262a6b..de6d464 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -64,10 +64,10 @@ int __init omap_init_opp_table(struct=20
> omap_opp_def *opp_def,
>  		}
>  		oh =3D omap_hwmod_lookup(opp_def->hwmod_name);
>  		if (!oh || !oh->od) {
> -			pr_warn("%s: no hwmod or odev for %s, [%d] "
> +			pr_debug("%s: no hwmod or odev for %s, [%d] "
>  				"cannot add OPPs.\n", __func__,
>  				opp_def->hwmod_name, i);
> -			return -EINVAL;
> +			continue;
>  		}
>  		dev =3D &oh->od->pdev->dev;
> =20
> --=20
> 1.7.0.4
>=20
>=20
> --=20
> Regards,
> Nishanth Menon

Hi,

sorry my fault! This was not what I was thinking of as generic. Works as =
expected!

Thanks, m.

--=-cBy60B/KSqI83ZGU2/6i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAk9jYIkACgkQ6nqkzTWctv7wCACeIPA95YFG9Tm+gp3/E3Mffody
sW8AoIiwds81nNUyZidL00wrmJ/TmDNp
=mmRz
-----END PGP SIGNATURE-----

--=-cBy60B/KSqI83ZGU2/6i--

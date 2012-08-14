From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Date: Tue, 14 Aug 2012 15:16:19 +0300
Message-ID: <1344946579.4845.35.camel@lappyti>
References: <1344425874-28222-1-git-send-email-cmahapatra@ti.com>
	 <1344859135-4470-1-git-send-email-cmahapatra@ti.com>
	 <CAF0AtAt9SakEnavHMFXYZ2+nPXXreGcQNyXiJ7TuarRa1tATXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-sKm24bRloHoNU/qrHebS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55975 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753675Ab2HNMQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 08:16:24 -0400
Received: by lbok6 with SMTP id k6so251536lbo.23
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 05:16:22 -0700 (PDT)
In-Reply-To: <CAF0AtAt9SakEnavHMFXYZ2+nPXXreGcQNyXiJ7TuarRa1tATXA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-sKm24bRloHoNU/qrHebS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-14 at 17:33 +0530, Mahapatra, Chandrabhanu wrote:
> > +static const struct __initdata dispc_features omap2_dispc_features =3D=
 {
> > +       .hp_max                 =3D       256,
> > +       .vp_max                 =3D       255,
> > +       .sw_max                 =3D       64,
> > +       .sw_start               =3D       5,
> > +       .fp_start               =3D       15,
> > +       .bp_start               =3D       27,
> > +       .calc_scaling           =3D       dispc_ovl_calc_scaling_24xx,
> > +       .calc_core_clk          =3D       calc_core_clk_24xx,
> > +};
> > +
> > +static const struct __initdata dispc_features omap3_2_1_dispc_features=
 =3D {
> > +       .hp_max                 =3D       256,
> > +       .vp_max                 =3D       255,
> > +       .sw_max                 =3D       64,
> > +       .sw_start               =3D       5,
> > +       .fp_start               =3D       15,
> > +       .bp_start               =3D       27,
> > +       .calc_scaling           =3D       dispc_ovl_calc_scaling_34xx,
> > +       .calc_core_clk          =3D       calc_core_clk_34xx,
> > +};
> > +
> > +static const struct __initdata dispc_features omap3_3_0_dispc_features=
 =3D {
> > +       .hp_max                 =3D       4096,
> > +       .vp_max                 =3D       4095,
> > +       .sw_max                 =3D       256,
> > +       .sw_start               =3D       7,
> > +       .fp_start               =3D       19,
> > +       .bp_start               =3D       31,
> > +       .calc_scaling           =3D       dispc_ovl_calc_scaling_34xx,
> > +       .calc_core_clk          =3D       calc_core_clk_34xx,
> > +};
> > +
> > +static const struct __initdata dispc_features omap4_dispc_features =3D=
 {
> > +       .hp_max                 =3D       4096,
> > +       .vp_max                 =3D       4095,
> > +       .sw_max                 =3D       256,
> > +       .sw_start               =3D       7,
> > +       .fp_start               =3D       19,
> > +       .bp_start               =3D       31,
> > +       .calc_scaling           =3D       dispc_ovl_calc_scaling_44xx,
> > +       .calc_core_clk          =3D       calc_core_clk_44xx,
> > +};
> > +
>=20
> Here the dispc_features not only mention the omap name but also the
> revision like omap3_3_0_dispc_features which initializes data for
> OMAP3430_REV_ES3_0 and higher. May be omap34xx_rev3_0_dispc_features
> is a better name for this. For others omap44xx_dispc_features kind of
> name should be ok without revision number being mentioned. What d you
> say?

Sounds ok to me.

 Tomi


--=-sKm24bRloHoNU/qrHebS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKkGTAAoJEPo9qoy8lh7175IP/iRjyeUd5ObaqYshpVysTd8P
SBf00jwg99dBzn4YfoQElAekicvMNEPaJXyYEzAxw7609UjUy0WYIYYfzs095fnM
VC71sTGnxTnVhO4LFFYbT3S5yzSm2audg/k6DaHFiKVgSFRPfWs6uR3+kY2oxufD
efxATMlNKnX1/+5uApTUCUlaHvJM63n4EjA0abHPgK6ZjhckO2JI8lXuM86nMQah
ktSpXOFK5x+Sf7aHigjv66cjwInKGy9Jd941ztkZQFtY9bxWZXl9UzQ1ZiphDAIe
b/is540Pt/l4wZFH6aFgb7TuNXmqJzDdoy8/FxvsJJYhyOb5/sZYeYVcdhZrfKOb
JFi0k5yetR9boHtYUalfch1JGkKfaXtTwfr/LcNmM8vf1tbJDgSz4tkaC+6xhM/y
HE6MoVwkTQDkr1XGtojNvSzxtzLbnh5vSOSEFZyDJfdyVTnq2NQkaVKYWIGSjIF/
qii6FY+4KKOq47zrrkSUxg++h3uI6iXQoNAYdSyku0geUUcI775b4WC5mU8SZ6Ch
sZwNld8TRMRs/dTAMu+GPCbmV1+IU0PUSYSZIVVqIGQsWYAMJjJMWbSNw7wdkKYr
RfvVa3Ocq9fXu7t34cYHaLjgMo1r0XNbPYeq1qbwk3tXhbIGdjH5rkJd/ffisMvA
U3n7xmxiOkwkFaYS4j6x
=Pm4l
-----END PGP SIGNATURE-----

--=-sKm24bRloHoNU/qrHebS--


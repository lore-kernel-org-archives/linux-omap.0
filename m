From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] PWM: Add support for configuring polarity of PWM
Date: Tue, 24 Jul 2012 10:26:24 +0200
Message-ID: <20120724082624.GA4476@avionic-0098.mockup.avionic-design.de>
References: <1342616053-7793-1-git-send-email-avinashphilip@ti.com>
 <20120723083032.GA12868@avionic-0098.mockup.avionic-design.de>
 <500DB0CB.1000600@metafoo.de>
 <20120724065121.GA30417@avionic-0098.mockup.avionic-design.de>
 <500E5BED.6050401@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <500E5BED.6050401@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: linux-omap@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2012 at 10:25:17AM +0200, Lars-Peter Clausen wrote:
> On 07/24/2012 08:51 AM, Thierry Reding wrote:
> >=20
> > How about the following?
> >=20
> > /**
> >  * enum pwm_polarity - polarity of a PWM signal
> >  * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
> >  *   cycle, followed by a low signal for the remainder of the pulse
> >  *   period
> >  * @PWM_POLARITY_INVERSED: a low signal for the duration of the duty-
> >  *   cycle, followed by a high signal for the remainder of the pulse
> >  *   period
> >  */
> > enum pwm_polarity {
> > 	PWM_POLARITY_NORMAL,
> > 	PWM_POLARITY_INVERSED,
> > };
> >=20
>=20
> Looks fine :)

Philip: can you fold this into your patch?

Thierry

--DocE+STaALJfprDB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDlwwAAoJEN0jrNd/PrOh62cP/i77Mw0m4gmbVn8eVoSLTCvP
sGoOMu/ah++aako1tUVAmRF0tYqwzsXhgS625U3kUPL1MEsDepKP8WModFwz8VOX
XZju7gduZ9bqhFcCuV3cmyM+tHhjC0O58n1wijpMNS8xdLDmVSX2yR9fHSCpNj1M
Dep0Uw9PRj0SZgcFVtVsNOFXnbJen+3njJNR2S7RZSuRSZybdDlekTiw5Vm9Nmuy
pL1ELZhtRkN6X7z0pDbpFIWZo+UCeNMaps445gA6pcBS0aQcqyuDdeZCCzzEjJjO
0QJwsn/PGtfAsfZstPgxl1Fyf4Fg9zQ2tBqkNOwwYh0nJYH5m8Kq2XRZiPthIizz
ka6BHN9okUbbAVTRbIstFYlx6IJd1ge1kKKdjHFGuN5G49gI62dBI5QuyzFMdWwV
jwCy3UbKKv40w/KfnrQ/Ao8N8A0cWNotHQVKW36dM7YWeIa7+468ILoujKL3ie9Z
f6gPm6223R6tX7dh6MjwE9Eq87m9CaJc4j2D1i4yJ70f4/vwMO0K/yn6ubRrzYGa
rQBahj4xtQYRonu1GQhw0YfEyZmV2k5KUePNV7706LYmQ54ivsHuNF/2JTXgTasd
kI5dwzFcDkQVbdMlRgSHzcYmntFG54HE+rEUJ68NjoEMZ2zUwfPCXhWHM3jmZdPt
UCLoR8a0bUIlN1zshkMN
=j9i3
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Date: Wed, 27 Mar 2019 14:50:45 +0100
Message-ID: <20190327135045.GE5345@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
 <20190315124717.x3do5evok5syipo7@verge.net.au>
 <20190315131435.GE9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190315131435.GE9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +		if (!ret)
> > > +			timeout =3D 1;
> > > +		else
> > > +			timeout =3D 0;
> >=20
> >=20
> > nit: the following might be cleaner
> >=20
> > 		ret =3D !!timeout;
> >=20
>=20
> Other way around, perhaps,
>=20
>       timeout =3D !ret;

I saw that but didn't want to modify this patch. But yes, this is easy
enough and looks a lot better.


--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlybf7UACgkQFA3kzBSg
KbYUGA/7BMcz1G20aqZ92ejVHHeFnpHcGGpc1H8Ltdv07p4tnjcbDQDeXjfplXZl
RmBhHZegpLh2+G7DrDvMQGkL5ShRDwAQ75OO2ZRAdMYOPAKjcS+unsKf9iJVI1eB
GbOlPIzS9hbVoxtT+Rkk+4g3mkN7OPFynEza4JKxC/lGgTnosNZwAaimboVCiwRs
l00n20ZXYY5wGoGd33rlhr47A4kZ/j9RIr8wmsZ5MSOl+GP6G9gB+IryYb7jux7m
nLjElLwtQHyWcu3lz6YgOEwRsBoTdhOpaSDGze0TGGhuaRQTmQqvkiGPaqBaru1G
pTQePBso6cBfAXgZ3kXx1h3hbyan4Vn3L56kL9FcmHqmGQo/VM1g6J+OhtWLOi3y
5mEPZZefUMzUiHgB3IpTNeWfXMC5905HJKaQ1XbM9/qGW9jDCJ3sFmqEC0VVkkBZ
04n0zVMQJL0xuEzhiNYLGcvyJaFWX7b0sZNH1BGOeOOkQ1upEOaAzWMM/EGG+EGJ
nCh8/QLxhWvKvvuNSfPaX5EGGLd/6qYDFjBtJ206hdKnGVe/0OogEYMH5fcr8Ein
GeEhnpQ7wbkn/62ugZYtkakTw2PrK3Uvm+lRZgxagfddWi/Oa6cTo8ZtsC4sUGnf
m1DTK5M6iNQw2iRo0VzgTvvqqGr4w22fayvvEauu7Pp5aqZi8N0=
=BBzs
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--

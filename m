From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic
 callbacks
Date: Wed, 27 Mar 2019 14:51:14 +0100
Message-ID: <20190327135114.GF5345@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
 <20190326202005.s3ktyth42lfjirx2@porty>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326202005.s3ktyth42lfjirx2@porty>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Lengfeld <contact@stefanchrist.eu>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
> > +			       struct i2c_msg *msgs, int num)
> > +
> > +{
> > +	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, false);
> > +}
> > +
> > +static int tegra_bpmp_i2c_xfer_atomic(struct i2c_adapter *adapter,
> > +				      struct i2c_msg *msgs, int num)
> > +
>=20
> Here and between the function prototype of 'tegra_bpmp_i2c_xfer' and
> it's function body is a unneeded blank line. Nitpick.

Thanks, fixed!


--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlybf9IACgkQFA3kzBSg
KbbNzBAAjvch4rn4f/kdEFZ49DuydIgWhOBQ8vX0PTq/gepmHvRfc4AW/e0LsixM
XnPZiQQErviDLilZdEDFdXz5KnBc4c2wnymbAFwg4N8b2h7h+1cRcg21ze9wsTBr
mviw4p00Ly7XrED32o3kY0VQ97ulypjyaagbzs5w62aVoOV2FPCOysyAZh9qA4Nt
6Mz2KUiy2jkFSRdgG6VxEBLi3jkTGIGmz9GB1ZH541cwPNMG53olqllViQSmTJkL
XCI51hVf5LQdCgrYFWBY8mkje4fQuj8G/lQYsWPg+zScuQxxprhtIHq+qxqUfqul
Zf6g7MhMFKWq1QWg7aYetyUKoYWOzC3ZX1RNxKDcn0LorYiSoZeKRxmMvzHxKJgQ
D45IEYlZASsaWd5w5HSrllTfCG2fKYpQj3/Dywxr1gPNsfD9RCJeR95WgIYUXSI+
V+JnNrk97koU+EfntYwr8MQbUmoyklBfThuYPR+k2HEfGfPYVHVSVS5ZguEqC7vQ
FzaAzu/vO+d9Szzo1+8g6nl8znq6DZo76TXbCFSs8kDLpQzl6c4jT0izEd0TJvQ3
hFAxiWe2tnbmgl7f4pZlVIGkuw9/sC8V/2fy3oTXoClQCT8YyzmqdxL5iOJ4A5Yx
ANB7Ve19kReJYtZdFN/nj7tVf0JBIa6g1UeSNQDSBP08nHNn72I=
=1kMO
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

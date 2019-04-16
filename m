From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 06/12] i2c: omap: Add the master_xfer_irqless hook
Date: Tue, 16 Apr 2019 12:52:21 +0200
Message-ID: <20190416105221.c7h4ktzzu4xmdht3@ninjato>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-7-wsa+renesas@sang-engineering.com>
 <20190415220546.bvrp7jodgdq7phwg@porty>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="txtx6lpjzxgqvxdx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415220546.bvrp7jodgdq7phwg@porty>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Lengfeld <contact@stefanchrist.eu>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-omap@vger.kernel.org


--txtx6lpjzxgqvxdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> the subject line of this patch
>=20
>     i2c: omap: Add the master_xfer_irqless hook
>=20
> still contains the old name of the callback '_irqless'. It should be
> '_atomic' instead.
>=20
>=20
> On Wed, Apr 03, 2019 at 02:40:13PM +0200, Wolfram Sang wrote:
> > Add the master_xfer_irqless hook to enable i2c transactions
>=20
> Here again. It should be 'master_xfer_atomic'.

Yes, thanks, fixed!

> >  static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> > -			     struct i2c_msg *msg, int stop)
> > +			     struct i2c_msg *msg, int stop, bool polling)
>=20
> Nitpick. In the patches for the other drivers the boolean flag is called
> 'atomic' and not 'polling'.

This patch originally is not from me, so I prefer to not change it.
Also, I don't want to enforce strict naming within drivers. As long as
it is readable, I am fine with it.

> >  static const struct i2c_algorithm omap_i2c_algo =3D {
> > -	.master_xfer	=3D omap_i2c_xfer,
> > +	.master_xfer	=3D omap_i2c_xfer_irq,
> > +	.master_xfer_atomic	=3D omap_i2c_xfer_polling,
>=20
> When consistency with other drivers is a goal, the functions should be
> named like:
>=20
>     .master_xfe =3D omap_i2c_xfer,
>     .master_xfer_atomic =3D omap_i2c_xfer_atomic,
>=20
> The first without a suffix and the second with the '_atomic' suffix.

ditto.


--txtx6lpjzxgqvxdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly1s+UACgkQFA3kzBSg
Kbbbzg/6AocTzfCzOeRPB/NVFcGqaiGYqcQk7Hy7UA6lLoQpit+Chf2zJb9XD2wn
PmVDoRjkCLqX9nO6bZ7te2hayAVej50J/L7tdXWtV5icGbyQEEbAFR68Ipe+OQeB
v7fAjShyYYwkUD/VuRospLZ7z3oYB5GFeu5FvHZ4IOdKAGhlaIRkcdHQAjb3L11P
oMFCxS/WkKFeejPQChncWE0UkauM3ZT6ssE+mI55MdcK7OhG6QgTYwuYqaMK/k4E
KCehQC2KvyT1TDxkDYGCHOWhSyO0DLjPNtRh8DF1I/NWh5GfsfaHDyOKJ7e9L6xa
Y2JH4Y8pcb94B2hm831fedAuyf031gtYuZRxag3ZhfbZFGY55ubABk77lI+o6a+E
0ZJK3fMgQkZ4Iik0FFm+039vTwrcPLMZK4L2ZwreHyp7ER9kmlfxUT1Fi3ZonAcQ
gy/juds3pyE/4T515+7WD7EAdbWIt1PC9oc3LgkJaEn1vbXGu4Nbg6XJ9ImaRsXs
txDjlSClQgWBKuh76cIKR5oIhBD6vn6fzjxTN37Dwmc37lHXtC/X2qoQ3S+IcISv
0L47f1Jd53M6RVeLL1P89zH/CsmeByeqjYbNSTMnHoMEWw6g5VqaPGAfXgnbit83
3tW7UvQF0krApbKmJHZL0NCWVctO+tDmk7asjdnEn82uba3fGCg=
=v1tF
-----END PGP SIGNATURE-----

--txtx6lpjzxgqvxdx--

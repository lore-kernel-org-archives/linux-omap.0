From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/12] i2c: core: introduce atomic transfers
Date: Mon, 15 Apr 2019 14:06:11 +0200
Message-ID: <20190415120611.euidifhshkf5yqns@ninjato>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403131510.GE9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rigvuvst2m7kwesb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403131510.GE9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org


--rigvuvst2m7kwesb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 04:15:10PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 03, 2019 at 02:40:07PM +0200, Wolfram Sang wrote:
> > This series adds support for very late atomic transfers to the I2C subs=
ystem.
> > It finally reached a state which I think is ready-to-apply. This is mai=
nly
> > because of two things:
> >=20
> > a) we decided to respect the current locking scheme and to not give ato=
mic
> > transfers a priority. The code needed for that would have been either
> > incomplete or very invasive. And we cannot guarantee successful transfe=
rs
> > anyhow. See [1] for the discussion and other write-ups for design choic=
es.
> >=20
> > b) thanks to a discussion with Peter Zijlstra[2], the conditions when t=
o allow
> > atomic transfers became much clearer. The new helper i2c_in_atomic_xfer=
_mode()
> > adds readability, too.
> >=20
> > In detail, changes since RFC v2:
> >=20
> > * dropped coding style patch because already applied
> > * added new patch 1 to drop in_atomic() and have better conditions when
> >   to enter the atomic path
> > * added support to the mux-core
> > * simplified omap conversion a little
> > * added new conversions for ocores, stu300, and algo-bit/gpio
> > * typo corrections found by Simon and Stefan
> > * added tags to drivers
> > * dropped tags from core patches because that part changed too much
> >=20
> > All tested on a Renesas Lager board (R-Car H2). Sadly, the i2c-sh_mobil=
e driver
> > cannot be converted now because of other work needed first. I tested wi=
th the
> > i2c-gpio driver, though. The other driver patches are build tested. A b=
ranch
> > can be found here:
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c=
/atomic_xfer
> >=20
> > I am happy for reviews and comments. Please note if you review (especia=
lly the
> > core parts), I'd like to have a short summary of your review even if th=
ere is
> > no proposed change. Like what you did, what you think about it, etc. So=
me stuff
> > in here is subtle, so if you went through the effort to double check my
> > assumptions you should name it :)
> >=20
>=20
> Thank you!
>=20
> FWIW,
>=20
> Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> for patches 1-5,12.

Thanks for the review, Andy! May I ask you once more to tag the patches
individually so patchwork can pick them up for me?


--rigvuvst2m7kwesb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0c7MACgkQFA3kzBSg
KbaPdg/5AQODvYA/brIEzEebBWxkjKYMSE6klgfCnyxiyMGQpdbuqY8OcnA+hwI/
1R813o4sfcHaia62ssxzlPJ7Uipc5yItgMc+yX/KNGJWFmC0JJkbNsFhbEnDGho2
6OEQF/gLqXgpxrd024fb/melBhZhDzAD/BaH5zoPPJ8u8MUymeW4ft8MqnN27aYR
Ah0TRQ5CbsqOE2X8sh2laQFypFW7CJuV15vk0RAq+GvyTM/RCG71LWRqIgNv9lKk
KRdCnHbiRTyoxeApI4l45+D8jAu4ogxgMSY3B+rEd91Clk/GgiM2nydeLmuyvfYB
oueTE1K6fqTYqOOMvkhbufW5bkVQyuhgjwlN9EnnG2ZTGQ3k2Xn3a8kp4TpRbvUL
k9QgaBazdN2GngwI6Laa9ePrrVnYdqJM+qexmTX89FRMsLJOveVf/38bHLWOmEP1
TEGVCI6EiOwe6zFdZIHPZ6vWaBD5GQVPNZI3j0orbnia4MfZ2R/+8hBUpI7lj6wm
yUKdhgChaGFRPHYvbPC/dWZ1QQQknsBWi6bUyJe5fzBZvq949EUpBPlWzzWeomPt
pEi6M3foHyE3wUUH4H8Ecwla8pV6SekKEbshMZwmirF4ZamEoKTKjixNoik7uI8l
tWEg2JSw9ku4bkiDM1MiGYZHam2Ea+mMC3n4XOeCVRrlyrbWCU0=
=0JbO
-----END PGP SIGNATURE-----

--rigvuvst2m7kwesb--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/12] i2c: core: introduce atomic transfers
Date: Mon, 15 Apr 2019 14:10:52 +0200
Message-ID: <20190415121052.6fqyffpgvd4ljvzi@ninjato>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zrottfhsaoyamy5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org


--2zrottfhsaoyamy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 02:40:07PM +0200, Wolfram Sang wrote:
> This series adds support for very late atomic transfers to the I2C subsys=
tem.
> It finally reached a state which I think is ready-to-apply. This is mainly
> because of two things:
>=20
> a) we decided to respect the current locking scheme and to not give atomic
> transfers a priority. The code needed for that would have been either
> incomplete or very invasive. And we cannot guarantee successful transfers
> anyhow. See [1] for the discussion and other write-ups for design choices.
>=20
> b) thanks to a discussion with Peter Zijlstra[2], the conditions when to =
allow
> atomic transfers became much clearer. The new helper i2c_in_atomic_xfer_m=
ode()
> adds readability, too.
>=20
> In detail, changes since RFC v2:
>=20
> * dropped coding style patch because already applied
> * added new patch 1 to drop in_atomic() and have better conditions when
>   to enter the atomic path
> * added support to the mux-core
> * simplified omap conversion a little
> * added new conversions for ocores, stu300, and algo-bit/gpio
> * typo corrections found by Simon and Stefan
> * added tags to drivers
> * dropped tags from core patches because that part changed too much
>=20
> All tested on a Renesas Lager board (R-Car H2). Sadly, the i2c-sh_mobile =
driver
> cannot be converted now because of other work needed first. I tested with=
 the
> i2c-gpio driver, though. The other driver patches are build tested. A bra=
nch
> can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/a=
tomic_xfer
>=20
> I am happy for reviews and comments. Please note if you review (especiall=
y the
> core parts), I'd like to have a short summary of your review even if ther=
e is
> no proposed change. Like what you did, what you think about it, etc. Some=
 stuff
> in here is subtle, so if you went through the effort to double check my
> assumptions you should name it :)
>=20
>=20
> Finally, a big thank you and credit to Renesas for funding this work, of =
course!

No major critcism voiced here, so applied to for-next! Let's see how
this series does there...


--2zrottfhsaoyamy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0dMwACgkQFA3kzBSg
KbYY4hAApGC2YILoXcStCZBF2oIFh8J8yxZF1GCl4EzMAONs5aoXCoV2xomtv/7Y
J7F44kQYHVt65lnMAnTX+Q+EmnI5PNzmgzjQEbQYE6vIOw9TJ2RZD7S2s+F5pj6Q
PNweo+l6qO4/lPTrcOCGymgu2NW5upqjDDKdBo445aSDznSeuxT3tNxadLrINy4R
BzyClWBaV0RPBYS3Fr2wVPkIEZOznRYAEZx6En5oP9IknFXIMhwh9QYQjkPagvgA
Zsc8BzxomC3spUsgbQZ3ivJXcIcjSR12lDVTHz+Nk3YnJdOXIyXWupSmyTcslMXq
2mou//sGg5GYtD3h4Arx1XRtdF+NHgxQoKAh1oXuPjg55On84YQ32r6bs5j7rQN2
2b0wENsxIEJTvVo8XJpfPiMES6CLvwomSErO1h7SejO5djJWNFIMZiNw8u2ubFO/
mQs7O/7UcuJ0j/P3UiR3hgPXxsrMvm6OnpcLsWM18x7KhwVttKgTJbduj66+vB26
oZ7thpvQ8gp5TaMYip8EBJJ124T9YHqrt+We52ZVjxsQ4Q7cBYLiuB1tLAFxExZw
cNr5woDJVVsIw9RBoFmph+WyU0Q8eigjfAiZ3MfNnhfeWtEIMY7PPQT0Mu3WhVy2
203X/YVUBlqQwcQenxLse5bp95KKb7EKFlAvnTlnguYGWfmjPqg=
=2/JU
-----END PGP SIGNATURE-----

--2zrottfhsaoyamy5--

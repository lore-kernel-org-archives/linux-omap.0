From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Date: Mon, 22 May 2017 12:28:12 +0200
Message-ID: <20170522102812.GA1459@katana>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dani
List-Id: linux-omap@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 10:52:43AM +0100, Mark Brown wrote:
> On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
>=20
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks!

> I'm missing the rest of the series and/or the cover letter...

I meanwhile send cover letters only to all mailing lists involved. I
used to CC the individuals, too, until those messages were rejected
because the CC list grew too large :( And I really only CCed maintainers
then, no git history used.

If you were not CCed on the other patches, then you are likely not
listed as a maintainer for them?


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkivTgACgkQFA3kzBSg
KbaTdQ//X6Cza46bguYF00U+Vf7lEyTuUUuhl7rujtuXRrZTTNNJmQryjeAWa4ws
3tM5vJrZjpsdz8K1dAtyZC+Og/SsnkieakqAEPCyym0aE1Wyr3ynjL4DAgQB0nHG
AbBfLsgI2dTwBwkOJ8JwEFM9a6C7knsPdW/XyM9VfQNuC84stCSPqmzYJzxjkUjF
LtN1Wo9IRigyV9WpJXZeLUKanm5lsPvtHArK0cwWLfA3sdVo/xKYiznOJ91CkUxf
WUXe2jOihnra1lOm+HiMKtu1KlOPJ65Te5bACMtArVKIhP7bFqk8COcgh8YFzAeM
kei6j3pX8+jqoy/EELwdCGp0l9FiQSR7aeQmP2Vuc1l4l0iuafDQkjCwGqekdMjS
SUCE6GpmLTPL8x8H2PBX/YzUouHBpp5VlftFGe0t+T/KfIy6o+6KIc41qvrgfp4S
yyNF+Q85aMGI0NMlVmh6JENL4+XI17EgYfREWfL2IoeVl5URQbbN0XHxVnCZF5wY
IHMsbhUSnWb4OOakZnf9dEAKpuX9fHVhjY9dSWX1A3xrNY7SliAUPjei3sKXEiPw
20zSkk4F7qqyQd/Y5WzIOVlmmteoVlEQaCF0sqAxFILeHFX8yyl8BvDq+HPVu2Wo
7IX601Djf7wwU4+Ix1So9alvmVrM0mfW7O4eZHIEeblp18rs22Y=
=A/8Y
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

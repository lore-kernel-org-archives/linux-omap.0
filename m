From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Date: Thu, 7 Mar 2019 00:10:03 +0100
Message-ID: <20190306231003.GD7915@amd>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116132431.GE23399@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>, Arnd Bergmann <arnd@arndb.de>, Charles Keepax <ckeepax@opensource.cirrus.com>, Cory Maccarrone <darkstar6262@gmail.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, Dong Aisheng <dong.aisheng@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jin Park <jinyoungp@nvidia.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-omap@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-16 13:24:31, Lee Jones wrote:
> [...]
>=20
> > Paul Gortmaker (18):
> >   mfd: aat2870-core: Make it explicitly non-modular
> >   mfd: adp5520: Make it explicitly non-modular
> >   mfd: as3711: Make it explicitly non-modular
> >   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
> >   mfd: htc-i2cpld: Make it explicitly non-modular
> >   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
> >   mfd: rc5t583: Make it explicitly non-modular
> >   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
> >   mfd: syscon: Make it explicitly non-modular
> >   mfd: tps65090: Make it explicitly non-modular
> >   mfd: tps65910: Make it explicitly non-modular
> >   mfd: tps80031: Make it explicitly non-modular
> >   mfd: wm831x-spi: Make it explicitly non-modular
> >   mfd: wm831x-i2c: Make it explicitly non-modular
> >   mfd: wm831x-core: drop unused module infrastructure from non-modular =
code
> >   mfd: wm8350-i2c: Make it explicitly non-modular
> >   mfd: wm8350-core: drop unused module infrastructure from non-modular =
code
> >   mfd: wm8400-core: Make it explicitly non-modular
> >=20
> >  drivers/mfd/aat2870-core.c      | 40 +++------------------------------=
-------
> >  drivers/mfd/adp5520.c           | 30 +++++++-----------------------
> >  drivers/mfd/as3711.c            | 14 --------------
> >  drivers/mfd/db8500-prcmu.c      | 10 ++++------
> >  drivers/mfd/htc-i2cpld.c        | 18 +-----------------
> >  20 files changed, 41 insertions(+), 332 deletions(-)
>=20
> All applied!

Is it good idea?

We want distro kernels on ARM, too, which means people will eventually
want these as a modules, no?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAU0sACgkQMOfwapXb+vK87gCfYqDOuTU/ycnXzAkAmrnRwdxB
rzkAn1eqwcVZ9SI2Z+rhSE1L7etSgIz+
=iMdg
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--

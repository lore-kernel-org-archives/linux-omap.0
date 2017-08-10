From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next 2017-08-08 keyboard failure on Nokia N900
Date: Thu, 10 Aug 2017 19:10:34 +0200
Message-ID: <20170810171034.GA26019@amd>
References: <20170808101756.GA12922@amd>
 <20170808103444.GA18247@amd>
 <20170808111243.GA20328@amd>
 <61264d43-eda3-df9d-0c06-28611f373ce7@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61264d43-eda3-df9d-0c06-28611f373ce7@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, Julia Lawall <Julia.Lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> I tried today's linux-next. It boots on n900 (up to X), but then my
> >>> screen locks and I can't get back. Touchscreen worked, so my guess is
> >>> keyboard does not...? Ssh connection over usb still works.
> >>
> >> Confirmed, its the keyboard.
> >>
=2E..
> > [    0.682769] twl4030_madc 48070000.i2c:twl@48:madc: could not
> > request irq
> > [    0.684051] twl4030_madc: probe of 48070000.i2c:twl@48:madc failed
>=20
> I've not precisely checked it, but smth is telling me that below=20
> patch  can cause this:
>=20
> commit 78daaca78ee57dead0f4aa5ee399f0499e81cd9e
=2E..
>  int twl4030_init_irq(struct device *dev, int irq_num)
>  {
> -       static struct irq_chip  twl4030_irq_chip;
> +       struct irq_chip twl4030_irq_chip;
>=20
>=20
> but if we will look at code - it can be seen that this variable is passed=
 by reference to
> irq_set_chip_and_handler().=20
> Ops. And what will happen when twl4030_init_irq() returns ;)

Thanks, this would take me a while to figure out. I'm testing
next-..-08-10, which should have this fixed... and yes, it does.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmMk4oACgkQMOfwapXb+vJWFgCfXgm08iGewaBL9K74uu7qvUZ1
T68AnjIp1HYBCUE+yWKK6lZfJ2RT/VBC
=3TNn
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

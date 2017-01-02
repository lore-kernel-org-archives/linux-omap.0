From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 21:01:01 +0100
Message-ID: <201701022101.01341@pali>
References: <201701012054.54505@pali> <20170102084432.GA6728@pali> <20170102184945.m6maflaoihumd7nt@raspberrypi-2.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9900843.1C44kTPyt9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170102184945.m6maflaoihumd7nt@raspberrypi-2.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart9900843.1C44kTPyt9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 January 2017 19:49:45 Aaro Koskinen wrote:
> Hi,
>=20
> On Mon, Jan 02, 2017 at 09:44:32AM +0100, Pali Roh=C3=A1r wrote:
> > On Monday 02 January 2017 10:23:23 Peter Ujfalusi wrote:
> > > GPIO_182 is to select where to route the MIC line from the jack
> > > for the ECI core to handle (when the TVOUT is disabled).
> >=20
> > Yes, already figured out from schematic.
> >=20
> > > I have no idea what the
> > > gpio_178 should have been used for. It might be only needed for
> > > early protos but not in production devices?
> >=20
> > I do not know, reason why I'm asking.
>=20
> The schematic shows ECI(5:0), but only 3 are connected/used. There
> were 3 other GPIOs reserved but not used in the final product.

Are you sure that this is truth (maybe you have some information)? Or=20
you just looked at schematic and deduced this observation (as other=20
people too)?

Joerg already told us that RX51 schematic does not 100% match production=20
N900 and e.g. there is missing UART3 pins...

What we know that gpio 178 is *already* controlled and changed by=20
production Nokia kernel running on production N900 devices (as I wrote=20
in first email).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9900843.1C44kTPyt9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhqsX0ACgkQi/DJPQPkQ1JuAQCdHN5u5wXzw3gPlnhrtHH6fWAL
jVQAoMvau7z1fJbIHKyCNtTknkxTVTqn
=LDkQ
-----END PGP SIGNATURE-----

--nextPart9900843.1C44kTPyt9--

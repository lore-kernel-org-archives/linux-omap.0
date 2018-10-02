From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Date: Tue, 2 Oct 2018 09:56:29 +0200
Message-ID: <20181002075629.GB19677@amd>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928182954.25446-2-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-09-28 13:29:46, Dan Murphy wrote:
> From: Pavel Machek <pavel@ucw.cz>
>=20
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>=20
> It controls LEDs on Droid 4
> smartphone, including keyboard and screen backlights.
>=20
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
> binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [remove backlight subsystem support for now]
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

So... this driver adds support for LM3532, LM3631, LM3632, LM3633,
LM3695 and LM3697 (or it did when I signed it off).

The rest of the series does not really bring any advantages (you claim
it may add advantages in future). It takes code out of common driver
and duplicates it.

Could we take this patch, get the basic support for LM3532, LM3631,
LM3632, LM3633, LM3695 and LM3697, and then split out the drivers when
we actually gain some advantage doing so (and also when the costs are
clear)?

Thanks,

								Pavel

>  drivers/leds/Kconfig             |   8 ++
>  drivers/leds/Makefile            |   1 +
>  drivers/leds/ti-lmu-led-common.c | 138 +++++++++++++++++++++++++++++++
>  drivers/leds/ti-lmu-led-common.h |  54 ++++++++++++
>  4 files changed, 201 insertions(+)
>  create mode 100644 drivers/leds/ti-lmu-led-common.c
>  create mode 100644 drivers/leds/ti-lmu-led-common.h

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzJK0ACgkQMOfwapXb+vJPfQCeN5zfZPU7rrI6+9qKKKezKCj+
vLoAn1SVCqWQaZhDgEySYyhd3nxaxrA5
=0Ipj
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 20:42:15 +0100
Message-ID: <201702202042.15878@pali>
References: <cover.1482936802.git.hns@goldelico.com> <20170220010714.GB8358@dtor-ws> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1527656.MuGuQcp6Iy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?utf-8?q?Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org

--nextPart1527656.MuGuQcp6Iy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Nikolaus!

On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> Hi Dmitry,
>=20
> > Input driver may set resolution for given axis in units per mm (or
> > units per radian for rotational axis ABS_RX, ABS_RY, ABS_RZ), and
> > if you check the binding, you can use "touchscreen-x-mm" and
> > "touchscreen-y-mm" to specify the size of entire touch surface and
> > set resolution from it so that userspace can calculate the proper
> > scaling factor.
>=20
> How is this information exposed by the kernel to user-space? By
> scanning the DT file or tree?

Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS=20
ioctl() on input device. Look at struct input_absinfo, you should have=20
all needed information here. This is generic input interface, no DT is=20
needed.

I hope that XServer is already using it for evdev devices...

=46or whole implementation look at evtest program. That should be good=20
starting point for your userspace implementation.

While I'm watching this discussion... in my opinion kernel should just=20
invert input axes (when needed) and should not do any other=20
normalization or integer/floating-point re-calibration/re-calculation.=20
If it correctly exports minimum value, maximum value and resolution then=20
userspace can correctly re-scale input events to units which userspace=20
needs (e.g. mapping into LCD screen pixels or whatever is needed).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1527656.MuGuQcp6Iy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlirRpcACgkQi/DJPQPkQ1KlhgCfenWu7036G3+S4Lgzb8sRH8Lx
MSUAoKqCFGY13UKTeJaV+BoqlA64pxS5
=MNFb
-----END PGP SIGNATURE-----

--nextPart1527656.MuGuQcp6Iy--

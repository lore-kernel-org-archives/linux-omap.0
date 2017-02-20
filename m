From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 23:45:49 +0100
Message-ID: <201702202345.49231@pali>
References: <cover.1482936802.git.hns@goldelico.com> <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com> <15339314-8696-f603-d0da-beefe54f0653@tul.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4208919.Hg0nChBCbv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <15339314-8696-f603-d0da-beefe54f0653@tul.cz>
Sender: linux-input-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?utf-8?q?Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdeg>
List-Id: linux-omap@vger.kernel.org

--nextPart4208919.Hg0nChBCbv
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 February 2017 23:21:37 Petr Cvek wrote:
> Hi,
>=20
> Dne 20.2.2017 v 22:50 Dmitry Torokhov napsal(a):
> > On Mon, Feb 20, 2017 at 1:27 PM, H. Nikolaus Schaller
> > <hns@goldelico.com> wrote:
> >>> Am 20.02.2017 um 22:08 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> >>>=20
> >>> On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
> >>>> Hi Nikolaus!
> >>>>=20
> >>>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> >>>>> Hi Dmitry,
> >>>>>=20
> >>>>>> Input driver may set resolution for given axis in units per mm
> >>>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
> >>>>>> ABS_RZ), and if you check the binding, you can use
> >>>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size
> >>>>>> of entire touch surface and set resolution from it so that
> >>>>>> userspace can calculate the proper scaling factor.
> >>>>>=20
> >>>>> How is this information exposed by the kernel to user-space? By
> >>>>> scanning the DT file or tree?
> >>>>=20
> >>>> Set input_abs_set_res() from kernel. And in userspace call
> >>>> EVIOCGABS ioctl() on input device. Look at struct
> >>>> input_absinfo, you should have all needed information here.
> >>>> This is generic input interface, no DT is needed.
> >>>=20
> >>> Looking at kernel code... via EVIOCSABS ioctl() you can even set
> >>> resolution from userspace for specified input device.
> >>>=20
> >>> So this could be potentially used for calibrating input device
> >>> from userspace? (In case DT data will not fully match current
> >>> HW)
> >>>=20
> >>>> I hope that XServer is already using it for evdev devices...
> >>>>=20
> >>>> For whole implementation look at evtest program. That should be
> >>>> good starting point for your userspace implementation.
> >>>>=20
> >>>> While I'm watching this discussion... in my opinion kernel
> >>>> should just invert input axes (when needed)
> >>=20
> >> It is questionable why it should do that at all then.
> >=20
> > Because the task of the kernel is to provide unified view of the
> > hardware. Axis swapping and inversion is needed to that "up" is
> > always "up" and "right" is always "right".
>=20
> Actually my Xorg calibration 3x3 matrix is fine with both axis
> inverted (on TSC2046).

Yes, 3x3 matrix which represent affine transformation can code inverted=20
axis. This is IIRC what Xorg is doing.

But with information of min, max and current values plus resolution you=20
cannot code information that axes are inverted (unless you misuse fact=20
what is minimal and what maximal value). And this is what kernel=20
provides for input device.

Affine transformation supported by Xorg is "stronger" as resolution=20
provided by kernel.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4208919.Hg0nChBCbv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlircZ0ACgkQi/DJPQPkQ1JoegCePhuUAGrh81cz8cSnxEn+PARP
sIAAoKD+hIk48K8MArDfkVffaX1q8/2N
=EWUC
-----END PGP SIGNATURE-----

--nextPart4208919.Hg0nChBCbv--

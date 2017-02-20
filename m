From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 21:35:18 +0100
Message-ID: <53529A9D-E2AA-405C-A12A-716984D2CDBC@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <20170220010714.GB8358@dtor-ws> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_3076C7D0-340F-4FBE-BF31-0C222EC248F8"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <201702202042.15878@pali>
Sender: linux-input-owner@vger.kernel.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_3076C7D0-340F-4FBE-BF31-0C222EC248F8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Pali,

> Am 20.02.2017 um 20:42 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
>=20
> Hi Nikolaus!
>=20
> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>> Hi Dmitry,
>>=20
>>> Input driver may set resolution for given axis in units per mm (or
>>> units per radian for rotational axis ABS_RX, ABS_RY, ABS_RZ), and
>>> if you check the binding, you can use "touchscreen-x-mm" and
>>> "touchscreen-y-mm" to specify the size of entire touch surface and
>>> set resolution from it so that userspace can calculate the proper
>>> scaling factor.
>>=20
>> How is this information exposed by the kernel to user-space? By
>> scanning the DT file or tree?
>=20
> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
> ioctl() on input device. Look at struct input_absinfo, you should have
> all needed information here. This is generic input interface, no DT is
> needed.

This assumes that I can and want to write a graphics system myself.

>=20
> I hope that XServer is already using it for evdev devices...

No idea if it does. It is a black box for me out of our control.

>=20
> For whole implementation look at evtest program. That should be good
> starting point for your userspace implementation.

The problem I have is that *I* have no userspace implementation and
the GTA04 project does not want to enforce one. We have several =
different
ones: X11 based (LXDE and others), Qt (fb based), Replicant to name =
some.

All have the same problem to be solved once. The common denominator for
a solution are 2 lines of code in the kernel plus some DT properties
you need anyways if calibration should be automated in userland.

>=20
> While I'm watching this discussion... in my opinion kernel should just
> invert input axes (when needed) and should not do any other
> normalization or integer/floating-point re-calibration/re-calculation.
> If it correctly exports minimum value, maximum value and resolution =
then
> userspace can correctly re-scale input events to units which userspace
> needs (e.g. mapping into LCD screen pixels or whatever is needed).

It can, but afaik it does not yet. And if it does, it does it in a =
plethora
of different implementation states. That is the reason why we want to =
solve
it once for all userlands in the kernel and not rely on user-space help.

Surely, userland can do a lot of things. It could also do the whole
file system stuff (FUSE).

A more input device related example comes to my mind: userland could do
keyboard mapping completely. It would suffice if the kernel presents
some x/y coordinates or gpio-numbers for buttons and user-space could =
map.
Still there is a (pre-)mapping to Key-Codes. And yes, they are mapped a =
second
time in userland if needed, but it works sufficiently well if not done.

BR and thanks,
Nikolaus


--Apple-Mail=_3076C7D0-340F-4FBE-BF31-0C222EC248F8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq1MHAAoJEIl79TGLgAm6zQoP/3Mmh4igsM256TfpcmJDzboq
esmCr1bqJCD0qOkoGioRBSpUT1/u4bZmbkbQL7j0FLYoFZlciNo+K8ilV1fyxyxi
KaDZwiLWuexhVb1qsgPmhK+qimstoCC5w0xFwYpG7hqoWzHbppH/fb96EIn0GBNV
D0J5uylPe0M0+UbymqZbZLGSAddOm+xaItWfgvHgkF1xPMJi0BjHnxXcVbYoof/7
jNI/fPhuzPlPK3kgbQupfsy/2+w2OGUi2q5jK211kENIuiaqDfN1EHiGRvpdQCDP
+gcUtrltcU6OI+++k0Pop9PPlDW2s5gwVDLpsnOFTxoPsDCC+TenbebQEQlW86hF
8feGKF+9vGq4xGNsrlw5VgWA65Ou9g3UVRmjn9n28P/7Lm5YzXdvZJlhceCNJam4
a9zFTEFqjko+wE6SvolAihgvlErjNuHQ+lGEcUs5k+4zRLN1t9fQL60oM0o/CW6j
4QqpB8tePm5QMsp4r/SR6zqpFo2DbbwB9wkHW7eLfeHGVHe4iPVVDRCqmVcmzEC2
QMhM5VMVDMq7BI4p0a97G+zYgyBxa5ic7+D6jeCJliME7Ubv0JhtlORiBF6+KazV
j42RZTE8ckR6UxrhvyxUYmM+6hRXZS8fnExieW7Eow0G9+F/9lZEv0RUT36xRVXZ
4VcsoaulG1KC5ZccyecF
=drRa
-----END PGP SIGNATURE-----

--Apple-Mail=_3076C7D0-340F-4FBE-BF31-0C222EC248F8--

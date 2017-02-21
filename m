From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 07:49:00 +0100
Message-ID: <3217AD62-BFC8-4121-AAAE-313E109283A9@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <201702202208.50498@pali> <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com> <201702202304.22964@pali>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DF2AB3C8-D2E4-44BD-8D9F-7FCF1038037D"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201702202304.22964@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_DF2AB3C8-D2E4-44BD-8D9F-7FCF1038037D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Pali,

> Am 20.02.2017 um 23:04 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
>=20
> On Monday 20 February 2017 22:27:39 H. Nikolaus Schaller wrote:
>>> Am 20.02.2017 um 22:08 schrieb Pali Roh=C3=A1r =
<pali.rohar@gmail.com>:
>>>=20
>>> On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
>>>> While I'm watching this discussion... in my opinion kernel should
>>>> just invert input axes (when needed)
>>=20
>> It is questionable why it should do that at all then.
>>=20
>> User-Space can also easily do it. Either the driver should provide
>> raw data only or if it does pre-processing (scaling by +/-1), why
>> exclude pre-scaling by other factors?
>=20
> Via resolution property which is in that EVIOCSABS ioctl() you specify
> value which represent unit per mm. So you cannot do full rescaling =
like
> via affine transformation. Specially you cannot swap axes or invert =
it.
>=20
> As such thing is not supported by current kernel <--> userspace API it
> needs to be done in kernel.

Then, this what you asked for to be missing in the ABI and should be =
added
to clean upt the kernel drivers.

>=20
> Moreover I see that this is already handled by kernel's =
of_touchscreen.c
> code via DT properties: touchscreen-inverted-* touchscreen-swapped-x-y

Should be removed IMHO because user-space can do it equally well.
By setting the affine transform to negative values or use something
like ((0 -1) (1 0))

Or it should be processed as a generic value by the input core and =
should
not need to be implemented in every driver again and again.

If input core would handle these properties in a generic way, this patch
is no longer necessary (wrt flipping and rotation).

So please fix the input core so that it makes life of device driver =
developers
easier.

>=20
> And... I'm not sure but I think that linux exports absolute input
> devices with coordinates where point (0,0) is mapped as left upper
> corner.
>=20
>>>> and should not do any other
>>>> normalization or integer/floating-point
>>>> re-calibration/re-calculation. If it correctly exports minimum
>>>> value, maximum value and resolution then userspace can correctly
>>>> re-scale input events to units which userspace needs (e.g. mapping
>>>> into LCD screen pixels or whatever is needed).

BR and thanks,
Nikolaus

--Apple-Mail=_DF2AB3C8-D2E4-44BD-8D9F-7FCF1038037D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq+LdAAoJEIl79TGLgAm6F2IP/0O+kEBdphBYFiIbr/PLQeCy
ylqaUXB6onOtoFvWEsstY2WD1itgd+itAAZiBWdt8HXQjWWYzc+FBz5TrYFPb+kR
u3CDkHbdws7A/tI0xD+UMEwCHrn1Kvf6HFZ4od/lKVO1KMhOYUAAbJnSyr4OrVHs
kSKlfYITT8RBXtZs2ptlCS1sfVwYYp8Zs4WkV8xFWjUmgnj6fFAb2MJeNNDqx2mE
/EtfDYUJnt6TFaCLFMMn+saa/EPv95EBQk4kpbrJTa73d2uLcJzaSNxmicg3C1g9
QziAeRbWQZE5TCpMwD3GWD8N3z3U03pVk52OnE6o9lnqi89+WAQ6IYbwbP0RZvRI
++bsg8Vkf1xvxaubsrbv+WZXkW/3v3lhtz+UmIIMVg9cki3RLwN5oqmh1kkCk9CR
BPpm4eCty3kCyV71c3cwlVQK6B6+aajN3G05o23zdVeIWzjMcJsUxpn2iGtBZV1W
JJXhBbaOGQnISd5b2v8t9RHnIXCfUlii+/FMVdqe7sNDR6j2d3E+XUJslEwUXHyV
y5LXPvjx4vQeCvU+8bItH7wBOpCyVvpfA4Yq7pFuyGM24zIZrw/tphMeB2GsI3RN
AdvkhTecbQJyDna6s8a+RP78GeB3Zp/KXIrMD/Ok+bhQjGAHHDUt1RLarCExnHeS
PSG4wSmlvEj1O8Z6yfh0
=bfcB
-----END PGP SIGNATURE-----

--Apple-Mail=_DF2AB3C8-D2E4-44BD-8D9F-7FCF1038037D--

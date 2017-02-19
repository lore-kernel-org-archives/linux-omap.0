From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 13:05:25 +0100
Message-ID: <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170218225435.GA4693@amd>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 18.02.2017 um 23:54 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>=20
> On Sat 2017-02-18 20:17:09, H. Nikolaus Schaller wrote:
>>=20
>>> Am 18.02.2017 um 19:08 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>>>=20
>>>>> And I agree that kernel should _not_ attempt rescaling itself, as =
it
>>>>> would lose precision.
>>>>=20
>>>> With an almost 1:1 mapping you won't loose precision.
>>>=20
>>> How do you propose to do that?
>>=20
>> something like
>>=20
>> xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate =
Transformation Matrix"  1.00 0.00 0.00  0.00 1.00 0.00  0.00 0.00 1.00
>>=20
>> but I think it is the default of X11 if you use no coordinate =
transformation at all.
>> And having the kernel to properly scale from ADC values to screen =
coordinates.
>>=20
>=20
> No. How do you propose doing rescaling in the kernel without loosing
> precision?

I wonder how it works with your setting

xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate =
Transformation Matrix"  1.10 0.00 -0.05  0.00 1.18 -0.10  0.00 0.00 1.00

This obviously also assumes that the input events report pixel =
coordinates or you would have factors not close to 0.00 and 1.00.
It just aligns the touch with the screen, i.e. calibrates. Or your =
example was incomplete.

About loosing precision: there is already noise (jitter) in real-world =
devices so that you can't achieve subpixel precision anyways (unless =
your panel has a very low resolution). Please see my answer to Dmitry =
some mails ago.

BR and thanks,
Nikolaus


--Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqYoGAAoJEIl79TGLgAm6O+MP/2xCAvKRKen8ZX6ZylTNCgnz
BJEp+awnsICgeb6Cny2vm29ujBMSyBKR7dgPjgGFLJV8C2jLlaPjPgKuOxKMYXdl
iAi0yQoqwRR7rONWGd74aiWQHhpXmt8LSRD5trXrpA1aAC2qmpDyLeCKwkA5UskE
EzcXMh125ZsrKUtk2qHJ3a/RMWbGIlvBdlw/A7qfkwF6FedyKL7GQMoE0iV/GVcK
ynHhIzTH+3m3ajU2uZK0ZOIv/4AdNYLu+5mVmbaQt0bgSzEMBsmUW1pyx6fdqJKL
tcYBiHCRx2pLwh6tju3GzCzmv0DJrWv+UDan2DqjMMRsVsA0qhY9k6QG4F2CG5+Y
HkWxb4Je7AUAAz2kO3MMxGDErDEaqVJDajiBQLMSQDZTvJ1DOeOgHPKJUQ6pdpNF
qkXrD+8Mw658dmTx2t8brYoVY51wvadCKkidhdWMCV71P0pP2hDraMYaJm4pUasY
YMhkE8MG7dhaPY++sO0K0iJj7nEC/UNMbqvwpF3/aycXGuqt3d5GzkviMggffZ2s
70bsvIFMByiE4obsTSr2bsnk5BFO+qnva9Ry+yb2ToAkbJMdXOzIOn6rgbENpoQ9
y/sem5fjOZZgAQTfmGvbp/lL3J4mr2Wg80t3/xMepUAktPSnWnF//519EFZF5VUa
sbJJsO/EGFY6IKalSIGJ
=UPAP
-----END PGP SIGNATURE-----

--Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF--

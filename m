From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sat, 18 Feb 2017 20:17:09 +0100
Message-ID: <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_4F7BA00B-D589-44E0-8928-19071F3C6371"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170218180811.GB9377@amd>
Sender: linux-input-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_4F7BA00B-D589-44E0-8928-19071F3C6371
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 18.02.2017 um 19:08 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
>>> And I agree that kernel should _not_ attempt rescaling itself, as it
>>> would lose precision.
>>=20
>> With an almost 1:1 mapping you won't loose precision.
>=20
> How do you propose to do that?

something like

xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate =
Transformation Matrix"  1.00 0.00 0.00  0.00 1.00 0.00  0.00 0.00 1.00

but I think it is the default of X11 if you use no coordinate =
transformation at all.
And having the kernel to properly scale from ADC values to screen =
coordinates.

BR,
Nikolaus


--Apple-Mail=_4F7BA00B-D589-44E0-8928-19071F3C6371
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqJ23AAoJEIl79TGLgAm6CH0P/iM0Z/rF9pXb4SfHXbz4pVKw
yWrnNohq7Bp3X0GDdfhsWt0mlt+RQ78PTx4Kx5BXApDxzoxgHjwtR1SnqEJ9Ppvy
OUvxP2l3jFc/YLyRoDok6meMEcmyaHswhR20hVT62mOaSMMzFO7ZUun9VI/y9y8T
TBocsL8nT1tX3FX2kcnN55Fuy6AXNzGiL2Oavxci2+fN8k2oh9Fs05xoJ/d8bSgG
5ehu9/pnhFwOOV69xetrUgQppmGRewwMFaDRJS8R6mR8zIwkMalhvDYP7VeQfu1O
gvld3u3R/Wch1TssQXqY09+1MBYADbjr+g47XYxtQn5wWCUhe5P31Jvd6TGAoLo0
ykVgipyLi8Gw7DOQfk6gwLQjeYH04ITKLVWQk5UOiuzzBMTAfkoJktGOY0jvh+9k
j7pRmmOTjYRT8dWDiaicCMzvxYWexNNiCofOQ4gz9FBjyJ5aTTYotUfog++ttVy/
kdyyxSMdN8kinWPDCy1p76BsjPGG922VkUXp6oCcAo3dSsz8vsm0aNmka3i+drqR
9JROWWfoILQ996YN9HFLcD9Sc8ueDPGEYnAWUdD8bzkxhev1Q00MiTZXT161gJqx
7dme7TsnM4xxX7vyLCL385sMakAKezXRyKYpRT+YMShHfKo3hL2D2HIBVak6OC9j
WrSIi1tLVontrGaE+ut3
=XF5e
-----END PGP SIGNATURE-----

--Apple-Mail=_4F7BA00B-D589-44E0-8928-19071F3C6371--

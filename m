From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 20:31:25 +0100
Message-ID: <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
References: <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_4135E42D-093A-42E0-B624-E6DB96976C6D"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170219190547.GA17292@amd>
Sender: linux-input-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_4135E42D-093A-42E0-B624-E6DB96976C6D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 19.02.2017 um 20:05 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> Hi!
>=20
>> Hi Pavel,
>> I love discussions with you :)
>=20
> Unfortunately I can't say the same.

>=20
>>> Am 19.02.2017 um 18:15 schrieb Pavel Machek <pavel@ucw.cz>:
>>>=20
>>>=20
>>>>> Solve it properly. That means passing calibration
>>>>> data from kernel to userland.
>>>>=20
>>>> As written before, the really proper solution would be to provide =
floating
>>>> or fixed point subpixel input events. Not arbitrarily scaling up in =
kernel
>>>> and leaving downscaling to user space (where everybody can make it
>>>> worse).
>>>=20
>>> That has no advantages,
>>=20
>> It has the advantage of providing you with the full precision of raw =
data (but
>> properly scaled) so that you don't loose any bit of information. This =
is what
>> you just asked for - one or two mails before.
>=20
> Not really, right? No matter what kind of fixed point you introduce,
> you'll still loose precision.

Can you please elaborate?

My thoughts:

If the ADC has 12 bit of precision, then let's say 32 bits (16 before =
and 16
after the decimal point) of fixed point precision are not loosing =
anything
if you scale to screen coordinates (in most cases they are between 480 =
and
1280 max).

Theoretically you can loose the LSB of the 16 bits right of the decimal =
point.
This is ca. 0.000015259 pixels of precision. I don't care about this =
loss of
precision... Do you? If yes, why?

But as said I don't think we need float or fixed point for practical =
systems
at all.

>=20
>>> and floating point in kernel is hard. Also
>>> you'd either have to invent new interface, or you'd break =
touchscreen
>>> for people that already have their touchscreens calibrated.
>>=20
>> No, I don't break calibration for people using a different chip.
>=20
> So you propose your touchscreen to behave differently from all other
> touchscreens in tree?

No. I only propose that my touch screen behaves properly and in the
best way it can. If others are worse, they should also be improved at
some time.

And note that I am not making things different from others in tree, I
am making the tsc2007 right (incl. following the touchscreen bindings
which define the touchscreen size in "Pixels").

> That's just no-go.

In other words: you want to block any improvements unless your favourite
touchscreen is giving directions...

>=20
>>> Yes, that's not really proper solution, that just overengineered. =
Not
>>> worth implementing. Pass calibration data to userland.
>>=20
>> You seem to repeat yourself and just say which solution you prefer,
>> but I am missing the arguments why your solution (Pass calibration =
data
>> to userland) is right and the best one.
>> Which problems does it solve?
>=20
> All you described.

I think you are missing one problem: providing already properly scaled =
touch
values to user space.

Please look how iio is doing raw and processed data.

>=20
>> Which one does it solve better than others?
>=20
> It is not terminally ugly.

"ugly" is not a technical or scientific criterion and depends on your =
personal
perception. Do you have a better argument?

>=20
>> How can you implement it in
>> a stable and portable way?
>=20
> Easily.

Please go ahead and show code.

>=20
>> How can you make sure that all user-space GUI
>> systems can and will make use of this calibration data?
>=20
> You can't,

Exactly. Hence my proposal is superior. Because it avoids asking
the user-space to use calibration data.

>  and you don't need to.

How can you know that I don't have to? Do you know my systems and
users and what they want?

BR and thanks,
Nikolaus



--Apple-Mail=_4135E42D-093A-42E0-B624-E6DB96976C6D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqfKOAAoJEIl79TGLgAm6oxIP+wdL2ORV7dO0FrFyX6sQHHeI
EEEdMj2wyMIo+kkZ1YwAAzAq+L6HDOBzaD9xKUJbpu2Uef6g4xDAYI3IGuZcu95a
6D6kZgD/HNfdUrF7AZtgVgStH5aPRToLFWVF9rIpMmLO/CmpT6BjvlUl0fGwbUhF
xz2PNOlQqm3pKU/LzV2Sv410mgVSXkxLvybmCqNBIBeMbdxcmZ1/a1966iMcPKCh
h8ZdnePCJpl8iebMEKqJoeola+7cuhzu56YemPkYV7TTR2ENXPjZW6EuDJ/rj8Os
aZ4NiDnY67au7+OzqNNUYooJJWofI0G2vRcfAU6qPpoNazlYqDwXP0fLT2dHDxOT
9uFFOB1liIp5K+wpSbNIXKNTb8VcTcFMKqHRUuBjY1Sx/OaAkf2d/tg/pH96A70g
iIRuqeUTRWJwAvHEnHMauRwkWA9pZmEHlGgVl0/XGGMUBb1SpxYVHbEIx4QVU0ub
UjsI9GMzZZZDxc3qAtB/GRKZxESusJFp8CkuHAvpcSskQRd7M77/R6FkVspAlTM2
HStr4e4MsUz++PT5zrD/1HjZqgoB90b7xBp5CGjKxUdVWA/2kyz18500iu5LC5y4
RETZy+C+vOtNA4fEQp25RAJCjXnY8B+GChWD46SyzRZONverzeFyR2/lJeRJvi+7
hFUxFLCOKUsI7Fke4mWa
=lqWV
-----END PGP SIGNATURE-----

--Apple-Mail=_4135E42D-093A-42E0-B624-E6DB96976C6D--

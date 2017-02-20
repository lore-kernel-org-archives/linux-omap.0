From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 17:50:01 +0100
Message-ID: <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com>
References: <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com> <20170219221930.GA1568@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_03F07CC6-17F3-4F3B-8503-AB16FB19ABE6"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219221930.GA1568@amd>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_03F07CC6-17F3-4F3B-8503-AB16FB19ABE6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 19.02.2017 um 23:19 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>=20
> hi!
>=20
>>>> But as said I don't think we need float or fixed point for =
practical systems
>>>> at all.
>>>=20
>>> So you are going to loose precision. And if userspace decides to
>>> calibrate it slightly differently from kernel, lost precision will
>>> matter.
>>=20
>> Really?
>=20
> Really.
>=20
>> Example:
>>=20
>> ADC values go 100 .. 3995 (i.e. touch margin is 100 steps in =
pre-calibration)
>>=20
>> This is scaled to let's say 0..640.
>=20
> Ok. Now userspace realizes that kernel alignemnt is off, and it would
> want to scale it to 1..642.

Screen coordinates are still 0..639.

> That will mean that single pixel will be
> inaccessible, right?

Yes, that can happen if the additional user-space scale is > 1.0.

As long as it is small (I expect <1.01 =3D 1% error in scale) it is
barely noticeable.

Therefore, I asked before: how big in pixels is your finger or stylus?
Does this effect matter?

A resistive touch is a man-machine-interface where people press buttons =
of at
least 12x12 pixels size (or they are no longer visually recognizable).

A resistive touch is not intended to be a high-precision measurement =
instrument.

So the discussion boils down to "what gives the better usability?":
a) getting rid of the nasty user-space calibration step (and plethora of =
different tools)
b) getting highest theoretical precision which has a low practical =
relevance

I am in favor of a). Like most users we ask. A minority is in favor of =
b).
Since we don't exclude b) users from reconfiguring their system to get =
it done
as they like. I think this is the best we can achieve.

>=20
>>> No. You have to design interface such that they _can_ be improved, =
and
>>> what you propose does not work that way.
>>=20
>> It works. Please do real world tests...
>=20
> You do a real world test on N900, and propose upgrade path.

I have no N900 running. But since it uses a tsc2004/5 controller which =
seems
to be quite similar, you can likely copy&paste some code or add the =
algorithm:

ABS_X =3D (touchscreen-size-x * (adc_x - adc_min_x)) / (adc_max_x - =
adc_min_x)

Thats it.

If you set touchscreen-size-x =3D (adc_max_x - adc_min_x) you get =
maximum precision
you can achieve with integer arithmetic. And if you set adc_min_x =3D 0 =
your
user-space gets what it would have got before adding such a formula and =
then you
can and must do calibration there.

Taking this as the defaults if none of the new properties is specified, =
makes
the scaling feature completely disappear. And I don't care about 2 =
additional
subtractions, one multiplication and one division per axis.

So the upgrade path is:
1. introduce new optional properties, parse and store them in the struct
2. set defaults for the optional properties as described above
3. add the formula to the code (1 line for each axis)
4. deploy - nobody will notice
5. update the DT and remove user-space calibration - people will be =
happy
   that they do not have to calibrate first any more

>=20
>>> Yes. I want to prevent you from pushing crap into the kernel.
>>=20
>> Crap? Well, we have discussed this driver for months here on the list =
and
>> after a lot of improvements we came up to v9.
>>=20
>> And you still think it is crap and none of the other reviewers has =
noticed?
>=20
> I'm pretty sure you will not be able to push calibration into kernel.

>=20
>>> Userspace has to know how to do the calibration _anyway_ (for
>>> other hardware),
>>=20
>> What for? I do not understand which other hardware you are talking =
about.
>>=20
>> On our devices there is only one touch glued to the panel and that =
one
>> has to be calibrated. Ideally before the user gets the device into =
his
>> hands =3D> precalibration...
>>=20
>> If you connect a digitizer, then that one has to be calibrated of =
course,
>> but it is not glued onto the display panel. Hence it is a different
>> issue.
>=20
> It is actually same issue. One kernel interface should work for all
> the touchscreens.

Do we propose a different kernel interface? We propose to still use =
input events.
There is no change at all here.

BR and thanks,
Nikolaus


--Apple-Mail=_03F07CC6-17F3-4F3B-8503-AB16FB19ABE6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqx45AAoJEIl79TGLgAm6gyAQAIoNUMD2py2bLgPwjTtjaYNP
4MEOgnAlQ2S7tbW9WbbEqTU5BrTDEPBFf47CVfPFFN/KhDLCjPr0jOCcfnYDqUnj
0JQBB/XcsGmpyfWQaS8lrAAoiVhZm/pGYoO0y+lfKxVt3sKjJjl7InTjvwmEfWw1
N8CZ2xkc/PzN08llUfQlt7K2Ov0w5EMngce+YyKpZ+APDjaNblcHJe60oVVBj/HP
KFHfB/Nw9vIoni3rpBy6gcBuJyJVLGInE/xZOqu2CI2cZUqb8xuYjPUjnRy+d7xs
W2wAPbrqKLPi3Ux8rSRNtY0P1gIACrp19BfkRJVkBavc5FJ664WM0diNh7Xag2NR
WA1ycxgPvO/ss6ArokkuBYJxn6PmDHDXDegU0zhSrLTi0DHETsTNHzkbAOmLUCC1
9sylsbjcxLFdwH6yjVIkh7FzZ4B0+C/AdlTr5xKfx06A32vGt8P9k6Tz4/814yWn
rkScQR5B8srpwPFf5ppZYIEra2Auhgy4RgY+FTO9Hc0U1IDQfMqpg30kSYNEN3Dw
IwxRzzAVGIgRwpCncqOVy2NE7Abi0MlRRu09VxIx/i+LIL/8jDrEhY3oQSN9rCSD
UvR408Jwx4KE2vpZFzm4yiru8BKNMkzTOOl5qdLdrGQ6/y2fZB6tYcTce/ObgOoJ
aZC92Oz4tRNo1ZuPrKB+
=+d6N
-----END PGP SIGNATURE-----

--Apple-Mail=_03F07CC6-17F3-4F3B-8503-AB16FB19ABE6--

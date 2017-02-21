From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 07:42:17 +0100
Message-ID: <4BA8DA1B-D6CB-4D38-AAD6-3B1CF217E521@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <201702202207.38582@pali> <A77657DA-BFF3-4A4E-9302-047B77072F3A@goldelico.com> <201702202254.35023@pali>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_01A4F1EA-E962-4961-9E2A-885960C56312"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201702202254.35023@pali>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_01A4F1EA-E962-4961-9E2A-885960C56312
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Pali,

> Am 20.02.2017 um 22:54 schrieb Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> On Monday 20 February 2017 22:24:31 H. Nikolaus Schaller wrote:
>> Hi Pali,
>>=20
>>> Am 20.02.2017 um 22:07 schrieb Pali Roh=C3=A1r =
<pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>=20
>>> On Monday 20 February 2017 21:35:18 H. Nikolaus Schaller wrote:
>>>> Hi Pali,
>>>>=20
>>>>> Am 20.02.2017 um 20:42 schrieb Pali Roh=C3=A1r =
<pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>>>=20
>>>>> Hi Nikolaus!
>>>>>=20
>>>>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>>>>>> Hi Dmitry,
>>>>>>=20
>>>>>>> Input driver may set resolution for given axis in units per mm
>>>>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
>>>>>>> ABS_RZ), and if you check the binding, you can use
>>>>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size
>>>>>>> of entire touch surface and set resolution from it so that
>>>>>>> userspace can calculate the proper scaling factor.
>>>>>>=20
>>>>>> How is this information exposed by the kernel to user-space? By
>>>>>> scanning the DT file or tree?
>>>>>=20
>>>>> Set input_abs_set_res() from kernel. And in userspace call
>>>>> EVIOCGABS ioctl() on input device. Look at struct input_absinfo,
>>>>> you should have all needed information here. This is generic
>>>>> input interface, no DT is needed.
>>>>=20
>>>> This assumes that I can and want to write a graphics system
>>>> myself.
>>>=20
>>> Not only. There are already existing graphics systems. And you need
>>> to provide needed information from kernel, so they can start using
>>> it.
>>>=20
>>> So input_abs_set_res() is needed to use in your kernel driver.
>>=20
>> I didn't know about this feature and obviously nobody else has
>> implemented it in the tsc2007 driver.
>=20
> So... before doing other things, can you deeply look at it and check =
if
> it really fixes this problem? Because I think that yes.
>=20
> You can probably set it from DT and in your DT file you can have =
stored
> screen size (or resolution factor).
>=20
> Also for testing, you can set it even via userspace (ioctl which I =
wrote
> in previous email).

Interesting thing. It does not seem to be well known because nobody else
brought it up during several months of lenghty discussions.

I have seen it is in use for scaling topics, e.g. =
https://lkml.org/lkml/2015/7/9/749

>=20
>>>> And if it does, it does it in a
>>>> plethora of different implementation states. That is the reason
>>>> why we want to solve it once for all userlands in the kernel and
>>>> not rely on user-space help.
>>>=20
>>> For me this looks like "we are going to fix userspace bugs in
>>> kernel".
>>=20
>> Such things are system bugs and it is neither necessarily a userspace
>> or kernel bug.
>=20
> In case kernel defines stable API/ABI and correctly provides =
information
> via that API/ABI and application does not work correctly, then I would
> say it is bug in application. Not in kernel.

So a kernel can simply add a new interface and declare bugs for =
userland?

>=20
> We can say that some kernel API/ABI is wrong too. And in this case it
> could be bug in kernel.
>=20
> So is current stable kernel API/ABI for input device wrong? I do not
> thing.

Difficult to judge because there is scarce documentation of this.

> But if you think that yes, please show us what exactly and we can
> start discussing how to fix such problem which you see/have. I know =
that
> no application is without bugs, but in my opinion problem which you =
are
> describing is already solved and defined by current stable kernel ABI.
>=20
>>> Really! Not a good idea. Plus I still see this as abusing kernel
>>> API/ABI as resolution should be handled differently as you are
>>> proposing.
>>=20
>> I don't understand what you say here. Where are we abusing kernel
>> API/ABI?
>=20
> I mean that we already have stable API/ABI how to export size of input
> screen from kernel to userspace. And you want to rescale event data
> directly in kernel to workaround problem of screen size. So I think =
this
> is abusing API/ABI as kernel already have API for it.

BR and thanks,
Nikolaus


--Apple-Mail=_01A4F1EA-E962-4961-9E2A-885960C56312
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq+FKAAoJEIl79TGLgAm6u1gP/iaDqZQ/zwdzk7p/LijVafq6
ULuJYYnDzeSMngu58/qTKMC3yOgyPED5O2rRMIU3h/p5TdQsLsav4UbaL/xnsLQ/
nWdn7olw4eYB30kT6huB1CHcDLEOpfvQSzCiwzd3z+KMLxbej6cJ1sx7NFlBV1Ht
CCbr05BS8IBMPvzXQCPEqgWUZhT1igvhesULLIGrSQ6pMfWEZDn5aukWRWONJwhm
EUeRo6zWqkUbR33hrzO1QVO/EJg67P2Zb3Q9cxUxx/TDVt4drZ77ThizOwIn75mO
mqNgxDA7bpJ9vnxz+EGLRZVAkvuyOSqZPVNjR9NviAOhQcdXtRl5RjSSqGPgrmbC
A9DklITwSq5eUhGmEe7HIFFF5ZoxV1heq3bXyjnTykV8Lihd9OsF3RPraAFFzSOu
RjZm4RlwlKAPgZGo6YrUXLd+NzzL1tqbYYpnzNEYrQzStMHNxJLaDSnYOyEIvkkm
1BJenHEByQEee0yhjf1NFjYVSSrnADEfG1ikr9ld111s5+aOfS9gJVps2HmKxHEw
f3OtKOWKMHOsVxaqtsX1CXUHEiJcQGNUX1tjWxiB35Px3eWcuoWZRPuXjD4TZ6ce
9yOobPfbJTPU8dKoeeoU3JU8Vkx14oSnouIVD0RNG16CtEcuUjpAN5aQaNDhcbi2
CcZmHR6ExHxW0ubH7GGD
=qoG7
-----END PGP SIGNATURE-----

--Apple-Mail=_01A4F1EA-E962-4961-9E2A-885960C56312--

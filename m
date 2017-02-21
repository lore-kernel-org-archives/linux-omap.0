From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 08:14:09 +0100
Message-ID: <A41872A2-F095-47F8-B122-FFAE430B0D7F@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <20170220010714.GB8358@dtor-ws> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201702202042.15878@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Pali,

> Am 20.02.2017 um 20:42 schrieb Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
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
> Set input_abs_set_res() from kernel.

I can't find this function defined anywhere but used in 101 LOC.
LXR doesn't know it either: =
http://lxr.free-electrons.com/ident?i=3Dinput_abs_set_res

What is going on here?

> And in userspace call EVIOCGABS
> ioctl() on input device. Look at struct input_absinfo, you should have
> all needed information here. This is generic input interface, no DT is
> needed.

Ok, if this is not set by a driver it is indeed a driver bug.

But we have to define it's value in DT because the tsc2007 does not know
anything about the panel dimensions.

IMHO something that should be done by generic of_touchscreen.c

If of_touchscreen would simply pass the touchscreen-size parameters
to input_abs_set_res() and the bindings would define it to be units/mm
it might have saved us all a lot of work and discussion.

>=20
> I hope that XServer is already using it for evdev devices...
>=20
> For whole implementation look at evtest program. That should be good
> starting point for your userspace implementation.
>=20
> While I'm watching this discussion... in my opinion kernel should just
> invert input axes (when needed) and should not do any other
> normalization or integer/floating-point re-calibration/re-calculation.
> If it correctly exports minimum value, maximum value and resolution =
then
> userspace can correctly re-scale input events to units which userspace
> needs (e.g. mapping into LCD screen pixels or whatever is needed).

BR and thanks,
Nikolaus


--Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq+jCAAoJEIl79TGLgAm6oLEQAIKq8AY89cWAIJrRNy2H+rqG
SHz5Aw7eYmXDbcVp9wubECAJWdIyoZGzGlHScnmgyK8R4RJXG6wa1UVMR0mAIqk3
zE9cBxnEkEVFyL+d+50Bt5WaolFiyGBJKWn/IeLz1Bxv5gEknqoH5J/A9pjroW0U
JlZi3uHhG1pUioLEs7SfuDrl3rHrXP5GewJhzk3jSoSq0xtBPtr9ArlwVYNVpC03
WAqpFdQdIRd99nEEf2fZ/DMKsXiFELQvf+rbmJcDQmH4WE39Iaq9iwLJLGkjwb+t
v4H5cNKCmKKrKpLjDrYSIrw6M9gApOavICP3kfBKzztALxdFWnp8rY0+89gYumVc
wqYfFJJsf1hAnMeYLln/zxVP3DGk5UQnaOeu10bLB0gHU11nSc+9cH0rAGy1fcq5
OaG9FiaSXg5t9nV8lB8hUpAQnlhEp0GeMsMuaVx2kydjvwUfq62Udr/6RkfT5B10
E5PLCj5dhbtl0HSPnOZ7/OPQcGqSKz/4DWfp+Nxfq8lgTCUuCAELeln5T5JGqbYU
+vL3irsXjUFMKopKosLeqM0FBc4QNvK+TUKdV7heFO6fiADCX/OZMKzxd1K2J9dk
q6tSpGtB+K8HYEIEk9LThTYRgWsRjIzgv8NKGADr+6IU7JMKqE9Z3Rh2oi5Wd2Bt
gyDZ+paoXp37jRla9+1o
=AdSb
-----END PGP SIGNATURE-----

--Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

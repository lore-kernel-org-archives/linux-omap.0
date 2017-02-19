From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 23:01:20 +0100
Message-ID: <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com>
References: <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_5D5C2A45-7CE9-4086-AAA4-5C6A6DAF0CCE"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219205708.GA9641@amd>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_5D5C2A45-7CE9-4086-AAA4-5C6A6DAF0CCE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 19.02.2017 um 21:57 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>=20
> Hi!
>=20
>=20
>> But as said I don't think we need float or fixed point for practical =
systems
>> at all.
>=20
> So you are going to loose precision. And if userspace decides to
> calibrate it slightly differently from kernel, lost precision will
> matter.

Really?

Example:

ADC values go 100 .. 3995 (i.e. touch margin is 100 steps in =
pre-calibration)

This is scaled to let's say 0..640.

Now you find your touch is misaligned by 1% which is 6.4 pixels but =
barely
noticeable on a 5cm screen (1% is 0.5mm).

So you simply subtract 6 from all coordinates and the screen is aligned =
again.
Does the 0.4 pixel deviation in precision (=3D 0.2mm) matter?

If you do this scaling from ADC range 0..4095 to 0..640 in user-space, =
you will
find that you have to subtract 59 from the ADC values and then scale by =
0.16431.
The result will be almost the same and deviate in the micrometer range. =
How big
is your stylus or finger?

We learn: a real world touch screen is not a high precision instrument.

>=20
>>>>> and floating point in kernel is hard. Also
>>>>> you'd either have to invent new interface, or you'd break =
touchscreen
>>>>> for people that already have their touchscreens calibrated.
>>>>=20
>>>> No, I don't break calibration for people using a different chip.
>>>=20
>>> So you propose your touchscreen to behave differently from all other
>>> touchscreens in tree?
>>=20
>> No. I only propose that my touch screen behaves properly and in the
>> best way it can. If others are worse, they should also be improved at
>> some time.
>=20
> Different from all other drivers. Read: broken.

If something differs from requirements or a spec, then it is broken.

Not if it differs from other drivers (implementations). They may be =
broken
as well or follow different requirements.

Note:
1. the touch screen bindings do ask to scale to screen size (please read
=
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/inp=
ut/touchscreen/touchscreen.txt )

2. if you don't use these features the driver behaves exactly as it was
before by using defaults and like other drivers which do (not yet) have =
it

>=20
> No. You have to design interface such that they _can_ be improved, and
> what you propose does not work that way.

It works. Please do real world tests...

>=20
>> And note that I am not making things different from others in tree, I
>> am making the tsc2007 right (incl. following the touchscreen bindings
>> which define the touchscreen size in "Pixels").
>=20
> Your touch screen is not in any way special, so it has to behave in
> the same way others do.

It does. Plus some new features which are missing...

>=20
>>> That's just no-go.
>>=20
>> In other words: you want to block any improvements unless your =
favourite
>> touchscreen is giving directions...
>=20
> Yes. I want to prevent you from pushing crap into the kernel.

Crap? Well, we have discussed this driver for months here on the list =
and
after a lot of improvements we came up to v9.

And you still think it is crap and none of the other reviewers has =
noticed?

>=20
> If you want to improve it in reasonable way, you know what to do.
>=20
>>>> You seem to repeat yourself and just say which solution you prefer,
>>>> but I am missing the arguments why your solution (Pass calibration =
data
>>>> to userland) is right and the best one.
>>>> Which problems does it solve?
>>>=20
>>> All you described.
>>=20
>> I think you are missing one problem: providing already properly =
scaled touch
>> values to user space.
>=20
> I'm not.

You are. Because you said: "All you described." And I had described that =
as well.

So you were either wrong before or now.

> Userspace has to know how to do the calibration _anyway_ (for
> other hardware),

What for? I do not understand which other hardware you are talking =
about.

On our devices there is only one touch glued to the panel and that one
has to be calibrated. Ideally before the user gets the device into his
hands =3D> precalibration...

If you connect a digitizer, then that one has to be calibrated of =
course,
but it is not glued onto the display panel. Hence it is a different =
issue.

Please describe the use case / scenario you are thinking of.

> so giving scaled values to userspace is useless.

This is another example why I love to discuss with you :)

You are so wonderful in ignoring my explanations during the past 20 =
mails
where I described exactly and in detail why it is useful for me, for
others, for users of the GTA04 for the upcoming Pyra device... So at
least 2000 or more persons.

One daily user of these devices and kernel contributor already had =
commented his view.

IMHO, only Pavel Machek is thinking it is useless. Therefore he =
concludes it must be
useless for everybody else as well.

>=20
>>>> How can you implement it in
>>>> a stable and portable way?
>>>=20
>>> Easily.
>>=20
>> Please go ahead and show code.
>=20
> You don't get to tell me what to do, unless you pay me.

Same for me.

But: you get our contributions for free. Unpaid work, we did put into =
developing
these patches for the benefit of mankind.

>=20
> You want to break kernel, you do coding. Or pay someone else,
> preferably someone who knows how to design kernel code.

Ah, so that's the way the wind is blowing...

You are trying to block community contributions to get a paid job by =
pretending to do
it better :)

This is a quite clever attempt to ruin the open source, volunteer and =
community idea.

It is defined as "building from and giving back to the community". We =
could easily run
our own fork of Linux and ignore upstreaming, but I believe that we =
should give back
something to those who have developed the other parts of Linux we simply =
use. And you
want to exclude us from this? Nonono.

It is really funny to discuss with you and I can still learn how to work =
around really
answering questions, accepting that other people have different =
requirements and ignoring
technical arguments and answers given to form a big picture.

So just derailing this discussion because you want to be paid is not at =
all fair.
But I can withstand this.

Please give me convincing technical arguments (which include our =
requirements and not
only yours) like other reviewers do and we will change code.

BR and thanks,
Nikolaus


--Apple-Mail=_5D5C2A45-7CE9-4086-AAA4-5C6A6DAF0CCE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqhWxAAoJEIl79TGLgAm6cG0P/1uo1dP1aWnOpcSQCyXMmzO1
x+RfDqdaF6nut1QinjvCdRYzImVy+ydx0rIJMxb6m2Lp6160xVbt13EATMF/ZKDM
cQ6Erfm/bcvgd5J0WI8hNL+h3QfP1kxG5rOeWiAMhgY27ACoZ6XYQ7Weo0m1YLCf
vR4kOE9/7+Aic6SOxHmNuTIHQC0Eeb7rLfgbCb5B8pHnFLofM5V2+QfP+cQPcy9u
0jronPX4ournN7FmvqK093JqHhG2QvTxxgSuyaS/4aauNQa/Zws3vlgoIRE/tpVr
92FxeQ4XMclfRVEwZc9orCbaGNMjeHvlt86Q62vQdXKcNkpgy4tB8Eod7m59XcKx
vgxO2+7cibtozV40uoomVMsgcnTzV5ohuC71bh/DdwCFuBaIN72XHgqBU827F8so
YK8234POqFVgFDuWxGxJOBxOHqwuc9z4tkcsakWxqa4mDjuOCORAiKuvpWQ8jsi7
/vcK2shoI2ezRwz1b4kHOIK8R1U9O8+zJPpm41RLZeycOLk1Kk0y6vSL0q2rnhrT
e9pxgbnG+HD3AX84d0uIZjwKT+F3eXdpM/4/OJaD4TMMSnCuZGjW+S+kfyZSS7UN
fvukIA48vIRS6RjdWqlUTA7wVYRP06eOBQKzcrzwx1x445dlXod4mXiZNsvus2uH
6kKc0ywec5R5NUX+qod/
=9WZf
-----END PGP SIGNATURE-----

--Apple-Mail=_5D5C2A45-7CE9-4086-AAA4-5C6A6DAF0CCE--

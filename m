From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 09:29:53 +0100
Message-ID: <EABA13E3-05E4-4A7B-A84D-033BB8FBDE28@goldelico.com>
References: <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com> <20170219221930.GA1568@amd> <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com> <e3dd020e-8590-6e65-9151-b5f1492debcb@tul.cz>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e3dd020e-8590-6e65-9151-b5f1492debcb-qphu/3gb4gc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Han
List-Id: linux-omap@vger.kernel.org

Hi Petr and all,

> Am 20.02.2017 um 23:26 schrieb Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>:
>=20
> Hi
>=20
> Dne 20.2.2017 v 17:50 H. Nikolaus Schaller napsal(a):
>> Hi Pavel,
>>=20
>>> Am 19.02.2017 um 23:19 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>>>=20
>>> hi!
>>>=20
>>>>>> But as said I don't think we need float or fixed point for =
practical systems
>>>>>> at all.
>>>>>=20
>>>>> So you are going to loose precision. And if userspace decides to
>>>>> calibrate it slightly differently from kernel, lost precision will
>>>>> matter.
>>>>=20
>>>> Really?
>>>=20
>>> Really.
>>>=20
>>>> Example:
>>>>=20
>>>> ADC values go 100 .. 3995 (i.e. touch margin is 100 steps in =
pre-calibration)
>>>>=20
>>>> This is scaled to let's say 0..640.
>>>=20
>>> Ok. Now userspace realizes that kernel alignemnt is off, and it =
would
>>> want to scale it to 1..642.
>>=20
>> Screen coordinates are still 0..639.
>>=20
>>> That will mean that single pixel will be
>>> inaccessible, right?
>>=20
>> Yes, that can happen if the additional user-space scale is > 1.0.
>>=20
>> As long as it is small (I expect <1.01 =3D 1% error in scale) it is
>> barely noticeable.
>>=20
>> Therefore, I asked before: how big in pixels is your finger or =
stylus?
>> Does this effect matter?
>>=20
>> A resistive touch is a man-machine-interface where people press =
buttons of at
>> least 12x12 pixels size (or they are no longer visually =
recognizable).
>=20
> Smallest kernel font is 4x6 (i think) and I'm regularly using 8x8. I =
would like
> to be able to select a single letter in the console.

So you probably have exceptionally good eyes and reading a terminal on a =
touch
screen is not a typical use case (except for us hard-core programmers).

Anyways, if there is only a single pixel is not accessible due do =
rescaling and integer
truncation effects (which is what Pavel complained) you can still select =
single letters
in a 4x6 font.

---

So, let's close commenting this patch here since in my opinion =
everything is said
and the maintainers have decided not to accept it.

I hope that I have not forgotten anyone to answer.

Thank you very much to all participants for this discussion, because it =
was
really enlightening to me and contains a lot of new perspectives.

BR and thanks,
Nikolaus=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

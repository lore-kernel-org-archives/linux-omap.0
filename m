From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v3 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Fri, 30 Sep 2016 18:36:47 +0200
Message-ID: <BB701067-29E9-4491-BEB5-AD0EBE89A28A@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com> <CA+Ot1Owa_evu62LJpH+TdUkLWd0n+0Dm30Q1-5KFJ6w_UBPfQQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+Ot1Owa_evu62LJpH+TdUkLWd0n+0Dm30Q1-5KFJ6w_UBPfQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Christ,

> Am 30.09.2016 um 18:23 schrieb Christ van Willegen =
<cvwillegen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> Hi,
>=20
> I saw this earlier, but didn't think it important to mention, but:
>=20
>=20
> On Fri, Sep 23, 2016 at 2:41 PM, H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>=20
>> diff --git a/drivers/input/touchscreen/tsc2007.c =
b/drivers/input/touchscreen/tsc2007.c
>> index 5d0cd51..9a11509 100644
>> --- a/drivers/input/touchscreen/tsc2007.c
>> +++ b/drivers/input/touchscreen/tsc2007.c
>=20
>> +                       /* scale ADC values to desired output range =
*/
>> +                       sx =3D (ts->prop.max_x * (tc.x - ts->min_x))
>> +                               / (ts->max_x - ts->min_x);
>> +                       sy =3D (ts->prop.max_y * (tc.y - ts->min_y))
>> +                               / (ts->max_y - ts->min_y);
>> +                       rt =3D (input->absinfo[ABS_PRESSURE].maximum =
* rt) /
>> +                               ts->max_rt;
>=20
> If ts->max_rt is zero, or ts->max_x =3D=3D ts->min_x, or ts->max_y =3D=3D=

> ts->min_y, these yield a division by zero error.

Ah, that is a good observation!

>=20
> Ofcourse, this is under control of the DT-maintainer(s) of the device
> (if I'm not mistaking)

Yes, the DT should be designed properly.

> , but throwing an error on DT parse if (one of)
> these condition(s) is met yields better info to the DT-maintainer than
> a /0 error...

Yes, but I wonder how likely it is to happen at all.

In an case there is an indicative message (either /0 or an explaining =
one) in
the boot log which goes away as soon as it has been fixed.

This is already better than in many other cases where things simply fail =
without
any message...

So I would weight the likelihood of happening vs. the additional code
to check every time.

>=20
> If you (or others) agree, could you add this to the patch?

If maintainers request, I can easily add it. But personally I do not see
it as absolutely necessary.

BR and many thanks,
Nikolaus

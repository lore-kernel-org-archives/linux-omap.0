From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sat, 28 Jan 2017 22:44:35 +0100
Message-ID: <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170128193342.GB38136@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr Cvek <petr.cve>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

> Am 28.01.2017 um 20:33 schrieb Dmitry Torokhov =
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> Hi Nikolaus,
>=20
> On Wed, Dec 28, 2016 at 03:53:16PM +0100, H. Nikolaus Schaller wrote:
>> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
>> introduced common DT bindings for touchscreens [1] and a helper =
function to
>> parse the DT.
>>=20
>> commit ed7c9870c9bc ("Input: of_touchscreen - add support for =
inverted / swapped axes")
>> added another helper for parsing axis inversion and swapping
>> and applying them to x and y coordinates.
>>=20
>> Both helpers have been integrated to accommodate any orientation of =
the
>> touch panel in relation to the LCD.
>>=20
>> A new feature is to introduce scaling the min/max ADC values to the =
screen
>> size.
>>=20
>> This makes it possible to pre-calibrate the touch so that is (almost)
>> exactly matches the LCD pixel coordinates it is glued onto. This =
allows to
>> well enough operate the touch before a user space calibration step =
can
>> improve the precision.
>=20
> I question whether doing scaling in kernel is really right solution.

Since lower left corner does not exactly report [0 0] and upper right =
corner
does not report [4095 4095] from the ADC we need offset and steepness =
correction
of the ADC values.

This steepness is the scaling that must happen in kernel and I don't =
understand
why you want to propagate this ADC errors to user-space by avoiding =
scaling.

Let me iterate what we want to achieve:
* use new common bindings
* offset and steepness calibration of the ADC (called pre-calibration).
  This makes a real device much more reliable to operate with factory =
installed
  scaling factors.
* flipping and rotation

(note that touch pixel to LCD pixel scaling is not explicitly on this =
list!)

Now to achieve the ADC pre-calibration we must calculate

	x' =3D (x - ti,min-x) / (ti,max-x-ti,min-x) giving a rante from =
0.0 ... 1.0

This is scaled up to what is defined by touchscreen-size-x, i.e.

	x' =3D (touchscreen-size-x * (x - ti,min-x)) / =
(ti,max-x-ti,min-x)

How do you want to avoid this scaling to take place? It happens =
automatically.
It is not even an additional line of code. And is necessary for =
compensating ADC
offsets and steepness.

So the only way to avoid the scaling option is to eliminate the =
precalibration/ADC
compensation which is essential for a device which has no means to =
properly
calibrate before operating the device through touch.

The other option would be to avoid common bindings and set

	touchscreen-size-x =3D (ti,max-x-ti,min-x)

This is heavily dependent on specific ADC offsets forwarded to =
user-space.
IMHO the worst we can do (and the current tsc2007 driver does it that =
way!).

>=20
> Why do you want this?

It seems that you assume that we want to enforce 1:1 scaling between =
touch pixels
and LCD pixels and have designed code to achieve exactly that.

This is not the case. It is just a byproduct that you can do it.

And since it is easier to understand we have made the examples this way.

> If your touch resolution is lower than your screen
> then it might be useful, but if it is lower then you are losing data
> that can be very helpful for gesture recognition, and I hope you =
design
> your userspace so it can handle not only "bad" hardware, but "good" as
> well. And even with "bad" there are a lot of tricks that can be done =
to
> get "better" touch position in userspace.

You can just *choose* DT parameters touchscreen-size-x to match the LCD =
size.
This of course reduces the touch precision to full LCD pixels. For =
finger-
touch operated devices, subpixel precision is rarely needed.

Also, some user-spaces (e.g. older Replicant for GTA04) assume that =
there is
such an 1:1 mapping and they will be perfectly happy about this.=20

But, if you can modify your user-space easily, you can also choose a =
different
factor.

You can for example define touchscreen-size-x=3D<4096> and then you get =
almost
the highest precision of the ADC and won't loose any bits. Or even =
define a
bigger range and get steps >1 bit.

LCD driver (e.g. X11 calibration matrix) can scale it down again to LCD =
pixels.

So effectively we get for LCD pixels when the touch sets a mouse =
pointer:

	x'' =3D user-space-scale * <<input-event<< ((touchscreen-size-x =
* (x - ti,min-x)) / (ti,max-x-ti,min-x))

The most simple setup would then be but others are possible:

	user-space-scale =3D 1
	touchscreen-size-x =3D LCD-size-x

Let me cite myself:

>> This makes it possible to pre-calibrate the touch so that is (almost)


>=20
>>=20
>> Please note that the old ti,fuzz properties have been removed since =
they
>> are replaced by the common bindings touchscreen-fuzz-x/y/z.
>>=20
>> Finally, calculate_pressure has been renamed to calculate_resistance
>> because that is what it is doing.
>=20
> That is not what your patch does though. In the presence of
> "ti,report-resistance" parameter you start reporting resistance =
through
> ABS_PRESSURE

Well, there is some historic confusion wether this driver reports =
resistance
or pressure.

The unpatched tsc2007 driver does it wrong (please test!) and we fix it =
on
the fly (because a separate patch is much more complex than doing it =
right
immediately).

This ti,report-resistance property is a means to get the old (wrong) =
meaning back
in case someone urgently needs it and can't fix the user-space =
workaround which
he must be using.

AFAIK there is no mainline board using the DT except ours (and the =
upcoming
OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can =
remove this
compatibility property. We don't need it for our devices.

That the function name is wrong is a second issue and this double =
negation might
confuse a litte.

Please test on a real device if the patched driver reports pressure now =
(unless
ti,report-resistance is specified).

> without any indication to the userspace that meaning of
> event changed. This is no better if than reporting it through ABS_X. =
You
> should not override meaning of input events.

BR and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

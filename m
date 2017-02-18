From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sat, 18 Feb 2017 12:32:48 +0100
Message-ID: <558407EE-4884-4CC3-9098-79DC4B222868@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170217204041.GE13050@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr Cvek <petr.cve>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

> Am 17.02.2017 um 21:40 schrieb Dmitry Torokhov =
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> Hi Nikolaus,
>=20
> On Sat, Jan 28, 2017 at 10:44:35PM +0100, H. Nikolaus Schaller wrote:
>> Hi Dmitry,
>>=20
>>> Am 28.01.2017 um 20:33 schrieb Dmitry Torokhov =
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>=20
>>> Hi Nikolaus,
>>>=20
>>> On Wed, Dec 28, 2016 at 03:53:16PM +0100, H. Nikolaus Schaller =
wrote:
>>>> commit b98abe52fa8e ("Input: add common DT binding for =
touchscreens")
>>>> introduced common DT bindings for touchscreens [1] and a helper =
function to
>>>> parse the DT.
>>>>=20
>>>> commit ed7c9870c9bc ("Input: of_touchscreen - add support for =
inverted / swapped axes")
>>>> added another helper for parsing axis inversion and swapping
>>>> and applying them to x and y coordinates.
>>>>=20
>>>> Both helpers have been integrated to accommodate any orientation of =
the
>>>> touch panel in relation to the LCD.
>>>>=20
>>>> A new feature is to introduce scaling the min/max ADC values to the =
screen
>>>> size.
>>>>=20
>>>> This makes it possible to pre-calibrate the touch so that is =
(almost)
>>>> exactly matches the LCD pixel coordinates it is glued onto. This =
allows to
>>>> well enough operate the touch before a user space calibration step =
can
>>>> improve the precision.
>>>=20
>>> I question whether doing scaling in kernel is really right solution.
>>=20
>> Since lower left corner does not exactly report [0 0] and upper right =
corner
>> does not report [4095 4095] from the ADC we need offset and steepness =
correction
>> of the ADC values.
>>=20
>> This steepness is the scaling that must happen in kernel and I don't =
understand
>> why you want to propagate this ADC errors to user-space by avoiding =
scaling.
>>=20
>> Let me iterate what we want to achieve:
>> * use new common bindings
>> * offset and steepness calibration of the ADC (called =
pre-calibration).
>>  This makes a real device much more reliable to operate with factory =
installed
>>  scaling factors.
>> * flipping and rotation
>>=20
>> (note that touch pixel to LCD pixel scaling is not explicitly on this =
list!)
>=20
> That was explicitly called out in the patch:
>=20
> "A new feature is to introduce scaling the min/max ADC values to the
> screen size."

Because it is a feature that was not planned nor required, but is there. =
So it came
into the description of what can be done. If this is the key problem I =
am happy with
removing it from the commit messages.

Anyways, scaling to screen coordinates is not my invention. It is based =
on

	=
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/inp=
ut/touchscreen/touchscreen.txt

which defines the size to be in pixels. Well, a resistive touch screen =
does not have pixels.
It might have a resolution/precision given by the ADC conversion steps =
but I assume
this is not meant here.

So this scaling to screen size was also stimulated by this DT bindings.

>=20
>>=20
>> Now to achieve the ADC pre-calibration we must calculate
>>=20
>> 	x' =3D (x - ti,min-x) / (ti,max-x-ti,min-x) giving a rante from =
0.0 ... 1.0
>>=20
>> This is scaled up to what is defined by touchscreen-size-x, i.e.
>>=20
>> 	x' =3D (touchscreen-size-x * (x - ti,min-x)) / =
(ti,max-x-ti,min-x)
>>=20
>> How do you want to avoid this scaling to take place? It happens =
automatically.
>> It is not even an additional line of code. And is necessary for =
compensating ADC
>> offsets and steepness.
>>=20
>> So the only way to avoid the scaling option is to eliminate the =
precalibration/ADC
>> compensation which is essential for a device which has no means to =
properly
>> calibrate before operating the device through touch.
>>=20
>> The other option would be to avoid common bindings and set
>>=20
>> 	touchscreen-size-x =3D (ti,max-x-ti,min-x)
>>=20
>> This is heavily dependent on specific ADC offsets forwarded to =
user-space.
>> IMHO the worst we can do (and the current tsc2007 driver does it that =
way!).
>>=20
>>>=20
>>> Why do you want this?
>>=20
>> It seems that you assume that we want to enforce 1:1 scaling between =
touch pixels
>> and LCD pixels and have designed code to achieve exactly that.
>>=20
>> This is not the case. It is just a byproduct that you can do it.
>>=20
>> And since it is easier to understand we have made the examples this =
way.
>>=20
>>> If your touch resolution is lower than your screen
>>> then it might be useful, but if it is lower then you are losing data
>>> that can be very helpful for gesture recognition, and I hope you =
design
>>> your userspace so it can handle not only "bad" hardware, but "good" =
as
>>> well. And even with "bad" there are a lot of tricks that can be done =
to
>>> get "better" touch position in userspace.
>>=20
>> You can just *choose* DT parameters touchscreen-size-x to match the =
LCD size.
>> This of course reduces the touch precision to full LCD pixels. For =
finger-
>> touch operated devices, subpixel precision is rarely needed.
>>=20
>> Also, some user-spaces (e.g. older Replicant for GTA04) assume that =
there is
>> such an 1:1 mapping and they will be perfectly happy about this.=20
>>=20
>> But, if you can modify your user-space easily, you can also choose a =
different
>> factor.
>>=20
>> You can for example define touchscreen-size-x=3D<4096> and then you =
get almost
>> the highest precision of the ADC and won't loose any bits. Or even =
define a
>> bigger range and get steps >1 bit.
>>=20
>> LCD driver (e.g. X11 calibration matrix) can scale it down again to =
LCD pixels.
>>=20
>> So effectively we get for LCD pixels when the touch sets a mouse =
pointer:
>>=20
>> 	x'' =3D user-space-scale * <<input-event<< ((touchscreen-size-x =
* (x - ti,min-x)) / (ti,max-x-ti,min-x))
>>=20
>> The most simple setup would then be but others are possible:
>>=20
>> 	user-space-scale =3D 1
>> 	touchscreen-size-x =3D LCD-size-x
>>=20
>> Let me cite myself:
>>=20
>>>> This makes it possible to pre-calibrate the touch so that is =
(almost)
>=20
> Yes, it allows you to pre-calibrate, I get it. But you still do =
properly
> calibrate later, right?

No. We want to get rid of this step unless we need to improve the =
precision by
some tiny %.

Why do we want to get rid of it?

This needs a longer explanation.

First of all we are working on the Letux distribution which aims at =
supporting
multiple devices in the same way and with a single SD card image that =
contains
one or multiple rootfs (Debian X11, QtMoko, Replicant etc.) the kernel =
uImage
and DTB files for each supported device.

One of the ideas is to allow users to swap the SD card from one device =
to the
other. This means that the touch screen calibration must magically be =
carried
along - or we enforce to recalibrate every time the sd card is swapped =
back or
forth.

The same is true for prebuilt SD-images. To have a single (no longer =
device specific)
download requires to have a well defined default calibration. Especially =
on
devices where you have no keyboard where you can ask the user to =
manually fine-tune
something.

Our challenge is to make it work well without asking for explicit =
calibration.
This is where pre-calibration comes into the game.

It turns out to be related to the touch screen properties and how it is =
glued onto
the specific LCD panel, i.e. hardware and its description.

So the natural location of defining this relation is the DTB for each =
device
and not the user-space. And it happens that we already have one per =
device
(touch screen, lcd, tsc variant) on the SD card.

> So you are doing double work here, once in
> kernel, and second time in userspace.

This is no longer required, as long as we can use the default 1:1 =
coordinate mapping
of e.g. framebuffer or X11 based GUI toolkits.

If we don't have the 1:1 mapping of touch screen input event coordinates
to LCD pixels we have a mess of different scaling factors back in =
user-space
again. And the problem is setting them up properly in an installable =
.tbz
or .dd image.

Recently, you have raised another topic I had indeed not thought abut, =
which is
the potential subpixel precision of a resistive touch. You get approx. =
12
bit from the ADC but the x coordinate of the 480 pixel wide screen is =
just 9
bit. So scaling the input event coordinates to pixels throws away 3 =
bits.

But there are two things to consider.

One is that we could set the pre-calibration to keep as much resolution =
as
possible, ca. 12 pixels and make the user-space scale down to screen =
coordinates.

Unfortunately that differs between devices and hence we need not only
different DTBs (which we already have) but different scale factors in =
user-space.

Next, one could argue that subpixel coordinates should not be handled by
scaling input event coordinates up and then down again in user-space. =
The
correct solution would be that input events could report fixed or =
floating
point coordinates, but this is probably beyond what we all want to do.

The other thing is noise. No resistive touch screen I have seen in the =
wild with
the tsc2007 or tsc2046 controller has the precision to really report =
subpixels.
Rather we have to set the fuzz between 3 or 10 or so. Which means that =
those
bits we cut off by scaling to screen coordinates are already lost in =
noise.

>=20
> I'd be more open to allowing setting the "min-axis" values to allow
> reporting typical range for given device, and let userspace scale as =
it
> sees fit.

The problem is: what is "typical range"? It turns out to be a completely
arbitrary definition.

I see a choice between:
a) full theoretical ADC range
b) millimeters
c) pixels of the LCD the touch is glued to

For me, the most natural and practical "typical range" still seems to be =
the
pixels of the lcd panel the touch is glued onto.

The reason why I see it as superior to the others is that only this =
leads to
a stable 1:1 mapping in user-space avoiding to adjust any factors there.

And this 1:1 saves a lot of configuration hassle if you swap GUI systems
(X, Wayland, Android, DirectFB, fb based Qt, ...).

>=20
>>=20
>>>=20
>>>>=20
>>>> Please note that the old ti,fuzz properties have been removed since =
they
>>>> are replaced by the common bindings touchscreen-fuzz-x/y/z.
>>>>=20
>>>> Finally, calculate_pressure has been renamed to =
calculate_resistance
>>>> because that is what it is doing.
>>>=20
>>> That is not what your patch does though. In the presence of
>>> "ti,report-resistance" parameter you start reporting resistance =
through
>>> ABS_PRESSURE
>>=20
>> Well, there is some historic confusion wether this driver reports =
resistance
>> or pressure.
>>=20
>> The unpatched tsc2007 driver does it wrong (please test!) and we fix =
it on
>> the fly (because a separate patch is much more complex than doing it =
right
>> immediately).
>>=20
>> This ti,report-resistance property is a means to get the old (wrong) =
meaning back
>> in case someone urgently needs it and can't fix the user-space =
workaround which
>> he must be using.
>>=20
>>=20
>> AFAIK there is no mainline board using the DT except ours (and the =
upcoming
>> OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can =
remove this
>> compatibility property. We don't need it for our devices.
>>=20
>=20
> You seem to be treating DT data as something very fluid, which is =
wrong.

No,only sometimes.

Of course it should be done right once. Of course there is long =
discussion about
what is right...

> You need to treat it as a firmware, unlikely to change once device is
> shipped. Unlike legacy platform data, the fact that DTS files are not
> present in mainline does not mean that we can ignore such users and
> change behavior at will.

Well, it happens to me as maintainer of a 99.5% mainline device every
now and then. Of course this should not be an argument to do it equally =
bad here.

One more thought: for some devices it is easier to modify the DTB =
"firmware"
than the user space (e.g. if you have no access to it because it is =
maintained
by somebody else).

>=20
> That said, if driver behavior is out of line from the subsystem
> expectations, we need to fix it.
>=20
>=20
>> That the function name is wrong is a second issue and this double =
negation might
>> confuse a litte.
>>=20
>> Please test on a real device if the patched driver reports pressure =
now (unless
>> ti,report-resistance is specified).
>=20
> I unfortunately can not test this driver as I do not have the =
hardware.

Ah, ok. This is indeed a road block.

Maybe someone else with a real tsc2007 hardware is reading this =
discussion and can comment?

> So all my observations are from code and data sheets.

> That said, what is the values emitted as ABS_PRESSURE when finger is =
not
> touching the device, barely touching the device, or pressing firmly?

> It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
> confusion as to what is being reported.

Indeed. The original tsc2007 jumps from 0 to a maximum value and goes =
down when
pressing more firmly. This is not "pressure". The other drivers (I have =
tested
the OpenPandora with tsc2046) are doing it in a monotonic curve.

Hence I suggested to fix it for the tsc2007 (any perhaps others showing =
the same bug).
And allow a mechanism for those people who can more easily touch the DTB =
file than
the user space to turn it back to the old but wrong situation by setting =
a DT
property (maybe even in their boot.scr).

> I am adding a few more folks to the CC so we can try and soft this =
out.
> Sebastian, Pali, Pavel, any input here?

Fine!

BR and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

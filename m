From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v4 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Tue, 18 Oct 2016 19:27:01 +0200
Message-ID: <3D3CBADC-42F7-4A2B-9D0D-40A0649F79FB@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com> <76746b85957c9f3ef7101a7ee883898a414cabd8.1476712675.git.hns@goldelico.com> <CAL_JsqJhzZC6Hw3eRLFDiBA8jih=N507WvEh=TRbPhLS9EjhBQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJhzZC6Hw3eRLFDiBA8jih=N507WvEh=TRbPhLS9EjhBQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussion
List-Id: linux-omap@vger.kernel.org

Hi Rob,

> Am 18.10.2016 um 18:22 schrieb Rob Herring <robh+dt@kernel.org>:
>=20
> On Mon, Oct 17, 2016 at 8:57 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
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
>=20
> Please add the explanation of why this is a compatible change here.

Can you please describe in more detail what you are missing here?

The patch simply makes use of the generic helper function introduced by =
the
two patches cited above and is therefore automatically compatible if =
none of
the new properties is defined.

The tsc2007 didn't have these features before. So what should we say
about compatibility?

>=20
>> A new feature is to introduce scaling the min/max ADC values to the =
screen
>> size.
>=20
> Sounds like a separate change.

I have thought about that for a while, but did not find a way to =
separate it
into two independent patches. If you can propose something, please help.

>=20
>> This makes it possible to pre-calibrate the touch so that is (almost)
>> exactly matches the LCD pixel coordinates it is glued onto. This =
allows to
>> well enough operate the touch before a user space calibration step =
can
>> improve the precision.
>>=20
>> Finally, calculate_pressure has been renamed to calculate_resistance
>> because that is what it is doing.
>>=20
>> [1]: =
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--
>> drivers/input/touchscreen/tsc2007.c                | 120 =
+++++++++++++++++----
>> include/linux/i2c/tsc2007.h                        |   8 ++
>> 3 files changed, 118 insertions(+), 30 deletions(-)
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt =
b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> index ec365e1..6e9fd55 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> @@ -6,6 +6,7 @@ Required properties:
>> - ti,x-plate-ohms: X-plate resistance in ohms.
>>=20
>> Optional properties:
>> +- generic touch screen properties: see touchscreen binding [2].
>> - gpios: the interrupt gpio the chip is connected to (trough the =
penirq pin).
>>   The penirq pin goes to low when the panel is touched.
>>   (see GPIO binding[1] for more details).
>> @@ -13,17 +14,20 @@ Optional properties:
>>   (see interrupt binding[0]).
>> - interrupts: (gpio) interrupt to which the chip is connected
>>   (see interrupt binding[0]).
>> -- ti,max-rt: maximum pressure.
>> -- ti,fuzzx: specifies the absolute input fuzz x value.
>> -  If set, it will permit noise in the data up to +- the value given =
to the fuzz
>> -  parameter, that is used to filter noise from the event stream.
>> -- ti,fuzzy: specifies the absolute input fuzz y value.
>> -- ti,fuzzz: specifies the absolute input fuzz z value.
>> +- ti,max-rt: maximum pressure resistance above which samples are =
ignored
>> +  (default: 4095).
>> +- ti,report-resistance: report resistance (no pressure =3D max_rt) =
instead
>> +  of pressure (no pressure =3D 0).
>> +- ti,min-x: minimum value reported by X axis ADC (default 0).
>> +- ti,max-x: maximum value reported by X axis ADC (default 4095).
>> +- ti,min-y: minimum value reported by Y axis ADC (default 0).
>> +- ti,max-y: maximum value reported by Y axis ADC (default 4095).
>=20
> I thought these were going to be common? I think they should be.

Yes, we had discussed that before.

In a second thought, I found that they are not even existing for the =
different
touch chip drivers that are around. And some chip might not need them =
(because
e.g. min/max are constants or defined my means outside the DT or the =
chip itself
can store them in NV memory).

And, since they define ADC raw-values, they are very closely related to =
the
individual chip, so that I am not sure if it is really necessary to make
them common. At least if they are properly documented in the bindings =
for
the specific chip they can have different names without disturbing each
other.

So I think it is perfectly reasonable to define common bindings towards
the input event layer (e.g. size, fuzz, swapping, inversion) and support
them by common code which bakes raw coordinates into input events. The =
latest
helper functions already do most of that fully automatic.

Next, I had simply copied them from the ads7846 driver where they
exist for a long time. So this is sort of "common", at least for two =
different
chips now. See also patch 6/8 of this series which adds the common =
properties
to the ads7846 as well.

For more reference about the existing bindings:

Documentation/devicetree/bindings/input/ads7846.txt

(btw I think someone should move them to bindings/input/touchscreen).

It appears as if there is some overlap of the new generic properties =
(for x/y
swapping) with the old ads7846 properties, but that is something you had
already proposed a while ago to make me the driver recognize both =
properties to
stay compatible with older DT files.

So if we now rename the min/max-x/y properties for the tsc2007 we have =
to rename
them for the ads7846 (and maybe others) as well, which might break =
out-of-tree
ads7846 devices or leads to more complex code for handling of property =
aliases.

Does this sound enough reasons to keep it as proposed originally?

BR and thanks,
Nikolaus


>=20
> Rob
>=20
>> - ti,poll-period: how much time to wait (in milliseconds) before =
reading again the
>> -  values from the tsc2007.
>> +  values from the tsc2007 (default 1).
>>=20
>> [0]: =
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> [1]: Documentation/devicetree/bindings/gpio/gpio.txt
>> +[2]: =
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>=20
>> Example:
>>        &i2c1 {
>> @@ -35,6 +39,8 @@ Example:
>>                        interrupts =3D <0x0 0x8>;
>>                        gpios =3D <&gpio4 0 0>;
>>                        ti,x-plate-ohms =3D <180>;
>> +                       touchscreen-size-x =3D <640>;
>> +                       touchscreen-size-y =3D <480>;
>>                };
>>=20
>>                /* ... */


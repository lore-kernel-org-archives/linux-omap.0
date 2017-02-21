From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 07:36:17 +0100
Message-ID: <0A33CCEA-448C-4C1D-9563-FDA54743BD01@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali> <201702202208.50498@pali> <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com> <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 20.02.2017 um 22:50 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>=20
> On Mon, Feb 20, 2017 at 1:27 PM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>>> Am 20.02.2017 um 22:08 schrieb Pali Roh=C3=A1r =
<pali.rohar@gmail.com>:
>>>=20
>>> On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
>>>> Hi Nikolaus!
>>>>=20
>>>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>>>>> Hi Dmitry,
>>>>>=20
>>>>>> Input driver may set resolution for given axis in units per mm
>>>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
>>>>>> ABS_RZ), and if you check the binding, you can use
>>>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
>>>>>> entire touch surface and set resolution from it so that
>>>>>> userspace can calculate the proper scaling factor.
>>>>>=20
>>>>> How is this information exposed by the kernel to user-space? By
>>>>> scanning the DT file or tree?
>>>>=20
>>>> Set input_abs_set_res() from kernel. And in userspace call =
EVIOCGABS
>>>> ioctl() on input device. Look at struct input_absinfo, you should
>>>> have all needed information here. This is generic input interface,
>>>> no DT is needed.
>>>=20
>>> Looking at kernel code... via EVIOCSABS ioctl() you can even set
>>> resolution from userspace for specified input device.
>>>=20
>>> So this could be potentially used for calibrating input device from
>>> userspace? (In case DT data will not fully match current HW)
>>>=20
>>>> I hope that XServer is already using it for evdev devices...
>>>>=20
>>>> For whole implementation look at evtest program. That should be =
good
>>>> starting point for your userspace implementation.
>>>>=20
>>>> While I'm watching this discussion... in my opinion kernel should
>>>> just invert input axes (when needed)
>>=20
>> It is questionable why it should do that at all then.
>=20
> Because the task of the kernel is to provide unified view of the
> hardware. Axis swapping and inversion is needed to that "up" is always
> "up" and "right" is always "right".

Hm. Why not touching pixel (0,0) on the touch is always pixel (0,0) on =
the
screen and touching pixel (639,479) is always (639,479)?

I think it is time to end this discussion.

It has show me how much a mess and half-baked area this is, which I did
not expect. I read contradicting messages from different people:

* don't break user space because it is carved in stone
* fix users space if you want to do it properly
* scaling by +/-1 and shifting by full range is ok
* scaling by ts-size/adc-range and shifting by adc_min is not ok
* full numeric ADC resolution is required but subpixel coordinates is =
not acceptable

I will monitor this to see if this becomes sorted out before submitting =
anything
new.

BR and thanks,
Nikolaus=

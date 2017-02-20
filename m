From: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 23:21:37 +0100
Message-ID: <15339314-8696-f603-d0da-beefe54f0653@tul.cz>
References: <cover.1482936802.git.hns@goldelico.com>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
 <201702202042.15878@pali> <201702202208.50498@pali>
 <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
 <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin
List-Id: linux-omap@vger.kernel.org

Hi,

Dne 20.2.2017 v 22:50 Dmitry Torokhov napsal(a):
> On Mon, Feb 20, 2017 at 1:27 PM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>>
>>> Am 20.02.2017 um 22:08 schrieb Pali Rohár <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>
>>> On Monday 20 February 2017 20:42:15 Pali Rohár wrote:
>>>> Hi Nikolaus!
>>>>
>>>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>>> Input driver may set resolution for given axis in units per mm
>>>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
>>>>>> ABS_RZ), and if you check the binding, you can use
>>>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
>>>>>> entire touch surface and set resolution from it so that
>>>>>> userspace can calculate the proper scaling factor.
>>>>>
>>>>> How is this information exposed by the kernel to user-space? By
>>>>> scanning the DT file or tree?
>>>>
>>>> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
>>>> ioctl() on input device. Look at struct input_absinfo, you should
>>>> have all needed information here. This is generic input interface,
>>>> no DT is needed.
>>>
>>> Looking at kernel code... via EVIOCSABS ioctl() you can even set
>>> resolution from userspace for specified input device.
>>>
>>> So this could be potentially used for calibrating input device from
>>> userspace? (In case DT data will not fully match current HW)
>>>
>>>> I hope that XServer is already using it for evdev devices...
>>>>
>>>> For whole implementation look at evtest program. That should be good
>>>> starting point for your userspace implementation.
>>>>
>>>> While I'm watching this discussion... in my opinion kernel should
>>>> just invert input axes (when needed)
>>
>> It is questionable why it should do that at all then.
> 
> Because the task of the kernel is to provide unified view of the
> hardware. Axis swapping and inversion is needed to that "up" is always
> "up" and "right" is always "right".

Actually my Xorg calibration 3x3 matrix is fine with both axis inverted (on TSC2046).

best regards,
Petr

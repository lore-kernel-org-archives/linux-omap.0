From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/8] drivers:input:tsc2007: add iio interface to read
 external ADC input, temperature and raw conversion values
Date: Sat, 24 Sep 2016 10:44:50 -0700
Message-ID: <CAKdAkRS3OhUp=WXtrLxQSJAvtgt24jo2W8Nw_NwR4O=R9jboaA@mail.gmail.com>
References: <cover.1474634475.git.hns@goldelico.com> <909d06d4f54359c7ac0dcf36a49cbd3ff7e8ebf2.1474634475.git.hns@goldelico.com>
 <af39fdf1-b6e4-1ab7-9b41-ddb25bfab829@kernel.org> <8A30B517-FE25-418B-9921-407243B0B72B@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <8A30B517-FE25-418B-9921-407243B0B72B@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Discussions
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 24, 2016 at 10:07 AM, H. Nikolaus Schaller
<hns@goldelico.com> wrote:
> Hi Jonathan,
>
>> Am 24.09.2016 um 18:07 schrieb Jonathan Cameron <jic23@kernel.org>:
>>
>> On 23/09/16 13:41, H. Nikolaus Schaller wrote:
>>> The tsc2007 chip not only has a resistive touch screen controller but
>>> also an external AUX adc imput which can be used for an ambient
>>> light sensor, battery voltage monitoring or any general purpose.
>>>
>>> Additionally it can measure the chip temperature.
>>>
>>> This extension provides an iio interface for these adc channels
>>> in addition to the raw x, y, z values and the estimated touch
>>> screen resistance. This can be used for debugging or special
>>> applications.
>> I'm unconvinced that exposing the touch related channels is terribly
>> useful.
>
> Mostly for debugging of if someone wants to do a (better) touch detection
> in user space.

For that we should probably export data as a heat map via V4L2
interface, similarly to what Nick Dyer did for Synaptics and Atmel
drivers (albeit their heatmap functions are too slow for real
processing and only suitable for debug/validation).

Thanks.

-- 
Dmitry

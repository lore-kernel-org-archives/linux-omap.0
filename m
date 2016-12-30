From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v8 3/8] drivers:input:tsc2007: add iio interface to read
 external ADC input and temperature
Date: Fri, 30 Dec 2016 20:17:53 +0000
Message-ID: <422954b1-4ae5-acc1-f98a-f6f71047f4bf@kernel.org>
References: <cover.1479823354.git.hns@goldelico.com>
 <cover.1479823354.git.hns@goldelico.com>
 <99f236df48b03b3188e12f94a20097f8440db7a5.1479823354.git.hns@goldelico.com>
 <E42B1EF7-222E-46D6-878B-30C789CFBBC5@jic23.retrosnub.co.uk>
 <811B6F6A-2E3D-45B4-A984-74ABE0E37192@goldelico.com>
 <8d3fc752-e69c-f568-4f71-4f1768a3fffe@kernel.org>
 <AC7B3C1C-C05B-45B5-8426-5225F151DC26@goldelico.com>
 <E4E31180-A686-4631-9713-519987C55F06@goldelico.com>
 <20161227215416.GB28140@dtor-ws>
 <FA2666F0-0C5B-458E-97B5-83243F26D0DE@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <FA2666F0-0C5B-458E-97B5-83243F26D0DE@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Petr
List-Id: linux-omap@vger.kernel.org

On 28/12/16 14:52, H. Nikolaus Schaller wrote:
> Hi Dmitry,
> 
>> Am 27.12.2016 um 22:54 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>
>> On Mon, Dec 12, 2016 at 10:21:25PM +0100, H. Nikolaus Schaller wrote:
>>> Hi,
>>>
>>>
>>>> Am 27.11.2016 um 16:47 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>>>
>>>> Hi Jonathan,
>>>>
>>>>> Am 27.11.2016 um 12:02 schrieb Jonathan Cameron <jic23@kernel.org>:
>>>>>
>>>>> On 24/11/16 18:05, H. Nikolaus Schaller wrote:
>>>>>>
>>>>>>> Am 24.11.2016 um 18:38 schrieb Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 22 November 2016 14:02:30 GMT+00:00, "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>>>
>>>>
>>>>> - hence cc'd Yann and the Kbuild list
>>>>> to see if they can offer some advices.
>>>
>>> no response / advice so far.
>>
>> Since you are saying that IIO stuff is optional, add it to Kconfig
>> explicitly:
>>
>> config "TOUCHSCREEN_TSC2007_IIO"
>> 	bool "IIO interface for external ADC input and temperature"
>> 	depends on TOUCHSCREEN_TSC2007
>> 	depends on IIO=y || IIO=TOUCHSCREEN_TSC2007
>> 	help
>> 	  ...
>>
>> and use this symbols in makefile:
>>
>> and in Makefile:
>>
>> obj-$(CONFIG_TOUCHSCREEN_TSC2007) += tsc2007.o
>> tsc2007-y := tsc2007-core.o ...
>> tsc2007-$(CONFIG_TOUCHSCREEN_TSC2007_IIO) += tsc2007_iio.o
> 
> Ah, ok. Well, we tried to make it without an explicit config option
> but it does not hurt to have one.
> 
> Your proposal works fine for 3 out of the 4 possible combinations.
> 
> I think it is unlikely that the combination TOUCHSCREEN_TSC2007=y IIO=m
> is needed at all (we configure as much as possible as =m in our kernel).
Indeed - that shouldn't work and is blocked by the above which is good.
> 
> Patch v9 will come next (where I have also moved this iio driver
> patch to be 8/8).
Wise move ;)
> 
> BR and thanks,
> Nikolaus
> 


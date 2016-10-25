From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 4/8] drivers:input:tsc2007: add iio interface to read
 external ADC input and temperature
Date: Tue, 25 Oct 2016 17:54:12 +0100
Message-ID: <f814b75d-4061-1479-15b8-347599bf0213@kernel.org>
References: <cover.1476712675.git.hns@goldelico.com>
 <4d3c600bf0a6b75a74212a103bf31525505290a0.1476712675.git.hns@goldelico.com>
 <07bb4d52-a439-f9a9-8593-ddde8e93e6ee@kernel.org>
 <7A0E332C-4930-4F1A-8320-F87F864B53AE@goldelico.com>
 <1dd251db-7f45-78bf-c9dd-4ae29b0ed757@kernel.org>
 <976C7328-A6AA-4CD5-AAAA-3B14BA3BD793@goldelico.com>
 <F0CB8C7F-29FD-41DF-A652-9D1AF7824D5F@goldelico.com>
 <4b6773d9-bc33-7471-ee29-01f51c5cfce2@kernel.org>
 <4735A551-6E90-4D2B-8A37-671B2789ECE4@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4735A551-6E90-4D2B-8A37-671B2789ECE4@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kernel@pyra-handheld.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-input@vger.kernel.org, Michael Welling <mwelling@ieee.org>, letux-kernel@openphoenux.org, "Andrew F. Davis" <afd@ti.com>, Igor Grinberg <grinberg@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

On 24/10/16 20:14, H. Nikolaus Schaller wrote:
> Hi Jonathan,
> 
>> Am 23.10.2016 um 21:00 schrieb Jonathan Cameron <jic23@kernel.org>:
>>
>> On 23/10/16 19:34, H. Nikolaus Schaller wrote:
>>> Hi Jonathan,
>>>
>>>> Am 23.10.2016 um 11:57 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>>>
>>>> Hi,
>>>>
>>>>>> +static int tsc2007_alloc(struct i2c_client *client, struct tsc2007 **ts,
>>>>>> +                          struct input_dev **input_dev)
>>>>>> +{
>>>>>> +       int err;
>>>>>> +       struct iio_dev *indio_dev;
>>>>>> +
>>>>>> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ts));
>>>>> Instead of doing this to reduce the delta between versions make 
>>>>> iio_priv a struct tsc2007 **
>>>>>
>>>>> That is have a single pointer in there and do your allocation of struct
>>>>> tsc2007 separately.
>>>>
>>>> Sorry, but I think I do not completely understand what you mean here.
>>>>
>>>> The problem is that we need to allocate some struct tsc2007 in both cases.
>>>> But in one case managed directly by &client->dev and in the other managed
>>>> indirectly. This is why I use the private area of struct iio_dev to store
>>>> the full struct tsc2007 and not just a pointer.
>>>
>>> Ok, I think I finally did understand how you mean this and have started to
>>> implement something.
>>>
>> oops. Didn't look on in my emails to get to this one!
>>> The idea is to have one alloc function to return a struct tsc2007. This
>>> can be part of the probe function, like it is in the unpatched driver.
>>>
>>> In case of iio this struct tsc2007 is also allocated explicitly so that
>>> a pointer can be stored in iio_priv.
>>>
>>> This just means an additional iio_priv->ts = devm_kzalloc() in case of iio.
>>>
>>> I have added that approach to my inlined patch and it seems to work (attached).
>>>
>>> Sorry if I do not use the wording you would use and sometimes overlook
>>> something you have said. I feel here like moving on thin ice and doing
>>> guesswork about unspoken assumptions...
>> That's fine.  Stuff that can appear obvious to one person is not
>> necessarily obvious to another!
>>>
>>>>
>>>>>
>>>>> Having doing that, you can have this CONFIG_IIO block as just
>>>>> doing the iio stuff with the input elements pulled back into the main
>>>>> probe function.
>>>>>
>>>>> Then define something like
>>>>>
>>>>> iio_configure (stubbed to nothing if no IIO)
>>>>> and
>>>>> iio_unconfigure (also stubbed to nothing if no IIO).
>>>
>>> This seems to work (draft attached).
>>>
>>>>>
>>>>> A couple of additions in the header
>>>
>>> I think you mean tsc2007.h?
>> Nope. A local header alongside the driver is what you want for this stuff.
>> driver/input/tsc2007.h 
>>>
>>> This currently contains only platform data and could IMHO be eliminated
>>> if everything becomes DT.
>>>
>>>>> to make it all work
>>>>> (the struct tsc2007 and tsc2007_xfer() + a few of the
>>>>> register defines..
>>>
>>> Here it appears to me that I have to make a lot of so far private static
>>> and even static inline functions public so that I can make them stubs and
>>> call them from tsc2007_iio.c.
>> There will be a few.
>>>
>>> And for having proper parameter types I have to make most private structs
>>> also public.
>> Yes a few of those as well.
>>>
>>> I really like the idea to have the optional iio feature in a separate source
>>> file, but when really starting to write code, I get the impression that
>>> it introduces more problems than it solves.
>>>
>>> And I wonder a little why it is not done for #ifdef CONFIG_OF in tsc2007.c
>>> as well. There are also two static function in some #ifdef #else # endif
>>> and not going through stubs.
>> Usually it is only done once a certain volume of code exists.
>>>
>>> So is this intended to give up some static definitions?
>> Yes, that happens the moment you have multiple source files.
>>
>> Some losses but generally end up with clean code separation. Always a trade
>> off unfortunately.  Pity we can't just insist IIO is available! Rather large
>> to pull in for what is probable a niche use case.
>>
>> Below is definitely heading in the right direction. I remember vaguely being
>> convinced of the worth of doing this when optional code is involved!
>> (was a good while ago now)
>>
>> Jonathan
>>>
>>> BR and thanks,
>>> Nikolaus
>>>
>>> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
>>> index 5e3c4bf..92da8f6 100644
>>> --- a/drivers/input/touchscreen/tsc2007.c
>>> +++ b/drivers/input/touchscreen/tsc2007.c
>>> @@ -30,6 +30,7 @@
>>> #include <linux/of.h>
>>> #include <linux/of_gpio.h>
>>> #include <linux/input/touchscreen.h>
>>> +#include <linux/iio/iio.h>
>> Should not need this after introducing the new file.  Will only be
>> needed in the iio specific .c file.
>>>
>>> #define TSC2007_MEASURE_TEMP0          (0x0 << 4)
>>> #define TSC2007_MEASURE_AUX            (0x2 << 4)
>>> @@ -98,6 +99,9 @@ struct tsc2007 {
>> This will definitely need to go in the header though.
> 
> Now I have split the code into:
> 
> tsc2007.h (constants, structs and stubs)
> tsc2007_iio.c (the iio stuff)
> tsc2007.c (most parts of the original driver)
> 
> but I have a problem of correctly modifying the Makefile.
> 
> It currently looks like:
> 
> obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
> obj-$(CONFIG_IIO)			+= tsc2007_iio.o
> 
> We have configured CONFIG_TOUCHSCREEN_TSC2007=m and CONFIG_IIO=y.
> 
> This obviously compiles tsc2007_iio.o into the kernel.
> 
> This means that tsc2007_iio.o references tsc2007_xfer which is part of
> the module.
> 
> I would like to get both linked into the module, but the iio part
> obviously only if CONFIG_IIO is defined (either -y or -m).
> 
> How can I define this?
> 
> Or can I define
> 
> obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o tsc2007_iio.o
This is a common problem with optional support. Various ways of 
handling it.

A simple one would be:
#Define the stuff that always forms part of the .o file
magic_tsc2007-y := tsc2007.o
#Define the optional bit to build the resulting magic_tsc2007.o file
magic_tsc2007-$(CONFIG_IIO) += tsc2007_iio.o
#Use this magic combined file
obj-$(CONFIG_TOUCHSCREEN_TSC2007) += magic_tsc2007.o

With sensible naming of course ;)

Jonathan
> 
> and embrace all code in tsc2007_iio with a big #ifdef CONFIG_IIO
> so that it is compiled into an empty object file in the non-iio case?
> 
> BR and thanks,
> Nikolaus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure
 pendown_gpio
Date: Sun, 06 Feb 2011 09:31:28 +0200
Message-ID: <4D4E4E50.4030709@compulab.co.il>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>	<20110203165405.GB12802@core.coreip.homeip.net>	<20110203171953.GA13997@core.coreip.homeip.net>	<20110204133250.GB2070@m-desktop>	<20110204140847.GA3178@pengutronix.de>	<20110204141618.GE2070@m-desktop>	<4D4C116D.4080408@compulab.co.il>	<AANLkTi=23s6jxGFVM9vUr3XopgPnSyfie2Ywj-PcKHSF@mail.gmail.com>	<4D4C1B83.3020000@compulab.co.il> <AANLkTimQS_dNcaeTqqR=7vqFcGi-CtmH_ynrPyt4p1uK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <AANLkTimQS_dNcaeTqqR=7vqFcGi-CtmH_ynrPyt4p1uK@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, balbi@ti.com, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, LW@karo-electronics.de, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org

> On Fri, Feb 4, 2011 at 9:00 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>
>> On 02/04/11 17:11, Poddar, Sourav wrote:
>>
>>> On Fri, Feb 4, 2011 at 8:17 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>>> On 02/04/11 16:16, G, Manjunath Kondaiah wrote:
>>>>
>>>>> On Fri, Feb 04, 2011 at 03:08:47PM +0100, Wolfram Sang wrote:
>>>>>> On Fri, Feb 04, 2011 at 07:02:50PM +0530, G, Manjunath Kondaiah wrote:
>>>>>>> On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
>>>>>>>> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
>>>>>>>>> Something like below should do I think. 
>>>>>>> Patch looks good but it applies only on top of previous patch:
>>>>>>> https://patchwork.kernel.org/patch/529941/
>>>>>>>
>>>>>>> Why to have two patches for this fix?
>>>>>> http://www.spinics.net/lists/linux-omap/msg45167.html
>>>>> My point here is:
>>>>> 1. The first patch only replaces gpio_request with gpio_request_one
>>>>> 2. Rest of the things are handled in 2nd patch posted by dmitry
>>>>>
>>>>> What is harm in merging both the patches? I don't think it affects
>>>>> readability.
>>>> Because the changes introduced by the patches are from different nature.
>>>> As stated in the link above, one is a functional change (gpio setup change)
>>>> and second is fixing the imbalance in request - free calls.
>>>> The impact is not readability, but bad bisect-ability.
>>>   Dmitry's patch fixes both the problems(request/free and direction)
>>>   in a single patch itself.Now there is no need of merging any patches.
>>>   Just that Dmitry's patch need to be rebased over the top of HEAD. (Currently,
>>>   its on top of my patch series).
>> Well, here you have missed the point of direction:
>> ...
>>
>> +               err = gpio_request_one(pdata->gpio_pendown, GPIOF_DIR_IN,
>> +                                                       "ads7846_pendown");
>>
>> ...
>>
>> -       err = gpio_request_one(pdata->gpio_pendown, GPIOF_DIR_IN,
>> -                                               "ads7846_pendown");
>> ...
>>
>>
>> It does not deal with direction, but only with request - free balance.
>> The gpio direction is fixed by your patch.
>>
> gpio_request_one is a different API which calls  gpio_direction_input
> for configuring the direction.

That is exactly the point :)
Your patch has added the gpio_request_one() and thus changed the gpio direction.
This patch only moves it around.

-- 
Regards,
Igor.


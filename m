From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
Date: Fri, 24 Feb 2012 16:12:32 +0100
Message-ID: <4F47A8E0.1070005@ti.com>
References: <4F46C1AF.2040201@ti.com> <20120223230821.GD18185@atomide.com> <4F47623E.5060908@ti.com> <CAC83ZvLm-ruk3pMkeLhiyOMAVVnByk9PPWsM40AyPErSqz=dKA@mail.gmail.com> <CAC83ZvJ-mCZFYzOPQ177th7qVC9GBrKnB2pL=R3knMktOeau2g@mail.gmail.com> <4F47915B.7050507@ti.com> <CAC83ZvJS8BoOD0GUE5UkgGz15e+wsgVv2CbRB5nnpBFZurJ18w@mail.gmail.com> <4F4796F5.7050404@ti.com> <CAC83ZvKknrxDq8hO37K6CpJTSx6Xy4ORcxejpK6QvsuOmFj0Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41578 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050Ab2BXPMi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 10:12:38 -0500
In-Reply-To: <CAC83ZvKknrxDq8hO37K6CpJTSx6Xy4ORcxejpK6QvsuOmFj0Ww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

On 2/24/2012 4:09 PM, DebBarma, Tarun Kanti wrote:
> Hi Benoit,
>
> On Fri, Feb 24, 2012 at 7:26 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 2/24/2012 2:53 PM, DebBarma, Tarun Kanti wrote:
>>>
>>> On Fri, Feb 24, 2012 at 7:02 PM, Cousson, Benoit<b-cousson@ti.com>    wrote:
>>>>
>>>> On 2/24/2012 2:24 PM, DebBarma, Tarun Kanti wrote:
>>>>>
>>>>>
>>>>> Hi Benoit,
>>>>>
>>>>> On Fri, Feb 24, 2012 at 4:07 PM, DebBarma, Tarun Kanti
>>>>> <tarun.kanti@ti.com>      wrote:
>>>>>>
>>>>>>
>>>>>> On Fri, Feb 24, 2012 at 3:41 PM, Cousson, Benoit<b-cousson@ti.com>
>>>>>>   wrote:
>>>>>>>
>>>>>>>
>>>>>>> + Tarun
>>>>>>>
>>>>>>>
>>>>>>> On 2/24/2012 12:08 AM, Tony Lindgren wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> * Cousson, Benoit<b-cousson@ti.com>        [120223 14:14]:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The GPIO driver is still relying on internal OMAP IRQ defines that
>>>>>>>>> are not relevant anymore if OMAP is built with SPARSE_IRQ.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Great :)
>>>>>>>>
>>>>>>>>> Please note that this patch is still RFC, because I do not know
>>>>>>>>> how to fix properly the ugly cpu_class_is_omap1 and the dependency
>>>>>>>>> with IH_MPUIO_BASE to detect a MPUIO.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Sounds like gpio_to_irq() needs to be set in the
>>>>>>>> arch/arm/*omap*/gpio*.c then.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> In fact, after a second thought, that might even work for OMAP1
>>>>>>> because
>>>>>>> I'm
>>>>>>> using the proper base (IRQ and GPIO) to convert the IRQ number.
>>>>>>>
>>>>>>>
>>>>>>> static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
>>>>>>> {
>>>>>>>
>>>>>>>         return gpio_irq - bank->irq_base + bank->chip.base;
>>>>>>> }
>>>>>>>
>>>>>>> But it might be good to test it on OMAP1 platform.
>>>>>>>
>>>>>>>
>>>>>>> Tarun,
>>>>>>>
>>>>>>> Do you have an OMAP1 board to test that.
>>>>>>
>>>>>>
>>>>>> Yes, I will test on OMAP1 board.
>>>>>
>>>>>
>>>>> I have booted the image on OMAP1 with following change.
>>>>> I guess bank->irq_base was a typo?
>>>>
>>>>
>>>>
>>>> Not at all :-), it was done on purpose to get rid if the static IRQ
>>>> definition.
>>>
>>> BTW, it was giving me following compilation error...
>>> drivers/gpio/gpio-omap.c: In function 'irq_to_gpio':
>>> drivers/gpio/gpio-omap.c:90: error: 'struct gpio_bank' has no member
>>> named 'irq_base'
>>> make[2]: *** [drivers/gpio/gpio-omap.o] Error 1
>>
>>
>> Oh, that's different... you are missing the cleanup patches from the DT
>> series I did before this one:
>>
>> eaabbb0 gpio/omap: Fix IRQ handling for SPARSE_IRQ
>> fa560a7 arm/dts: OMAP3: Add gpio nodes
>> bfeb298 arm/dts: OMAP4: Add gpio nodes
>> 3062158 gpio/omap: Add DT support to GPIO driver
>> a140d12 gpio/omap: Use devm_ API and add request_mem_region
>> 0416689 gpio/omap: Remove bank->id information and misc cleanup
>> 249f60c Merge branch 'for_3.4/gpio_cleanup_fixes_v9' of
>> git://gitorious.org/~tarunkanti/omap-sw-deve
>>
>> I'll push a temp branch for you.
>
> I have pulled from git://gitorious.org/omap-pm/linux.git for_3.4/dt_gpio_dt.
> It is working on OMAP1710.

Hehe, that's cool.

I'll repost the gpio DT series and add that one in it.

Thanks a lot.
Benoit


From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3] gpio/omap: fix off-mode bug: clear debounce clock
 enable mask on free/reset
Date: Fri, 26 Oct 2012 14:14:55 -0500
Message-ID: <508AE12F.5080704@ti.com>
References: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com> <5089C2B6.5020606@ti.com> <508A273E.3020500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966126Ab2JZTPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 15:15:06 -0400
In-Reply-To: <508A273E.3020500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>


On 10/26/2012 01:01 AM, Santosh Shilimkar wrote:
> Jon,
> 
> On Friday 26 October 2012 04:22 AM, Jon Hunter wrote:
>> Hi Kevin,
>>
>> On 10/25/2012 11:34 AM, Kevin Hilman wrote:
>>> From: Kevin Hilman <khilman@ti.com>
>>>
> 
> [...]
> 
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 94cbc84..ce1da19 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -539,6 +539,8 @@ static void _reset_gpio(struct gpio_bank *bank,
>>> int gpio)
>>>       _set_gpio_irqenable(bank, gpio, 0);
>>>       _clear_gpio_irqstatus(bank, gpio);
>>>       _set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>>> +    bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
>>> +    _gpio_dbck_disable(bank);
>>
>> We can't use _gpio_dbck_disable() here. This has been specifically
>> implemented
>> for the suspend path and is designed to disable the debounce clock while
>> debounce is enabled (which makes sense). Yes this needs to be cleaned up.
>>
> I thought this bit was clear on v2 discussion list that debounce
> clock disable needs to be conditional based on debounce mask.

Yes that part was crystal clear ;-)

However, what I had overlooked was how _gpio_dbck_disable() was
implemented and is intended to work. Hence, I do not call this new in
the _gpio_clear_debounce() function.

>>  From 33812f3bd4f7aab1154e7194b7f11fba700a5086 Mon Sep 17 00:00:00 2001
>> From: Jon Hunter <jon-hunter@ti.com>
>> Date: Thu, 25 Oct 2012 16:00:51 -0500
>> Subject: [PATCH] gpio/omap: fix clearing of debounce settings on gpio
>>   free/reset
>>
>> When a GPIO is freed or shutdown, we need to ensure that any debounce
>> settings
>> are cleared and if the GPIO is the only GPIO in the bank that is
>> currently
>> using debounce, then disable the debounce clock as well to save power.
>>
>> Therefore, introduce a new function called _clear_gpio_debounce() to
>> clear
>> any debounce settings when the GPIO is freed or shutdown.
>>
>> Please note that we cannot use _gpio_dbck_disable() to disable the
>> debounce
>> clock because this has been specifically created for the gpio suspend
>> path
>> and is intended to shutdown the debounce clock while debounce is enabled.
>>
>> This has been unit tested on an OMAP3430 Beagle board, by requesting a
>> gpio,
>> enabling debounce and then freeing the gpio and checking the register
>> contents,
>> the saved register context and the debounce clock state.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
> Now that we are aligned, so we can take this patch forward. Feel free
> to add my ack in case you plan to refresh it.
> 
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks!

Jon


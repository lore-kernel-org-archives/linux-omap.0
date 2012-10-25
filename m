From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2] gpio/omap: fix off-mode bug: clear debounce clock
 enable mask on free/reset
Date: Thu, 25 Oct 2012 11:49:24 -0500
Message-ID: <50896D94.4010803@ti.com>
References: <1351098641-23917-1-git-send-email-khilman@deeprootsystems.com> <50887197.8010104@ti.com> <5088E387.2050704@ti.com> <50893A71.1030702@ti.com> <87hapi4ir9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35362 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935930Ab2JYQtd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 12:49:33 -0400
In-Reply-To: <87hapi4ir9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>


On 10/25/2012 11:30 AM, Kevin Hilman wrote:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
>> On 10/25/2012 02:00 AM, Santosh Shilimkar wrote:
>>> On Thursday 25 October 2012 04:24 AM, Jon Hunter wrote:
>>>>
>>>> On 10/24/2012 12:10 PM, Kevin Hilman wrote:
>>>>> From: Kevin Hilman <khilman@ti.com>
>>>>>
>>>>> When a GPIO bank is freed or shutdown, ensure that the banks
>>>>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>>>>> subsequent off-mode transition will restore previous value from the
>>>>> shadow copies (bank->context.debounce*) leading to mismatch state
>>>>> between driver state and hardware state.
>>>>>
>>>>> This was discovered when board code was doing
>>>>>
>>>>>    gpio_request_one()
>>>>>    gpio_set_debounce()
>>>>>    gpio_free()
>>>>>
>>>>> which was leaving the GPIO debounce settings in a confused state.  If
>>>>> that GPIO bank is subsequently used with off-mode enabled, bogus state
>>>>> would be restored, leaving GPIO debounce enabled which then prevented
>>>>> the CORE powerdomain from transitioning.
>>>>>
>>>>> To fix, ensure that bank->dbck_enable_mask is cleared when the bank
>>>>> is freed/shutdown so debounce state doesn't persist.
>>> The freed part is fine but I don't understand why it needs to be done
>>> on _a_ gpio irq shutdown callback where IRQs related configuration
>>> on that one GPIO needs to be cleared. De-bounce clock is surely not IRQ
>>> related configuration.
>>
>> If we are freeing the IRQs related to gpio and resetting the gpio, then
>> I don't see why we should not. We should not leave the debounce clock on
>> if these gpios are no longer being used.
>>
>>>>> Special thanks to Grazvydas Ignotas for pointing out a bug in an
>>>>> earlier version that would've disabled debounce on any runtime PM
>>>>> transition.
>>>>>
>>>>> Reported-by: Paul Walmsley <paul@pwsan.com>
>>>>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>>>>> Cc: Grazvydas Ignotas <notasas@gmail.com>
>>>>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>>>>> ---
>>>>> v2: only clear mask in free/shutdown, not in runtime PM paths,
>>>>>      clarified changelog
>>>>> Applies on v3.7-rc2.
>>>>>
>>>>>   drivers/gpio/gpio-omap.c | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>>> index 94cbc84..113b167 100644
>>>>> --- a/drivers/gpio/gpio-omap.c
>>>>> +++ b/drivers/gpio/gpio-omap.c
>>>>> @@ -539,6 +539,7 @@ static void _reset_gpio(struct gpio_bank *bank,
>>>>> int gpio)
>>>>>       _set_gpio_irqenable(bank, gpio, 0);
>>>>>       _clear_gpio_irqstatus(bank, gpio);
>>>>>       _set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>>>>> +    bank->dbck_enable_mask = 0;
>>>>>   }
>>>>
>>>> Does this need to be ...
>>>>
>>>> +    bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
>>>> +    _gpio_dbck_disable(bank);
>>>>
>>> Yes, its a per bank clock. There is an alternate. See below.
>>>
>>>> There could be more than one gpio using debounce and so we should only
>>>> clear the appropriate bit. Also after clearing a bit we could see if we
>>>> can disable the debounce clock too.
>>>>
>>> When I mentioned the clearing in gpio_free() path will do trick, I had
>>> something like below in mind.
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index dee2856..8574105 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -629,8 +629,10 @@ static void omap_gpio_free(struct gpio_chip *chip,
>>> unsigned offset)
>>>       * If this is the last gpio to be freed in the bank,
>>>       * disable the bank module.
>>>       */
>>> -    if (!bank->mod_usage)
>>> +    if (!bank->mod_usage) {
>>> +        bank->dbck_enable_mask = 0;
>>>          pm_runtime_put(bank->dev);
>>> +    }
>>
>> However, with this we could be leaving the debounce clock on longer than
>> needed. I think we need to call _gpio_dbck_disable() each time we free a
>> gpio and this function will determine if it can turn off the debounce
>> clock.
>>
>> In fact, there appears to be another bug in the current driver, that we
>> do not clear the debounce_en register when freeing the gpio. Your patch
>> addresses this, but I think that debounce should be disabled when a gpio
>> is freed and not just when the last one is freed.
>>
>> Also, with the above change, can't we still run into the original
>> problem? In other words, if a gpio is freed, but there is still another
>> one active in the back that is not using debounce, then we could restore
>> a incorrect debounce context because we have not clean-up the debounce
>> settings?
>>
>> So may be we need to add a _clear_gpio_debounce() function and
>> call this when freeing a gpio.
> 
> Care to cook up a patch for this, on top of v3 of $SUBJECT patch?

Yes will do.

Cheers
Jon

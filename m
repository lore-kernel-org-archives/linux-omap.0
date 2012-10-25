From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] gpio/omap: fix off-mode bug: clear debounce clock enable mask on free/reset
Date: Thu, 25 Oct 2012 09:26:36 -0700
Message-ID: <87mwza4iwz.fsf@deeprootsystems.com>
References: <1351098641-23917-1-git-send-email-khilman@deeprootsystems.com>
	<50887197.8010104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62834 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058Ab2JYQ0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 12:26:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2127990pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:26:05 -0700 (PDT)
In-Reply-To: <50887197.8010104@ti.com> (Jon Hunter's message of "Wed, 24 Oct
	2012 17:54:15 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

Jon Hunter <jon-hunter@ti.com> writes:

> On 10/24/2012 12:10 PM, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> When a GPIO bank is freed or shutdown, ensure that the banks
>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>> subsequent off-mode transition will restore previous value from the
>> shadow copies (bank->context.debounce*) leading to mismatch state
>> between driver state and hardware state.
>> 
>> This was discovered when board code was doing
>> 
>>   gpio_request_one()
>>   gpio_set_debounce()
>>   gpio_free()
>> 
>> which was leaving the GPIO debounce settings in a confused state.  If
>> that GPIO bank is subsequently used with off-mode enabled, bogus state
>> would be restored, leaving GPIO debounce enabled which then prevented
>> the CORE powerdomain from transitioning.
>> 
>> To fix, ensure that bank->dbck_enable_mask is cleared when the bank
>> is freed/shutdown so debounce state doesn't persist.
>> 
>> Special thanks to Grazvydas Ignotas for pointing out a bug in an
>> earlier version that would've disabled debounce on any runtime PM
>> transition.
>> 
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>> Cc: Grazvydas Ignotas <notasas@gmail.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> v2: only clear mask in free/shutdown, not in runtime PM paths, 
>>     clarified changelog   
>> Applies on v3.7-rc2.
>> 
>>  drivers/gpio/gpio-omap.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 94cbc84..113b167 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -539,6 +539,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
>>  	_set_gpio_irqenable(bank, gpio, 0);
>>  	_clear_gpio_irqstatus(bank, gpio);
>>  	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>> +	bank->dbck_enable_mask = 0;
>>  }
>
> Does this need to be ...
>
> +	bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
> +	_gpio_dbck_disable(bank);
>
> There could be more than one gpio using debounce and so we should only
> clear the appropriate bit. Also after clearing a bit we could see if we
> can disable the debounce clock too.

Sigh, you're right.  I'm clearly in too much of a rush with this one.
Thanks for taking the time to review. 

v3 coming right up using your suggestsion after some testing just to be
sure it fixes that bug.

Kevin


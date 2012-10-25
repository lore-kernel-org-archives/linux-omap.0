From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] gpio/omap: fix off-mode bug: clear debounce clock enable mask on free/reset
Date: Thu, 25 Oct 2012 16:57:19 -0700
Message-ID: <871ugmqf4w.fsf@deeprootsystems.com>
References: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com>
	<5089C2B6.5020606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:62165 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2JYX4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:56:47 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1020989dak.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 16:56:47 -0700 (PDT)
In-Reply-To: <5089C2B6.5020606@ti.com> (Jon Hunter's message of "Thu, 25 Oct
	2012 17:52:38 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

Jon Hunter <jon-hunter@ti.com> writes:

> Hi Kevin,
>
> On 10/25/2012 11:34 AM, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> When a GPIO is freed or shutdown, ensure that the proper bit in
>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>> subsequent off-mode transition will restore previous debounce values
>> from the shadow copies (bank->context.debounce*) leading to mismatch
>> state between driver state and hardware state.
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
>> To fix, ensure that right bit in bank->dbck_enable_mask is cleared
>> when a GPIO is freed/shutdown so debounce state doesn't persist after
>> free/reset.  If this GPIO is the last debounce-enabled GPIO in the
>> bank, the debounce will also be cut.
>> 
>> Special thanks to Grazvydas Ignotas for pointing out a bug in the
>> first version that would've disabled debounce on any runtime PM
>> transition.
>> 
>> And, special thanks to Jon Hunter for pointing out a bug in the second
>> version which was mistakenly clearing all debounce bits on reset
>> instead of individual GPIOs, as well as suggesting cutting the
>> debounce clock after all debounce bits are cleared.
>
> ... and for introducing yet another bug :-(
>
>> Tesed on 37xx/EVM board which configures GPIO debounce for the ads7846
>> touchscreen in its board file using the above sequence, and so was
>> failing off-mode tests in dynamic idle.  Verified that off-mode tests
>> are passing with this patch.
>> 
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>> Cc: Grazvydas Ignotas <notasas@gmail.com>
>> Cc: Jon Hunter <jon-hunter@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  drivers/gpio/gpio-omap.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 94cbc84..ce1da19 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -539,6 +539,8 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
>>  	_set_gpio_irqenable(bank, gpio, 0);
>>  	_clear_gpio_irqstatus(bank, gpio);
>>  	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>> +	bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
>> +	_gpio_dbck_disable(bank);
>
> We can't use _gpio_dbck_disable() here. This has been specifically implemented
> for the suspend path and is designed to disable the debounce clock while
> debounce is enabled (which makes sense). 

I agree, it makes sense.  It reminds me that this driver could use some
comments, since each time I come back to it I forget why some of this
stuff is there.

> Yes this needs to be cleaned up.

Most certainly agree.

> I have implemented the following and unit tested. Care to test on your 37xx
> board? Sorry I would do it myself I had one. 

Yes, it fixes the off-mode dynamic idle problem on my 37xx EVM.

> Also not sure if you just wish to squash your patch and mine together.
> This is based on top of yours.

Let's just drop mine and you can take this forward.

> Cheers
> Jon
>
> From 33812f3bd4f7aab1154e7194b7f11fba700a5086 Mon Sep 17 00:00:00 2001
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Thu, 25 Oct 2012 16:00:51 -0500
> Subject: [PATCH] gpio/omap: fix clearing of debounce settings on gpio
>  free/reset
>
> When a GPIO is freed or shutdown, we need to ensure that any debounce settings
> are cleared and if the GPIO is the only GPIO in the bank that is currently
> using debounce, then disable the debounce clock as well to save power.

Since this is a fix needed for v3.7-rc, you should add a bit more here
describing what was broken (bogus context restore, etc.)  Basically
answering "why" to your the "we need to ensure that..." statement.

> Therefore, introduce a new function called _clear_gpio_debounce() to clear
> any debounce settings when the GPIO is freed or shutdown.
>
> Please note that we cannot use _gpio_dbck_disable() to disable the debounce
> clock because this has been specifically created for the gpio suspend path
> and is intended to shutdown the debounce clock while debounce is enabled.
>
> This has been unit tested on an OMAP3430 Beagle board, by requesting a gpio,
> enabling debounce and then freeing the gpio and checking the register contents,
> the saved register context and the debounce clock state.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Reviewed-by: Kevin Hilman <khilman@ti.com>

(though not that that matters now that I've shown a high-level of
 incompetence with this patch)  ;)

Also, 

Tested-by: Kevin Hilman <khilman@ti.com>

When reposting for Linus W., you might make this 'v4' so that it's clear
that it superceeds the other bungling attempts at the same fix.

Thanks for following this through,

Kevin

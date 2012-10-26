From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3] gpio/omap: fix off-mode bug: clear debounce clock
 enable mask on free/reset
Date: Fri, 26 Oct 2012 11:31:34 +0530
Message-ID: <508A273E.3020500@ti.com>
References: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com> <5089C2B6.5020606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36049 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283Ab2JZGBs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 02:01:48 -0400
In-Reply-To: <5089C2B6.5020606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

Jon,

On Friday 26 October 2012 04:22 AM, Jon Hunter wrote:
> Hi Kevin,
>
> On 10/25/2012 11:34 AM, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>>

[...]

>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 94cbc84..ce1da19 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -539,6 +539,8 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
>>   	_set_gpio_irqenable(bank, gpio, 0);
>>   	_clear_gpio_irqstatus(bank, gpio);
>>   	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>> +	bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
>> +	_gpio_dbck_disable(bank);
>
> We can't use _gpio_dbck_disable() here. This has been specifically implemented
> for the suspend path and is designed to disable the debounce clock while
> debounce is enabled (which makes sense). Yes this needs to be cleaned up.
>
I thought this bit was clear on v2 discussion list that debounce
clock disable needs to be conditional based on debounce mask.

>  From 33812f3bd4f7aab1154e7194b7f11fba700a5086 Mon Sep 17 00:00:00 2001
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Thu, 25 Oct 2012 16:00:51 -0500
> Subject: [PATCH] gpio/omap: fix clearing of debounce settings on gpio
>   free/reset
>
> When a GPIO is freed or shutdown, we need to ensure that any debounce settings
> are cleared and if the GPIO is the only GPIO in the bank that is currently
> using debounce, then disable the debounce clock as well to save power.
>
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
> ---
Now that we are aligned, so we can take this patch forward. Feel free
to add my ack in case you plan to refresh it.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


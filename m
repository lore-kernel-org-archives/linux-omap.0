From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/11] ARM: OMAP2/3: GPIO: do not attempt to wake-enable
Date: Thu, 21 May 2009 08:53:18 -0700
Message-ID: <8763fufo5t.fsf@deeprootsystems.com>
References: <20090414214638.9878.17987.stgit@localhost>
	<20090414215826.9878.86819.stgit@localhost>
	<7B4574D56E4ADF438756313E9A172A87397A91F5@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f103.google.com ([209.85.216.103]:62425 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbZEUPxT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 11:53:19 -0400
Received: by pxi1 with SMTP id 1so772769pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2009 08:53:20 -0700 (PDT)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A87397A91F5@dlee01.ent.ti.com> (Jon Hunter's message of "Mon\, 18 May 2009 14\:50\:49 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

"Hunter, Jon" <jon-hunter@ti.com> writes:

> Hi Kevin,
>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/plat-omap/gpio.c |   14 ++++----------
>>  1 files changed, 4 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index d3fa41e..210a1c0 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -921,13 +921,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank,
>> int gpio, int enable)
>>  	case METHOD_MPUIO:
>>  	case METHOD_GPIO_1610:
>>  		spin_lock_irqsave(&bank->lock, flags);
>> -		if (enable) {
>> +		if (enable)
>>  			bank->suspend_wakeup |= (1 << gpio);
>> -			enable_irq_wake(bank->irq);
>> -		} else {
>> -			disable_irq_wake(bank->irq);
>> +		else
>>  			bank->suspend_wakeup &= ~(1 << gpio);
>> -		}
>>  		spin_unlock_irqrestore(&bank->lock, flags);
>>  		return 0;
>>  #endif
>> @@ -940,13 +937,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank,
>> int gpio, int enable)
>>  			return -EINVAL;
>>  		}
>>  		spin_lock_irqsave(&bank->lock, flags);
>> -		if (enable) {
>> +		if (enable)
>>  			bank->suspend_wakeup |= (1 << gpio);
>> -			enable_irq_wake(bank->irq);
>> -		} else {
>> -			disable_irq_wake(bank->irq);
>> +		else
>>  			bank->suspend_wakeup &= ~(1 << gpio);
>> -		}
>>  		spin_unlock_irqrestore(&bank->lock, flags);
>>  		return 0;
>>  #endif
>
>
> I have been looking into an issue that appears to be related to this. I have the following questions with regard to this patch. 
>
> 1). Although, I agree with the above change was there any reason why we did not add some code to set/clear the appropriate bit in the WKUENA register in this function? If this function is called via a call to set_irq_wake it will not modify the WKUENA register. Therefore, we were thinking of something along the lines of:
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 17d7afe..895c548 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -941,10 +941,13 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>                         return -EINVAL;
>                 }
>                 spin_lock_irqsave(&bank->lock, flags);
> -               if (enable)
> +               if (enable) {
>                         bank->suspend_wakeup |= (1 << gpio);
> -               else
> +                       __raw_writel(1 << gpio, bank->base + OMAP24XX_GPIO_SETWKUENA);
> +               } else {
> +                       __raw_writel(1 << gpio, bank->base + OMAP24XX_GPIO_CLEARWKUENA);
>                         bank->suspend_wakeup &= ~(1 << gpio);
> +               }
>                 spin_unlock_irqrestore(&bank->lock, flags);
>                 return 0;
>  #endif

You're right, ti doesn't enable the wakeup here, but it does
eventually get enabled in the suspend hook.  See the handling of the
bank->suspend_wakeup mask in the suspend hook.

This brings up an interesting point though that GPIO IRQs that are
configured as wakeups will cannot bring the system out of idle, but
can only bring the system out of suspend.

>
> 2). We have found that a call to request_irq results in a call to the function "set_24xx_gpio_triggering()" (for OMAP3430). In addition to configuring the triggering for a given GPIO, this function is also programming the WKUENA register. Hence, the wake-up enable is enabled for GPIO without calling set_irq_wake(). 
>
> I am not sure if this is the intended behaviour or if drivers should explicitly be calling set_irq_wake to enable/disable the wake-up. 

If a driver calls request_irq with one of the IRQF_TRIGGER* flags
(other than _NONE, see <linux/interrupt.h>), then the triggering code
should be called as internally, request_irq handles this.

If no IRQF_TRIGGER* flag is handed to request_irq() and the triggering
is still being enbabled, this is a bug.

> The other problem with this is that once request_irq is called for a
> gpio, then even if we call disable_irq the wake-up event is not
> cleared. So this means that a gpio event will still wake-up the
> device without the gpio being enabled and because the gpio is
> disabled the event will never be cleared and hence will prevent
> retention.
>
> So should the wake-up event only be enabled/disabled by a call to
> set_irq_wake() or should we make sure that calling disable_irq in
> turn calls gpio_mask_irq and make sure this clears the wake-up
> event?

IMHO, it should only be enabled/disabled by a call to *_irq_wake(), or
a request_irq with (flags & IRQF_TRIGGER_MASK) != 0

Kevin

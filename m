From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] gpio/omap: implement irq_enable/disable using mask/unmask.
Date: Thu, 20 Dec 2012 10:16:56 -0600
Message-ID: <50D339F8.6050200@ti.com>
References: <1355736437-14186-1-git-send-email-andreas.fenkart@streamunlimited.com> <50D2A94A.6060100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41512 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab2LTQRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 11:17:03 -0500
In-Reply-To: <50D2A94A.6060100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org


On 12/19/2012 11:59 PM, Santosh Shilimkar wrote:
> On Monday 17 December 2012 02:57 PM, Andreas Fenkart wrote:
> 
> Please add some changelog here too.
> 
>> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
>> ---
> Patch seems straight forward thought will be interesting where you found
> the need of it.

The only item that I was thinking of if the behaviour of mask/unmask
should be different from enable/disable?

When a gpio interrupt is masked, the gpio event will still be latched in
the interrupt status register so when you unmask it later you may get an
interrupt straight away. However, if the interrupt is disabled then gpio
events occurring will not be latched/stored.

I am also interested in the need for this, and if we should have a true
enable/disable here.

Cheers
Jon

> 
>>   drivers/gpio/gpio-omap.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index d335af1..c1951ec 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -815,6 +815,8 @@ static struct irq_chip gpio_irq_chip = {
>>       .irq_unmask    = gpio_unmask_irq,
>>       .irq_set_type    = gpio_irq_type,
>>       .irq_set_wake    = gpio_wake_enable,
>> +    .irq_disable    = gpio_mask_irq,
>> +    .irq_enable     = gpio_unmask_irq,
>>   };
>>
>>  
>> /*---------------------------------------------------------------------*/
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

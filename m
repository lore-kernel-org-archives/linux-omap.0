From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask
 is changed
Date: Mon, 14 Oct 2013 11:15:00 +0300
Message-ID: <525BA804.3010901@ti.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com> <20131011172128.GT29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41522 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3JNIPc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 04:15:32 -0400
In-Reply-To: <20131011172128.GT29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, peter.ujfalusi@ti.com, haojian.zhuang@linaro.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 10/11/2013 08:21 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [131011 09:21]:
>> On OMAPs the IO ring must be rearmed each time the pad wakeup
>> configuration is changed. So call pcs_soc->rearm() from
>> pcs_irq_set().
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/pinctrl/pinctrl-single.c |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
>> index c2aada7..1800e47 100644
>> --- a/drivers/pinctrl/pinctrl-single.c
>> +++ b/drivers/pinctrl/pinctrl-single.c
>> @@ -1604,6 +1604,9 @@ static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
>>  		pcs->write(mask, pcswi->reg);
>>  		raw_spin_unlock(&pcs->lock);
>>  	}
>> +
>> +	if (pcs_soc->rearm)
>> +		pcs_soc->rearm();
>>  }
>>  
>>  /**
>> @@ -1626,8 +1629,6 @@ static void pcs_irq_unmask(struct irq_data *d)
>>  	struct pcs_soc_data *pcs_soc = irq_data_get_irq_chip_data(d);
>>  
>>  	pcs_irq_set(pcs_soc, d->irq, true);
>> -	if (pcs_soc->rearm)
>> -		pcs_soc->rearm();
>>  }
> 
> This seems to cause the wake-up interrupts to happen also during
> runtime for me, which makes the omap3 behave the same way as omap4
> already does.
> 
> However, the concern I have is that we only want the io chain
> wake-up happen during idle and not during runtime.. So counting
> on the io chain in your EHCI driver during runtime would require
> also additional tracking of idle wake up events vs runtime wake-up
> events somewhere once we have the automatic solution for runtime PM.
> That is to avoid spurious interrupts during runtime.

Right. It is upto the driver to disable the irq when it is not interested
in the wake up interrupts.

> 
> In any case, since this is an interrupt controller now, we should
> just follow the Linux standard for interrupt controllers, so if
> you do a request_irq() on it, you really should get interrupts.
> 
> I've updated the patch a litte below to also remove the now bogus
> comment, and to update the description.
> 
> So considering all that, I suggest that Linus applies the updated
> fix below into the pinctrl tree after pulling in the the tag I
> posted for "pinctrl-single-for-linus-for-v3.13-signed".

Great. Thanks.

cheers,
-roger

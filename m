From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Wed, 05 Aug 2009 07:36:04 -0700
Message-ID: <877hxi9vl7.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D532D196@zmy16exm69.ds.mot.com>
	<20090805123354.GF7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f179.google.com ([209.85.222.179]:50204 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934540AbZHEOgH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:36:07 -0400
Received: by pzk9 with SMTP id 9so82826pzk.21
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 07:36:07 -0700 (PDT)
In-Reply-To: <20090805123354.GF7374@atomide.com> (Tony Lindgren's message of "Wed\, 5 Aug 2009 15\:33\:55 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Wang Sawsd-A24013 <cqwang@motorola.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Hi,
>
> Sorry for the long delay on replying to this one.

Tony, this one has been superceded, and the irq_enable/disable stuff no
longer is needed due to the patch

  OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask

from my PM fixes queue.

An updated version (currently in the PM branch) is here:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=c80a909697ad931ffad9d30ed321469fa699b208

but...

> * Wang Sawsd-A24013 <cqwang@motorola.com> [090602 02:25]:
>> This patch adds irq_enable and irq_disable for OMAP GPIO IRQ chip, and
>> also only enable WAKEUPEN
>> When GPIO edge detection is enabled, also clear the gpio event
>> triggering configurations to avoid
>> Pending interrupt status which is generated regardless of the IRQEN and
>> WKUPEN bit, the pending
>> IRQ status may prevent GPIO module acknowledge IDLE request and prevent
>> PER and thus RETENTION.
>> 
>> This is only applied for OMAP2/3 GPIO IRQs.
>> 
>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>> ---
>>  arch/arm/plat-omap/gpio.c |   44
>> ++++++++++++++++++++++++++++++++++++++++++--
>>  1 files changed, 42 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index bd04b40..19e0461 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -581,7 +581,7 @@ void omap_set_gpio_debounce_time(int gpio, int
>> enc_time)
>>  EXPORT_SYMBOL(omap_set_gpio_debounce_time);
>>  
>>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>> -static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int
>> gpio,
>> +static void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>>  						int trigger)
>>  {
>>  	void __iomem *base = bank->base;
>> @@ -597,7 +597,12 @@ static inline void set_24xx_gpio_triggering(struct
>> gpio_bank *bank, int gpio,
>>  		trigger & IRQ_TYPE_EDGE_FALLING);
>>  
>>  	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>> -		if (trigger != 0)
>> +		/*
>> +		 * GPIO wakeup request can only be generated on edge
>> +		 * transitions, see OMAP34xx_ES3.1_TRM_V_Q G25.5.3.1
>> +		 * wake-up request note for detail
>> +		 */
>> +		if ((trigger & IRQ_TYPE_EDGE_BOTH) != 0)
>>  			__raw_writel(1 << gpio, bank->base
>>  					+ OMAP24XX_GPIO_SETWKUENA);
>>  		else
>
> To me it looks like the right way to deal with the level gpio
> would be to change it temporarily to be edge for the duration of
> idle, then change it back to be level after returning from idle.

Not sure about that.  That would have to be experimented with to 
see if there are any other side effects.

In any case, that kind of change would be independent of this change
as this change just fixes a bug so wake-enables are only set on
edge-triggered GPIOs.

Kevin


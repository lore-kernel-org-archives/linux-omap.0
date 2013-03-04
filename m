From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
Date: Mon, 4 Mar 2013 11:06:12 -0600
Message-ID: <5134D484.8070307@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com> <1362158568-1624-2-git-send-email-jon-hunter@ti.com> <20130302114742.GA9965@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758074Ab3CDRGn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 12:06:43 -0500
In-Reply-To: <20130302114742.GA9965@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 03/02/2013 05:48 AM, Felipe Balbi wrote:
> On Fri, Mar 01, 2013 at 11:22:47AM -0600, Jon Hunter wrote:
>> Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
>> domain. This is not necessary because we do not need to assign a
>> specific interrupt number to the GPIO IRQ domain. Therefore, convert
>> the OMAP GPIO driver to use a linear mapping instead.
>>
>> Please note that this also allows to simplify the logic in the OMAP
>> gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
>> virtual irq number from the GPIO bank and bank index.
>>
>> Reported-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> Just one suggestion below for a later patch.
> 
>> @@ -680,7 +686,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>>  {
>>  	void __iomem *isr_reg = NULL;
>>  	u32 isr;
>> -	unsigned int gpio_irq, gpio_index;
>> +	unsigned int i;
>>  	struct gpio_bank *bank;
>>  	int unmasked = 0;
>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>> @@ -721,15 +727,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>>  		if (!isr)
>>  			break;
>>  
>> -		gpio_irq = bank->irq_base;
>> -		for (; isr != 0; isr >>= 1, gpio_irq++) {
>> -			int gpio = irq_to_gpio(bank, gpio_irq);
>> -
>> +		for (i = 0; isr != 0; isr >>= 1, i++) {
>>  			if (!(isr & 1))
>>  				continue;
> 
> this will iterate over all 32 GPIOs, a better way to handle this would
> be to have something like:

Worse case, if only bit 31 was set then I agree this is not that
efficient. Or even if one bit is set. However, the loop itself will
iterate while isr != 0 so not always over each bit. No different to the
existing code.

> while (isr) {
> 	unsigned long bit = __ffs(isr);
>
> 	/* clear this bit */
> 	isr &= ~bit;
> 
> 	generic_handle_irq(irq_find_mapping(bank->domain, bit);
> }
> 
> this way you will only iterate the amount of bits enabled in the isr
> register.

Definitely cleaner but I am wondering which approach would be more
efficient from an instruction standpoint. This could definitely be much
more efficient if there is only a couple bits set.

> ps: completely untested ;-)

No problem. Thanks for the inputs.

Cheers
Jon

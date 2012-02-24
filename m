From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
Date: Fri, 24 Feb 2012 15:54:52 +0100
Message-ID: <4F47A4BC.3020307@ti.com>
References: <4F46C1AF.2040201@ti.com> <4F479B31.7090508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab2BXOy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 09:54:58 -0500
In-Reply-To: <4F479B31.7090508@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2/24/2012 3:14 PM, Rob Herring wrote:
> On 02/23/2012 04:46 PM, Cousson, Benoit wrote:
...
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index bc2bd69..afef0f7 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -93,6 +93,11 @@ struct gpio_bank {
>>   #define GPIO_BIT(bank, gpio) (1<<  GPIO_INDEX(bank, gpio))
>>   #define GPIO_MOD_CTRL_BIT	BIT(0)
>>
>> +static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
>> +{
>> +	return gpio_irq - bank->irq_base + bank->chip.base;
>
> Ideally, you could do something like this when you have a domain setup:
>
> irq_get_irq_data(gpio_irq)->hw_irq + bank->chip.base

OK, good to know. I still plan to move the current irq_domain basic 
support to the irqchip stuff you have done. I'll do that after 3.4.

> Also, with sparse irq you need to have a call to irq_alloc_desc.

irq_alloc_desc was already added as part of the DT migration patch.
It was not explicit in the changelog, but that patch is based on GPIO 
cleanup + DT migration series.

> You can avoid that by setting NR_IRQS or machine .nr_irqs, but that needs to go
> away.

Based on a recommendation you did in the commit to fix GIC I did that in 
the SPARSE_IRQ series I've just sent before that RFC patch:

+#ifdef CONFIG_SPARSE_IRQ
+#define NR_IRQS			NR_IRQS_LEGACY
+#else
  #define NR_IRQS			OMAP_GPMC_IRQ_END
+#endif

> Otherwise, it certainly is a step in the right direction.

Yeah, there is still a long way to clean all the old nasty IRQ stuff in 
OMAP :-)

Thanks,
Benoit

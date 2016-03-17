From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 08/15] genirq: Add runtime power management support for
 IRQ chips
Date: Thu, 17 Mar 2016 15:46:08 +0000
Message-ID: <56EAD140.3090709@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1603171556020.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1603171556020.3978@nanos>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 17/03/16 15:02, Thomas Gleixner wrote:
> On Thu, 17 Mar 2016, Jon Hunter wrote:
>>  /**
>>   * struct irq_chip - hardware interrupt chip descriptor
>>   *
>> + * @parent:		pointer to associated device
> 
> That's really a bad name. parent suggests that this is a parent interrupt chip
> and your explanation sucks as well. What's an associated device? Network card? 

Linus, can you re-iterate your concerns here about just using 'dev' for
the name?

>>  #include <linux/irqdesc.h>
>>  #include <linux/kernel_stat.h>
>> +#include <linux/pm_runtime.h>
>>  
>>  #ifdef CONFIG_SPARSE_IRQ
>>  # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index b2a93a37f772..65878e7c7c82 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1114,6 +1114,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>>  	if (!try_module_get(desc->owner))
>>  		return -ENODEV;
>>  
>> +	ret = irq_chip_pm_get(&desc->irq_data);
>> +	if (ret < 0)
>> +		goto out_mput;
> 
> So this call nests inside the chip_bus_lock() region. Is that intentional?

Hmm ... I was trying to simplify the call paths, but yes I think it
would be safer to move outside. Ok, will fix that.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

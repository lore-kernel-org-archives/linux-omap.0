From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 08/19] irqchip: crossbar: fix checkpatch warning
Date: Thu, 12 Jun 2014 19:05:24 +0530
Message-ID: <5399AC9C.4080602@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com> <1402574007-13987-9-git-send-email-r.sricharan@ti.com> <20140612131042.GU8664@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140612131042.GU8664-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jason,

On Thursday 12 June 2014 06:40 PM, Jason Cooper wrote:
> On Thu, Jun 12, 2014 at 05:23:16PM +0530, Sricharan R wrote:
>> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>
>> remove un-necessary space in function pointer.
>>
>> Fixes checkpatch warning:
>> WARNING: Unnecessary space before function pointer arguments
>>  #37: FILE: drivers/irqchip/irq-crossbar.c:37:
>>  +	void (*write) (int, int);
>>
>> WARNING: Missing a blank line after declarations
>> +	int *register_offsets;
>> +	void (*write)(int, int);
>>
>> WARNING: Prefer kcalloc over kzalloc with multiply
>> +	cb->irq_map = kzalloc(max * sizeof(int), GFP_KERNEL);
>>
>> WARNING: Prefer kcalloc over kzalloc with multiply
>> +	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);
>>
>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/irqchip/irq-crossbar.c |    7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
>> index 5da9d36..58790d4 100644
>> --- a/drivers/irqchip/irq-crossbar.c
>> +++ b/drivers/irqchip/irq-crossbar.c
>> @@ -34,7 +34,8 @@ struct crossbar_device {
>>  	uint *irq_map;
>>  	void __iomem *crossbar_base;
>>  	int *register_offsets;
>> -	void (*write) (int, int);
>> +
>> +	void (*write)(int, int);
> 
> The empty line here looks bogus to me.  Did you re-run checkpatch after
> fixing the unnecessary space to see if it still complained about having
> a 'blank line after declarations'?
> 
 Yes, it still complains even after fixing unnecessary space.

WARNING: Missing a blank line after declarations
#37: FILE: ./drivers/irqchip/irq-crossbar.c:37:
+	int *register_offsets;
+	void (*write)(int, int);

>>  };
>>  
>>  /**
>> @@ -150,7 +151,7 @@ static int __init crossbar_of_init(struct device_node *node,
>>  		goto err1;
>>  
>>  	of_property_read_u32(node, "ti,max-irqs", &max);
>> -	cb->irq_map = kzalloc(max * sizeof(int), GFP_KERNEL);
>> +	cb->irq_map = kcalloc(max, sizeof(int), GFP_KERNEL);
>>  	if (!cb->irq_map)
>>  		goto err2;
>>  
>> @@ -176,7 +177,7 @@ static int __init crossbar_of_init(struct device_node *node,
>>  		}
>>  	}
>>  
>> -	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);
>> +	cb->register_offsets = kcalloc(max, sizeof(int), GFP_KERNEL);
>>  	if (!cb->register_offsets)
>>  		goto err3;
> 
> I'm generally opposed to these sorts of checkpatch patches, especially
> when they are just warnings.  It's great for a new driver in the staging
> tree, but it makes backporting future bugfixes that much harder when
> drivers have been live in mainline.
> 
> If, in the future, you're changing code in this area, go ahead and
> convert to kcalloc(), but I wouldn't do a separate patch for this kind
> of thing.
> 
> Honestly, I would just drop this patch and not worry about it.
> 
  Ok, but i just hope that there may not be real needs to make changes
  for this driver in future. So if that's the case then it might be 
  better to fix it once for now.

Regards,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

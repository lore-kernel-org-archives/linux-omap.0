From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Mon, 29 Jun 2009 10:51:09 -0700
Message-ID: <87prcn7wtu.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
	<20090624075756.GA13052@n2100.arm.linux.org.uk>
	<20090629093004.GA2111@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B53AC23F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:54103 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbZF2RvK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 13:51:10 -0400
Received: by pxi28 with SMTP id 28so3565599pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 10:51:12 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B53AC23F@dbde02.ent.ti.com> (Santosh Shilimkar's message of "Mon\, 29 Jun 2009 21\:04\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

>> And here it is - I've only build-tested it so far.
>> 
>>  drivers/mfd/twl4030-irq.c |   55 
>> ++++++++++++++++++--------------------------
>>  1 files changed, 23 insertions(+), 32 deletions(-)
>> 
>> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
>> index bae61b2..4bb1ea7 100644
>> --- a/drivers/mfd/twl4030-irq.c
>> +++ b/drivers/mfd/twl4030-irq.c
>> @@ -180,15 +180,9 @@ static struct completion irq_event;
>>  static int twl4030_irq_thread(void *data)
>>  {
>>  	long irq = (long)data;
>> -	struct irq_desc *desc = irq_to_desc(irq);
>>  	static unsigned i2c_errors;
>>  	static const unsigned max_i2c_errors = 100;
>>  
>> -	if (!desc) {
>> -		pr_err("twl4030: Invalid IRQ: %ld\n", irq);
>> -		return -EINVAL;
>> -	}
>> -
>>  	current->flags |= PF_NOFREEZE;
>>  
>>  	while (!kthread_should_stop()) {
>> @@ -240,38 +234,25 @@ static int twl4030_irq_thread(void *data)
>>  		}
>>  		local_irq_enable();
>>  
>> -		desc->chip->unmask(irq);
>> +		enable_irq(irq);
>>  	}
>>  
>>  	return 0;
>>  }
> Russell,
> Just a question here.
>
> In the enable_irq(irq) and disable_irq(irq) call tree, internally there are calls to 
> the interrupt controller chip.
>
> In disable_irq() path:
> 	desc->chip->disable(irq);
> And in emable_irq() path:
> 	desc->chip->enable(irq);

> But the in gic gic_chip, enable/disable fn are not populated.

And if you look at the OMAP's MPU irq_chip implementation, these are 
not populated either.  We rely on the default lazy enable via unmask
and the lazy disable.

Kevin

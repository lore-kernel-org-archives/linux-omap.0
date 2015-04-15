From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] genirq: provide dummy set_irq_wake()
Date: Wed, 15 Apr 2015 10:51:15 +0200
Message-ID: <552E2683.8090107@free-electrons.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com> <552CE847.7060103@ti.com> <552D1DEF.6080303@free-electrons.com> <552E1C4A.7060503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <552E1C4A.7060503-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 15/04/2015 10:07, Roger Quadros wrote:
> Hi Gregory,
> 
> On 14/04/15 17:02, Gregory CLEMENT wrote:
>> Hi Roger,
>>
>> On 14/04/2015 12:13, Roger Quadros wrote:
>>> Hi Thomas,
>>>
>>> On 30/03/15 16:15, Roger Quadros wrote:
>>>> Without this system suspend is broken on systems that have
>>>> drivers calling enable/disable_irq_wake() for interrupts based off
>>>> the dummy irq hook.
>>>> (e.g. drivers/gpio/gpio-pcf857x.c)
>>>>
>>>> http://article.gmane.org/gmane.linux.kernel/1879035
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>
>>> Any comments on this patch?
>>
>> I read the url you pointed and I wonder why, at then end, did
>> you choose to add a dummy set_irq_wake() instead of using
>> IRQCHIP_SKIP_SET_WAKE ?
> 
> You mean like this?
> 
> diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
> index 988dc58..2feb6fe 100644
> --- a/kernel/irq/dummychip.c
> +++ b/kernel/irq/dummychip.c
> @@ -57,5 +57,6 @@ struct irq_chip dummy_irq_chip = {
>  	.irq_ack	= noop,
>  	.irq_mask	= noop,
>  	.irq_unmask	= noop,
> +	.flags		= IRQCHIP_SKIP_SET_WAKE,
>  };
>  EXPORT_SYMBOL_GPL(dummy_irq_chip);


Yes exactly.

> 
> This works as well and is better. I'll post a v2.


Thanks,

Gregory

> 
> cheers,
> -roger
> 
>>>
>>>> ---
>>>>  kernel/irq/dummychip.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
>>>> index 988dc58..2405d7a 100644
>>>> --- a/kernel/irq/dummychip.c
>>>> +++ b/kernel/irq/dummychip.c
>>>> @@ -32,6 +32,11 @@ static unsigned int noop_ret(struct irq_data *data)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int noop_int_ret(struct irq_data *data, unsigned int val)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  /*
>>>>   * Generic no controller implementation
>>>>   */
>>>> @@ -57,5 +62,6 @@ struct irq_chip dummy_irq_chip = {
>>>>  	.irq_ack	= noop,
>>>>  	.irq_mask	= noop,
>>>>  	.irq_unmask	= noop,
>>>> +	.irq_set_wake	= noop_int_ret,
>>>>  };
>>>>  EXPORT_SYMBOL_GPL(dummy_irq_chip);
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: Fixed crash bug with serial + suspend
Date: Wed, 04 Mar 2009 12:47:23 -0800
Message-ID: <49AEE8DB.3070607@deeprootsystems.com>
References: <1236073539-21607-1-git-send-email-tero.kristo@nokia.com> <874oya7dd7.fsf@deeprootsystems.com> <1F18D6510CF0474A8C9500565A7E41A2036FBE1987@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:63266 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbZCDUr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 15:47:29 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4109198wfa.4
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2009 12:47:27 -0800 (PST)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A2036FBE1987@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

Tero.Kristo@nokia.com wrote:
>  
> 
>> -----Original Message-----
>> From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: 03 March, 2009 18:58
>> To: Kristo Tero (Nokia-D/Tampere)
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] OMAP3: Fixed crash bug with serial + suspend
>>
>> Tero Kristo <tero.kristo@nokia.com> writes:
>>
>>> It was possible for an unhandled interrupt to occur if there was 
>>> incoming serial traffic during wakeup from suspend. This was 
>> caused by 
>>> the code in arch-arm/mach-omap2/serial.c keeping interrupt 
>> enabled all 
>>> the time, but not acking its interrupts. Applies on top of PM branch.
>>>
>>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>> ---
>>>  arch/arm/mach-omap2/pm34xx.c             |   15 +++++++++++++++
>>>  arch/arm/mach-omap2/serial.c             |   18 ++++++++++++++++++
>>>  arch/arm/plat-omap/include/mach/serial.h |    1 +
>>>  3 files changed, 34 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>>> b/arch/arm/mach-omap2/pm34xx.c index 9102cee..5a627db 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -629,7 +629,22 @@ static void omap3_pm_finish(void)
>>>  	pm_idle = saved_idle;
>>>  }
>>>  
>>> +/* Hooks to enable / disable UART interrupts during suspend 
>> */ static 
>>> +int omap3_pm_begin(suspend_state_t state) {
>>> +	omap_uart_enable_irqs(0);
>>> +	return 0;
>>> +}
>>> +
>>> +static void omap3_pm_end(void)
>>> +{
>>> +	omap_uart_enable_irqs(1);
>>> +	return;
>>> +}
>>> +
>>>  static struct platform_suspend_ops omap_pm_ops = {
>>> +	.begin		= omap3_pm_begin,
>>> +	.end		= omap3_pm_end,
>>>  	.prepare	= omap3_pm_prepare,
>>>  	.enter		= omap3_pm_enter,
>>>  	.finish		= omap3_pm_finish,
>> I think this functionality is more appropriate for the 
>> prepare/finish hooks than the begin/end hooks.  serial.c already has
>> omap_uart_prepare_suspend() hook where the interrupt disable 
>> could be added., and a omap_uart_prepare_resume() call could 
>> be added to the omap3_pm_finish.
> 
> This would cause sequencing issues and it would still be possible to get unhandled interrupts if I understand the behavior of suspend correctly. I think it works (simplified) like this:
> 
> call begin hook
> suspend devices [ this is where the driver interrupt gets disabled ]
> call prepare hook
> enter state [ Zzzz ]
> call finish hook
> resume devices [ this is where the driver interrupt gets enabled ]
> call end hook
> 
> So, if you use prepare / finish hooks to enable the interrupt in serial.c, you will get a short time period where you have the interrupt enabled but you do not have "real" handler for the interrupt. This time is longer if you have some drivers in the system that take a long time to resume/suspend and you are unlucky with the ordering of drivers.

OK, makes sense.  I'm OK with the begin/end hook then.

There are some other conventions when using the begin/end hook that I'll 
probably add.  e.g., if the begin/end hooks are used then the next state
should be set based on the state passed in from begin, and ignored in 
the 'enter' hook.

Anyways, I will fix that part up.

>>> diff --git a/arch/arm/mach-omap2/serial.c 
>>> b/arch/arm/mach-omap2/serial.c index 90f1c67..952da79 100644
>>> --- a/arch/arm/mach-omap2/serial.c
>>> +++ b/arch/arm/mach-omap2/serial.c
>>> @@ -432,6 +432,24 @@ static void omap_uart_idle_init(struct 
>> omap_uart_state *uart)
>>>  	WARN_ON(ret);
>>>  }
>>>  
>>> +void omap_uart_enable_irqs(int enable) {
>>> +	int i, ret;
>>> +
>>> +	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
>>> +		struct plat_serial8250_port *p = 
>> serial_platform_data + i;
>>> +		struct omap_uart_state *uart = &omap_uart[i];
>>> +
>> Can you use the "list_for_each_entry(uart, &uart_list, node)"
>> construct instead of a for loop?  Or was there a reason to 
>> enable/ack all serial interrupts, even those that have not 
>> been enabled.
> 
> Hmm, yea that's true. I'll fix this one.

ok, thanks.

Kevin

>>> +		if (!p->membase)
>>> +			continue;
>>> +		if (enable)
>>> +			ret = request_irq(p->irq, omap_uart_interrupt,
>>> +				IRQF_SHARED, "serial idle", 
>> (void *)uart);
>>> +		else
>>> +			free_irq(p->irq, (void *)uart);
>>> +	}
>>> +}
>>> +
>>>  static ssize_t sleep_timeout_show(struct kobject *kobj,
>>>  				  struct kobj_attribute *attr,
>>>  				  char *buf)
>>> diff --git a/arch/arm/plat-omap/include/mach/serial.h 
>>> b/arch/arm/plat-omap/include/mach/serial.h
>>> index 8e89585..7ca1f27 100644
>>> --- a/arch/arm/plat-omap/include/mach/serial.h
>>> +++ b/arch/arm/plat-omap/include/mach/serial.h
>>> @@ -47,6 +47,7 @@ extern void omap_uart_check_wakeup(void);  extern 
>>> void omap_uart_prepare_suspend(void);  extern void 
>>> omap_uart_prepare_idle(int num);  extern void 
>>> omap_uart_resume_idle(int num);
>>> +extern void omap_uart_enable_irqs(int enable);
>>>  #endif
>>>  
>>>  #endif
>>> --
>>> 1.5.4.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" 
>>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>>> info at  http://vger.kernel.org/majordomo-info.html
>>


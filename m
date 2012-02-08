From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 16/16] ARM: omap: disable cpuidle for OMAP3 platforms
Date: Wed, 08 Feb 2012 15:30:44 -0800
Message-ID: <87haz0ykbf.fsf@ti.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
	<E1RvAZz-0006Hr-9C@rmk-PC.arm.linux.org.uk>
	<20120208185905.GP29796@atomide.com> <87ipjg3osg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:49911 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538Ab2BHXar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:30:47 -0500
Received: by dakp5 with SMTP id p5so1081124dak.8
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 15:30:46 -0800 (PST)
In-Reply-To: <87ipjg3osg.fsf@ti.com> (Kevin Hilman's message of "Wed, 08 Feb
	2012 15:09:51 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Tony Lindgren <tony@atomide.com> writes:
>
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:10]:
>>> Commit 2fd149645eb4 (ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos)
>>> has caused a regression on OMAP3 platforms.
>>> 
>>> When the UART is trying to transmit data, if we enter a low power mode,
>>> transmission stops, which makes serial on OMAP3 unusable - a 'dmesg'
>>> takes five minutes to be output at 115200 baud, at a rate of around a
>>> block of 16 characters every couple of seconds.
>>> 
>>> Unfortunately, the commit above can't be reverted because of many other
>>> changes in this area, so this implements a dirty fix by disabling
>>> CPU idle in the places the original commit does, irrespective of the
>>> UART state.
>> ...
>>
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -421,7 +421,7 @@ static void omap3_pm_idle(void)
>>>  	local_irq_disable();
>>>  	local_fiq_disable();
>>>  
>>> -	if (omap_irq_pending() || need_resched())
>>> +	if (omap_irq_pending() || need_resched() || 1)
>>>  		goto out;
>>>  
>>>  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>>
>> Argh, this is just too ugly. There has got to be a better fix for the
>> -rc series.
>>
>> Looks like the patches to fix omap-serial.c are queued for v3.4,
>> so that won't help.
>>
>> Kevin, what do you have for the -rc fix here to avoid the if (1)
>> hack?
>
> There was confusion with Greg about this serial fixes which were
> supposed to be for -rc.
>
> He pulled the original series in to -rc, and reverted them when Paul
> updated the series.  Then he decided to queue the updated series for
> 3.4. :(
>
> I've now asked Greg if he can queue that series for 3.3.

And he refused (on the 34xx thread). :(

It is a very targetted set of fixes that directly address the problems
in the UART driver, but he has decided they should wait because we went
through a couple revisions.

Maybe you can respond to Greg saying that we really need them for 3.3?

Kevin





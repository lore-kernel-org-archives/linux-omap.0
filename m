From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 16/16] ARM: omap: disable cpuidle for OMAP3 platforms
Date: Wed, 08 Feb 2012 15:09:51 -0800
Message-ID: <87ipjg3osg.fsf@ti.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
	<E1RvAZz-0006Hr-9C@rmk-PC.arm.linux.org.uk>
	<20120208185905.GP29796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:55331 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757524Ab2BHXJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:09:57 -0500
Received: by dakp5 with SMTP id p5so1090904dak.22
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 15:09:53 -0800 (PST)
In-Reply-To: <20120208185905.GP29796@atomide.com> (Tony Lindgren's message of
	"Wed, 8 Feb 2012 10:59:06 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:10]:
>> Commit 2fd149645eb4 (ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos)
>> has caused a regression on OMAP3 platforms.
>> 
>> When the UART is trying to transmit data, if we enter a low power mode,
>> transmission stops, which makes serial on OMAP3 unusable - a 'dmesg'
>> takes five minutes to be output at 115200 baud, at a rate of around a
>> block of 16 characters every couple of seconds.
>> 
>> Unfortunately, the commit above can't be reverted because of many other
>> changes in this area, so this implements a dirty fix by disabling
>> CPU idle in the places the original commit does, irrespective of the
>> UART state.
> ...
>
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -421,7 +421,7 @@ static void omap3_pm_idle(void)
>>  	local_irq_disable();
>>  	local_fiq_disable();
>>  
>> -	if (omap_irq_pending() || need_resched())
>> +	if (omap_irq_pending() || need_resched() || 1)
>>  		goto out;
>>  
>>  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>
> Argh, this is just too ugly. There has got to be a better fix for the
> -rc series.
>
> Looks like the patches to fix omap-serial.c are queued for v3.4,
> so that won't help.
>
> Kevin, what do you have for the -rc fix here to avoid the if (1)
> hack?

There was confusion with Greg about this serial fixes which were
supposed to be for -rc.

He pulled the original series in to -rc, and reverted them when Paul
updated the series.  Then he decided to queue the updated series for
3.4. :(

I've now asked Greg if he can queue that series for 3.3.

Kevin


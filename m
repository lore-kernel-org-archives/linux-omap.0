From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: omap3 cpuidle interrupt latency
Date: Wed, 04 Mar 2009 11:15:10 -0800
Message-ID: <49AED33E.3060206@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com> <873advaet2.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301CC052561@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301CC052FB3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:43752 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbZCDTPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 14:15:16 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4067183wfa.4
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2009 11:15:13 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC052FB3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
>> Sent: Tuesday, March 03, 2009 3:54 PM
>> To: Kevin Hilman
>> Cc: linux-omap@vger.kernel.org
>> Subject: RE: omap3 cpuidle interrupt latency
>>
>>> -----Original Message-----
>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>> Sent: Tuesday, March 03, 2009 1:16 AM
>>> To: Premi, Sanjeev
>>> Cc: linux-omap@vger.kernel.org
>>> Subject: Re: omap3 cpuidle interrupt latency
>>>
>>> "Premi, Sanjeev" <premi@ti.com> writes:
>>>
>>>> I have noticed large interrupt latency when the cpuidle 
>> is enabled.
>>>> e.g. response time for ping goes from avg 10-20ms to 800-1000ms.
>>>> (I am at HEAD of the 'pm' branch)
>>> Is it interrupt latency in general you are measuring?  or just the 
>>> interrupt latency for the smc network driver.  I think what you are 
>>> seeing is the result of the SMC IRQ not being configured as 
>> a wakeup 
>>> source, thus a network interrupt will not wake the system, 
>> but you end 
>>> up waiting for the next idle timer until the system wakes 
>> and handles 
>>> the network interrupt.
>> I used SMC as an example. The read over USB is also slow...
>>
>> I feel there is generic latency. Initially, I was suspecting 
>> the hrtimer functions taking long time. But that may not be the case.
>>
>>> By default, I don't believe the GPIO interrupt used by the smc is 
>>> configured as a wakeup source.  Have you configured that GPIO as a 
>>> wakeup source?
>> My current measurements are based with all idle related flags 
>> 'sleep_while_idle', 'clocks_off_while_idle' and 'enable_off_mode'
>> set at 0.
>>
>> Does WFI require a wakeup event? Even when system is not in 
>> 'off' stare?
> 
> For simple debug, I replaced the _omap_sram_idle() processing with:
> 	__asm__ ("dmb");
> 	__asm__ ("dsb");
> 	__asm__ ("wfi");
> 
> Here, again behavior was same for ethernet.
> 
> For more simplification, I focused on keypad and touchscreen.
> 1) Let the system stay idle for about 10secs
> 2) Press the keypad & tap the touchscreen
> 3) cat /proc/interrupts
> 
> While the keypad interrupts (via SYS_NIRQ) are getting updated;
> most of the TS interrupts (via GPIO) seem to be missing; With a
> busy loop in the background OR _omap_sram_idle() commented - not
> doing WFI - changes the behavior. Each tap on the TS is registered
> in /proc/interrupts.
> 

IIUC, the keypad interrupts are making it all the way to the kernel, but 
the touchscreen ones are not, correct?

What happens if you enable IRQ wakeups for the TS interrupt?

Kevin

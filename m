From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCHv6] OMAP3: Serial: Improved sleep logic
Date: Thu, 11 Mar 2010 18:07:46 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224FCF7B731@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1267118749-1836-1-git-send-email-tero.kristo@nokia.com>
	<87ljebdb3c.fsf@deeprootsystems.com>	<87aaugf37d.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A224FCF7B6C7@NOK-EUMSG-02.mgdnok.nokia.com>
 <87iq92ddos.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33222 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933303Ab0CKRIP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 12:08:15 -0500
In-Reply-To: <87iq92ddos.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 11 March, 2010 18:30
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv6] OMAP3: Serial: Improved sleep logic
>
><Tero.Kristo@nokia.com> writes:
>
>>  
>>
>>>-----Original Message-----
>>>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>>>Sent: 10 March, 2010 20:21
>>>To: Kristo Tero (Nokia-D/Tampere)
>>>Cc: linux-omap@vger.kernel.org
>>>Subject: Re: [PATCHv6] OMAP3: Serial: Improved sleep logic
>>>
>>>Kevin Hilman <khilman@deeprootsystems.com> writes:
>>>
>>>> Tero Kristo <tero.kristo@nokia.com> writes:
>>>>
>>>>> From: Tero Kristo <tero.kristo@nokia.com>
>>>>>
>>>>> This patch contains following improvements:
>>>>> - Only RX interrupt will now kick the sleep prevent timer
>>>>> - TX fifo status is checked before disabling clocks, this 
>>>will prevent
>>>>>   on-going transmission to be cut
>>>>> - Smartidle is now enabled/disabled only while switching 
>>>clocks, as having
>>>>>   smartidle enabled while RX/TX prevents any wakeups from 
>>>being received
>>>>>   from UART module
>>>>> - Added workqueue for wakeup checks, as jiffy timer access 
>>>within the
>>>>>   idle loop results into skewed timers as jiffy timers are stopped
>>>>> - Added garbage_timer for ignoring the first character 
>>>received during
>>>>>   the first tick after clock enable, this prevents garbage 
>>>characters to be
>>>>>   received in low sleep states
>>>>> - omap_uart_enable_irqs() changed to use enable_irq / 
>>>disable_irq instead
>>>>>   of request / free. Using request/free changes the 
>>>behavior after first
>>>>>   suspend due to reversed interrupt handler ordering
>>>>>
>>>>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>>>
>>>> Thanks Tero.  This version looks good.
>>>>
>>>> Adding to pm-fixes queue for 2.6.34-rcX after minor change below...
>>>>
>>>
>>>There's still something slightly strange going on here...
>>>
>>>I noticed via powertop that the garbage timer is now one of the top
>>>reasons for wakeup in an idle system.  Seems like the garbage timer
>>>is firing when it shouldn't be, and triggering unnecessary wakeups
>>>
>>>Based on powertop stats, the garbage timer is firing about 3x more
>>>often than the GPtimer that should be waking the system.
>>
>> You get one timer expire each wakeup cycle, but the system 
>actually fires its own timer for each UART, thus you get 3x. 
>It is possible to optimize the timer a bit by only firing it 
>if we have a wakeup from UART, but this probably causes 
>occasional garbage to the console, if a wakeup from some other 
>source than UART and UART RX happen at the same time. Might be 
>the lesser of two evils though.
>>
>> I can experiment with this change a bit and see how it behaves.
>>
>
>OK, the 3x makes sense, but the garbage timer should never be the
>cause of a wakeup.
>
>Maybe you also need to be sure that the garbage timer is disabled
>before clocks are disabled so it doesn't fire and cause a wakeup.

Yeah, that's another addition that I can do, but I don't think the system is actually woken up even though powertop claims so. Powertop is not too reliable wakeup source indicator, it only shows the number of expired timers / interrupts in most cases, but it does not know whether the device was sleeping when the interrupt was raised or not. The number of wakeups can be reliably seen from the number of PRCM interrupts that have occurred, but powertop does not parse the results too well for OMAP3 currently. And, there is no wakeup source indicator anyway available that would be exported from the kernel currently. I have fiddled at some point with a patch that does this, but I never posted it anywhere.

-Tero

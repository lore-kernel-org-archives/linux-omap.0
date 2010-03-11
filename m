From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCHv6] OMAP3: Serial: Improved sleep logic
Date: Thu, 11 Mar 2010 17:20:41 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224FCF7B6C7@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1267118749-1836-1-git-send-email-tero.kristo@nokia.com>
	<87ljebdb3c.fsf@deeprootsystems.com> <87aaugf37d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59519 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933204Ab0CKQVA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 11:21:00 -0500
In-Reply-To: <87aaugf37d.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 10 March, 2010 20:21
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv6] OMAP3: Serial: Improved sleep logic
>
>Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> Tero Kristo <tero.kristo@nokia.com> writes:
>>
>>> From: Tero Kristo <tero.kristo@nokia.com>
>>>
>>> This patch contains following improvements:
>>> - Only RX interrupt will now kick the sleep prevent timer
>>> - TX fifo status is checked before disabling clocks, this 
>will prevent
>>>   on-going transmission to be cut
>>> - Smartidle is now enabled/disabled only while switching 
>clocks, as having
>>>   smartidle enabled while RX/TX prevents any wakeups from 
>being received
>>>   from UART module
>>> - Added workqueue for wakeup checks, as jiffy timer access 
>within the
>>>   idle loop results into skewed timers as jiffy timers are stopped
>>> - Added garbage_timer for ignoring the first character 
>received during
>>>   the first tick after clock enable, this prevents garbage 
>characters to be
>>>   received in low sleep states
>>> - omap_uart_enable_irqs() changed to use enable_irq / 
>disable_irq instead
>>>   of request / free. Using request/free changes the 
>behavior after first
>>>   suspend due to reversed interrupt handler ordering
>>>
>>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>
>> Thanks Tero.  This version looks good.
>>
>> Adding to pm-fixes queue for 2.6.34-rcX after minor change below...
>>
>
>There's still something slightly strange going on here...
>
>I noticed via powertop that the garbage timer is now one of the top
>reasons for wakeup in an idle system.  Seems like the garbage timer
>is firing when it shouldn't be, and triggering unnecessary wakeups
>
>Based on powertop stats, the garbage timer is firing about 3x more
>often than the GPtimer that should be waking the system.

You get one timer expire each wakeup cycle, but the system actually fires its own timer for each UART, thus you get 3x. It is possible to optimize the timer a bit by only firing it if we have a wakeup from UART, but this probably causes occasional garbage to the console, if a wakeup from some other source than UART and UART RX happen at the same time. Might be the lesser of two evils though.

I can experiment with this change a bit and see how it behaves.

>
>I haven't dug any deeper, but this needs to be fixed before merging
>upstream.
>
>Kevin
>
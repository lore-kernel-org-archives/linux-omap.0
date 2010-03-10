From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv6] OMAP3: Serial: Improved sleep logic
Date: Wed, 10 Mar 2010 10:20:54 -0800
Message-ID: <87aaugf37d.fsf@deeprootsystems.com>
References: <1267118749-1836-1-git-send-email-tero.kristo@nokia.com>
	<87ljebdb3c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:48619 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab0CJSVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 13:21:01 -0500
Received: by fxm19 with SMTP id 19so8955325fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 10:21:00 -0800 (PST)
In-Reply-To: <87ljebdb3c.fsf@deeprootsystems.com> (Kevin Hilman's message of "Mon\, 01 Mar 2010 12\:46\:15 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> This patch contains following improvements:
>> - Only RX interrupt will now kick the sleep prevent timer
>> - TX fifo status is checked before disabling clocks, this will prevent
>>   on-going transmission to be cut
>> - Smartidle is now enabled/disabled only while switching clocks, as having
>>   smartidle enabled while RX/TX prevents any wakeups from being received
>>   from UART module
>> - Added workqueue for wakeup checks, as jiffy timer access within the
>>   idle loop results into skewed timers as jiffy timers are stopped
>> - Added garbage_timer for ignoring the first character received during
>>   the first tick after clock enable, this prevents garbage characters to be
>>   received in low sleep states
>> - omap_uart_enable_irqs() changed to use enable_irq / disable_irq instead
>>   of request / free. Using request/free changes the behavior after first
>>   suspend due to reversed interrupt handler ordering
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
> Thanks Tero.  This version looks good.
>
> Adding to pm-fixes queue for 2.6.34-rcX after minor change below...
>

There's still something slightly strange going on here...

I noticed via powertop that the garbage timer is now one of the top
reasons for wakeup in an idle system.  Seems like the garbage timer
is firing when it shouldn't be, and triggering unnecessary wakeups

Based on powertop stats, the garbage timer is firing about 3x more
often than the GPtimer that should be waking the system.

I haven't dug any deeper, but this needs to be fixed before merging
upstream.

Kevin

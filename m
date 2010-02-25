From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCHv5] OMAP3: Serial: Improved sleep logic
Date: Thu, 25 Feb 2010 16:39:02 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224BF581013@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266421892-1021-1-git-send-email-tero.kristo@nokia.com>
	<877hq2sjpy.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A224BF580B19@NOK-EUMSG-02.mgdnok.nokia.com>
 <87k4u1mjel.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61355 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509Ab0BYPjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 10:39:10 -0500
In-Reply-To: <87k4u1mjel.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kevin Hilman
>Sent: 25 February, 2010 17:21
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv5] OMAP3: Serial: Improved sleep logic
>
><Tero.Kristo@nokia.com> writes:
>
>[...]
>
>>>Here's my hunch as to what's happening:
>>>
>>>I think the problem is a deadlock in getrawmonotonic().  Nested calls
>>>here will deadlock due to the xtime_lock being held.
>>
>> Looking at the seqlock code, I think a seqlock reader can 
>"hang" only in a case where someone is constantly writing the 
>seqlock. And, as we are inside interrupt, this should not be possible.
>>
>>>When updading the timeout, sleep_timeout_store() does a
>>>getrawmonotonic() to update the expiry time.  While this happening,
>>>the UART interrupt could fire, causing an omap_uart_block_sleep()
>>>which would also getrawmonotonic() and deadlock in interrupt mode.
>>
>> It does not really explain why it hangs after the 5 second 
>period though, as the device has called getrawmonotonic 
>several times by this already. I have not seen this kind of 
>behavior in my testing, even while fiddling with the 
>sleep_timeout_store().
>
>minor clarification...
>
>For me the hang is not after the 5 second timeout.  For me it happens
>as soon as I write a non-zero value to
>/sys/devices/.../serial8250.2/sleep_timeout.

It looks somewhat weird... I did some debugging on this today and I am seeing the same hang here, and it actually seems to be caused by the getrawmonotonic() somehow, as the system did not hang anymore after I removed the calls. Anyway, I figured another way to solve the issues I am seeing. I reverted back to using jiffy timers, but added a workqueue for wakeups; now wakeup timers are kicked into action after the timebase is restored. I'll post the new patch right away.

There is still one issue with the UART though; some TX is still lost because PM code does not currently prevent CORE off while PER is active, basically resetting the PER domain when CORE goes off. This would be fixed by the cpuidle set I posted a bit back.

Another note, I am seeing really strange behavior for my n900 with current linux-omap tree. PM branch boots up nicely, but it does not go into dynamic idle until I force it to suspend once.... Also, master branch crashes mid-boot to an ubifs caused DMA failure.

-Tero

From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
Date: Thu, 16 Jun 2011 11:25:15 -0700
Message-ID: <87vcw5k510.fsf@ti.com>
References: <1308229940-27025-1-git-send-email-premi@ti.com>
	<877h8lsswk.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D563E79@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60469 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757801Ab1FPSZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 14:25:19 -0400
Received: by mail-pz0-f44.google.com with SMTP id 5so1404181pzk.31
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 11:25:18 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D563E79@dbde02.ent.ti.com>
	(Sanjeev Premi's message of "Thu, 16 Jun 2011 21:43:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin 
>> Sent: Thursday, June 16, 2011 8:52 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
>> 
>> Hi Sanjeev,
>> 
>> Sanjeev Premi <premi@ti.com> writes:
>> 
>> > When multiple wakeup sources are defined in a system,
>> > there is a small window, when more than one source
>> > can trigger wakeup interrupt.
>> >
>> > In the current implementation, the do-while() loop
>> > can handle all wakeup sources that are recorded when
>> > probing the status register in prcm_interrupt_handler().
>> >
>> > When the ISR executes due to next queued wakeup, it
>> > there is nothing to be handled and value of "c" is 0.
>> 
>> Thanks for tracking this one down.
>> 
>> However, It's still not clear to me what is happening here.
>> 
>> Why is the IRQ firing if there is nothing to be handled?  
>> That suggests
>> to me that the IRQ status is not properly being cleared.
>
> [SP] On the contrary the IRQ status is actually getting cleared,
>      but there are more than "1" PRCM interrupts queued.
>
>      The do-while() clears all the interrupt sources that
>      are flagged in the status register.
>
>      When the next wakeup interrupt is getting processed, the
>      status register doesn't contain any "source" to handle.

Still confused.

If a wakeup interrupt is fired, it was caused by something.  

IOW, if "the status register doesn't contain any source",  how is

		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
				     OMAP3430_IO_ST_MASK)) 

ever true?

Kevin

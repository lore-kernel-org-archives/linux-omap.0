From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
Date: Fri, 09 Sep 2011 09:59:17 +0530
Message-ID: <4E69961D.40700@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com> <878vpyhotu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37289 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752088Ab1IIE3Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 00:29:24 -0400
Received: by gyc15 with SMTP id 15so61530gyc.7
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 21:29:23 -0700 (PDT)
In-Reply-To: <878vpyhotu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, Thomas Gleixner <tglx@linutronix.de>

On Thursday 08 September 2011 11:57 PM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> OMAP WakeupGen is the interrupt controller extension used along
>> with ARM GIC to wake the CPU out from low power states on
>> external interrupts.
>>
>> The WakeupGen unit is responsible for generating wakeup event
>> from the incoming interrupts and enable bits. It is implemented
>> in MPU always ON power domain. During normal operation,
>> WakeupGen delivers external interrupts directly to the GIC.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> [...]
>
>> +#ifdef CONFIG_PM
>> +/*
>> + * Masking wakeup irqs is handled by the IRQCHIP_MASK_ON_SUSPEND flag,
>> + * so no action is necessary in set_wake, but implement an empty handler
>> + * here to prevent enable_irq_wake() returning an error.
>> + * FIXME: Remove the dummy handler once gen irq code fix above.
>> + */
>
> Just curious... is there a fix for this pending for v3.2?
>
I have sent a proposed change to Thomas but have not seen
any response yet from him.

http://www.spinics.net/lists/arm-kernel/msg134297.html

Regards
Santosh



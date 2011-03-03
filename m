From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 11/19] omap3+: sr: call handler with interrupt disabled
Date: Thu, 03 Mar 2011 06:16:01 +0530
Message-ID: <4D6EE4C9.7030305@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>	<1298116918-30744-12-git-send-email-nm@ti.com> <87fwr5vzaj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59258 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459Ab1CCAqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:46:09 -0500
Received: by mail-ew0-f44.google.com with SMTP id 9so195376ewy.3
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:46:08 -0800 (PST)
In-Reply-To: <87fwr5vzaj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Kevin Hilman wrote, on 03/03/2011 05:41 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> Request the handler irq such that there is no nesting for calls.
>> the notifiers are not expected to be nested, further the interrupt
>> events for status change should be handled prior to the next event
>> else there is a risk of loosing events.
>>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>
> IRQs disabled interrupt handlers are soon to disappear in the kernel.
>
> This kind of thing should be handled using locking, most likely IRQs
> disabled spinlocks.

http://marc.info/?t=129906354500012&r=1&w=2
Ack.. painfully made clear in l-a as well.. dropping this :(
>
> Kevin
>
>> ---
>>   arch/arm/mach-omap2/smartreflex.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>> index 1fe8b95..7931fcd 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>>   			goto error;
>>   		}
>>   		ret = request_irq(sr_info->irq, sr_interrupt,
>> -				0, name, (void *)sr_info);
>> +				IRQF_DISABLED, name, (void *)sr_info);
>>   		if (ret)
>>   			goto error;
>>   	}


-- 
Regards,
Nishanth Menon

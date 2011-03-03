From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 12/19] omap3+: sr: disable interrupt by default
Date: Thu, 03 Mar 2011 05:56:53 +0530
Message-ID: <4D6EE04D.600@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>	<1298116918-30744-13-git-send-email-nm@ti.com> <8739n5vz3g.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45567 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612Ab1CCA1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:27:05 -0500
Received: by mail-vx0-f180.google.com with SMTP id 38so703740vxc.39
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:27:04 -0800 (PST)
In-Reply-To: <8739n5vz3g.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Kevin Hilman wrote, on 03/03/2011 05:45 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> We will enable and disable interrupt on a need basis in the class
>> driver. we need to keep the irq disabled by default else the
>> forceupdate or vcbypass events could trigger events that we dont
>> need/expect to handle.
>
> It's not clear from the patch where the IRQ is re-enabled.  For example,
> without knowing better, I would expect a corresponding change to the
> Class 3 driver to enable/disable the IRQ as needed.

Why would that be?
a) class 3 driver does not request for any notifiers
b) class 3 does'nt need interrupts.
c) each class driver can choose to enable when it needs it - class3 does'nt.

is it fine if I add a "this is a preperation for class drivers such as 
class 2 and class 1.5 which would need to use interrupts" in commit message?

>
> Kevin
>
>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> ---
>>   arch/arm/mach-omap2/smartreflex.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>> index 7931fcd..9c61ab0 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -281,6 +281,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>>   				IRQF_DISABLED, name, (void *)sr_info);
>>   		if (ret)
>>   			goto error;
>> +		disable_irq(sr_info->irq);
>>   	}
>>
>>   	if (pdata&&  pdata->enable_on_init)


-- 
Regards,
Nishanth Menon

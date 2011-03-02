From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 15/18] omap3+: sr: disable spamming interrupts
Date: Wed, 02 Mar 2011 22:30:54 +0530
Message-ID: <4D6E77C6.209@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com> <1299063331-27968-16-git-send-email-nm@ti.com> <4D6E49E9.1020307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42700 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753457Ab1CBRBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:01:12 -0500
Received: by pwi15 with SMTP id 15so77692pwi.5
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 09:01:03 -0800 (PST)
In-Reply-To: <4D6E49E9.1020307@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

Sergei Shtylyov wrote, on 03/02/2011 07:15 PM:
[...]
>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>> b/arch/arm/mach-omap2/smartreflex.c
>> index 49a04ea..d62da3d 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -209,8 +209,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
>> value = irqstat_to_notifier_v2(status);
>> }
>>
>> - if (sr_class->notify)
>> - sr_class->notify(sr_info->voltdm, value);
>> + /* Attempt some resemblence of recovery! */
>
> Resemblance?
arrgh.. thanks for catching :)

-- 
Regards,
Nishanth Menon

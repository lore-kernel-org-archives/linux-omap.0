From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 10/18] omap3+: sr: call handler with interrupt disabled
Date: Wed, 02 Mar 2011 22:38:39 +0530
Message-ID: <4D6E7997.2040303@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com> <1299063331-27968-11-git-send-email-nm@ti.com> <4D6E4866.6070107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49400 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755280Ab1CBRP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:15:28 -0500
Received: by mail-fx0-f42.google.com with SMTP id 20so186358fxm.29
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 09:15:27 -0800 (PST)
In-Reply-To: <4D6E4866.6070107@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de

Sergei Shtylyov wrote, on 03/02/2011 07:08 PM:
> Hello.
>
> On 02-03-2011 13:55, Nishanth Menon wrote:
>
>> Request the handler irq such that there is no nesting for calls.
>> the notifiers are not expected to be nested, further the interrupt
>> events for status change should be handled prior to the next event
>> else there is a risk of loosing events.
>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> ---
>> arch/arm/mach-omap2/smartreflex.c | 2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>> b/arch/arm/mach-omap2/smartreflex.c
>> index 99e4c4f..a4e9f2d 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>> goto error;
>> }
>> ret = request_irq(sr_info->irq, sr_interrupt,
>> - 0, name, (void *)sr_info);
>> + IRQF_DISABLED, name, (void *)sr_info);
>
> Isn't this flag a nop now?
thanks. hmm...
Documentation/feature-removal-schedule.txt says so as well.. I guess I 
was just being paranoid (again?).

-- 
Regards,
Nishanth Menon

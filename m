From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 10/18] omap3+: sr: call handler with interrupt disabled
Date: Wed, 02 Mar 2011 23:18:19 +0530
Message-ID: <4D6E82E3.70206@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com> <1299063331-27968-11-git-send-email-nm@ti.com> <4D6E4866.6070107@ru.mvista.com> <4D6E80B6.9090901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:32829 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756681Ab1CBRtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:49:07 -0500
Received: by mail-fx0-f44.google.com with SMTP id 15so237945fxm.31
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 09:49:06 -0800 (PST)
In-Reply-To: <4D6E80B6.9090901@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de

Sergei Shtylyov wrote, on 03/02/2011 11:09 PM:
> I wrote:
>
>>> Request the handler irq such that there is no nesting for calls.
>>> the notifiers are not expected to be nested, further the interrupt
>>> events for status change should be handled prior to the next event
>>> else there is a risk of loosing events.
>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> ---
>>> arch/arm/mach-omap2/smartreflex.c | 2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>>> b/arch/arm/mach-omap2/smartreflex.c
>>> index 99e4c4f..a4e9f2d 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>>> goto error;
>>> }
>>> ret = request_irq(sr_info->irq, sr_interrupt,
>>> - 0, name, (void *)sr_info);
>>> + IRQF_DISABLED, name, (void *)sr_info);
>
>> Isn't this flag a nop now?
>
> Indeed, it is, according to the comment in <linux/interrupt.h>. So what
> does this patch really achieve?

Carry over since I had implemented this driver originally on an ancient 
kernel and other than the showing off the obvious fact that I am not 
reading lwn.net enough, I dont think it achieved anything much :(

The original intent was as following: since bootloaders may have used 
the same h/w logic which could generate pending interrupt status, I 
wanted to explicitly flag that requesting the irq should also ensure the 
IRQ is in disabled status before I get a chance to clean things up.


-- 
Regards,
Nishanth Menon

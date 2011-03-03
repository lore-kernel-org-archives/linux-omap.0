From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/19] omap3: hwmod: add smartreflex irqs
Date: Thu, 03 Mar 2011 06:13:12 +0530
Message-ID: <4D6EE420.9040602@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>	<1298116918-30744-2-git-send-email-nm@ti.com> <87bp1txewg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52759 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884Ab1CCAnT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:43:19 -0500
Received: by mail-vw0-f50.google.com with SMTP id 11so489176vws.9
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:43:18 -0800 (PST)
In-Reply-To: <87bp1txewg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Kevin Hilman wrote, on 03/03/2011 05:18 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> OMAP3 smartreflex irqs in hwmod structures with the same naming as
>> present in OMAP4. Without these IRQs being registered, SmartReflex
>> driver will be unable to get the irq numbers to handle notifications
>>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>
> minor: IRQ is an acronym, please capitalize consistenly throughout.
>
> I know we haven't been too consitent about this but OMAP is also an
> acronym, please capitialize (c.f. $SUBJECT).  This goes for the whole
> series.
here and elsewhere - will do with v3.. thanks for catching..

>
> Otherwise patch looks fine.

-- 
Regards,
Nishanth Menon

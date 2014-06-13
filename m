From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from getting
 mapped to crossbar
Date: Fri, 13 Jun 2014 12:26:10 +0530
Message-ID: <539AA08A.7010001@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com> <1402574007-13987-4-git-send-email-r.sricharan@ti.com> <20140612125134.GS8664@titan.lakedaemon.net> <20140612135715.GE17845@atomide.com> <20140612140508.GC8664@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbaFMG6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2014 02:58:33 -0400
In-Reply-To: <20140612140508.GC8664@titan.lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de

Hi Jason,

On Thursday 12 June 2014 07:35 PM, Jason Cooper wrote:
> On Thu, Jun 12, 2014 at 06:57:15AM -0700, Tony Lindgren wrote:
>> * Jason Cooper <jason@lakedaemon.net> [140612 05:52]:
>>> On Thu, Jun 12, 2014 at 05:23:11PM +0530, Sricharan R wrote:
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> When, in the system due to varied reasons, interrupts might be unusable
>>>> due to hardware behavior, but register maps do exist, then those interrupts
>>>> should be skipped while mapping irq to crossbars.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Tony, have you applied these somewhere already?
>>
>> I think some of these I had applied into a branch ready for
>> merging but then it was discovered that further changes
>> were needed and the branch was dropped.
> 
> Ok.
> 
>> Sricharan, please remove my Signed-off-by from this series.
>> If I end up applying it for merging my scripts will add it
>> automatically.
> 
> Do you have other changes outside of irqchip depending on this series?
> If so, I can set up a topic branch for you guys to base off of.
> Otherwise, I'll just apply them to irqchip/core when they're ready.
> 
 There are dts changes which are dependent upon this series.

  http://www.spinics.net/lists/linux-omap/msg108116.html

> Also, Sricharan, when you respin this, please clearly identify (in the
> comment section) those patches that need to be flagged for stable.  It
> would be helpful if they were the first patches in the series as well.

Ok, i will point this out clearly.

Regards,
 Sricharan

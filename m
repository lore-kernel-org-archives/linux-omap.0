From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Thu, 01 Apr 2010 13:23:36 +0300 (EEST)
Message-ID: <20100401.132336.193692763.Hiroshi.DOYU@nokia.com>
References: <20100329070145.GF28825@nokia.com>
	<20100329.120856.59654379.Hiroshi.DOYU@nokia.com>
	<20100401095203.GL31200@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35928 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab0DAKYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 06:24:05 -0400
In-Reply-To: <20100401095203.GL31200@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: felipe.balbi@nokia.com, x0095840@ti.com, linux-omap@vger.kernel.org, ameya.palande@nokia.com, felipe.contreras@nokia.com

From: ext Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Thu, 1 Apr 2010 11:52:04 +0200

> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100329 02:05]:
>> From: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
>> Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
>> Date: Mon, 29 Mar 2010 09:01:45 +0200
>> > 
>> > in that case, wouldn't it be better to split that into 
>> > arch/arm/omap1/mbox.c arch/arm/omap2/mbox24xx.c 
>> > arch/arm/omap2/mbox34xx.c arch/arm/omap2/mbox44xx.c ??
>> > 
>> > that way we don't need ifdefs on the code and we will only compile what 
>> > we really need.
>> 
>> This is feasible.
>> But I'm not so sure whether adding 4 new files with around only 10
>> lines code is acceptable or not.
>> 
>> Tony, any comment on the above?
>> 
>> Basically there could be the case we need all resources if we want to
>> support omap1, 2, 3 and 4 at the same time, and the appropriate one
>> will be chosen at run time by CPUID. I'm not sure how mature "omap
>> multi arch" support is practically, but it's better to keep it as much
>> as possbile.
> 
> I like Felipe's suggestion of adding devices2420.c, devices34xx.c,
> devices44xx.c or similar. Then do the device init from those with
> a arch_initcall that returns immediately if not running on the right
> soc.

Ok, let's procced with this. I'll post something later.


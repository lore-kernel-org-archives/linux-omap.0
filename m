From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: am33xx: Fix the timer fck clock naming convention
Date: Mon, 27 Aug 2012 12:22:53 +0530
Message-ID: <503B1945.5010308@ti.com>
References: <1342462158-15998-1-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1207161754230.28834@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA6E8B1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52150 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2H0GxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 02:53:08 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA6E8B1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>



On 7/17/2012 10:14 AM, Hiremath, Vaibhav wrote:
> On Tue, Jul 17, 2012 at 05:24:39, Paul Walmsley wrote:
>> On Mon, 16 Jul 2012, Vaibhav Hiremath wrote:
>>
>>> With commit ae6df418a21f3a361c5f9b878e32a8aba4e17692
>>> Sub: ARM: OMAP2+: dmtimer: cleanup fclk usage)
>>> The Timer functional clock naming convention has changed from
>>> gptX_fck => timerXfck, and so as the timer init function
>>> in mach-omap2/timer.c.
>>> OMAP4 clocktree also has changed accordingly.
>>>
>>> AM33xx Clock Tree has been merged during rc3-4 timeframe,
>>> before above commit got merged, so similar change is required
>>> for AM33xx as well (Change the gptX_fck => timerX_fck).
>>>
>>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>>
>> Thanks, this looks like 3.6-rc material, right?
>>
>>
> 
> Yes, that's correct.
> 

Tony/Paul,

Ping !!!

Thanks,
Vaibhav

> Thanks,
> Vaibhav
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

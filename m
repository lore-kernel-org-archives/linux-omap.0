From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization
 delay
Date: Fri, 11 Dec 2009 19:37:47 +0530
Message-ID: <4B225233.2020601@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com> <200912111414.41310.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50047 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbZLKOH5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 09:07:57 -0500
In-Reply-To: <200912111414.41310.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jean Pihet wrote:
> On Friday 11 December 2009 13:05:37 Reddy, Teerth wrote:
>> Reposting the patch with proper format
>>
>> From: Teerth Reddy <teerth@ti.com>
>>
>> This patch sets the dpll3 clock stabilization delay during
>> DVFS. The stabilization delay is calculated dynamically
>> using the ARM performance counter.
>> Currently 6us of SDRC stabilization value is used to get
>> the correct delay.
> That is a good thing to have! However the counters might already be in use, 
> cf. below
> 
Yes, we had a concern about that and not sure how soon the perf counter starts
up. We do this at very early boot code as a part of init_IRQ. much before
profile_init. So I am not sure if your concern is valid.

Thanks,
-Romit

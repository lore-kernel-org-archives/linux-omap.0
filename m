From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ register
Date: Wed, 18 Sep 2013 09:45:13 -0400
Message-ID: <5239AE69.6040600@ti.com>
References: <1379503416-26318-1-git-send-email-r.sricharan@ti.com> <5239AB2C.1090201@ti.com> <5239AE35.8030406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50665 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab3IRNqT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 09:46:19 -0400
In-Reply-To: <5239AE35.8030406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rnayak@ti.com, tony@atomide.com, marc.zyngier@arm.com, mark.rutland@arm.com

On Wednesday 18 September 2013 09:44 AM, Nishanth Menon wrote:
> On 09/18/2013 08:31 AM, Santosh Shilimkar wrote:
>> On Wednesday 18 September 2013 07:23 AM, Sricharan R wrote:
> [...]
> 						4, 0, 0, 0, 0, 0);
>>>  
>>>  	/*
>>> +	 * Configure the CNTFRQ register for the secondary cpu's which
>>> +	 * indicates the frequency of the cpu local timers.
>>> +	 */
>>> +	if (soc_is_omap54xx() || soc_is_dra7xx())
>> CNTFREQ programming was not supported on OMAP5 ES1.0 and that was one
>> of the reason this parameter came into picture. So you need to skip
>> the ES1.0 here. 
>>
> Even though ES1.0 is present in id.c, we have 0 support for ES1.0.
> 
> ES1.0 was more or less a test chip, no production devices were
> manufactured with it, no public boards (including uevms) are available
> to purchase with ES1.0. Further, inside TI, all ES1.0 samples and
> boards have been scrapped and replaced with ES2.0 platforms.
> 
> In short, no users and dead code in kernel tree. I dont see why we
> cant just cleanup OMAP5 ES1.0 entirely from kernel tree?
> 
Yes...There is no reason to keep broken ES1.0 support. Patch please ;-)

Regards,
Santosh

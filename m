From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Mon, 19 May 2014 13:34:07 -0400
Message-ID: <537A408F.7070301@ti.com>
References: <5373C8E8.6040208@ti.com> <5373CBB9.40506@linaro.org> <5373DD94.8030208@ti.com> <5374F35E.5040900@ti.com> <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com> <5375079E.3060305@ti.com> <537615EA.3020809@ti.com> <20140516212942.GK12881@atomide.com> <537A3544.1050307@linaro.org> <20140519172338.GJ4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49980 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbaESRec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 13:34:32 -0400
In-Reply-To: <20140519172338.GJ4849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Alex Shi <alex.shi@linaro.org>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On Monday 19 May 2014 01:23 PM, Tony Lindgren wrote:
> * Daniel Lezcano <daniel.lezcano@linaro.org> [140519 09:46]:
>> On 05/16/2014 11:29 PM, Tony Lindgren wrote:
>>>
>>> And just to recap, this problem can be reproduced with current
>>> Linux next with omap2plus_defconfig with CONFIG_CPU_IDLE enabled. The
>>> system should hang during the boot at some point.
>>
>> I can take the time to investigate a bit more but not right now. What is
>> your deadline before committing the reverts ?
> 
> Well we do have several automated build and boot systems failing
> because of this with multi_v7_defconfig. And users are complaining,
> see this report from Tobias Jakobi:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=75421
> 
> It seems that doing the revert is not enough based on the
> page above.
>
Thats not true. The above link used the half patch and not the
updated patch. Updated patch worked for Alex also. As you can
see they saw RCU stalls and they go away after the updated patch.

Can you please point them to try out the updated patch ?
 
> I'd prefer we'd fix this issue properly for sure, it seems that
> we're not quite understanding what's going on. And this might
> hit other platforms too when they start implementing deeper
> PM idle states in the mainline kernel.
> 
I am certain that the updated patch fixed the regression
for sure. The issue is really not generic enough since its related
an OMAP ROM errata which needs that special handling of
interrupt re-trigger etc. You don't need that for other platforms
so they are not likely get affected.

 

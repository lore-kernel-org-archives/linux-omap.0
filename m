From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 00/18] ARM: OMAP5: PM: Add MPUSS suspend and CPUidle support
Date: Thu, 04 Apr 2013 10:57:17 -0700
Message-ID: <87eheqmb5u.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<87hajnp6ph.fsf@linaro.org> <515D8F60.1080603@ti.com>
	<515DAF15.8000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:63159 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764200Ab3DDR5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 13:57:21 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so1601069pab.35
        for <linux-omap@vger.kernel.org>; Thu, 04 Apr 2013 10:57:20 -0700 (PDT)
In-Reply-To: <515DAF15.8000700@ti.com> (Santosh Shilimkar's message of "Thu, 4
	Apr 2013 22:19:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Thursday 04 April 2013 08:04 PM, Santosh Shilimkar wrote:
>> On Thursday 04 April 2013 04:22 AM, Kevin Hilman wrote:
>>> Hi Santosh,
>>>
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> Here is the refreshed version(v2) of the OMAP5 PM suspport which was posted
>>>> earlier (March 1st 2013). Patch-set incorporates comments from Nishant
>>>> Menon (Thanks for review NM) and his acked-by tags. I would like to get this
>>>> queued for 3.10 merge window if you are ok with the series.
>>>
>>> I did a review of this series with several comments on the individual
>>> patches.  
>>>
>> Thanks a lot Kevin. I have addressed all the comments and have
>> updated patches ready.
>> 
>>> I've already queued most of the CPUidle fixes/cleanups in my
>>> for_3.10/cleanup/cpuidle branch and will get that to Tony soon.  For the
>>> rest, I suggest probably breaking it up into cleanup/consolidation stuff
>>> and then OMAP5 support.  The latter will depend on all the OMAP5
>>> data/headers but the cleanup/consolidation stuff could be merged sooner
>>> (but probably a bit late for v3.10 now.)
>>>
>> I have already split the patch-set into 'consolidation' and 'OMAP5
>> support' since it was straight forward. Need to just build the
>> branches on top of your branches. So waiting for you to update
>> your 'for_3.10/*' branches.
>> 
>> For the merge, its your call:)
>> As you said OMAP5 support(couple of patches) has a dependency
>> on OMAP5 data files. I will at least make the branches ready on
>> top of yours.
>> 
> After looking at your tree, looks like the branches are already
> there. Idle branch name is not for_3.10/fixes/cpuidle though :)

oh, sorry.  I changed it to 'cleanup'.

> So I created 'for_3.10/omap_pm-cleanup' and 'for_3.10/omap5_pm_v2'
> and pushed on my git tree [1] in case you would like to have
> a look. I briefly tested them on OMAP4 device with
> CPUidle enabled and they seems to work fine. Will do OMAP5
> testing tomorrow and then post the updated patches on list.

Perfect, thanks.

Kevin


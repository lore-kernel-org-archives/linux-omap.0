From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: decrease cpufreq transition latency
Date: Thu, 29 Oct 2009 14:38:45 -0700
Message-ID: <87tyxhyj6i.fsf@deeprootsystems.com>
References: <1256850129-31618-1-git-send-email-mturquette@ti.com>
	<87k4ydzyvg.fsf@deeprootsystems.com> <4AEA0D71.5020906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:32943 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZJ2Vim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 17:38:42 -0400
Received: by pwj9 with SMTP id 9so298472pwj.21
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 14:38:47 -0700 (PDT)
In-Reply-To: <4AEA0D71.5020906@ti.com> (Mike Turquette's message of "Thu\, 29 Oct 2009 16\:47\:29 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Mike Turquette <mturquette@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Mike Turquette <mturquette@ti.com> writes:

> Kevin Hilman wrote:
>> Mike Turquette <mturquette@gmail.com> writes:
>>
>>> Adjust OMAP3 frequency transition latency from 10,000,000uS to a more
>>> reasonable 300,000uS.  This causes ondemand and conservative governors to
>>> sample CPU load more often resulting in more responsive behavior.
>>>
>>> Tested on Android 2.6.29; using this value and conservative governor, CORE
>>> power consumption on Zoom2 was comparable to the old and unresponsive
>>> 10,000,000uS value while UI responsiveness was greatly improved.
>>>
>>> This patch applies against Tony's omap-fixes branch.
>>>
>>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>>> ---
>>>  arch/arm/plat-omap/cpu-omap.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
>>> index 1868c0d..341235c 100644
>>> --- a/arch/arm/plat-omap/cpu-omap.c
>>> +++ b/arch/arm/plat-omap/cpu-omap.c
>>> @@ -127,7 +127,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
>>>  	}
>>>   	/* FIXME: what's the actual transition time? */
>>
>> Can probably drop this 'FIXME' comment now.
>
> I chose not to drop the FIXME since the worst-case transition time is
> still unknown.  At some point I'd like to revisit this number with
> something better supported by data from the hardware guys.  This
> number was deemed "safe", but may not be optimal.

OK by me.  

Kevin

>
>>> -	policy->cpuinfo.transition_latency = 10 * 1000 * 1000;
>>> +	policy->cpuinfo.transition_latency = 300 * 1000;
>>
>> otherwise,
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Tony, can this still be queued for .32-rc?
>>
>> Kevin
>>

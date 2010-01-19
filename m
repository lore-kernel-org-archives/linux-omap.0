From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/1] OMAP3: PM: Fix compilation issue of omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 08:32:48 -0600
Message-ID: <4B55C290.2060205@ti.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com> <4B559F1C.6070802@gmail.com> <20100119134927.GE12231@esdhcp037198.research.nokia.com> <4B55BD13.70704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53999 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab0ASOcw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 09:32:52 -0500
In-Reply-To: <4B55BD13.70704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Romit Dasgupta had written, on 01/19/2010 08:09 AM, the following:
>>>>   
>>> Err... NAK.. I think you missed 
>>> http://marc.info/?t=126356119700001&r=1&w=2 ?
>>> there seems to be an issue else where, I have not dug at it yet..
>>
>> Yeah. OK, I couldn't see the logs as the dumps has been removed already from that thread.
>> But if I got the problem correctly, the problem is when CONFIG_PM is not set but cpu freq is.
>> And if there is any call to new omap opp layer helper functions, then it will BUG the system.
>> Causing hangs.
>>
>> I guess one way to solve this is to bind compilation of omap opp layer to CONFIG_PM and CONFIG_CPU_FREQ.
>> If either is disabled, then omap opp layer must be nops.
>>
>> What do you think?
>>
>> I am sending a patch to do the above.
> No. That is incorrect. CONFIG_CPU_FREQ, CONFIG_CPU_IDLE and CONFIG_PM are
> independent. None of the features should be dependent on the other two!
> -Romit
OPP layer is required by CPU_FREQ & CONFIG_PM, not CPU_IDLE.

if we modify Eduardo's patch from:

if defined(CONFIG_PM) && defined(CONFIG_CPU_FREQ)
To

if defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ)

wont that ensure the independence is maintained for OPP layer? then, 
probably pm34xx.c maynot be the right place for opp registration for 
3430 opps, and we should move it to opp34xx.c(I hate having new files :( )..

-- 
Regards,
Nishanth Menon

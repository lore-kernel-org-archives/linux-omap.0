From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 1/1] OMAP3: PM: Fix compilation issue of omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 20:11:02 +0530
Message-ID: <4B55C47E.2090002@ti.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com> <4B559F1C.6070802@gmail.com> <20100119134927.GE12231@esdhcp037198.research.nokia.com> <4B55BD13.70704@ti.com> <4B55C290.2060205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471Ab0ASOlP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 09:41:15 -0500
In-Reply-To: <4B55C290.2060205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Menon, Nishanth wrote:
> Romit Dasgupta had written, on 01/19/2010 08:09 AM, the following:
>>>>>   
>>>> Err... NAK.. I think you missed 
>>>> http://marc.info/?t=126356119700001&r=1&w=2 ?
>>>> there seems to be an issue else where, I have not dug at it yet..
>>> Yeah. OK, I couldn't see the logs as the dumps has been removed already from that thread.
>>> But if I got the problem correctly, the problem is when CONFIG_PM is not set but cpu freq is.
>>> And if there is any call to new omap opp layer helper functions, then it will BUG the system.
>>> Causing hangs.
>>>
>>> I guess one way to solve this is to bind compilation of omap opp layer to CONFIG_PM and CONFIG_CPU_FREQ.
>>> If either is disabled, then omap opp layer must be nops.
>>>
>>> What do you think?
>>>
>>> I am sending a patch to do the above.
>> No. That is incorrect. CONFIG_CPU_FREQ, CONFIG_CPU_IDLE and CONFIG_PM are
>> independent. None of the features should be dependent on the other two!
>> -Romit
> OPP layer is required by CPU_FREQ & CONFIG_PM, not CPU_IDLE.
> 
> if we modify Eduardo's patch from:
> 
> if defined(CONFIG_PM) && defined(CONFIG_CPU_FREQ)
> To
> 
> if defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ)
> 
> wont that ensure the independence is maintained for OPP layer? then, 
> probably pm34xx.c maynot be the right place for opp registration for 
> 3430 opps, and we should move it to opp34xx.c(I hate having new files :( )..
> 
It should be only
#ifdef CONFIG_CPU_FREQ. OPP has nothing to do with CONFIG_PM.

Why do you need CPU_FREQ for suspend/resume??


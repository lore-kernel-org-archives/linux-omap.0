From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/1] OMAP3: PM: Fix compilation issue of omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 08:45:03 -0600
Message-ID: <4B55C56F.9030100@ti.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com> <4B559F1C.6070802@gmail.com> <20100119134927.GE12231@esdhcp037198.research.nokia.com> <4B55BD13.70704@ti.com> <4B55C290.2060205@ti.com> <4B55C47E.2090002@ti.com> <4B55C4CF.4030509@ti.com> <4B55C521.5050602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54715 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab0ASOpK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 09:45:10 -0500
In-Reply-To: <4B55C521.5050602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Dasgupta, Romit had written, on 01/19/2010 08:43 AM, the following:
>>> 3430 opps, and we should move it to opp34xx.c(I hate having new files :( )..
>>> It should be only
>>> #ifdef CONFIG_CPU_FREQ. OPP has nothing to do with CONFIG_PM.
>>>
>>> Why do you need CPU_FREQ for suspend/resume??
>>>
>> voltage control - SR needs to query for voltage?
>>
> Why should suspend/resume be dependent on SR?
please see the code logic -> when SR is enabled and OFF/RET happens, you 
need the voltage for the current frequency so that you can disable SR, 
set the nominal voltage for the current OPP then go to WFI.

-- 
Regards,
Nishanth Menon

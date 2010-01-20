From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 17:30:05 +0530
Message-ID: <4B56F045.4040708@ti.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com> <4B56E5B3.8070303@ti.com> <20100120115407.GG12231@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53905 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab0ATMAS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 07:00:18 -0500
In-Reply-To: <20100120115407.GG12231@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Keski-Saari Juha.1 (EXT-Teleca/Helsinki)" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Eduardo Valentin wrote:
> On Wed, Jan 20, 2010 at 12:14:59PM +0100, ext Romit Dasgupta wrote:
>>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>>>
>>> OMAP OPP layer functions now have dependencies of CONFIG_CPU_FREQ only.
>>>
>>> With this patch, omap opp layer now has its compilation flags
>>> bound to CONFIG_CPU_FREQ. Also its code has been removed from pm34xx.c.
>>>
>>> A new file has been created to contain cpu freq code related to
>>> OMAP3: cpufreq34xx.c.
>>>
>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
>> NAK also for the following  non-working kernel (smartreflex without cpufreq).
> 
> Then this is a problem of dependency with smartreflex and cpufreq. In this case
> better to solve this other problem with another patch. This patch is to rip off
> cpufreq code from pm34xx, as stated in the above description.

In that case the right fix should

1) __not__ include opp.h for non cpufreq builds
OR
2) If it includes opp.h the functions for getting current opp
should abstract out the right mechanism to get current frequency/voltage from
 the chip/power IC.

> 
> And sorry, I didn't get your boot log (if you intended to put it, as you said
> "following non-working kernel"
> 
Actually I meant for the following non-working kernel __configuration__. I do
not have boot logs!


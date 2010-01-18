From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] pm: omap3: fix build error for PM disabled
Date: Mon, 18 Jan 2010 11:27:00 +0530
Message-ID: <4B53F82C.1000000@ti.com>
References: <1263561186-12994-1-git-send-email-nm@ti.com> <4B506C4A.8080406@ti.com> <4B506E83.5080806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55187 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab0ARF5K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jan 2010 00:57:10 -0500
In-Reply-To: <4B506E83.5080806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

>>> index d257225..5fc056f 100644
>>> --- a/arch/arm/mach-omap2/pm.h
>>> +++ b/arch/arm/mach-omap2/pm.h
>>> @@ -69,7 +69,13 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
>>>   * Initialize the basic opp table here, board files could choose to modify opp
>>>   * table after the basic initialization
>>>   */
>>> +#ifdef CONFIG_PM
>>>  extern void omap3_pm_init_opp_table(void);
>>> +#else
>>> +static inline void omap3_pm_init_opp_table(void)
>>> +{
>>> +}
>>> +#endif
>>>  
>>>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>>>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>> This patch IMHO just solves the build issue. The runtime behaviour is a nasty
>> crash. OMAP architecture has tied CONFIG_PM with CONFIG_CPU_FREQ. So I think we
>> need a fix that solves the runtime behavior too.
> hmm.. thanks for pointing it out (dropping the patch) - even though that 
> was not the reason for this patch - I had send this patch after booting 
> the kernel using omap3_pm_defconfig (disable PM) on SDP3630:
> SDP3630: http://pastebin.mozilla.org/697292 - complete boot
> SDP3430: http://pastebin.mozilla.org/697294 - hang
As I mentioned there is a __fundamental__ problem in OMAP3 PM tree today.
CONFIG_CPU_FREQ, CONFIG_CPU_IDLE are made dependent on CONFIG_PM.  You can have
cpufreq, cpuidle without suspend resume. So IMHO making these features
independent is the right fix.



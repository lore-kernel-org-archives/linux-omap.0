From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if
 < ES1.2
Date: Mon, 13 Dec 2010 07:43:26 -0600
Message-ID: <4D0622FE.2070801@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com> <1291395818-8639-6-git-send-email-nm@ti.com> <2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39242 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757925Ab0LMNnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 08:43:32 -0500
Received: by mail-gy0-f172.google.com with SMTP id 12so3314961gyd.31
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 05:43:29 -0800 (PST)
In-Reply-To: <2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Vishwanath Sripathy had written, on 12/13/2010 07:35 AM, the following:
> Nishant,
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Nishanth Menon
>> Sent: Friday, December 03, 2010 10:34 PM
>> To: linux-omap
>> Cc: Eduardo Valentin; Kevin Hilman; Tony Lindgren; Nishanth Menon
>> Subject: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if
>> < ES1.2
>>
>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>>
>> Limitation i583: Self_Refresh Exit issue after OFF mode
>>
>> Issue:
>> When device is waking up from OFF mode, then SDRC state machine
>> sends
>> inappropriate sequence violating JEDEC standards.
>>
>> Impact:
>> OMAP3630 < ES1.2 is impacted as follows depending on the platform:
>> CS0: for 38.4MHz as internal sysclk, DDR content seen to be stable,
>> while
>> 	for all other sysclk frequencies, varied levels of instability
>> 	seen based on varied parameters.
>> CS1: impacted
>>
>> This patch takes option #3 as recommended by the Silicon erratum:
>> Avoid core power domain transitioning to OFF mode. Power consumption
>> impact is expected in this case.
>> To do this, we route OFF requests to RET request on the impacted
>> revisions
>> of silicon.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>>
>> [nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code changed
>> a bit]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
>> ---
>> v3: no functional change in erratum wa implementation, just registration
>> of
>>  	erratum is collated to a single cpu detection and version check
>> v2: https://patchwork.kernel.org/patch/365262/
>>     rebased to this patch series instead of depending on hs changes
>>     fix typo for macro definition
>> v1: http://marc.info/?l=linux-omap&m=129013173425266&w=2
>>  arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
>> omap2/pm34xx.c
>> index b49e02b..ba3c0d6 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -56,6 +56,7 @@
>>  #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
>>
>>  #define RTA_ERRATUM_i608		(1 << 0)
>> +#define SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
>>  static u16 pm34xx_errata;
>>  #define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
>>
>> @@ -406,6 +407,17 @@ void omap_sram_idle(void)
>>  	}
>>
>>  	/* CORE */
>> +	/*
>> +	 * Erratum i583: implementation for ES rev < Es1.2 on 3630
>> +	 * We cannot enable OFF mode in a stable form for previous
>> +	 * revisions, transition instead to RET
>> +	 */
>> +	if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583) &&
>> +			(core_next_state == PWRDM_POWER_OFF)) {
>> +		pwrdm_set_next_pwrst(core_pwrdm,
>> PWRDM_POWER_RET);
>> +		core_next_state = PWRDM_POWER_RET;
>> +	}
> 
> Since next_state in pwrst_list (for core) is not updated, this is throwing
> up an error "Powerdomain (core_pwrdm) didn't enter target state 0" when
> you off mode is enabled for ES1.1 or lesser (in suspend path). It's not
> really true that Core has not entered target state. It has entered
> Retention state which is the actual target state set in omap_sram_idle.
> However it did not enter the state that was passed by omap3_pm_suspend. Is
> this expected behavior?

we could go both ways on this - this patch will(as you noticed) indicate 
that the transition failed on <ES1.2, or we could make it entirely 
transparent(by modifying the the pwrst_list - claim we achieved off, 
while not really hitting off - I personally dont think that is correct.

-- 
Regards,
Nishanth Menon

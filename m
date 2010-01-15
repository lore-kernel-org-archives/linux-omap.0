From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] pm: omap3: fix build error for PM disabled
Date: Fri, 15 Jan 2010 07:32:51 -0600
Message-ID: <4B506E83.5080806@ti.com>
References: <1263561186-12994-1-git-send-email-nm@ti.com> <4B506C4A.8080406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab0AONcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 08:32:55 -0500
In-Reply-To: <4B506C4A.8080406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

Dasgupta, Romit had written, on 01/15/2010 07:23 AM, the following:
> Nishanth Menon wrote:
>> omap3_pm_init_opp_table should be under #ifdef CONFIG_PM
>> else build fails when PM is disabled. Reported by Paul originally.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  arch/arm/mach-omap2/pm.h |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index d257225..5fc056f 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -69,7 +69,13 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
>>   * Initialize the basic opp table here, board files could choose to modify opp
>>   * table after the basic initialization
>>   */
>> +#ifdef CONFIG_PM
>>  extern void omap3_pm_init_opp_table(void);
>> +#else
>> +static inline void omap3_pm_init_opp_table(void)
>> +{
>> +}
>> +#endif
>>  
>>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
> 
> This patch IMHO just solves the build issue. The runtime behaviour is a nasty
> crash. OMAP architecture has tied CONFIG_PM with CONFIG_CPU_FREQ. So I think we
> need a fix that solves the runtime behavior too.
hmm.. thanks for pointing it out (dropping the patch) - even though that 
was not the reason for this patch - I had send this patch after booting 
the kernel using omap3_pm_defconfig (disable PM) on SDP3630:
SDP3630: http://pastebin.mozilla.org/697292 - complete boot
SDP3430: http://pastebin.mozilla.org/697294 - hang

-- 
Regards,
Nishanth Menon

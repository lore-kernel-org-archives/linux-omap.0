From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Fri, 19 Mar 2010 09:21:34 -0500
Message-ID: <4BA3886E.9070906@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>	<1268937891-19445-2-git-send-email-nm@ti.com> <87tysdi6tq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60804 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab0CSOVi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 10:21:38 -0400
In-Reply-To: <87tysdi6tq.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Kevin Hilman had written, on 03/18/2010 05:49 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> BUG_ON should not ideally contain a functional code. Remove it out.
> 
> True.  But this code should not be using BUG_ON() in the first place.
> 
> We should not crash the whole kernel in this case, just fail
> with a warning.
> 
> If you're cleaning this up, can you make it fail more gracefully.
I agree  if this was a preipheral driver or a non-critical path. but in 
this case:

a) we are speaking of a core description of the h/w - OPPs frequencies 
and voltages which out which the functionality of the system is at 
stake. I am not speaking of just having a basic kernel boot up to shell 
prompt - we need the kernel to do much better than that.

b) Is there any reason why the registration could fail - if it did fail 
at this point, there is something catastrophic happening - some other 
driver is going beserk OR Opp layer is by itself screwed up - why 
continue if we can warn the system and force a fix of the code?

c) is there a recovery mechanism to put the system back in a usable mode 
with dvfs etc? I might prefer to get some ideas on it..

> 
> Kevin
> 
> 
>> Ref: http://marc.info/?l=linux-kernel&m=109391212925546&w=2
>>
>> Cc: Ambresh K <ambresh@ti.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
>> Cc: Sanjeev Premi <premi@ti.com>
>> Cc: Tero Kristo <tero.kristo@nokia.com>
>> Cc: Thara Gopinath <thara@ti.com>
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  arch/arm/mach-omap2/cpufreq34xx.c |    8 +++++---
>>  1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
>> index c453ec5..f0ed3ae 100644
>> --- a/arch/arm/mach-omap2/cpufreq34xx.c
>> +++ b/arch/arm/mach-omap2/cpufreq34xx.c
>> @@ -111,6 +111,7 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
>>  
>>  void __init omap3_pm_init_opp_table(void)
>>  {
>> +	int r;
>>  	struct omap_opp_def **omap3_opp_def_list;
>>  	struct omap_opp_def *omap34xx_opp_def_list[] = {
>>  		omap34xx_mpu_rate_table,
>> @@ -126,8 +127,9 @@ void __init omap3_pm_init_opp_table(void)
>>  	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
>>  				omap34xx_opp_def_list;
>>  
>> -	BUG_ON(opp_init_list(OPP_MPU, omap3_opp_def_list[0]));
>> -	BUG_ON(opp_init_list(OPP_L3, omap3_opp_def_list[1]));
>> -	BUG_ON(opp_init_list(OPP_DSP, omap3_opp_def_list[2]));
>> +	r = opp_init_list(OPP_MPU, omap3_opp_def_list[0]);
>> +	r |= opp_init_list(OPP_L3, omap3_opp_def_list[1]);
>> +	r |= opp_init_list(OPP_DSP, omap3_opp_def_list[2]);
>> +	BUG_ON(r);
>>  }
>>  
>> -- 
>> 1.6.3.3


-- 
Regards,
Nishanth Menon

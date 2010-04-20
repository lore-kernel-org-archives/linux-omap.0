From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/2 v2] omap3: pm: cpufreq: BUG_ON cleanup
Date: Tue, 20 Apr 2010 18:48:25 -0500
Message-ID: <4BCE3D49.20309@ti.com>
References: <1271792994-31816-1-git-send-email-nm@ti.com>	<1271792994-31816-2-git-send-email-nm@ti.com> <87d3xtbskh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56505 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab0DTXsb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 19:48:31 -0400
In-Reply-To: <87d3xtbskh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Kevin Hilman had written, on 04/20/2010 06:41 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
[..]

>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> Ref:
>> v1: https://patchwork.kernel.org/patch/86793/
>> v2 changes:
>> 	removed BUG_ON entirely. instead have introduced int
>> 	return value allowing for board files which call to
>> 	handle the return results intelligently.
> 
> Thanks, I like this better.
> 
thx.. comments follow..

>>  arch/arm/mach-omap2/cpufreq34xx.c |   36 ++++++++++++++++++++++++++++++++----
>>  arch/arm/mach-omap2/omap3-opp.h   |    5 +++--
>>  2 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
>> index 189c42e..01cf98f 100644
>> --- a/arch/arm/mach-omap2/cpufreq34xx.c
>> +++ b/arch/arm/mach-omap2/cpufreq34xx.c
[..]

>>  
>> -void __init omap3_pm_init_opp_table(void)
>> +int __init omap3_pm_init_opp_table(void)
>>  {
>> +	int i, r;
>>  	struct omap_opp_def **omap3_opp_def_list;
>>  	struct omap_opp_def *omap34xx_opp_def_list[] = {
>>  		omap34xx_mpu_rate_table,
>> @@ -122,12 +124,38 @@ void __init omap3_pm_init_opp_table(void)
>>  		omap36xx_l3_rate_table,
>>  		omap36xx_dsp_rate_table
>>  	};
>> +	enum opp_t omap3_opps[] = {
>> +		OPP_MPU,
>> +		OPP_L3,
>> +		OPP_DSP
>> +	};
> 
> Aren't these already defined in <plat/opp.h> ?
They are. but without using a array, I cant have a for loop ;).. i 
prefer for loops to replicating code thrice ;)..

if your question is on:
+#include "omap3-opp.h"
the reason is the header include makes sense to keep sparse happy + 
first time i built, there was'nt a crib from build when void became int, 
realized this was needed anyways.. shrug if you would like to split it 
out as a separate patch..

if your point was something else, I missed it.. :(
> 
>>  
>>  	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
>>  				omap34xx_opp_def_list;
>>  
>> -	BUG_ON(opp_init_list(OPP_MPU, omap3_opp_def_list[0]));
>> -	BUG_ON(opp_init_list(OPP_L3, omap3_opp_def_list[1]));
>> -	BUG_ON(opp_init_list(OPP_DSP, omap3_opp_def_list[2]));
>> +	for (i = 0; i < ARRAY_SIZE(omap3_opps); i++) {
>> +		r = opp_init_list(omap3_opps[i], omap3_opp_def_list[i]);
>> +		if (r)
>> +			break;
>> +	}
>> +	if (!r)
>> +		return 0;
>> +
>> +	/* Cascading error handling - disable all enabled OPPs */
>> +	pr_err("%s: Failed to register %d OPP type\n", __func__,
>> +		omap3_opps[i]);
>> +	i--;
>> +	while (i != -1) {
>> +		struct omap_opp *opp;
>> +		unsigned long freq = 0;
> 
> insert blank line
> 
thx..
>> +		while (!IS_ERR(opp = opp_find_freq_ceil(omap3_opps[i],
>> +							&freq))) {
> 
> for redability, would rather see the line-wrap avoided. 
> Just put the IS_ERR() on a separate line.
/me kicks myself for being lazy about this.. i guess i better kick it 
out and clean that loop out.. will do..

[..]

-- 
Regards,
Nishanth Menon

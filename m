From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 3/4] OMAP SR/SRF: use OPP API for OPP ID, remove direct access
Date: Tue, 22 Dec 2009 08:16:06 -0800
Message-ID: <87ljgvt261.fsf@deeprootsystems.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com>
	<1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
	<1261177539-15429-3-git-send-email-khilman@deeprootsystems.com>
	<1261177539-15429-4-git-send-email-khilman@deeprootsystems.com>
	<4B2CC126.8090008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:62905 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbZLVQQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 11:16:09 -0500
Received: by pzk1 with SMTP id 1so4570393pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 22 Dec 2009 08:16:09 -0800 (PST)
In-Reply-To: <4B2CC126.8090008@ti.com> (Nishanth Menon's message of "Sat\, 19 Dec 2009 17\:33\:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> Kevin Hilman said the following on 12/19/2009 04:35 AM:
>> SR and SRF currenly direclty access OPP struct internals.  Use new
>> accessor function to get OPP ID.
>>
>> Also SRF was doing doing direct access of the OPP struct array using a
>> convoluted conversion from a 'level' to an OPP ID, when they're
>> actually the same thing.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/mach-omap2/resource34xx.c |    6 +++---
>>  arch/arm/mach-omap2/smartreflex.c  |    4 ++--
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
>> index 1fa8bb5..31b8af2 100644
>> --- a/arch/arm/mach-omap2/resource34xx.c
>> +++ b/arch/arm/mach-omap2/resource34xx.c
>> @@ -204,7 +204,7 @@ static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
>>  	opp = opp_find_freq_ceil(opps, &freq);
>>  	if (IS_ERR(opp))
>>  		return -EINVAL;
>> -	*opp_id = opp->opp_id;
>> +	*opp_id = opp_get_opp_id(opp);
>>  	return 0;
>>  }
>>  @@ -337,8 +337,8 @@ static int program_opp(int res, struct omap_opp
>> *opp, int target_level,
>>  #ifdef CONFIG_OMAP_SMARTREFLEX
>>  	unsigned long t_opp, c_opp;
>>  -	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level - 1].opp_id);
>> -	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level - 1].opp_id);
>> +	t_opp = ID_VDD(res) | ID_OPP_NO(target_level - 1);
>> +	c_opp = ID_VDD(res) | ID_OPP_NO(current_level - 1);
>>   
> not sure of this.
> target_level = 3,
> opp[target_level - 1].opp_id ==3
> BUT,
> target_level -1 = 2
> these are not the same.

Hmm, good catch.

Now that it's not being used as index into OPP array, I should be
using target level directly.

Will update in pm-wip-opp.

Kevin



>>  #endif
>>   	/* See if have a freq associated, if not, invalid opp */
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>> index 9c0d5bf..d341857 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -159,7 +159,7 @@ static u8 get_vdd1_opp(void)
>>  	if (IS_ERR(opp))
>>  		return 0;
>>  -	return opp->opp_id;
>> +	return opp_get_opp_id(opp);
>>  }
>>   static u8 get_vdd2_opp(void)
>> @@ -174,7 +174,7 @@ static u8 get_vdd2_opp(void)
>>  	if (IS_ERR(opp))
>>  		return 0;
>>  -	return opp->opp_id;
>> +	return opp_get_opp_id(opp);
>>  }
>>     
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

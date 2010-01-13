From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different
 OPP types
Date: Wed, 13 Jan 2010 16:11:48 +0530
Message-ID: <4B4DA36C.7040206@ti.com>
References: <1263299979.1536.7.camel@boson> <7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55727 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755746Ab0AMKl6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jan 2010 05:41:58 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Menon, Nishanth wrote:
> 
> General comment: might be good to state the enum types you are introducing
> for OMAP3 in the commit message
Actually the introduction of enum type itself is the heart of the patch. The
details are irrelevant.
> 
>> Signed-off-by: Romit Dasgupta <romit@ti.com>
>> ---
>>
>>         omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
>>                                 omap34xx_opp_def_list;
>> -       for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
>> -               *omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
>> +       entries = cpu_is_omap3630() ? ARRAY_SIZE(omap34xx_opp_def_list) :
>> +                       ARRAY_SIZE(omap36xx_opp_def_list);
>> +       for (i = 1; i <= entries; i++) {
>> +               ret = opp_init_list(i, omap3_opp_def_list[i - 1]);
> a) if you remove OPP_NONE, i-1 is not needed (same everywhere in the patch)
Frankly, I did not want to introduce OPP_NONE but did so as you are checking all
parameters passed to the OPP APIs.

> b) if we modify the ENUMS or the sequence of definitions in opp_t the logic
> here becomes fault. it might be good to retain an equivalent of
> omap3_rate_table with enum equivalents and register by indexing off that.
You are right but this is a kernel level API and user level code is not going to
use this. Having said this there is no scope for a programmer to introduce new
sequences without understanding the consequences.
> 
>>                 /* We dont want half configured system at the moment */
>> -               BUG_ON(IS_ERR(omap3_rate_tables[i]));
>> +               BUG_ON(ret);
>>         }
>>  }
>>
>> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
>> index 157b38e..38c44ee 100644
>> --- a/arch/arm/mach-omap2/resource34xx.c
>> +++ b/arch/arm/mach-omap2/resource34xx.c
>> @@ -161,7 +161,7 @@ static DEFINE_MUTEX(dvfs_mutex);
>>  /**
>>   * opp_to_freq - convert OPPID to frequency (DEPRECATED)
>>   * @freq: return frequency back to caller
>> - * @opps: opp list
>> + * @opp_t: OPP type where we need to look.
>>   * @opp_id: OPP ID we are searching for
>>   *
>>   * return 0 and freq is populated if we find the opp_id, else,
>> @@ -169,14 +169,14 @@ static DEFINE_MUTEX(dvfs_mutex);
>>   *
>>   * NOTE: this function is a standin for the timebeing as opp_id is deprecated
>>   */
>> -static int __deprecated opp_to_freq(unsigned long *freq,
>> -               const struct omap_opp *opps, u8 opp_id)
>> +static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_t,
> 
> Enum type and variable have the same name :( mebbe a rename of variable is
> appropriate

Not sure why you say this. Did you see the compiler throwing up any warning?
>> @@ -188,20 +188,20 @@ static int __deprecated opp_to_freq(unsigned long *freq,
>> -static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
>> +static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_t,
> Re: enum type and variable have the same name :( mebbe a rename of variable is
> appropriate
>>                 unsigned long freq)
>>  {
>>         struct omap_opp *opp;
>>
>> -       BUG_ON(!opp_id || !opps);
>> -       opp = opp_find_freq_ceil(opps, &freq);
>> +       BUG_ON(opp_t == OPP_NONE || opp_t > OPP_TYPES);
>> +       opp = opp_find_freq_ceil(opp_t, &freq);
>>         if (IS_ERR(opp))
>>                 return -EINVAL;
>>         *opp_id = opp_get_opp_id(opp);
>> @@ -218,9 +218,6 @@ void init_opp(struct shared_resource *resp)
>>         u8 opp_id;
>>         resp->no_of_users = 0;
>>
>> -       if (!mpu_opps || !dsp_opps || !l3_opps)
>> -               return;
>> -
> the original intent of this check is lost here - if the initializations did not
> take place, we will not proceed. An equivalent check might be good to maintain
> at this point.

You are partially correct. I took off the checks because we have a BUG_ON() call
in the beginning of the boot code right after we initialize the OPP tables. So
we should not hit this check.
>> @@ -519,19 +513,16 @@ void init_freq(struct shared_resource *resp)
>>         unsigned long freq;
>>         resp->no_of_users = 0;
>>
>> -       if (!mpu_opps || !dsp_opps)
>> -               return;
>> -
> again the initial intent is lost -> to handle cases where the initialization was
> not being done.
Same comment as before.


Thanks,
-Romit

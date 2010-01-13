From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different
 OPP types
Date: Wed, 13 Jan 2010 06:54:47 -0600
Message-ID: <4B4DC297.8070703@gmail.com>
References: <1263299979.1536.7.camel@boson> <7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com> <4B4DA36C.7040206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:43528 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab0AMMyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 07:54:51 -0500
Received: by ywh6 with SMTP id 6so23423521ywh.4
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 04:54:49 -0800 (PST)
In-Reply-To: <4B4DA36C.7040206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Romit Dasgupta said the following on 01/13/2010 04:41 AM:
> Menon, Nishanth wrote:
>   
>> General comment: might be good to state the enum types you are introducing
>> for OMAP3 in the commit message
>>     
> Actually the introduction of enum type itself is the heart of the patch. The
> details are irrelevant.
>   
could you be a little more verbose as to what is irrelevant? the OMAP3 
enums descriptions in commit message?

>>> Signed-off-by: Romit Dasgupta <romit@ti.com>
>>> ---
>>>
>>>         omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
>>>                                 omap34xx_opp_def_list;
>>> -       for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
>>> -               *omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
>>> +       entries = cpu_is_omap3630() ? ARRAY_SIZE(omap34xx_opp_def_list) :
>>> +                       ARRAY_SIZE(omap36xx_opp_def_list);
>>> +       for (i = 1; i <= entries; i++) {
>>> +               ret = opp_init_list(i, omap3_opp_def_list[i - 1]);
>>>       
>> a) if you remove OPP_NONE, i-1 is not needed (same everywhere in the patch)
>>     
> Frankly, I did not want to introduce OPP_NONE but did so as you are checking all
> parameters passed to the OPP APIs.
>   
Lets remove it then.
>   
>> b) if we modify the ENUMS or the sequence of definitions in opp_t the logic
>> here becomes fault. it might be good to retain an equivalent of
>> omap3_rate_table with enum equivalents and register by indexing off that.
>>     
> You are right but this is a kernel level API and user level code is not going to
> use this. Having said this there is no scope for a programmer to introduce new
> sequences without understanding the consequences.
>   
definition of enum and the implicit usage  of enums are in two different 
files. there is a distinct possibility of some one modifying the header 
without actually knowing that .c depends on the exact values of the enum 
definition.

pm34xx.c has no right to depend on opp.h definition values -> if it does 
it ties it down and a constraint for future flexibility. please change.

>>>                 /* We dont want half configured system at the moment */
>>> -               BUG_ON(IS_ERR(omap3_rate_tables[i]));
>>> +               BUG_ON(ret);
>>>         }
>>>  }
>>>
>>> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
>>> index 157b38e..38c44ee 100644
>>> --- a/arch/arm/mach-omap2/resource34xx.c
>>> +++ b/arch/arm/mach-omap2/resource34xx.c
>>> @@ -161,7 +161,7 @@ static DEFINE_MUTEX(dvfs_mutex);
>>>  /**
>>>   * opp_to_freq - convert OPPID to frequency (DEPRECATED)
>>>   * @freq: return frequency back to caller
>>> - * @opps: opp list
>>> + * @opp_t: OPP type where we need to look.
>>>   * @opp_id: OPP ID we are searching for
>>>   *
>>>   * return 0 and freq is populated if we find the opp_id, else,
>>> @@ -169,14 +169,14 @@ static DEFINE_MUTEX(dvfs_mutex);
>>>   *
>>>   * NOTE: this function is a standin for the timebeing as opp_id is deprecated
>>>   */
>>> -static int __deprecated opp_to_freq(unsigned long *freq,
>>> -               const struct omap_opp *opps, u8 opp_id)
>>> +static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_t,
>>>       
>> Enum type and variable have the same name :( mebbe a rename of variable is
>> appropriate
>>     
>
> Not sure why you say this. Did you see the compiler throwing up any warning?
>   
The usage later in the code is opp_t -> this is a readability issue not 
a compiler warning.

>>> @@ -188,20 +188,20 @@ static int __deprecated opp_to_freq(unsigned long *freq,
>>> -static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
>>> +static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_t,
>>>       
>> Re: enum type and variable have the same name :( mebbe a rename of variable is
>> appropriate
>>     
>>>                 unsigned long freq)
>>>  {
>>>         struct omap_opp *opp;
>>>
>>> -       BUG_ON(!opp_id || !opps);
>>> -       opp = opp_find_freq_ceil(opps, &freq);
>>> +       BUG_ON(opp_t == OPP_NONE || opp_t > OPP_TYPES);
>>> +       opp = opp_find_freq_ceil(opp_t, &freq);
>>>         if (IS_ERR(opp))
>>>                 return -EINVAL;
>>>         *opp_id = opp_get_opp_id(opp);
>>> @@ -218,9 +218,6 @@ void init_opp(struct shared_resource *resp)
>>>         u8 opp_id;
>>>         resp->no_of_users = 0;
>>>
>>> -       if (!mpu_opps || !dsp_opps || !l3_opps)
>>> -               return;
>>> -
>>>       
>> the original intent of this check is lost here - if the initializations did not
>> take place, we will not proceed. An equivalent check might be good to maintain
>> at this point.
>>     
>
> You are partially correct. I took off the checks because we have a BUG_ON() call
> in the beginning of the boot code right after we initialize the OPP tables. So
> we should not hit this check.
>   
hmm.. interesting.. can you elaborate with exact functions?

if you are removing this check, please do a follow up patch and maintain 
equivalent one for this so that the patch does exactly what the commit 
message says "introduce enums" - not do something more.


[...]
Regards,
Nishanth Menon

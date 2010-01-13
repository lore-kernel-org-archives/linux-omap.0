From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different
 OPP types
Date: Wed, 13 Jan 2010 18:52:07 +0530
Message-ID: <4B4DC8FF.8090606@ti.com>
References: <1263299979.1536.7.camel@boson> <7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com> <4B4DA36C.7040206@ti.com> <4B4DC297.8070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41640 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab0AMNWN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jan 2010 08:22:13 -0500
In-Reply-To: <4B4DC297.8070703@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon wrote:
> Romit Dasgupta said the following on 01/13/2010 04:41 AM:
>> Menon, Nishanth wrote:
>>   
>>> General comment: might be good to state the enum types you are introducing
>>> for OMAP3 in the commit message
>>>     
>> Actually the introduction of enum type itself is the heart of the patch. The
>> details are irrelevant.
>>   
> could you be a little more verbose as to what is irrelevant? the OMAP3 
> enums descriptions in commit message?
Yes, because they are going to be SoC specific.
> 
>>>> Signed-off-by: Romit Dasgupta <romit@ti.com>
>>>> ---
>>>>
>>>>         omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
>>>>                                 omap34xx_opp_def_list;
>>>> -       for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
>>>> -               *omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
>>>> +       entries = cpu_is_omap3630() ? ARRAY_SIZE(omap34xx_opp_def_list) :
>>>> +                       ARRAY_SIZE(omap36xx_opp_def_list);
>>>> +       for (i = 1; i <= entries; i++) {
>>>> +               ret = opp_init_list(i, omap3_opp_def_list[i - 1]);
>>>>       
>>> a) if you remove OPP_NONE, i-1 is not needed (same everywhere in the patch)
>>>     
>> Frankly, I did not want to introduce OPP_NONE but did so as you are checking all
>> parameters passed to the OPP APIs.
>>   
> Lets remove it then.

OK
>>   
>>   
> definition of enum and the implicit usage  of enums are in two different 
> files. there is a distinct possibility of some one modifying the header 
> without actually knowing that .c depends on the exact values of the enum 
> definition.
As I said before one needs to make changes in the kernel by knowing what they
are doing.
> 
> pm34xx.c has no right to depend on opp.h definition values -> if it does 
> it ties it down and a constraint for future flexibility. please change.

The right approach should be to take out the loop in pm34xx.c for now and
explicitly call the opp_init_list function after passing OPP_MPU, OPP_L3,
OPP_DSP in any order. So pm34xx.c needs to change not opp.[ch]. What do you think?
>>>>   */
>>>> -static int __deprecated opp_to_freq(unsigned long *freq,
>>>> -               const struct omap_opp *opps, u8 opp_id)
>>>> +static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_t,
>>>>       
>>> Enum type and variable have the same name :( mebbe a rename of variable is
>>> appropriate
>>>     
>> Not sure why you say this. Did you see the compiler throwing up any warning?
>>   
> The usage later in the code is opp_t -> this is a readability issue not 
> a compiler warning.
What is the readability issue? Why cant we declare something like enum opp_t opp_t?

>>> the original intent of this check is lost here - if the initializations did not
>>> take place, we will not proceed. An equivalent check might be good to maintain
>>> at this point.
>>>     
>> You are partially correct. I took off the checks because we have a BUG_ON() call
>> in the beginning of the boot code right after we initialize the OPP tables. So
>> we should not hit this check.
>>   
> hmm.. interesting.. can you elaborate with exact functions?

omap3_pm_init_opp_table
> 
> if you are removing this check, please do a follow up patch and maintain 
> equivalent one for this so that the patch does exactly what the commit 
> message says "introduce enums" - not do something more.
> 

How on earth?? I have removed mpu_opps, l3_opps, dsp_opps from the code so how
do you think I should preserve the checking of the variables when they don't exist.


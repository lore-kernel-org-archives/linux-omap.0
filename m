From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different
 OPP types
Date: Fri, 15 Jan 2010 04:35:07 -0600
Message-ID: <4B5044DB.1010201@ti.com>
References: <1263299979.1536.7.camel@boson> <7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com> <4B4DA36C.7040206@ti.com> <4B4DC297.8070703@gmail.com> <4B4DC8FF.8090606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab0AOKfK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 05:35:10 -0500
In-Reply-To: <4B4DC8FF.8090606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Romit Dasgupta had written, on 01/13/2010 07:22 AM, the following:
Apologies on a delayed response, few other topics required urgent 
attention meanwhile.

> Nishanth Menon wrote:
>> Romit Dasgupta said the following on 01/13/2010 04:41 AM:
>>> Menon, Nishanth wrote:
>>>   
>>>> General comment: might be good to state the enum types you are introducing
>>>> for OMAP3 in the commit message
>>>>     
>>> Actually the introduction of enum type itself is the heart of the patch. The
>>> details are irrelevant.
>>>   
>> could you be a little more verbose as to what is irrelevant? the OMAP3 
>> enums descriptions in commit message?
> Yes, because they are going to be SoC specific.
Here is a sample commit message I can think of:
----
Using omap_opp * to refer to domain types restricts opp implementation 
into maintaining pointers outside the opp layer. This causes issues such as:
a) Describing cross domain dependencies (e.g. dsp vs mpu)
b) Ease of transitioning/supporting to multiple silicon variants and 
families
c) Choice of varied options in implementing opp layer internals.

Since all we need a identifying a specific domain for query/operational 
purposes, we introduce enum for identifying OPP types instead of using 
opp layer's internal data structure pointer.

Currently, OMAP3 is the only silicon supporting the OPP layer, hence 
mpu_opps, l3_opps and dsp_opps are deprecated and replaced with OPP_MPU, 
OPP_L3 and OPP_DSP respectively.
---

Benefit of this is that someone who may not monitoring linux-omap very 
closely and is not aware of this change (e.g. private trees and 
potential users such as dspbridge) can figure out from the git log which 
commit might potentially affect them. The patch does SOC specific 
change, so the commit message ought to catch their attention. It also 
allows maintainers(later in the pipeline) who maynot know about this 
specific discussion (btw, a link might be useful as mentioned 
previously), to understand the scope of the change accurately.

Please note I have divided the commit message into three parts:
   i) why is the old strategy not effection (motivation for the patch)
  ii) why is the new strategy beneficial (benefit of the patch)
iii) what is the impact of the patch (warning for historical 
purposes/informative).

[...]
>>>>> +       for (i = 1; i <= entries; i++) {
>>>>> +               ret = opp_init_list(i, omap3_opp_def_list[i - 1]);
>>>>>       
>>>> a) if you remove OPP_NONE, i-1 is not needed (same everywhere in the patch)
>>>>     
>>> Frankly, I did not want to introduce OPP_NONE but did so as you are checking all
>>> parameters passed to the OPP APIs.
>>>   
>> Lets remove it then.
> 
> OK
Thanks.

>>>   
>>>   
>> definition of enum and the implicit usage  of enums are in two different 
>> files. there is a distinct possibility of some one modifying the header 
>> without actually knowing that .c depends on the exact values of the enum 
>> definition.
> As I said before one needs to make changes in the kernel by knowing what they
> are doing.
>> pm34xx.c has no right to depend on opp.h definition values -> if it does 
>> it ties it down and a constraint for future flexibility. please change.
> 
> The right approach should be to take out the loop in pm34xx.c for now and
> explicitly call the opp_init_list function after passing OPP_MPU, OPP_L3,
> OPP_DSP in any order. So pm34xx.c needs to change not opp.[ch]. What do you think?

I did dig into this a few mins ago.. and yes I can see similar example 
in drivers/mfd/twl4030-core.c

The intent of my comment is this: when someone else, few months from 
now, is focusing on adding/changing opp logic, they will focus on opp.c 
and .h. we have two choices to handle this:
a) Ensure that users of opp.h do not know how it works internally -> 
e.g. ordering of opp list for example.
b) add
/* WARNING: See file:arch/arm/mach-omap2/pm34xx.c before modifying the 
sequence of these enums */ to opp.h
and
/* WARNING: See file:arch/arm/plat-omap/include/plat/opp.h before 
modifying this */ in pm34xx.c

now, I was recommending doing a, till a thought a little more on the 
implementation(array based) and how long that implementation might 
last(we might potentially move opp.c to a list implementation). the 
effort would be to complicate the opp_init,add functions for a very 
short lifetime. This effort maynot be worth it.

Instead I would request at least (b) be done to prevent mistaken 
modifications.

>>>>>   */
>>>>> -static int __deprecated opp_to_freq(unsigned long *freq,
>>>>> -               const struct omap_opp *opps, u8 opp_id)
>>>>> +static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_t,
>>>>>       
>>>> Enum type and variable have the same name :( mebbe a rename of variable is
>>>> appropriate
>>>>     
>>> Not sure why you say this. Did you see the compiler throwing up any warning?
>>>   
>> The usage later in the code is opp_t -> this is a readability issue not 
>> a compiler warning.
> What is the readability issue? Why cant we declare something like enum opp_t opp_t?

Let me try to explain this clearly. assume we have a struct opp_t (not 
enum) for the time being.
void some_func(struct opp_t *opp_t)
{
   struct opp_t *opp;

..
200 line of code (>one page full)
....
/* point 1 */
    BUG_ON(opp_t.xyz)
...
  200 lines of more code
..
/* point 2 */
    BUG_ON(opp.xyz)
...

}

lets say this is compiled by some non follower of this mail chain,
compiler throws an error for point 1: filex:liney
so the guy/gal fires up vim and opens the filex, goes to line y
he/she cannot see the start of the function, knows that there is a 
struct opp_t
seeing opp_t.xyz the reader is confused and has to search for what opp_t 
  really is.

Now if it was point 2, it might have been easier for the reader at the 
first look.

I know we cannot write code idiot friendly, but we dont need to make it 
obfuscated either.. renaming opp_t to *oppt or enum opp_t to opp_type 
might be a little verbose, but it helps for some poor bloke later on..

> 
>>>> the original intent of this check is lost here - if the initializations did not
>>>> take place, we will not proceed. An equivalent check might be good to maintain
>>>> at this point.
>>>>     
>>> You are partially correct. I took off the checks because we have a BUG_ON() call
>>> in the beginning of the boot code right after we initialize the OPP tables. So
>>> we should not hit this check.
>>>   
>> hmm.. interesting.. can you elaborate with exact functions?
> 
> omap3_pm_init_opp_table
>> if you are removing this check, please do a follow up patch and maintain 
>> equivalent one for this so that the patch does exactly what the commit 
>> message says "introduce enums" - not do something more.
>>
> 
> How on earth?? I have removed mpu_opps, l3_opps, dsp_opps from the code so how
> do you think I should preserve the checking of the variables when they don't exist.
the test there was checking if the opp tables were initialized - at that 
time those variables were the only way to do it. now you have replaced 
those variables with enums, I think I understand your point about 
redundancy of those checks, but that will be fixing a different problem 
altogether and breaks the atomicity of this patch. apologies on being a 
nitpick, but it does indeed help a git bisect if something goes wrong in 
the future due to the missing of the check and something we did not see 
today.

-- 
Regards,
Nishanth Menon

From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5] omap: Allow testing for omap type with 	omap_has_feature
Date: Thu, 8 Jul 2010 14:37:34 -0500
Message-ID: <4C3628FE.5030201@ti.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>	<20100708093804.16352.82935.stgit@baageli.muru.com>	<4C35E8D1.6030504@ti.com>	<AANLkTimTBT_tNNB4GB7mvy1hAEcMrWsauIvjG_p33TD2@mail.gmail.com>	<4C35FCBF.4020400@ti.com> <AANLkTinoIchxcoG-GBROttjr63ZxIRwFheQwZ4RAxnWn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758476Ab0GHThg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 15:37:36 -0400
In-Reply-To: <AANLkTinoIchxcoG-GBROttjr63ZxIRwFheQwZ4RAxnWn@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Venkatraman S had written, on 07/08/2010 02:28 PM, the following:
> On Thu, Jul 8, 2010 at 9:58 PM, Nishanth Menon <nm@ti.com> wrote:
>> S, Venkatraman had written, on 07/08/2010 11:15 AM, the following:
>>> On Thu, Jul 8, 2010 at 8:33 PM, Nishanth Menon <nm@ti.com> wrote:
>>>> Tony Lindgren had written, on 07/08/2010 04:38 AM, the following:
>>>>> Allow testing for omap type with omap_has_feature. This
>>>>> can be used to leave out cpu_is_omapxxxx checks.
>>>>>
>>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>>> ---
>>>>>  arch/arm/plat-omap/include/plat/cpu.h |   38
>>>>> ++++++++++++++++++++++++++-------
>>>>>  1 files changed, 30 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
>>>>> b/arch/arm/plat-omap/include/plat/cpu.h
>>>>> index 96eac4d..c117c3c 100644
>>>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>>>> @@ -437,14 +437,36 @@ int omap_chip_is(struct omap_chip_id oci);
>>>>>  void omap2_check_revision(void);
>>>>>  /*
>>>>> - * Runtime detection of OMAP3 features
>>>>> + * Runtime detection of OMAP features
>>>>>  */
>>>>> -#define OMAP3_HAS_L2CACHE              BIT(0)
>>>>> -#define OMAP3_HAS_IVA                  BIT(1)
>>>>> -#define OMAP3_HAS_SGX                  BIT(2)
>>>>> -#define OMAP3_HAS_NEON                 BIT(3)
>>>>> -#define OMAP3_HAS_ISP                  BIT(4)
>>>>> -#define OMAP3_HAS_192MHZ_CLK           BIT(5)
>>>>> -#define OMAP3_HAS_IO_WAKEUP            BIT(6)
>>>>> +#define OMAP_FEAT_CLASS_OMAP1          BIT(24)
>>>>> +#define OMAP_FEAT_CLASS_OMAP2          BIT(25)
>>>>> +#define OMAP_FEAT_CLASS_OMAP3          BIT(26)
>>>>> +#define OMAP_FEAT_CLASS_OMAP4          BIT(27)
>>>>> +
>>>>> +#define OMAP_HAS_L2CACHE               BIT(0)
>>>>> +#define OMAP_HAS_IVA                   BIT(1)
>>>>> +#define OMAP_HAS_SGX                   BIT(2)
>>>>> +#define OMAP_HAS_NEON                  BIT(3)
>>>>> +#define OMAP_HAS_ISP                   BIT(4)
>>>>> +#define OMAP_HAS_192MHZ_CLK            BIT(5)
>>>>> +#define OMAP_HAS_IO_WAKEUP             BIT(6)
>>>>> +
>>>>> +#define OMAP2_HAS_IVA                  OMAP_FEAT_CLASS_OMAP2 |
>>>>> OMAP_HAS_IVA
>>>>> +#define OMAP2_HAS_SGX                  OMAP_FEAT_CLASS_OMAP2 |
>>>>> OMAP_HAS_SGX
>>>>> +
>>>>> +#define OMAP3_HAS_L2CACHE              OMAP_FEAT_CLASS_OMAP3 |
>>>>> OMAP_HAS_L2CACHE
>>>>> +#define OMAP3_HAS_IVA                  OMAP_FEAT_CLASS_OMAP3 |
>>>>> OMAP_HAS_IVA
>>>>> +#define OMAP3_HAS_SGX                  OMAP_FEAT_CLASS_OMAP3 |
>>>>> OMAP_HAS_SGX
>>>>> +#define OMAP3_HAS_NEON                 OMAP_FEAT_CLASS_OMAP3 |
>>>>> OMAP_HAS_NEON
>>>>> +#define OMAP3_HAS_ISP                  OMAP_FEAT_CLASS_OMAP3 |
>>>>> OMAP_HAS_ISP
>>>>> +#define OMAP3_HAS_192MHZ_CLK           OMAP_FEAT_CLASS_OMAP3 |
>>>>> OMAP_HAS_192MHZ_CLK
>>>>> +#define OMAP3_HAS_IO_WAKEUP            OMAP_FEAT_CLASS_OMAP3 |
>>>>> OMAP_HAS_IOWAKEUP
>>>>> +
>>>>> +#define OMAP4_HAS_L2CACHE              OMAP_FEAT_CLASS_OMAP4 |
>>>>> OMAP_HAS_L2CACHE
>>>>> +#define OMAP4_HAS_IVA                  OMAP_FEAT_CLASS_OMAP4 |
>>>>> OMAP_HAS_IVA
>>>>> +#define OMAP4_HAS_SGX                  OMAP_FEAT_CLASS_OMAP4 |
>>>>> OMAP_HAS_SGX
>>>>> +#define OMAP4_HAS_NEON                 OMAP_FEAT_CLASS_OMAP4 |
>>>>> OMAP_HAS_NEON
>>>>> +#define OMAP4_HAS_ISP                  OMAP_FEAT_CLASS_OMAP4 |
>>>>> OMAP_HAS_ISP
>>>>>  #endif
>>>>>
>>>> here is my contention:
>>>> there will be two ways to use this:
>>>> omap_has_feature(OMAP_HAS_SGX) and omap_has_feature(OMAP3_HAS_SGX)
>>>>
>>>> OMAP_HAS_SGX should return true or false no matter what omap silicon it
>>>> is.
>>>>
>>>> OMAP3_HAS_SGX usage is meant for what? it is a mixture of cpu_is_omap3()
>>>> and
>>>> omap_has_feature(OMAP_HAS_SGX) - tries to do two things in one shot.
>>>> which
>>>> defeats why we are trying to introduce a generic omap_has_feature in the
>>>> first place.
>>>> a) confusing as there seems to be two standards
>>>> b) redundant information use cpu_is_omapxyz() if needed.
>>>>
>>>> IMHO:
>>>> +#define OMAP_HAS_L2CACHE               BIT(0)
>>>> +#define OMAP_HAS_IVA                   BIT(1)
>>>> +#define OMAP_HAS_SGX                   BIT(2)
>>>> +#define OMAP_HAS_NEON                  BIT(3)
>>>> +#define OMAP_HAS_ISP                   BIT(4)
>>>> +#define OMAP3_HAS_192MHZ_CLK           BIT(5)
>>>> +#define OMAP_HAS_IO_WAKEUP             BIT(6)
>>>> and later if needed
>>>> +#define OMAP4_SOME_NEW_OMAP4ONLY_FEATURE BIT(7)
>>>>
>>>> where OMAP3_HAS is indicative that this is a OMAP3 *only* feature and
>>>> should
>>>> be used to differentiate between various omap3 silicon.
>>>>
>>>> Benefits:
>>>> a) distinction b/w omap generic and omap family specific features
>>>> b) you get to define 32 features instead of reserving 24-32 for OMAP
>>>> classes.
>>>>
>>> I still can't grok the need for the distinction in (a), and for
>>> "" +#define OMAP4_SOME_NEW_OMAP4ONLY_FEATURE BIT(7)""  etc.
>>>
>> OMAP_HAS_192MHZ_CLK -> does not indicate if this is omap3 ONLY feature (e.g.
>> 3430 does not have it, 3630 has it) but we know that omap4, 2, 1 etc dont
>> need it.
>>
>> in terms of readability, when i see omap_has_feature(OMAP3_HAS_xyz), I can
>> immediately review the code/read the code with the context of omap3 alone Vs
>> if this code was used in omap4/2/1 context question why it is so and we can
>> all improve.
>>
>> e.g. if a generic clock code meant for all omaps used 192MHZ, I would
>> question why is cpu specific feature being used there. which is easier with
>> a OMAP3_ tag.
> 
> If we extend this analogy, I can write
> omap_dma_driver_init(OMAP3_NUM_CHANNELS)  only to make it "more
> readable" and provide a omap3 specific context to the reader.
> The whole point was that the user code doesn't have such klux.

I must sadly disagree on this. different concept entirely.
in the case of a dma driver, num_channels is defintely something you'd 
like to abstract out. the initialization makes sense, but from a driver 
context, using omap specific - nak.

> 
>>
>>> If that OMAP4ONLY_FEATURE has to be checked, then the code
>>> to use it will also be OMAP4 specific.
>>>
>>> IOW, as a user, there are 2 ways to use omap_has_xxxx()
>>>
>>> void a_generic_funciton_for_all_omaps() {
>>>     if (cpu_has_xxxx_feature()
>>>         /* Do generic stuff */
>>> }
>>>
>>> void a_omap_4_specific_function()   {
>>>    if (omap_has_that_new_feature()
>>>          /* Do omap_4 specific stuff */
>>> }
>> See above explanation. sitting in the shoes of a reviewer who looks through
>> code not written by self, it helps to have some differentiation in
>> definitions to aid review.
>>
> 
>     I think this 'lazy reviewability'  comes at the cost of very
> abstraction  the features framework is intended to provide, not to
> mention the question of correct selection (is this a OMAP4 specific
> feature or is OMAP5 expected to have it ?). and upgradation.
> 
>     As mentioned before, the surrounding context of the use of
> omap_has_feature() will provide enough clues about the cpu specific
> nature of a feature, if at all needed.
Does it really? when a new feature is added, dont we want to know if it 
is generic feature or a omap specific feature? where is the flag?

1 year down the line, neither of us will remember this discussion in 
detail. lets take an example what might happen:

assume OMAP_HAS_192MHZ is defined - with our good intentions of being omap3.

developer Y comes along for OMAP5, sees that there is a flag for 
OMAP_HAS_192MHZ and says - cool i need this and since it is already present,

writes code for
if(omap_has_feature(OMAP_HAS_192MHZ)) {
	/* enable some cruft errata */
}

in omap5 code. guess what he posts the patch to us, a quick reviewer has 
forgotten that OMAP_HAS_192MHZ was omap3 only feature, ignores the fact 
that the feature was not enabled in omap5's check_revision.. darn.. we 
have a bug to fix.

instead, the developer is now able to create two patches:
a) convert OMAP3_HAS_192MHZ into OMAP_HAS_192MHZ after adding the omap5 
check_revision
b) do his crufty code..

same applies for reviewers.

-- 
Regards,
Nishanth Menon

From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 5/5] omap: Allow testing for omap type with
	omap_has_feature
Date: Fri, 9 Jul 2010 00:58:45 +0530
Message-ID: <AANLkTinoIchxcoG-GBROttjr63ZxIRwFheQwZ4RAxnWn@mail.gmail.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>
	<20100708093804.16352.82935.stgit@baageli.muru.com>
	<4C35E8D1.6030504@ti.com>
	<AANLkTimTBT_tNNB4GB7mvy1hAEcMrWsauIvjG_p33TD2@mail.gmail.com>
	<4C35FCBF.4020400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56076 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab0GHT2r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 15:28:47 -0400
Received: by gxk23 with SMTP id 23so662187gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Jul 2010 12:28:46 -0700 (PDT)
In-Reply-To: <4C35FCBF.4020400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jul 8, 2010 at 9:58 PM, Nishanth Menon <nm@ti.com> wrote:
> S, Venkatraman had written, on 07/08/2010 11:15 AM, the following:
>>
>> On Thu, Jul 8, 2010 at 8:33 PM, Nishanth Menon <nm@ti.com> wrote:
>>>
>>> Tony Lindgren had written, on 07/08/2010 04:38 AM, the following:
>>>>
>>>> Allow testing for omap type with omap_has_feature. This
>>>> can be used to leave out cpu_is_omapxxxx checks.
>>>>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>> ---
>>>> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 38
>>>> ++++++++++++++++++++++++++-------
>>>> =A01 files changed, 30 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
>>>> b/arch/arm/plat-omap/include/plat/cpu.h
>>>> index 96eac4d..c117c3c 100644
>>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>>> @@ -437,14 +437,36 @@ int omap_chip_is(struct omap_chip_id oci);
>>>> =A0void omap2_check_revision(void);
>>>> =A0/*
>>>> - * Runtime detection of OMAP3 features
>>>> + * Runtime detection of OMAP features
>>>> =A0*/
>>>> -#define OMAP3_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
>>>> -#define OMAP3_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
>>>> -#define OMAP3_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
>>>> -#define OMAP3_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
>>>> -#define OMAP3_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
>>>> -#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
>>>> -#define OMAP3_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0BIT(6)
>>>> +#define OMAP_FEAT_CLASS_OMAP1 =A0 =A0 =A0 =A0 =A0BIT(24)
>>>> +#define OMAP_FEAT_CLASS_OMAP2 =A0 =A0 =A0 =A0 =A0BIT(25)
>>>> +#define OMAP_FEAT_CLASS_OMAP3 =A0 =A0 =A0 =A0 =A0BIT(26)
>>>> +#define OMAP_FEAT_CLASS_OMAP4 =A0 =A0 =A0 =A0 =A0BIT(27)
>>>> +
>>>> +#define OMAP_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
>>>> +#define OMAP_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
>>>> +#define OMAP_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
>>>> +#define OMAP_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
>>>> +#define OMAP_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
>>>> +#define OMAP_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 =A0BIT(5)
>>>> +#define OMAP_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
>>>> +
>>>> +#define OMAP2_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP2 |
>>>> OMAP_HAS_IVA
>>>> +#define OMAP2_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP2 |
>>>> OMAP_HAS_SGX
>>>> +
>>>> +#define OMAP3_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_CL=
ASS_OMAP3 |
>>>> OMAP_HAS_L2CACHE
>>>> +#define OMAP3_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP3 |
>>>> OMAP_HAS_IVA
>>>> +#define OMAP3_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP3 |
>>>> OMAP_HAS_SGX
>>>> +#define OMAP3_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_FEAT_=
CLASS_OMAP3 |
>>>> OMAP_HAS_NEON
>>>> +#define OMAP3_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP3 |
>>>> OMAP_HAS_ISP
>>>> +#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 OMAP_FEAT_CLASS_=
OMAP3 |
>>>> OMAP_HAS_192MHZ_CLK
>>>> +#define OMAP3_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_CLAS=
S_OMAP3 |
>>>> OMAP_HAS_IOWAKEUP
>>>> +
>>>> +#define OMAP4_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_CL=
ASS_OMAP4 |
>>>> OMAP_HAS_L2CACHE
>>>> +#define OMAP4_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP4 |
>>>> OMAP_HAS_IVA
>>>> +#define OMAP4_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP4 |
>>>> OMAP_HAS_SGX
>>>> +#define OMAP4_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_FEAT_=
CLASS_OMAP4 |
>>>> OMAP_HAS_NEON
>>>> +#define OMAP4_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEA=
T_CLASS_OMAP4 |
>>>> OMAP_HAS_ISP
>>>> =A0#endif
>>>>
>>> here is my contention:
>>> there will be two ways to use this:
>>> omap_has_feature(OMAP_HAS_SGX) and omap_has_feature(OMAP3_HAS_SGX)
>>>
>>> OMAP_HAS_SGX should return true or false no matter what omap silico=
n it
>>> is.
>>>
>>> OMAP3_HAS_SGX usage is meant for what? it is a mixture of cpu_is_om=
ap3()
>>> and
>>> omap_has_feature(OMAP_HAS_SGX) - tries to do two things in one shot=
=2E
>>> which
>>> defeats why we are trying to introduce a generic omap_has_feature i=
n the
>>> first place.
>>> a) confusing as there seems to be two standards
>>> b) redundant information use cpu_is_omapxyz() if needed.
>>>
>>> IMHO:
>>> +#define OMAP_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
>>> +#define OMAP_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
>>> +#define OMAP_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
>>> +#define OMAP_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
>>> +#define OMAP_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
>>> +#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
>>> +#define OMAP_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
>>> and later if needed
>>> +#define OMAP4_SOME_NEW_OMAP4ONLY_FEATURE BIT(7)
>>>
>>> where OMAP3_HAS is indicative that this is a OMAP3 *only* feature a=
nd
>>> should
>>> be used to differentiate between various omap3 silicon.
>>>
>>> Benefits:
>>> a) distinction b/w omap generic and omap family specific features
>>> b) you get to define 32 features instead of reserving 24-32 for OMA=
P
>>> classes.
>>>
>>
>> I still can't grok the need for the distinction in (a), and for
>> "" +#define OMAP4_SOME_NEW_OMAP4ONLY_FEATURE BIT(7)"" =A0etc.
>>
>
> OMAP_HAS_192MHZ_CLK -> does not indicate if this is omap3 ONLY featur=
e (e.g.
> 3430 does not have it, 3630 has it) but we know that omap4, 2, 1 etc =
dont
> need it.
>
> in terms of readability, when i see omap_has_feature(OMAP3_HAS_xyz), =
I can
> immediately review the code/read the code with the context of omap3 a=
lone Vs
> if this code was used in omap4/2/1 context question why it is so and =
we can
> all improve.
>
> e.g. if a generic clock code meant for all omaps used 192MHZ, I would
> question why is cpu specific feature being used there. which is easie=
r with
> a OMAP3_ tag.

If we extend this analogy, I can write
omap_dma_driver_init(OMAP3_NUM_CHANNELS)  only to make it "more
readable" and provide a omap3 specific context to the reader.
The whole point was that the user code doesn't have such klux.

>
>
>> If that OMAP4ONLY_FEATURE has to be checked, then the code
>> to use it will also be OMAP4 specific.
>>
>> IOW, as a user, there are 2 ways to use omap_has_xxxx()
>>
>> void a_generic_funciton_for_all_omaps() {
>> =A0 =A0 if (cpu_has_xxxx_feature()
>> =A0 =A0 =A0 =A0 /* Do generic stuff */
>> }
>>
>> void a_omap_4_specific_function() =A0 {
>> =A0 =A0if (omap_has_that_new_feature()
>> =A0 =A0 =A0 =A0 =A0/* Do omap_4 specific stuff */
>> }
>
> See above explanation. sitting in the shoes of a reviewer who looks t=
hrough
> code not written by self, it helps to have some differentiation in
> definitions to aid review.
>

    I think this 'lazy reviewability'  comes at the cost of very
abstraction  the features framework is intended to provide, not to
mention the question of correct selection (is this a OMAP4 specific
feature or is OMAP5 expected to have it ?). and upgradation.

    As mentioned before, the surrounding context of the use of
omap_has_feature() will provide enough clues about the cpu specific
nature of a feature, if at all needed.

Thanks,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

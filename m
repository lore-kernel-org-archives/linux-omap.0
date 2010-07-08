From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 5/5] omap: Allow testing for omap type with
	omap_has_feature
Date: Thu, 8 Jul 2010 21:45:25 +0530
Message-ID: <AANLkTimTBT_tNNB4GB7mvy1hAEcMrWsauIvjG_p33TD2@mail.gmail.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>
	<20100708093804.16352.82935.stgit@baageli.muru.com>
	<4C35E8D1.6030504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47800 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0GHQPj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 12:15:39 -0400
Received: by gxk23 with SMTP id 23so494538gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Jul 2010 09:15:38 -0700 (PDT)
In-Reply-To: <4C35E8D1.6030504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jul 8, 2010 at 8:33 PM, Nishanth Menon <nm@ti.com> wrote:
> Tony Lindgren had written, on 07/08/2010 04:38 AM, the following:
>>
>> Allow testing for omap type with omap_has_feature. This
>> can be used to leave out cpu_is_omapxxxx checks.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 38
>> ++++++++++++++++++++++++++-------
>> =A01 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
>> b/arch/arm/plat-omap/include/plat/cpu.h
>> index 96eac4d..c117c3c 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -437,14 +437,36 @@ int omap_chip_is(struct omap_chip_id oci);
>> =A0void omap2_check_revision(void);
>> =A0/*
>> - * Runtime detection of OMAP3 features
>> + * Runtime detection of OMAP features
>> =A0*/
>> -#define OMAP3_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
>> -#define OMAP3_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
>> -#define OMAP3_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
>> -#define OMAP3_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
>> -#define OMAP3_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
>> -#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
>> -#define OMAP3_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0BIT(6)
>> +#define OMAP_FEAT_CLASS_OMAP1 =A0 =A0 =A0 =A0 =A0BIT(24)
>> +#define OMAP_FEAT_CLASS_OMAP2 =A0 =A0 =A0 =A0 =A0BIT(25)
>> +#define OMAP_FEAT_CLASS_OMAP3 =A0 =A0 =A0 =A0 =A0BIT(26)
>> +#define OMAP_FEAT_CLASS_OMAP4 =A0 =A0 =A0 =A0 =A0BIT(27)
>> +
>> +#define OMAP_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
>> +#define OMAP_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
>> +#define OMAP_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
>> +#define OMAP_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
>> +#define OMAP_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
>> +#define OMAP_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 =A0BIT(5)
>> +#define OMAP_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
>> +
>> +#define OMAP2_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP2 |
>> OMAP_HAS_IVA
>> +#define OMAP2_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP2 |
>> OMAP_HAS_SGX
>> +
>> +#define OMAP3_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_CLAS=
S_OMAP3 |
>> OMAP_HAS_L2CACHE
>> +#define OMAP3_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP3 |
>> OMAP_HAS_IVA
>> +#define OMAP3_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP3 |
>> OMAP_HAS_SGX
>> +#define OMAP3_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_FEAT_CL=
ASS_OMAP3 |
>> OMAP_HAS_NEON
>> +#define OMAP3_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP3 |
>> OMAP_HAS_ISP
>> +#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 OMAP_FEAT_CLASS_OM=
AP3 |
>> OMAP_HAS_192MHZ_CLK
>> +#define OMAP3_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_CLASS_=
OMAP3 |
>> OMAP_HAS_IOWAKEUP
>> +
>> +#define OMAP4_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_CLAS=
S_OMAP4 |
>> OMAP_HAS_L2CACHE
>> +#define OMAP4_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP4 |
>> OMAP_HAS_IVA
>> +#define OMAP4_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP4 |
>> OMAP_HAS_SGX
>> +#define OMAP4_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_FEAT_CL=
ASS_OMAP4 |
>> OMAP_HAS_NEON
>> +#define OMAP4_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_FEAT_=
CLASS_OMAP4 |
>> OMAP_HAS_ISP
>> =A0#endif
>>
> here is my contention:
> there will be two ways to use this:
> omap_has_feature(OMAP_HAS_SGX) and omap_has_feature(OMAP3_HAS_SGX)
>
> OMAP_HAS_SGX should return true or false no matter what omap silicon =
it is.
>
> OMAP3_HAS_SGX usage is meant for what? it is a mixture of cpu_is_omap=
3() and
> omap_has_feature(OMAP_HAS_SGX) - tries to do two things in one shot. =
which
> defeats why we are trying to introduce a generic omap_has_feature in =
the
> first place.
> a) confusing as there seems to be two standards
> b) redundant information use cpu_is_omapxyz() if needed.
>
> IMHO:
> +#define OMAP_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> +#define OMAP_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> +#define OMAP_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
> +#define OMAP_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
> +#define OMAP_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
> +#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
> +#define OMAP_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
> and later if needed
> +#define OMAP4_SOME_NEW_OMAP4ONLY_FEATURE BIT(7)
>
> where OMAP3_HAS is indicative that this is a OMAP3 *only* feature and=
 should
> be used to differentiate between various omap3 silicon.
>
> Benefits:
> a) distinction b/w omap generic and omap family specific features
> b) you get to define 32 features instead of reserving 24-32 for OMAP
> classes.
>

I still can't grok the need for the distinction in (a), and for
"" +#define OMAP4_SOME_NEW_OMAP4ONLY_FEATURE BIT(7)""  etc.

If that OMAP4ONLY_FEATURE has to be checked, then the code
to use it will also be OMAP4 specific.

IOW, as a user, there are 2 ways to use omap_has_xxxx()

void a_generic_funciton_for_all_omaps() {
     if (cpu_has_xxxx_feature()
         /* Do generic stuff */
}

void a_omap_4_specific_function()   {
    if (omap_has_that_new_feature()
          /* Do omap_4 specific stuff */
}

In a_generic_function_for_all_omaps(), if there is a need for checking
OMAP4_has_xxxx,
then the code will eventually be ugly.  There is going to be a
cpu_is_xxxx() overload, for things
not expressed through features framework.

I did read the other thread
http://marc.info/?l=3Dlinux-omap&m=3D127858108626850&w=3D2
and it's been discussed before as well. But I can't see a genuine use
case yet, and what is the loss involved
if a omap3_has_192mhz_clk is expressed as omap_has_192mhz_clk, even if
it is omap3 specific.

Thanks,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

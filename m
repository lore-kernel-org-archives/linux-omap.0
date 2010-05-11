From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: How to introduce omap_features (was Re: [PATCH RESEND] update omap3
 features bitmap and API to generic 	names)
Date: Tue, 11 May 2010 07:06:20 -0500
Message-ID: <4BE9483C.7090308@gmail.com>
References: <1273521338-2896-1-git-send-email-svenkatr@ti.com> <AANLkTimNjnKG3WFK8mdpgHaLh-Xpv54fohFgEYYiVVcg@mail.gmail.com> <0680EC522D0CC943BC586913CF3768C003B3209B23@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:54007 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab0EKMGa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 08:06:30 -0400
Received: by yxe29 with SMTP id 29so2350211yxe.4
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 05:06:29 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3209B23@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

-linux-arm

On 05/10/2010 10:53 PM, S, Venkatraman wrote:
>> -----Original Message-----
>> From: menon.nishanth@gmail.com
>> [mailto:menon.nishanth@gmail.com] On Behalf Of Menon, Nishanth
>> Sent: Tuesday, May 11, 2010 5:02 AM
>> To: S, Venkatraman
>> Cc: linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; Tony Lindgren;
>> Chikkature Rajashekar, Madhusudhan
>> Subject: Re: [PATCH RESEND] update omap3 features bitmap and
>> API to generic names
>>
>> On Mon, May 10, 2010 at 2:55 PM, Venkatraman S
>> <svenkatr@ti.com>  wrote:
>>>         OMAP3 features bitmap is used a method to check for SoC
>>> specific features. This patch renames the global variables and the
>>> accessor functions to use a generic name from omap3_* to
>>> omap_*
>>>
>>> Signed-off-by: Venkatraman S<svenkatr@ti.com>
>>> CC: Nishant Menon<nm@ti.com>
>> Just for the patchworks
>> NAK - discussed before -
>> http://marc.info/?l=linux-omap&m=127349696800651&w=2
>
> This patch doesn't have the descriptor load changes, and just the rename.
> Did you take a look at it first?

Arrgh - my bad - there was no reference to previous discussions or 
anything in this patch, please do add references in diffstat section if 
you are refering to a previous discussed strategy to help the reviewers 
differentiate and understand you better.

overall this still opens up a question for me -> can we blindly replace 
omap3-features with omap features? how do we think of omap1,2,3,4 are 
handled consistently with a 32 bit field?

I agree on the need to have a omap independent field, but is 
omap3_features the one we need to modify OR should we be introducing a 
new field?

my vote goes for introducing a new field.

>
>>> CC: Tony Lindgren<tony@atomide.com>
>>> CC: Madhusudhan Chikkature<madhu.cr@ti.com>
>>> ---
>>>   * Resent to CC Madhu
>>>
>>>   arch/arm/mach-omap2/clock3xxx_data.c  |    2 +-
>>>   arch/arm/mach-omap2/id.c              |   18 ++++++++--------
>>>   arch/arm/plat-omap/include/plat/cpu.h |   34
>>> ++++++++++++++++----------------
>>>   3 files changed, 27 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c
>>> b/arch/arm/mach-omap2/clock3xxx_data.c
>>> index 9cba556..afa481d 100644
>>> --- a/arch/arm/mach-omap2/clock3xxx_data.c
>>> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
>>> @@ -3510,7 +3510,7 @@ int __init omap3xxx_clk_init(void)
>>>                         cpu_clkflg |= CK_3430ES2;
>>>                 }
>>>         }
>>> -       if (omap3_has_192mhz_clk())
>>> +       if (omap_has_192mhz_clk())
>>>                 omap_96m_alwon_fck = omap_96m_alwon_fck_3630;
>>>
>>>         if (cpu_is_omap3630()) {
>>> diff --git a/arch/arm/mach-omap2/id.c
>> b/arch/arm/mach-omap2/id.c index
>>> 37b8a1a..a095b87 100644
>>> --- a/arch/arm/mach-omap2/id.c
>>> +++ b/arch/arm/mach-omap2/id.c
>>> @@ -28,7 +28,7 @@
>>>   static struct omap_chip_id omap_chip;
>>>   static unsigned int omap_revision;
>>>
>>> -u32 omap3_features;
>>> +u32 omap_features;
>>>
>>>   unsigned int omap_rev(void)
>>>   {
>>> @@ -161,14 +161,14 @@ void __init omap24xx_check_revision(void)
>>>   #define OMAP3_CHECK_FEATURE(status,feat)
>>
>>> \
>>>         if (((status&  OMAP3_ ##feat## _MASK)
>>
>>> \
>>>                 >>  OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat##
>> _NONE) {
>>> \
>>> -               omap3_features |= OMAP3_HAS_ ##feat;
>>
>>> \
>>> +               omap_features |= OMAP_HAS_ ##feat;
>>
>>> + \
>>>         }
>>>
>>>   void __init omap3_check_features(void)
>>>   {
>>>         u32 status;
>>>
>>> -       omap3_features = 0;
>>> +       omap_features = 0;
>>>
>>>         status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
>>>
>>> @@ -178,7 +178,7 @@ void __init omap3_check_features(void)
>>>         OMAP3_CHECK_FEATURE(status, NEON);
>>>         OMAP3_CHECK_FEATURE(status, ISP);
>>>         if (cpu_is_omap3630())
>>> -               omap3_features |= OMAP3_HAS_192MHZ_CLK;
>>> +               omap_features |= OMAP_HAS_192MHZ_CLK;
>>>
>>>         /*
>>>          * TODO: Get additional info (where applicable) @@ -294,7
>>> +294,7 @@ void __init omap4_check_revision(void)
>>>   }
>>>
>>>   #define OMAP3_SHOW_FEATURE(feat)               \
>>> -       if (omap3_has_ ##feat())                \
>>> +       if (omap_has_ ##feat())         \
>>>                 printk(#feat" ");
>>>
>>>   void __init omap3_cpuinfo(void)
>>> @@ -314,20 +314,20 @@ void __init omap3_cpuinfo(void)
>>>                 /*
>>>                  * AM35xx devices
>>>                  */
>>> -               if (omap3_has_sgx()) {
>>> +               if (omap_has_sgx()) {
>>>                         omap_revision = OMAP3517_REV(rev);
>>>                         strcpy(cpu_name, "AM3517");
>>>                 } else {
>>>                         /* Already set in omap3_check_revision() */
>>>                         strcpy(cpu_name, "AM3505");
>>>                 }
>>> -       } else if (omap3_has_iva()&&  omap3_has_sgx()) {
>>> +       } else if (omap_has_iva()&&  omap_has_sgx()) {
>>>                 /* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
>>>                 strcpy(cpu_name, "OMAP3430/3530");
>>> -       } else if (omap3_has_iva()) {
>>> +       } else if (omap_has_iva()) {
>>>                 omap_revision = OMAP3525_REV(rev);
>>>                 strcpy(cpu_name, "OMAP3525");
>>> -       } else if (omap3_has_sgx()) {
>>> +       } else if (omap_has_sgx()) {
>>>                 omap_revision = OMAP3515_REV(rev);
>>>                 strcpy(cpu_name, "OMAP3515");
>>>         } else {
>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
>>> b/arch/arm/plat-omap/include/plat/cpu.h
>>> index 7514174..80dc8e0 100644
>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>> @@ -434,28 +434,28 @@ int omap_chip_is(struct omap_chip_id oci);
>>>   void omap2_check_revision(void);
>>>
>>>   /*
>>> - * Runtime detection of OMAP3 features
>>> + * Runtime detection of OMAP features
>>>   */
>>> -extern u32 omap3_features;
>>> +extern u32 omap_features;
>>>
>>> -#define OMAP3_HAS_L2CACHE              BIT(0) -#define
>> OMAP3_HAS_IVA
>>> BIT(1) -#define OMAP3_HAS_SGX                  BIT(2) -#define
>>> OMAP3_HAS_NEON                 BIT(3) -#define
>> OMAP3_HAS_ISP
>>> BIT(4) -#define OMAP3_HAS_192MHZ_CLK           BIT(5)
>>> +#define OMAP_HAS_L2CACHE               BIT(0) #define
>> OMAP_HAS_IVA
>>> +BIT(1) #define OMAP_HAS_SGX                   BIT(2) #define
>>> +OMAP_HAS_NEON                  BIT(3) #define OMAP_HAS_ISP
>>
>>> +BIT(4) #define OMAP_HAS_192MHZ_CLK            BIT(5)
>>>
>>> -#define OMAP3_HAS_FEATURE(feat,flag)                   \ -static
>>> inline unsigned int omap3_has_ ##feat(void)     \
>>> +#define OMAP_HAS_FEATURE(feat, flag)                   \ static
>>> +inline unsigned int omap_has_ ##feat(void)      \
>>>   {                                                      \
>>> -       return (omap3_features&  OMAP3_HAS_ ##flag);    \
>>> +       return (omap_features&  OMAP_HAS_ ##flag);      \
>>>   }                                                      \
>>>
>>> -OMAP3_HAS_FEATURE(l2cache, L2CACHE)
>>> -OMAP3_HAS_FEATURE(sgx, SGX)
>>> -OMAP3_HAS_FEATURE(iva, IVA)
>>> -OMAP3_HAS_FEATURE(neon, NEON)
>>> -OMAP3_HAS_FEATURE(isp, ISP)
>>> -OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
>>> +OMAP_HAS_FEATURE(l2cache, L2CACHE)
>>> +OMAP_HAS_FEATURE(sgx, SGX)
>>> +OMAP_HAS_FEATURE(iva, IVA)
>>> +OMAP_HAS_FEATURE(neon, NEON)
>>> +OMAP_HAS_FEATURE(isp, ISP)
>>> +OMAP_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
>>>
>>>   #endif
>>> --
>>> 1.6.3.3
>>>
>   --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


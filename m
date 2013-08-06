From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 7/9] ARM: DRA7: id: Add cpu detection support for DRA7xx
 based SoCs'
Date: Tue, 6 Aug 2013 14:59:41 +0300
Message-ID: <5200E52D.4020909@ti.com>
References: <1375633657-6835-1-git-send-email-rnayak@ti.com> <1375633657-6835-8-git-send-email-rnayak@ti.com> <51FF9025.6040401@ti.com> <5200AFC0.9030303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36054 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3HFMCQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 08:02:16 -0400
In-Reply-To: <5200AFC0.9030303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, santosh.shilimkar@ti.com, nm@ti.com, balbi@ti.com

On 08/06/2013 11:11 AM, Rajendra Nayak wrote:
> Hi Grygorii,
>
> On Monday 05 August 2013 05:14 PM, Grygorii Strashko wrote:
>> On 08/04/2013 07:27 PM, Rajendra Nayak wrote:
>>> From: R Sricharan <r.sricharan@ti.com>
>>>
>>> The DRA7xx is a high-performance, infotainment application device,
>>> based on enhanced OMAP architecture integrated on a 28-nm technology.
>>>
>>> Since DRA7 is a platform supported only using DT, the cpu detection
>>> is based on the compatibles passed from DT blobs as suggested here
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187712.html
>>>
>>> Suggested-by: Felipe Balbi <balbi@ti.com>
>>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>    arch/arm/mach-omap1/include/mach/soc.h |    1 +
>>>    arch/arm/mach-omap2/id.c               |    4 ++--
>>>    arch/arm/mach-omap2/soc.h              |   17 +++++++++++++++++
>>>    3 files changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap1/include/mach/soc.h b/arch/arm/mach-omap1/include/mach/soc.h
>>> index 6cf9c1c..612bd1c 100644
>>> --- a/arch/arm/mach-omap1/include/mach/soc.h
>>> +++ b/arch/arm/mach-omap1/include/mach/soc.h
>>> @@ -195,6 +195,7 @@ IS_OMAP_TYPE(1710, 0x1710)
>>>    #define cpu_is_omap34xx()        0
>>>    #define cpu_is_omap44xx()        0
>>>    #define soc_is_omap54xx()        0
>>> +#define soc_is_dra7xx()            0
>>>    #define soc_is_am33xx()            0
>>>    #define cpu_class_is_omap1()        1
>>>    #define cpu_class_is_omap2()        0
>>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>>> index 2dc62a2..0289adc 100644
>>> --- a/arch/arm/mach-omap2/id.c
>>> +++ b/arch/arm/mach-omap2/id.c
>>> @@ -61,7 +61,7 @@ int omap_type(void)
>>>            val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
>>>        } else if (cpu_is_omap44xx()) {
>>>            val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
>>> -    } else if (soc_is_omap54xx()) {
>>> +    } else if (soc_is_omap54xx() || soc_is_dra7xx()) {
>>>            val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
>>>            val &= OMAP5_DEVICETYPE_MASK;
>>>            val >>= 6;
>>> @@ -116,7 +116,7 @@ static u16 tap_prod_id;
>>>
>>>    void omap_get_die_id(struct omap_die_id *odi)
>>>    {
>>> -    if (cpu_is_omap44xx() || soc_is_omap54xx()) {
>>> +    if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
>>>            odi->id_0 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_0);
>>>            odi->id_1 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_1);
>>>            odi->id_2 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_2);
>>> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
>>> index 8c616e4..4588df1 100644
>>> --- a/arch/arm/mach-omap2/soc.h
>>> +++ b/arch/arm/mach-omap2/soc.h
>>> @@ -8,6 +8,7 @@
>>>     * Written by Tony Lindgren <tony.lindgren@nokia.com>
>>>     *
>>>     * Added OMAP4/5 specific defines - Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> + * Added DRA7xxx specific defines - Sricharan R<r.sricharan@ti.com>
>>>     *
>>>     * This program is free software; you can redistribute it and/or modify
>>>     * it under the terms of the GNU General Public License as published by
>>> @@ -35,6 +36,7 @@
>>>    #ifndef __ASSEMBLY__
>>>
>>>    #include <linux/bitops.h>
>>> +#include <linux/of.h>
>>>
>>>    /*
>>>     * Test if multicore OMAP support is needed
>>> @@ -105,6 +107,15 @@
>>>    # endif
>>>    #endif
>>>
>>> +#ifdef CONFIG_SOC_DRA7XX
>>> +# ifdef OMAP_NAME
>>> +#  undef MULTI_OMAP2
>>> +#  define MULTI_OMAP2
>>> +# else
>>> +#  define OMAP_NAME DRA7XX
>>> +# endif
>>> +#endif
>>> +
>>>    /*
>>>     * Omap device type i.e. EMU/HS/TST/GP/BAD
>>>     */
>>> @@ -233,6 +244,7 @@ IS_AM_SUBCLASS(437x, 0x437)
>>>    #define cpu_is_omap447x()        0
>>>    #define soc_is_omap54xx()        0
>>>    #define soc_is_omap543x()        0
>>> +#define soc_is_dra7xx()            0
>>>
>>>    #if defined(MULTI_OMAP2)
>>>    # if defined(CONFIG_ARCH_OMAP2)
>>> @@ -379,6 +391,11 @@ IS_OMAP_TYPE(3430, 0x3430)
>>>    # define soc_is_omap543x()        is_omap543x()
>>>    #endif
>>>
>>> +#if defined(CONFIG_SOC_DRA7XX)
>>> +#undef soc_is_dra7xx
>>> +#define soc_is_dra7xx()    (of_machine_is_compatible("ti,dra7"))
>>
>> Wouldn't that be too expensive to call of_machine_is_compatible every
>> time for DRA7 detection?
>
> Ideally these soc checks should happen only once at init (see PATCH 8/9 in the
> series for instance) so there should not be a 'every time' penalty.

Ok, Agreed then.

>
> regards,
> Rajendra
>
>>
>> May be static variable can be used to store DRA7 presence status,
>> smth. like this:
>>
>> static inline int is_dra7xx(void)
>> {
>> static int is_dra7 = -1;
>>
>> if (is_dra7 < 0)
>>   is_dra7 = of_machine_is_compatible("ti,dra7");
>>
>> return !!is_dra7;
>> }
>>
>> (it's just an idea, not verified)
>>
>>> +#endif
>>> +
>>>    /* Various silicon revisions for omap2 */
>>>    #define OMAP242X_CLASS        0x24200024
>>>    #define OMAP2420_REV_ES1_0    OMAP242X_CLASS
>>>
>>
>>
>> Regards,
>> -grygorii
>


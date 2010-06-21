From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
Date: Mon, 21 Jun 2010 08:26:09 -0500
Message-ID: <4C1F6871.2030807@ti.com>
References: <1277151798-26232-1-git-send-email-tarun.kanti@ti.com> <4C1F429E.40107@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB032358ECE4@dbde02.ent.ti.com> <4C1F618E.4090700@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032358ED1B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47274 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212Ab0FUN0L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jun 2010 09:26:11 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5LDQAmw011633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 08:26:10 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5LDQARw002154
	for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 08:26:10 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5LDQA7h018188
	for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 08:26:10 -0500 (CDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032358ED1B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

DebBarma, Tarun Kanti had written, on 06/21/2010 08:19 AM, the following:
[...]
>>>>> ---
>>>>>   arch/arm/plat-omap/dmtimer.c              |  131
>>>> +++++++++++++++++++++--------
>>>>>   arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
>>>>>   2 files changed, 96 insertions(+), 36 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
>> omap/dmtimer.c
>>>>> index c64875f..42344a7
>>>>> --- a/arch/arm/plat-omap/dmtimer.c
>>>>> +++ b/arch/arm/plat-omap/dmtimer.c
>>>>> @@ -160,6 +160,9 @@ struct omap_dm_timer {
>>>>>           unsigned reserved:1;
>>>>>           unsigned enabled:1;
>>>>>           unsigned posted:1;
>>>>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>>>>> + unsigned ms_correction:1;
>>>>> +#endif
>>>>>   };
>>>>>
>>>>>   static int dm_timer_count;
>>>>> @@ -185,18 +188,30 @@ static const int omap1_dm_timer_count =
>>>> ARRAY_SIZE(omap1_dm_timers);
>>>>>   #ifdef CONFIG_ARCH_OMAP2
>>>>>   static struct omap_dm_timer omap2_dm_timers[] = {
>>>>> - { .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
>>>>> - { .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
>>>>> - { .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
>>>>> - { .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
>>>>> - { .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
>>>>> - { .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
>>>>> - { .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
>>>>> - { .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
>>>>> - { .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
>>>>> - { .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
>>>>> - { .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
>>>>> - { .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
>>>>> + { .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11,
>>>>> +                                         .ms_correction = 0 },
>>>>> + { .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12,
>>>>> +                                         .ms_correction = 0 },
>>>> ignore of previous comments on .ms_correction initialization.
>>>> try the output of the following code:
>>>> struct b {
>>>>          unsigned char z:1;
>>>>          unsigned char a:1;
>>>> };
>>>>
>>>> static struct b b1[2]={
>>>>          {.z =1},
>>>>          {.a = 1},
>>>> };
>>>>
>>>> unsigned int main()
>>>> {
>>>>          int i;
>>>>          for (i=0; i<2; i++)
>>>>          printf("%d: %d %d\n", i, b1[i].z, b1[i].a);
>>>> }
>>> This comment is not clear to me.
>>> Are you suggesting to make the initialization of ms_correction variable
>>> in a separate function instead of doing the present way?
>> no. my suggestion is this:
>> you dont need to do .ms_correction = 0
>> when the variable is static - by C standards static variables are
>> initialized to 0. so, .ms_correction = 1 alone is needed in the specific
>> GPTimer cases where this is needed.
>>
>> the example i posted shows that it works :).
>>
> OK.
> But in this case I have to re-design / re-structure the other bit fields
> Viz. reserved, enabled, posted. Then we have to decide what to name the structure, etc. If you feel this is the right direction then I can go ahead.
My only complaint is with the unwanted initialization.

[...]

-- 
Regards,
Nishanth Menon

From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Tue, 13 Jul 2010 10:56:27 -0500
Message-ID: <4C3C8CAB.90900@ti.com>
References: <1278590256.3787.14.camel@Nokia-N900> <20100708122157.GI1920@atomide.com> <4C35E04B.1090102@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E7AADBE1@dbde02.ent.ti.com> <4C3C884D.20709@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E7AADC15@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60599 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756969Ab0GMP4k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jul 2010 11:56:40 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7AADC15@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "ValkeinenTomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Koskinen Aaro (Nokia-MS/Helsinki)" <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

Premi, Sanjeev had written, on 07/13/2010 10:48 AM, the following:
>> -----Original Message-----
>> From: Menon, Nishanth 
>> Sent: Tuesday, July 13, 2010 9:08 PM
>> To: Premi, Sanjeev
>> Cc: Tony Lindgren; felipe.balbi@nokia.com; linux-omap; Angelo 
>> Arrifano; Zebediah C. McClure; Alistair Buxton; Grazvydas 
>> Ignotas; Paul Walmsley; Shilimkar, Santosh; Guruswamy, 
>> Senthilvadivu; Kevin Hilman; DebBarma, Tarun Kanti; 
>> ValkeinenTomi (Nokia-MS/Helsinki); Koskinen Aaro 
>> (Nokia-MS/Helsinki); Pandita, Vikram; S, Vishwanath
>> Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single 
>> check_revision
>>
>> Premi, Sanjeev had written, on 07/13/2010 10:06 AM, the following:
>>>> -----Original Message-----
>>>> From: Menon, Nishanth 
>>>> Sent: Thursday, July 08, 2010 7:57 PM
>>>> To: Tony Lindgren
>>>> Cc: felipe.balbi@nokia.com; linux-omap; Angelo Arrifano; 
>>>> Zebediah C. McClure; Alistair Buxton; Grazvydas Ignotas; Paul 
>>>> Walmsley; Premi, Sanjeev; Shilimkar, Santosh; Guruswamy, 
>>>> Senthilvadivu; Kevin Hilman; DebBarma, Tarun Kanti; 
>>>> ValkeinenTomi (Nokia-MS/Helsinki); Koskinen Aaro 
>>>> (Nokia-MS/Helsinki); Pandita, Vikram; S, Vishwanath
>>>> Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single 
>>>> check_revision
>>>>
>>>> Tony Lindgren had written, on 07/08/2010 07:21 AM, the following:
>>>>> * Menon, Nishanth <nm@ti.com> [100708 14:49]:
>>>>>> ----- Original message -----
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Wed, Jul 07, 2010 at 07:24:16PM +0200, ext Nishanth 
>>>> Menon wrote:
>>>>>>>> I am not sure.. if you would like drivers to be 
>>>> modprobabe, there may
>>>>>>> be
>>>>>>>> quirks that you'd want to enable based on cpu_is_omapxxx 
>>>> checks. so it
>>>>>>>> probably does not make sense to __initdata the revision/feature
>>>>>>> variables.
>>>>>>>
>>>>>>> can't you pass the quirks via pdata, then ?
>>>>>> If pdata is passed based on board: Imagine 3630 and uart 
>>>> quirk. Why share errata xyz over pdata for every board using 
>>>> 3630? Quirks are cpu specific and not really domain of board..  
>>>>> We should be able to handle the quirks by passing some
>>>>> flag or function pointer from platform data.
>>>>>
>>>>> The drivers should be arch independent, using cpu_is_omapxxxx
>>>>> tests anywhere under drivers/* is wrong and should be
>>>>> fixed.
>>>> there are two forms of quirks:
>>>> a) quirks which can be detected based on IP rev
>>>> b) quirks which are silicon integration related - only 
>>>> cpu_is_xxxx can 
>>>> be used to detect them.
>>>> for a) - I disagree that pdata should be used (this was my 
>> original 
>>>> contention)
>>>> for b) the question IMHO is: How is pdata provided to the 
>>>> driver - that 
>>>> is important. IMHO, pdata taken into drivers could have 
>>>> quirks, but if 
>>>> the quirk addition is done from board files, I disagree, then 
>>>> should be 
>>>> done in arch/arm/mach-omap[12]/somefile.c where somefile.c is 
>>>> common for 
>>>> all boards (e.g. device.c) and that allows the driver to be cpu 
>>>> independent and allows board files not to have redundant 
>> information.
>>>> BUT, features *should* be kept distinct from quirks for 
>> readability 
>>>> purposes.
>>> Nishanth,
>>>
>>> Sorry missed most of discussion due to vacation. But just wanted to
>>> know the benefit of check_version() without the processor context.
>> lets try not to confuse things here:
>> a) feature - this debate is part of this thread
> 
> [sp] The OMAP_FEATURE appears in the patch below only because the corresponding
> lines didn't change in the patch I created. Not because I wanted to get
> another discussion on this subject.
> 
> Subject of this mail is "omap: generic: introduce a single check_revision"
> and hence I responded to same.

:) different context if you look at the thread itself..
> 
>> b) errata - done per driver
> 
> [sp] Didn't get the context here.

previously in the thread we had a discussion on quirk handling - quirks 
in hardware such as erratas dont really follow the normal configuration 
flow and need to be selectively handled.

> 
>> c) cpu_is_xyz() - used for cpu type detection
>> d) cpu_revision() - the patch that you post below - should be in a 
>> seperate thread.
>>
>> I am not averse to the new functions you are introducing and IMHO, I 
>> agree that it will improve readability, can you rebase and 
>> post seperately?
> 
> [sp] Will be doing it. The patch here was only for illustration.

thanks.

> 
>>> I had earlier submitted related patches; but 36x being considered
>>> as 34x broke the logic. Before going on vacation I had created a
>>> patch (against 2.6.32). Putting here for review (there are two
>>> typos in this specific patch, pl ignore that):
>>>
>>> Usage would be:
>>> if (cpu_rev_eq(omap34xx, OMAP34XX_ES_1_0))
>> maybe we could simplify this a bit(OMAP34XX prefix seems redundant):
> 
> Yes. I know, but then I am, not sure if the bit definitions will
> remain same in future. An early version of this patch had no
> OMAP34XX prefix.
lets take this up as part of the new thread.. you may also be interested 
in considering Anand G's recent patch for 3630
https://patchwork.kernel.org/patch/111147/


> 
>> if (cpu_rev_eq(omap34xx, ES_1_0))?
>> we should probably take the discussion seperately.
>>
>>>
>>> commit 6e4a9439fbc67eb2a55f440923cfade74c4509d2
>>> Author: Sanjeev Premi <premi@ti.com>
>>> Date:   Thu Jun 3 21:28:39 2010 +0530
>>>
>>>     omap: Add macros to evaluate cpu revision
>>>
>>>     This patch adds macros to evaluate the cpu revision.
>>>     These macros increase readability by reducing the
>>>     repetitive code when multiple silicon revisions have
>>>     to be tested.
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h 
>> b/arch/arm/plat-omap/include/
>>> index 7514174..7cc5611 100644
>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>> @@ -70,6 +70,12 @@ unsigned int omap_rev(void);
>>>  #define OMAP_REVBITS_20                0x20
>>>  #define OMAP_REVBITS_30                0x30
>>>  #define OMAP_REVBITS_40                0x40
>>> +#define OMAP_REVBITS_50                0x50
>>> +
>>> +/*
>>> + * Get the CPU Id for OMAP devices
>>> + */
>>> +#define GET_OMAP_ID()  ((omap_rev() >> 16) & 0xffff)
>>>
>>>  /*
>>>   * Get the CPU revision for OMAP devices
>>> @@ -385,6 +391,12 @@ IS_OMAP_TYPE(3517, 0x3517)
>>>  #define OMAP3505_REV(v)                (OMAP35XX_CLASS | 
>> (0x3505 << 16) | (v <<
>>>  #define OMAP3517_REV(v)                (OMAP35XX_CLASS | 
>> (0x3517 << 16) | (v <<
>>> +#define AM37XX_CLASS           0x37000034
>>> +#define AM3703_REV(v)          (AM37XX_CLASS | (0x3503 << 
>> 16) | (v << 8))
>>> +#define AM3715_REV(v)          (AM37XX_CLASS | (0x3515 << 
>> 16) | (v << 8))
>>> +#define AM3725_REV(v)          (AM37XX_CLASS | (0x3525 << 
>> 16) | (v << 8))
>>> +#define AM3730_REV(v)          (AM37XX_CLASS | (0x3530 << 
>> 16) | (v << 8))
>>> +
>>>  #define OMAP443X_CLASS         0x44300044
>>>  #define OMAP4430_REV_ES1_0     0x44300044
>>>
>>> @@ -458,4 +470,36 @@ OMAP3_HAS_FEATURE(neon, NEON)
>>>  OMAP3_HAS_FEATURE(isp, ISP)
>>>  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
>>>
>>> +/*
>>> + * Map revision bits to silicon specific revisions
>>> + */
>>> +#define OMAP34XX_ES_1_0                OMAP_REVBITS_00
>>> +#define OMAP34XX_ES_2_0                OMAP_REVBITS_10
>>> +#define OMAP34XX_ES_2_1                OMAP_REVBITS_20
>>> +#define OMAP34XX_ES_3_0                OMAP_REVBITS_30
>>> +#define OMAP34XX_ES_3_1                OMAP_REVBITS_40
>>> +#define OMAP34XX_ES_3_1_2      OMAP_REVBITS_50
>>> +
>>> +#define AM3517_ES_1_0          OMAP_REVBITS_00
>>> +
>>> +#define OMAP36XX_ES_1_0                OMAP_REVBITS_00
>>> +
>>> +/*
>>> + * Macros to evaluate CPU revision
>>> + */
>>> +#define cpu_rev_lt(cpu,rev)    \
>>> +       ((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() < 
>> (rev))) ? 1 : 0)
>>> +
>>> +#define cpu_rev_le(cpu,rev)    \
>>> +       ((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() <= 
>> (rev))) ? 1 : 0)
>>> +
>>> +#define cpu_rev_eq(cpu,rev)    \
>>> +       ((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() == 
>> (rev))) ? 1 : 0)
>>> +
>>> +#define cpu_rev_ge(cpu,rev)    \
>>> +       ((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() >= 
>> (rev))) ? 1 : 0)
>>> +
>>> +#define cpu_rev_gt(cpu,rev)    \
>>> +       ((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() > 
>> (rev))) ? 1 : 0)
>>> +
>>>  #endif
>>>
>>> ~sanjeev
>>>
>>>> -- 
>>>> Regards,
>>>> Nishanth Menon
>>>>
>>
>> -- 
>> Regards,
>> Nishanth Menon
>>


-- 
Regards,
Nishanth Menon

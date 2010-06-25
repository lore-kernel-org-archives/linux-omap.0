From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/9 v2] omap: generic: introduce a single check_revision
Date: Fri, 25 Jun 2010 11:24:01 -0500
Message-ID: <4C24D821.2050207@ti.com>
References: <1277472414-8676-1-git-send-email-nm@ti.com>	<5A47E75E594F054BAF48C5E4FC4B92AB032366B404@dbde02.ent.ti.com>	<4C24B54A.7050005@ti.com>	<AANLkTinU4sQuZJmiqNWtIL8a68onvZeaMByI7XYME14v@mail.gmail.com>	<4C24C097.70503@ti.com> <AANLkTimXf-dV1cWYhmAvVK2k9pGof1UNkInz8dUfZkDW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37586 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab0FYQYL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 12:24:11 -0400
In-Reply-To: <AANLkTimXf-dV1cWYhmAvVK2k9pGof1UNkInz8dUfZkDW@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

S, Venkatraman had written, on 06/25/2010 10:16 AM, the following:
> On Fri, Jun 25, 2010 at 8:13 PM, Nishanth Menon <nm@ti.com> wrote:
>> S, Venkatraman had written, on 06/25/2010 09:38 AM, the following:
>>> On Fri, Jun 25, 2010 at 7:25 PM, Nishanth Menon <nm@ti.com> wrote:
>>>> DebBarma, Tarun Kanti had written, on 06/25/2010 08:50 AM, the following:

[...]
>>>>>> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
>>>>>> index fca73cd..f240d9a 100644
>>>>>> --- a/arch/arm/plat-omap/common.c
>>>>>> +++ b/arch/arm/plat-omap/common.c
>>>>>> @@ -89,6 +89,18 @@ void __init omap_reserve(void)
>>>>>>       omap_vram_reserve_sdram_lmb();
>>>>>>  }
>>>>>>
>>>>>> +void __init omap_check_revision(void)
>>>>>> +{
>>>>>> +#ifdef CONFIG_ARCH_OMAP1
>>>>>> +       if (cpu_is_omap7xx() || cpu_is_omap15xx() || cpu_is_omap16xx())
>>>>>> +               omap1_check_revision();
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>>>>>> +       if (cpu_is_omap24xx() || cpu_is_omap34xx() ||
>>>>>> cpu_is_omap44xx())
>>>>>> +               omap2_check_revision();
>>>>>> +#endif
>>>>>> +}
>>>>> Inside omap2_check_revision() there is already check for cpu type. So do
>>>>> we need to have it here? Here is the code snippet!!
>>>>>
>>>>> void __init omap2_check_revision(void)

[...]

>>>> My rationale for doing it is to allow for a single OMAP build for both
>>>> omap1
>>>> and omap2+ in which case the cpu_is check makes sense.
>>>> we have two choices:
>>>> a) remove the hope of having a single omap build (and the above logic is
>>>> a
>>>> bit simpler.
>>> I think Tarun Kanti intended to point out the redundancy within the
>>> OMAP2PLUS build path.
>> yes I am aware of that. but consider the following:
>> CONFIG_ARCH_OMAP1 and CONFIG_ARCH_OMAP2PLUS being defined at the same time.
>>
>> the logic will enter without a reason for it to do so, instead it will print
>> OMAP revision unknown for OMAP1 - not desired.
> 
> AFAIK, Tony has ruled out OMAP1 _and_ OMAP2+ multi-omap build.

Thanks for clarifying. my bad.. missed that thread :(.

Will post a v3 - do feel free to review and reviewd/Ack if you find it ok.

> If it was indeed possible, then
> a) #ifdefs are not needed
ofcourse :)

> b) omap2_check_revision() shouldn't emit the warning, as it doesn't
> cater to all SoCs.
>   omap99_check_revision() could be in the later code path of
> omap_check_revision()
> 
hmm.. This will not be relevant anymore. will post a v3 which assumes 
that omap1 and omap2 are independent.
the headers ensure that null functions are introduced when the defines 
are not present.

[...]
-- 
Regards,
Nishanth Menon

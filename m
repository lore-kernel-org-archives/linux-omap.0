From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/9 v2] omap: generic: introduce a single check_revision
Date: Fri, 25 Jun 2010 08:55:22 -0500
Message-ID: <4C24B54A.7050005@ti.com>
References: <[PATCH 3/9] omap: generic: introduce a single check_revision> <1277472414-8676-1-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032366B404@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58317 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750Ab0FYNzb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 09:55:31 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032366B404@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

DebBarma, Tarun Kanti had written, on 06/25/2010 08:50 AM, the following:
> Nishant,
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>> Sent: Friday, June 25, 2010 6:57 PM
>> To: linux-omap
>> Cc: Menon, Nishanth; Tony Lindgren; Angelo Arrifano; Zebediah C. McClure;
>> Alistair Buxton; Grazvydas Ignotas; Paul Walmsley; Premi, Sanjeev;
[...]

>>
>> diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
>> index e4d8680..4f9ee73 100644
>> --- a/arch/arm/mach-omap1/io.c
>> +++ b/arch/arm/mach-omap1/io.c
>> @@ -20,7 +20,6 @@
>>
>>  #include "clock.h"
>>
>> -extern void omap1_check_revision(void);
>>  extern void omap_sram_init(void);
>>
>>  /*
>> @@ -102,7 +101,7 @@ void __init omap1_map_common_io(void)
>>  	/* We want to check CPU revision early for cpu_is_omapxxxx() macros.
>>  	 * IO space mapping must be initialized before we can do that.
>>  	 */
>> -	omap1_check_revision();
>> +	omap_check_revision();
>>
>>  #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
>>  	if (cpu_is_omap7xx()) {
>> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>> index 4e1f53d..eeb0e30 100644
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -238,7 +238,7 @@ static void __init _omap2_map_common_io(void)
>>  	local_flush_tlb_all();
>>  	flush_cache_all();
>>
>> -	omap2_check_revision();
>> +	omap_check_revision();
>>  	omap_sram_init();
>>  }
>>
>> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
>> index fca73cd..f240d9a 100644
>> --- a/arch/arm/plat-omap/common.c
>> +++ b/arch/arm/plat-omap/common.c
>> @@ -89,6 +89,18 @@ void __init omap_reserve(void)
>>  	omap_vram_reserve_sdram_lmb();
>>  }
>>
>> +void __init omap_check_revision(void)
>> +{
>> +#ifdef CONFIG_ARCH_OMAP1
>> +	if (cpu_is_omap7xx() || cpu_is_omap15xx() || cpu_is_omap16xx())
>> +		omap1_check_revision();
>> +#endif
>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
>> +		omap2_check_revision();
>> +#endif
>> +}
> 
> Inside omap2_check_revision() there is already check for cpu type. So do we need to have it here? Here is the code snippet!!
> 
> void __init omap2_check_revision(void)
> {
>         /*
>          * At this point we have an idea about the processor revision set
>          * earlier with omap2_set_globals_tap().
>          */
>         if (cpu_is_omap24xx()) {
>                 omap24xx_check_revision();
>         } else if (cpu_is_omap34xx()) {
>                 omap3_check_revision();
>                 omap3_check_features();
>                 omap3_cpuinfo();
>                 return;
>         } else if (cpu_is_omap44xx()) {
>                 omap4_check_revision();
>                 return;
>         } else {
>                 pr_err("OMAP revision unknown, please fix!\n");
>         }
> ...
thanks for your comment.

My rationale for doing it is to allow for a single OMAP build for both 
omap1 and omap2+ in which case the cpu_is check makes sense.
we have two choices:
a) remove the hope of having a single omap build (and the above logic is 
a bit simpler.
b)  when a new processor like omap5+ appears, yeah, we'd need to add 
cpu_is_omap5xxx() here as well..

I am biased to (a), but leave the decision to community wisdom ;)


[...]
-- 
Regards,
Nishanth Menon

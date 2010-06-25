From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 3/9 v2] omap: generic: introduce a single check_revision
Date: Fri, 25 Jun 2010 20:08:59 +0530
Message-ID: <AANLkTinU4sQuZJmiqNWtIL8a68onvZeaMByI7XYME14v@mail.gmail.com>
References: <1277472414-8676-1-git-send-email-nm@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032366B404@dbde02.ent.ti.com>
	<4C24B54A.7050005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51398 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812Ab0FYOjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 10:39:00 -0400
Received: by iwn41 with SMTP id 41so2059561iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 07:38:59 -0700 (PDT)
In-Reply-To: <4C24B54A.7050005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

On Fri, Jun 25, 2010 at 7:25 PM, Nishanth Menon <nm@ti.com> wrote:
> DebBarma, Tarun Kanti had written, on 06/25/2010 08:50 AM, the follow=
ing:
>>
>> Nishant,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>>> Sent: Friday, June 25, 2010 6:57 PM
>>> To: linux-omap
>>> Cc: Menon, Nishanth; Tony Lindgren; Angelo Arrifano; Zebediah C. Mc=
Clure;
>>> Alistair Buxton; Grazvydas Ignotas; Paul Walmsley; Premi, Sanjeev;
>
> [...]
>
>>>
>>> diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
>>> index e4d8680..4f9ee73 100644
>>> --- a/arch/arm/mach-omap1/io.c
>>> +++ b/arch/arm/mach-omap1/io.c
>>> @@ -20,7 +20,6 @@
>>>
>>> =A0#include "clock.h"
>>>
>>> -extern void omap1_check_revision(void);
>>> =A0extern void omap_sram_init(void);
>>>
>>> =A0/*
>>> @@ -102,7 +101,7 @@ void __init omap1_map_common_io(void)
>>> =A0 =A0 =A0 =A0/* We want to check CPU revision early for cpu_is_om=
apxxxx()
>>> macros.
>>> =A0 =A0 =A0 =A0 * IO space mapping must be initialized before we ca=
n do that.
>>> =A0 =A0 =A0 =A0 */
>>> - =A0 =A0 =A0 omap1_check_revision();
>>> + =A0 =A0 =A0 omap_check_revision();
>>>
>>> =A0#if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP85=
0)
>>> =A0 =A0 =A0 =A0if (cpu_is_omap7xx()) {
>>> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>>> index 4e1f53d..eeb0e30 100644
>>> --- a/arch/arm/mach-omap2/io.c
>>> +++ b/arch/arm/mach-omap2/io.c
>>> @@ -238,7 +238,7 @@ static void __init _omap2_map_common_io(void)
>>> =A0 =A0 =A0 =A0local_flush_tlb_all();
>>> =A0 =A0 =A0 =A0flush_cache_all();
>>>
>>> - =A0 =A0 =A0 omap2_check_revision();
>>> + =A0 =A0 =A0 omap_check_revision();
>>> =A0 =A0 =A0 =A0omap_sram_init();
>>> =A0}
>>>
>>> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/commo=
n.c
>>> index fca73cd..f240d9a 100644
>>> --- a/arch/arm/plat-omap/common.c
>>> +++ b/arch/arm/plat-omap/common.c
>>> @@ -89,6 +89,18 @@ void __init omap_reserve(void)
>>> =A0 =A0 =A0 =A0omap_vram_reserve_sdram_lmb();
>>> =A0}
>>>
>>> +void __init omap_check_revision(void)
>>> +{
>>> +#ifdef CONFIG_ARCH_OMAP1
>>> + =A0 =A0 =A0 if (cpu_is_omap7xx() || cpu_is_omap15xx() || cpu_is_o=
map16xx())
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap1_check_revision();
>>> +#endif
>>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>>> + =A0 =A0 =A0 if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_=
omap44xx())
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_check_revision();
>>> +#endif
>>> +}
>>
>> Inside omap2_check_revision() there is already check for cpu type. S=
o do
>> we need to have it here? Here is the code snippet!!
>>
>> void __init omap2_check_revision(void)
>> {
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * At this point we have an idea about the processor =
revision set
>> =A0 =A0 =A0 =A0 * earlier with omap2_set_globals_tap().
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0if (cpu_is_omap24xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap24xx_check_revision();
>> =A0 =A0 =A0 =A0} else if (cpu_is_omap34xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_check_revision();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_check_features();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_cpuinfo();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0} else if (cpu_is_omap44xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_check_revision();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("OMAP revision unknown, please=
 fix!\n");
>> =A0 =A0 =A0 =A0}
>> ...
>
> thanks for your comment.
>
> My rationale for doing it is to allow for a single OMAP build for bot=
h omap1
> and omap2+ in which case the cpu_is check makes sense.
> we have two choices:
> a) remove the hope of having a single omap build (and the above logic=
 is a
> bit simpler.

I think Tarun Kanti intended to point out the redundancy within the
OMAP2PLUS build path.

i.e  the cpu checks
>>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>>> + =A0 =A0 =A0 if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_=
omap44xx())
 ^^^ are not needed, as the omap2_check_revision does it anyway.

Then eventually omap_is_55xx() would be needed only inside
omap2_check_revision, and not in
omap_check_revision().

~Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

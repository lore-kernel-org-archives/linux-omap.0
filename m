From: Nishanth Menon <nm@ti.com>
Subject: static inline function style (was Re: [PATCH 3/9 v3] omap: generic:
 introduce a single check_revision)
Date: Fri, 25 Jun 2010 13:26:35 -0500
Message-ID: <4C24F4DB.5030100@ti.com>
References: <1277483122-3616-1-git-send-email-nm@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167DB@dbde02.ent.ti.com> <4C24E7F8.90007@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59236 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab0FYS0s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 14:26:48 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

Shilimkar, Santosh had written, on 06/25/2010 01:07 PM, the following:
>> -----Original Message-----
>> From: Menon, Nishanth
>> Sent: Friday, June 25, 2010 11:02 PM

[..]

>>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>>> @@ -431,7 +431,18 @@ IS_OMAP_TYPE(3517, 0x3517)
>>>>
>>>>
>>>>  int omap_chip_is(struct omap_chip_id oci);
>>>> -void omap2_check_revision(void);
>>>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>>>> +extern void omap2_check_revision(void);
>>>> +#else
>>>> +static inline void omap2_check_revision(void) {}
>>> I think codingstyle suggest empty function braces to be on next line
>>> like
>>> static inline void omap2_check_revision(void)
>>> {}
>> are you sure about that? can you point me to the documentation for that?
>> Style I followed is off:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
>> 2.6.git;a=blob;f=Documentation/SubmittingPatches;h=72651f788f4e3536149ef5e7ddfbed96a8f14d2f;hb=HEAD#l
>> 661
>>
> I got similar comment long back and hence remembered. Looks like it's not explicitly documented
changing subject to get folks interested..

i would think that checkpatch should crib about it, but it being an 
automated script, could be messed up sometimes..

but I am curious -
static inline void foo(void) { }
static inline int foo(void)
{
	return -ENODEV;
}

is the style I have seen to date. usually without a functional code, it 
made more sense to have it out of line and more in the style of a normal 
function..

could someone give any suggestions on this?
-- 
Regards,
Nishanth Menon

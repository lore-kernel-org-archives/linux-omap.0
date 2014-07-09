From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Wed, 9 Jul 2014 17:56:37 +0530
Message-ID: <53BD34FD.5070005@ti.com>
References: <20140707104727.GM28884@atomide.com> <20140707104944.GS3705@n2100.arm.linux.org.uk> <20140707110249.GO28884@atomide.com> <53BA8983.3030803@ti.com> <20140707121512.GT3705@n2100.arm.linux.org.uk> <20140707123925.GW28884@atomide.com> <20140707134008.GU3705@n2100.arm.linux.org.uk> <20140707151024.GJ5582@saruman.home> <53BB7980.2060909@ti.com> <20140708082948.GE28884@atomide.com> <20140709092531.GK28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33443 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbaGIM1M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jul 2014 08:27:12 -0400
In-Reply-To: <20140709092531.GK28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wednesday 09 July 2014 02:55 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140708 01:32]:
>> * Sekhar Nori <nsekhar@ti.com> [140707 21:56]:
>>> On Monday 07 July 2014 08:40 PM, Felipe Balbi wrote:
>>>> On Mon, Jul 07, 2014 at 02:40:08PM +0100, Russell King - ARM Linux wrote:
>>>>> --- a/arch/arm/mm/cache-l2x0.c
>>>>> +++ b/arch/arm/mm/cache-l2x0.c
>>>>> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, v
>>>>>  
>>>>>  static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
>>>>>  {
>>>>> -	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
>>>>> +	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_RTL_MASK;
>>>>>  	bool cortex_a9 = read_cpuid_part() == ARM_CPU_PART_CORTEX_A9;
>>>>
>>>> even with this change, l2c still tries to write to power control
>>>> register, at least on AM437x. Looking a little deeper here, AM437x
>>>> identifies itself as l2c PL310 r3p3, which should have power control
>>>> register, but aparentely there's no way to write that register. I'll
>>>> file a bug to our ROM team, but we will certainly need a way to
>>>> workaround this inside omap4-common.c
>>>
>>> Looks like we need both my patch as well as Russell's patch. I can
>>> respin my patch with the pr_info_once() dropped if it helps further
>>> reduce boot noise.
>>
>> In that case I'm fine with the original patch in this series. Russell,
>> got any better ideas?
> 
> I guess no more comments. Took a look at the patch again, Sekhar, can
> you please update the description with what has been discovered in this
> thread and repost?

How does the following sound:

---
AM437x has L2C-310 version r3p2 and ROM code on that device does not
support writing to L2C-310 power control register. The L2C driver,
however, tries writing to this register for all revisions >= r3p0.

This leads to a warning dump on boot which leads most users to believe
that L2 cache is non-functional.

Since the problem is understood, and cannot be addressed through
software, replace the warning with a pr_info() while maintaining the
WARN_ON() for other truly unexpected scenarios.

>From the public TRM available for OMAP4470, even on that device, ROM
does not support writing to this register even though it uses a version
of L2C-310 which has the register implemented. So this patch should take
care of all variants of existing OMAPs.
---

Two things that I have added are the version of L2C on AM437x and the
fact that OMAP4470 also has the same issue (at least from the public
TRM). Let me know if you would like to see anything else mentioned.

Thanks,
Sekhar

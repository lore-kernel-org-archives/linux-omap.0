From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Mon, 14 Jul 2014 16:11:23 +0530
Message-ID: <53C3B3D3.4060705@ti.com>
References: <20140707110249.GO28884@atomide.com> <53BA8983.3030803@ti.com> <20140707121512.GT3705@n2100.arm.linux.org.uk> <20140707123925.GW28884@atomide.com> <20140707134008.GU3705@n2100.arm.linux.org.uk> <20140707151024.GJ5582@saruman.home> <53BB7980.2060909@ti.com> <20140708082948.GE28884@atomide.com> <20140709092531.GK28884@atomide.com> <53BD34FD.5070005@ti.com> <20140709135530.GD973@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39010 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbaGNKly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2014 06:41:54 -0400
In-Reply-To: <20140709135530.GD973@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wednesday 09 July 2014 07:25 PM, Felipe Balbi wrote:
> On Wed, Jul 09, 2014 at 05:56:37PM +0530, Sekhar Nori wrote:
>> On Wednesday 09 July 2014 02:55 PM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [140708 01:32]:
>>>> * Sekhar Nori <nsekhar@ti.com> [140707 21:56]:
>>>>> On Monday 07 July 2014 08:40 PM, Felipe Balbi wrote:
>>>>>> On Mon, Jul 07, 2014 at 02:40:08PM +0100, Russell King - ARM Linux wrote:
>>>>>>> --- a/arch/arm/mm/cache-l2x0.c
>>>>>>> +++ b/arch/arm/mm/cache-l2x0.c
>>>>>>> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, v
>>>>>>>  
>>>>>>>  static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
>>>>>>>  {
>>>>>>> -	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
>>>>>>> +	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_RTL_MASK;
>>>>>>>  	bool cortex_a9 = read_cpuid_part() == ARM_CPU_PART_CORTEX_A9;
>>>>>>
>>>>>> even with this change, l2c still tries to write to power control
>>>>>> register, at least on AM437x. Looking a little deeper here, AM437x
>>>>>> identifies itself as l2c PL310 r3p3, which should have power control
>>>>>> register, but aparentely there's no way to write that register. I'll
>>>>>> file a bug to our ROM team, but we will certainly need a way to
>>>>>> workaround this inside omap4-common.c
>>>>>
>>>>> Looks like we need both my patch as well as Russell's patch. I can
>>>>> respin my patch with the pr_info_once() dropped if it helps further
>>>>> reduce boot noise.
>>>>
>>>> In that case I'm fine with the original patch in this series. Russell,
>>>> got any better ideas?
>>>
>>> I guess no more comments. Took a look at the patch again, Sekhar, can
>>> you please update the description with what has been discovered in this
>>> thread and repost?
>>
>> How does the following sound:
>>
>> ---
>> AM437x has L2C-310 version r3p2 and ROM code on that device does not
> 
> at least my SoC has r3p3 (cache ID 0x9), other than that, commit log
> looks good to my eyes.

Heh, the TRM documents it as r3p2 and I was relying on it to be correct.
I will change it to r3p3.

Thanks,
Sekhar

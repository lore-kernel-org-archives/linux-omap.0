From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Thu, 10 Apr 2014 17:38:46 +0530
Message-ID: <534689CE.2070904@ti.com>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <534412FD.5030308@ti.com> <20140409163330.GI27282@n2100.arm.linux.org.uk> <53457AD4.8090708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55982 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030248AbaDJMJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 08:09:19 -0400
In-Reply-To: <53457AD4.8090708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Wednesday 09 April 2014 10:22 PM, Santosh Shilimkar wrote:
> On Wednesday 09 April 2014 12:33 PM, Russell King - ARM Linux wrote:
>> On Tue, Apr 08, 2014 at 11:17:17AM -0400, Santosh Shilimkar wrote:
>>> On Tuesday 08 April 2014 10:53 AM, Sekhar Nori wrote:
>>>> On Friday 04 April 2014 03:48 PM, Russell King - ARM Linux wrote:
>>>>> On Fri, Apr 04, 2014 at 03:40:29PM +0530, Sekhar Nori wrote:
>>>>>> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
>>>>>> index f8b8dac..6b2a056 100644
>>>>>> --- a/arch/arm/mach-omap2/omap4-common.c
>>>>>> +++ b/arch/arm/mach-omap2/omap4-common.c
>>>>>> @@ -224,6 +224,14 @@ int __init omap4_l2_cache_init(void)
>>>>>>  
>>>>>>  	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
>>>>>>  }
>>>>>> +
>>>>>> +int __init am43xx_l2_cache_init(void)
>>>>>> +{
>>>>>> +	u32 aux_ctrl = L310_AUX_CTRL_DATA_PREFETCH |
>>>>>> +		       L310_AUX_CTRL_INSTR_PREFETCH;
>>>>>
>>>>> It would be good to documenting the difference between this and OMAP4,
>>>>> and why you have chosen different values.
>>>>
>>>> There are two main differences:
>>>>
>>>> 1) OMAP4 sets Shared attribute override enable bit. TBH, I think this is
>>>> not needed even in OMAP4 with latest kernel, but I am not sure if I can
>>>> do this safely without breaking any usecase currently working with OMAP4.
>>>>
>>> Wrong. Shared bit is mandatory for the OMAP4. Its a SMP system
>>> which needs that.
>>
>> Errr.  This bit affects the L2 cache behaviour for Normal memory, outer
>> non-cacheable accesses - in other words, those performed to memory mapped
>> via dma_alloc_coherent() or dma_alloc_writecombine().  It does not affect
>> other types of mappings (other access types ignore the sharable attribute).
>>
>> When this bit is clear, accesses to such memory are:
>>
>> - read: cacheable, no allocate
>> - write: write through, no write allocate
>>
>> what this means is that if there are no cache lines in the L2 cache
>> corresponding with the physical address, then none will be allocated.
>> However, if there are cache lines present, then they will be hit,
>> read or updated as appropriate.
>>
>> This may matter before CMA where we had the memory returned by
>> dma_alloc_coherent() and friends mapped as normal, cacheable mappings
>> which could be speculatively prefetched, and therefore cache lines
>> dragged into the L2 cache for these physical addresses.
>>
>> However, now that we're using CMA, this does not apply as we no longer
>> have this aliasing mapping.
>>
>> So, with CMA enabled, it should be safe not to set this bit.
>>
> Agree. That should be safe now.

Since we cannot guarantee that CONFIG_DMA_CMA will always be enabled in
kernel config, shall we take the safer route and keep the Shared
attribute override bit enabled in L2C configuration?

Thanks,
Sekhar

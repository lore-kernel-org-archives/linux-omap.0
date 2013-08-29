From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4+: Move SRAM data to DT
Date: Thu, 29 Aug 2013 16:32:52 +0530
Message-ID: <521F2A5C.80404@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com> <1377598305-15539-3-git-send-email-rnayak@ti.com> <521C8C47.2000502@ti.com> <521D977D.1000305@ti.com> <521DCFD8.2020304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47920 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab3H2LDU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 07:03:20 -0400
In-Reply-To: <521DCFD8.2020304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com

On Wednesday 28 August 2013 03:54 PM, Sekhar Nori wrote:
> On Wednesday 28 August 2013 11:53 AM, Rajendra Nayak wrote:
>> On Tuesday 27 August 2013 04:53 PM, Sekhar Nori wrote:
>>> On Tuesday 27 August 2013 03:41 PM, Rajendra Nayak wrote:
>>>> Use drivers/misc/sram.c driver to manage SRAM on all DT only
>>>> OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
>>>> the existing private implementation.
>>>>
>>>> Address and size related data  is removed from mach-omap2/sram.c
>>>> and now passed to drivers/misc/sram.c from DT.
>>>>
>>>> Users can hence use general purpose allocator apis instead of
>>>> OMAP private ones to manage and use SRAM.
>>>>
>>>> Currently there are no users on SRAM on these platfoms.
>>>>
>>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>>
>>> Nice getting rid of code.
>>>
>>>> diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
>>>> index ca7277c..3f83b80 100644
>>>> --- a/arch/arm/mach-omap2/sram.h
>>>> +++ b/arch/arm/mach-omap2/sram.h
>>>> @@ -80,4 +80,3 @@ static inline void omap_push_sram_idle(void) {}
>>>>  #else
>>>>  #define OMAP4_SRAM_PA		0x40300000
>>>>  #endif
>>>> -#define AM33XX_SRAM_PA		0x40300000
>>>
>>> I guess OMAP4_SRAM_PA is left in the code to take care of errata I688?
>>
>> right.
>>
>>> How about removing the iotable entry for SRAM on OMAP4 and converting
>>> omap_barriers_init() to use the gen_pool API instead of passing an
>>> incremented address to DT?
>>
>> Actually we dont really need to alloc and manage any sram pool for handling
>> the errata. It just needs to know an sram location which it can read and write
>> back into (which can be any sram location used/unused).
> 
> But there will be a race with other writes to SRAM since omap_bus_sync()
> is not atomic context.

Right, I completely overlooked the fact that omap_bus_sync() is also done every
wmb(). I was thinking its needed only just before a wfi.

I will repost a v2 using gen_pool to allocate sram space to handle errata I688
and get rid of all the static mappings.

regards,
Rajendra
> 
> Thanks,
> Sekhar
> 


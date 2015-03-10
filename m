From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: ARM: OMPA4+: is it expected dma_coerce_mask_and_coherent(dev,
 DMA_BIT_MASK(64)); to fail?
Date: Tue, 10 Mar 2015 19:35:41 +0200
Message-ID: <54FF2B6D.1030005@linaro.org>
References: <54F8A68B.3080709@linaro.org> <2886917.pqK9QloHOD@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:46053 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbbCJRfp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2015 13:35:45 -0400
Received: by lamq1 with SMTP id q1so3322631lam.12
        for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2015 10:35:43 -0700 (PDT)
In-Reply-To: <2886917.pqK9QloHOD@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux@arm.linux.org.uk, Tejun Heo <tj@kernel.org>, Tony Lindgren <tony@atomide.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Laura Abbott <lauraa@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi Arnd,

On 03/09/2015 11:33 PM, Arnd Bergmann wrote:
> On Thursday 05 March 2015 20:55:07 Grygorii.Strashko@linaro.org wrote:
>> Hi All,
>>
>> Now I can see very interesting behavior related to dma_coerce_mask_and_coherent()
>> and friends which I'd like to explain and clarify.
>>
>> Below is set of questions I have (why - I explained below):
>> - Is expected dma_coerce_mask_and_coherent(DMA_BIT_MASK(64)) and friends to fail on 32 bits HW?
> 
> No. dma_coerce_mask_and_coherent() is meant to ignore the actual mask. It's
> usually considered a bug to use this function for that reason.
> 
>> - What is expected value for max_pfn: max_phys_pfn or max_phys_pfn + 1?
>>
>> - What is expected value for struct memblock_region->size: mem_range_size or mem_range_size - 1?
>>
>> - What is expected value to be returned by memblock_end_of_DRAM():
>>    @base + @size(max_phys_addr + 1) or @base + @size - 1(max_phys_addr)?
>>
>>
>> I'm working with BeaglBoard-X15 (AM572x/DRA7xx) board and have following code in OMAP ASOC driver
>> which is failed SOMETIMES during the boot with error -EIO.
>> === to omap-pcm.c:
>> omap_pcm_new() {
>> ...
>> 	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(64));
>> ^^ failed sometimes
>> 	if (ret)
>> 		return ret;
>> }
> 
> The code should be fixed to use dma_set_mask_and_coherent(), which is expected to
> fail if the bus is incapable of addressing all RAM within the mask.
> 
>> I'd be very appreciated for any comments/clarification on questions I've listed at the
>> beginning of my e-mail - there are no patches from my side as I'd like to understand
>> expected behavior of the kernel first (especially taking into account that any
>> memblock changes might affect on at least half of arches).
> 
> Is the device you have actually 64-bit capable?
> 
> Is the bus it is connected to 64-bit wide?

As I mentioned before - The device was fixed by switching to use 32 bit mask
"The issue with omap-pcm was simply fixed by using DMA_BIT_MASK(32), ".

> 
> Does the dma-ranges property of the parent bus reflect the correct address width?

dma-ranges is not used and all devices are created with default mask DMA_BIT_MASK(32);


My goal was to clarify above questions (first of all), because on my HW I can see
different values of  max_pfn, max_mapnr and memblock configuration depending on 
CONFIG_ARM_LPAE=n|y and when RAM is defined as: start = 0x80000000 size = 0x80000000.
(and also between kernels 3.14 and LKML).

Looks like such RAM configuration is a corner case, which is not always handled as expected
(and how is it expected to be handled?).
For example:
before commit ARM: 8025/1: Get rid of meminfo
- registered RAM  start = 0x80000000 size = 0x80000000 will be adjusted by arm_add_memory()
and final RAM configuration will be start = 0x80000000 size = 0x7FFFF000
after this commit:
- code will try to register start = 0x80000000 size = 0x80000000, but memblock will
adjust it to start = 0x80000000 size = 0x7fffffff.



-- 
regards,
-grygorii

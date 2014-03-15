From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] iommu/omap: Use the cache cleaning API
Date: Sat, 15 Mar 2014 13:54:39 -0400
Message-ID: <532493DF.5010409@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <53226DD5.6070208@ti.com> <53232B0F.6090701@ti.com> <1802456.J2x6TOUvAS@avalon> <5323418B.90805@ti.com> <5323B1C4.4090904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34308 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418AbaCORzH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Mar 2014 13:55:07 -0400
In-Reply-To: <5323B1C4.4090904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Florian Vaussard <florian.vaussard@epfl.ch>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On Friday 14 March 2014 09:49 PM, Suman Anna wrote:
> Hi Santosh, Laurent, Russell, Arnd,
> 
> On 03/14/2014 12:51 PM, Santosh Shilimkar wrote:
>> On Friday 14 March 2014 12:38 PM, Laurent Pinchart wrote:
>>> Hi Santosh,
>>>
>>> On Friday 14 March 2014 12:15:11 Santosh Shilimkar wrote:
>>>> + Russell, Arnd
>>>>
>>>> On Thursday 13 March 2014 10:47 PM, Anna, Suman wrote:
>>>>> On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
>>>>>> The page table entries must be cleaned from the cache before being
>>>>>> accessed by the IOMMU. Instead of implementing cache management manually
>>>>>> (and ignoring L2 cache), use clean_dcache_area() to make sure the
>>>>>> entries are visible to the device.
>>>>>
>>>>> Thanks for fixing this, this has been long pending. There have been some
>>>>> previous attempts at this as well by Ramesh Gupta, with the last thread
>>>>> (a long time now) being
>>>>> http://marc.info/?t=134752035400001&r=1&w=2
>>>>>
>>>>> Santosh,
>>>>> Can you please take a look at this patch and provide your comments?
>>>>>
>>>>> regards
>>>>> Suman
>>>>>
>>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>> ---
>>>>>>
>>>>>>    drivers/iommu/omap-iommu.c | 41 ++++++++++-----------------------------
>>>>>>    1 file changed, 10 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>>>>>> index a893eca..bb605c9 100644
>>>>>> --- a/drivers/iommu/omap-iommu.c
>>>>>> +++ b/drivers/iommu/omap-iommu.c
>>>>>> @@ -500,24 +500,9 @@ EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
>>>>>>    /*
>>>>>>     *    H/W pagetable operations
>>>>>>     */
>>>>>> -static void flush_iopgd_range(u32 *first, u32 *last)
>>>>>> +static void flush_pgtable(void *addr, size_t size)
>>>>>>    {
>>>>>> -    /* FIXME: L2 cache should be taken care of if it exists */
>>>>>> -    do {
>>>>>> -        asm("mcr    p15, 0, %0, c7, c10, 1 @ flush_pgd"
>>>>>> -            : : "r" (first));
>>>>>> -        first += L1_CACHE_BYTES / sizeof(*first);
>>>>>> -    } while (first <= last);
>>>>>> -}
>>>>>> -
>>>>>> -static void flush_iopte_range(u32 *first, u32 *last)
>>>>>> -{
>>>>>> -    /* FIXME: L2 cache should be taken care of if it exists */
>>>>>> -    do {
>>>>>> -        asm("mcr    p15, 0, %0, c7, c10, 1 @ flush_pte"
>>>>>> -            : : "r" (first));
>>>>>> -        first += L1_CACHE_BYTES / sizeof(*first);
>>>>>> -    } while (first <= last);
>>>>>> +    clean_dcache_area(addr, size);
>>>>
>>>> I remember NAKing this approach in past and my stand remains same.
>>>> The cache APIs which you are trying to use here are not suppose
>>>> to be used outside.
> 
> So this particular change has a long history (have to dig through to educate myself). I have not seen clean_dcache_area attempted before, and I wasn't sure myself it it can be used here. Ramesh and Fernando definitely did start out with dmac_flush_range and outer_flush_range which was definitely nacked [1].
> 
OK. Please wrap the lines appropriately while replying.

>>>
>>> Please note that the omap-iommu driver already uses clean_dcache_area().
>>> That's where I got the idea :-)
>>>
>> So that fall through the cracks then ;-)
>>
>>>> I think the right way to fix this is to make use of streaming APIs.
>>>> If needed, IOMMU can have its own dma_ops for special case
>>>> handling if any.
>>>
>>> I can replace clean_dcache_area() with dma_map_page() as done by the arm-smmu
>>> driver. If that's fine I'll modify this patch accordingly in v2.
>>>
> 
> Ramesh had also attempted to use dma_page_single() previously [2], and Russell has instead suggested to extend the cpu cache operations [3].
> Ramesh had worked based on this suggestion and the series reached v6 [4] (same as link I mentioned above) and this is the last attempt on this, but the thread went silent.
> 
> I am wondering if that is still valid and is the right way to go, as this seems to be a common problem. I do see dmac_flush_range being used for similar purposes in msm_iommu.c and exynos-iommu.c, so looks like they also fell through the cracks.
> 
Thanks for the links. I think you should revive the v6 series unless and until
RMK has some other suggestion. This can also help to remove the wrong usages
from other IOMMU drivers as you pointed out.

> Laurent,
> Can you drop this patch out from v2 so that it is not clubbed with the small cleanup patches, and we can track this separately?
> 
Agree

Regards,
Santosh

> 
> [1] http://marc.info/?l=linux-omap&m=129907009019355&w=2
> [2] http://marc.info/?t=130281804900005&r=1&w=2
> [3] http://marc.info/?l=linux-omap&m=131310179423214&w=2
> [4] http://marc.info/?t=134752035400001&r=1&w=2
> 
> 


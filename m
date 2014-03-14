From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] iommu/omap: Use the cache cleaning API
Date: Fri, 14 Mar 2014 13:51:07 -0400
Message-ID: <5323418B.90805@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <53226DD5.6070208@ti.com> <53232B0F.6090701@ti.com> <1802456.J2x6TOUvAS@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36175 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548AbaCNRvd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 13:51:33 -0400
In-Reply-To: <1802456.J2x6TOUvAS@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Anna, Suman" <s-anna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Florian Vaussard <florian.vaussard@epfl.ch>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On Friday 14 March 2014 12:38 PM, Laurent Pinchart wrote:
> Hi Santosh,
> 
> On Friday 14 March 2014 12:15:11 Santosh Shilimkar wrote:
>> + Russell, Arnd
>>
>> On Thursday 13 March 2014 10:47 PM, Anna, Suman wrote:
>>> On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
>>>> The page table entries must be cleaned from the cache before being
>>>> accessed by the IOMMU. Instead of implementing cache management manually
>>>> (and ignoring L2 cache), use clean_dcache_area() to make sure the
>>>> entries are visible to the device.
>>>
>>> Thanks for fixing this, this has been long pending. There have been some
>>> previous attempts at this as well by Ramesh Gupta, with the last thread
>>> (a long time now) being
>>> http://marc.info/?t=134752035400001&r=1&w=2
>>>
>>> Santosh,
>>> Can you please take a look at this patch and provide your comments?
>>>
>>> regards
>>> Suman
>>>
>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> ---
>>>>
>>>>   drivers/iommu/omap-iommu.c | 41 ++++++++++-----------------------------
>>>>   1 file changed, 10 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>>>> index a893eca..bb605c9 100644
>>>> --- a/drivers/iommu/omap-iommu.c
>>>> +++ b/drivers/iommu/omap-iommu.c
>>>> @@ -500,24 +500,9 @@ EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
>>>>   /*
>>>>    *	H/W pagetable operations
>>>>    */
>>>> -static void flush_iopgd_range(u32 *first, u32 *last)
>>>> +static void flush_pgtable(void *addr, size_t size)
>>>>   {
>>>> -	/* FIXME: L2 cache should be taken care of if it exists */
>>>> -	do {
>>>> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
>>>> -		    : : "r" (first));
>>>> -		first += L1_CACHE_BYTES / sizeof(*first);
>>>> -	} while (first <= last);
>>>> -}
>>>> -
>>>> -static void flush_iopte_range(u32 *first, u32 *last)
>>>> -{
>>>> -	/* FIXME: L2 cache should be taken care of if it exists */
>>>> -	do {
>>>> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pte"
>>>> -		    : : "r" (first));
>>>> -		first += L1_CACHE_BYTES / sizeof(*first);
>>>> -	} while (first <= last);
>>>> +	clean_dcache_area(addr, size);
>>
>> I remember NAKing this approach in past and my stand remains same.
>> The cache APIs which you are trying to use here are not suppose
>> to be used outside.
> 
> Please note that the omap-iommu driver already uses clean_dcache_area(). 
> That's where I got the idea :-)
> 
So that fall through the cracks then ;-)

>> I think the right way to fix this is to make use of streaming APIs.
>> If needed, IOMMU can have its own dma_ops for special case
>> handling if any.
> 
> I can replace clean_dcache_area() with dma_map_page() as done by the arm-smmu 
> driver. If that's fine I'll modify this patch accordingly in v2.
> 
That will be definitely a better option than the APIs used. Those streaming
APIs will take care of L2 cache as well if present.

Regards,
Santosh


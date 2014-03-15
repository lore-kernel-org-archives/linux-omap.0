From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/omap: Use the cache cleaning API
Date: Fri, 14 Mar 2014 20:49:56 -0500
Message-ID: <5323B1C4.4090904@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<53226DD5.6070208@ti.com> <53232B0F.6090701@ti.com>
	<1802456.J2x6TOUvAS@avalon> <5323418B.90805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5323418B.90805-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "sakari.ailus-X3B1VOXEql0@public.gmane.org" <sakari.ailus-X3B1VOXEql0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Santosh, Laurent, Russell, Arnd,

On 03/14/2014 12:51 PM, Santosh Shilimkar wrote:
> On Friday 14 March 2014 12:38 PM, Laurent Pinchart wrote:
>> Hi Santosh,
>>
>> On Friday 14 March 2014 12:15:11 Santosh Shilimkar wrote:
>>> + Russell, Arnd
>>>
>>> On Thursday 13 March 2014 10:47 PM, Anna, Suman wrote:
>>>> On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
>>>>> The page table entries must be cleaned from the cache before being
>>>>> accessed by the IOMMU. Instead of implementing cache management manually
>>>>> (and ignoring L2 cache), use clean_dcache_area() to make sure the
>>>>> entries are visible to the device.
>>>>
>>>> Thanks for fixing this, this has been long pending. There have been some
>>>> previous attempts at this as well by Ramesh Gupta, with the last thread
>>>> (a long time now) being
>>>> http://marc.info/?t=134752035400001&r=1&w=2
>>>>
>>>> Santosh,
>>>> Can you please take a look at this patch and provide your comments?
>>>>
>>>> regards
>>>> Suman
>>>>
>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>>>> ---
>>>>>
>>>>>    drivers/iommu/omap-iommu.c | 41 ++++++++++-----------------------------
>>>>>    1 file changed, 10 insertions(+), 31 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>>>>> index a893eca..bb605c9 100644
>>>>> --- a/drivers/iommu/omap-iommu.c
>>>>> +++ b/drivers/iommu/omap-iommu.c
>>>>> @@ -500,24 +500,9 @@ EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
>>>>>    /*
>>>>>     *	H/W pagetable operations
>>>>>     */
>>>>> -static void flush_iopgd_range(u32 *first, u32 *last)
>>>>> +static void flush_pgtable(void *addr, size_t size)
>>>>>    {
>>>>> -	/* FIXME: L2 cache should be taken care of if it exists */
>>>>> -	do {
>>>>> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
>>>>> -		    : : "r" (first));
>>>>> -		first += L1_CACHE_BYTES / sizeof(*first);
>>>>> -	} while (first <= last);
>>>>> -}
>>>>> -
>>>>> -static void flush_iopte_range(u32 *first, u32 *last)
>>>>> -{
>>>>> -	/* FIXME: L2 cache should be taken care of if it exists */
>>>>> -	do {
>>>>> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pte"
>>>>> -		    : : "r" (first));
>>>>> -		first += L1_CACHE_BYTES / sizeof(*first);
>>>>> -	} while (first <= last);
>>>>> +	clean_dcache_area(addr, size);
>>>
>>> I remember NAKing this approach in past and my stand remains same.
>>> The cache APIs which you are trying to use here are not suppose
>>> to be used outside.

So this particular change has a long history (have to dig through to 
educate myself). I have not seen clean_dcache_area attempted before, and 
I wasn't sure myself it it can be used here. Ramesh and Fernando 
definitely did start out with dmac_flush_range and outer_flush_range 
which was definitely nacked [1].

>>
>> Please note that the omap-iommu driver already uses clean_dcache_area().
>> That's where I got the idea :-)
>>
> So that fall through the cracks then ;-)
>
>>> I think the right way to fix this is to make use of streaming APIs.
>>> If needed, IOMMU can have its own dma_ops for special case
>>> handling if any.
>>
>> I can replace clean_dcache_area() with dma_map_page() as done by the arm-smmu
>> driver. If that's fine I'll modify this patch accordingly in v2.
>>

Ramesh had also attempted to use dma_page_single() previously [2], and 
Russell has instead suggested to extend the cpu cache operations [3].
Ramesh had worked based on this suggestion and the series reached v6 [4] 
(same as link I mentioned above) and this is the last attempt on this, 
but the thread went silent.

I am wondering if that is still valid and is the right way to go, as 
this seems to be a common problem. I do see dmac_flush_range being used 
for similar purposes in msm_iommu.c and exynos-iommu.c, so looks like 
they also fell through the cracks.

Laurent,
Can you drop this patch out from v2 so that it is not clubbed with the 
small cleanup patches, and we can track this separately?

regards
Suman

[1] http://marc.info/?l=linux-omap&m=129907009019355&w=2
[2] http://marc.info/?t=130281804900005&r=1&w=2
[3] http://marc.info/?l=linux-omap&m=131310179423214&w=2
[4] http://marc.info/?t=134752035400001&r=1&w=2

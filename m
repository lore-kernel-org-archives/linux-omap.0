From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] iommu/omap: Use the cache cleaning API
Date: Fri, 14 Mar 2014 12:15:11 -0400
Message-ID: <53232B0F.6090701@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <1394239574-2389-2-git-send-email-laurent.pinchart@ideasonboard.com> <53226DD5.6070208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36737 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbaCNQPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 12:15:44 -0400
In-Reply-To: <53226DD5.6070208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Florian Vaussard <florian.vaussard@epfl.ch>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

+ Russell, Arnd

On Thursday 13 March 2014 10:47 PM, Anna, Suman wrote:
> Hi Laurent,
> 
> On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
>> The page table entries must be cleaned from the cache before being
>> accessed by the IOMMU. Instead of implementing cache management manually
>> (and ignoring L2 cache), use clean_dcache_area() to make sure the
>> entries are visible to the device.
> 
> Thanks for fixing this, this has been long pending. There have been some 
> previous attempts at this as well by Ramesh Gupta, with the last thread 
> (a long time now) being
> http://marc.info/?t=134752035400001&r=1&w=2
> 
> Santosh,
> Can you please take a look at this patch and provide your comments?
> 
> regards
> Suman
> 
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>>   drivers/iommu/omap-iommu.c | 41 ++++++++++-------------------------------
>>   1 file changed, 10 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>> index a893eca..bb605c9 100644
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -500,24 +500,9 @@ EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
>>   /*
>>    *	H/W pagetable operations
>>    */
>> -static void flush_iopgd_range(u32 *first, u32 *last)
>> +static void flush_pgtable(void *addr, size_t size)
>>   {
>> -	/* FIXME: L2 cache should be taken care of if it exists */
>> -	do {
>> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
>> -		    : : "r" (first));
>> -		first += L1_CACHE_BYTES / sizeof(*first);
>> -	} while (first <= last);
>> -}
>> -
>> -static void flush_iopte_range(u32 *first, u32 *last)
>> -{
>> -	/* FIXME: L2 cache should be taken care of if it exists */
>> -	do {
>> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pte"
>> -		    : : "r" (first));
>> -		first += L1_CACHE_BYTES / sizeof(*first);
>> -	} while (first <= last);
>> +	clean_dcache_area(addr, size);
I remember NAKing this approach in past and my stand remains same.
The cache APIs which you are trying to use here are not suppose
to be used outside.

I think the right way to fix this is to make use of streaming APIs.
If needed, IOMMU can have its own dma_ops for special case
handling if any.

Russell, Arnd might have more ideas.

>>   }
>>
>>   static void iopte_free(u32 *iopte)
>> @@ -546,7 +531,7 @@ static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da)
>>   			return ERR_PTR(-ENOMEM);
>>
>>   		*iopgd = virt_to_phys(iopte) | IOPGD_TABLE;
>> -		flush_iopgd_range(iopgd, iopgd);
>> +		flush_pgtable(iopgd, sizeof(*iopgd));
>>
>>   		dev_vdbg(obj->dev, "%s: a new pte:%p\n", __func__, iopte);
>>   	} else {
>> @@ -575,7 +560,7 @@ static int iopgd_alloc_section(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
>>   	}
>>
>>   	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
>> -	flush_iopgd_range(iopgd, iopgd);
>> +	flush_pgtable(iopgd, sizeof(*iopgd));
>>   	return 0;
>>   }
>>
>> @@ -592,7 +577,7 @@ static int iopgd_alloc_super(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
>>
>>   	for (i = 0; i < 16; i++)
>>   		*(iopgd + i) = (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
>> -	flush_iopgd_range(iopgd, iopgd + 15);
>> +	flush_pgtable(iopgd, sizeof(*iopgd) * 16);
>>   	return 0;
>>   }
>>
>> @@ -605,7 +590,7 @@ static int iopte_alloc_page(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
>>   		return PTR_ERR(iopte);
>>
>>   	*iopte = (pa & IOPAGE_MASK) | prot | IOPTE_SMALL;
>> -	flush_iopte_range(iopte, iopte);
>> +	flush_pgtable(iopte, sizeof(*iopte));
>>
>>   	dev_vdbg(obj->dev, "%s: da:%08x pa:%08x pte:%p *pte:%08x\n",
>>   		 __func__, da, pa, iopte, *iopte);
>> @@ -619,18 +604,12 @@ static int iopte_alloc_large(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
>>   	u32 *iopte = iopte_alloc(obj, iopgd, da);
>>   	int i;
>>
>> -	if ((da | pa) & ~IOLARGE_MASK) {
>> -		dev_err(obj->dev, "%s: %08x:%08x should aligned on %08lx\n",
>> -			__func__, da, pa, IOLARGE_SIZE);
>> -		return -EINVAL;
>> -	}
>> -
>>   	if (IS_ERR(iopte))
>>   		return PTR_ERR(iopte);
>>
>>   	for (i = 0; i < 16; i++)
>>   		*(iopte + i) = (pa & IOLARGE_MASK) | prot | IOPTE_LARGE;
>> -	flush_iopte_range(iopte, iopte + 15);
>> +	flush_pgtable(iopte, sizeof(*iopte) * 16);
>>   	return 0;
>>   }
>>
>> @@ -733,7 +712,7 @@ static size_t iopgtable_clear_entry_core(struct omap_iommu *obj, u32 da)
>>   		}
>>   		bytes *= nent;
>>   		memset(iopte, 0, nent * sizeof(*iopte));
>> -		flush_iopte_range(iopte, iopte + (nent - 1) * sizeof(*iopte));
>> +		flush_pgtable(iopte, sizeof(*iopte) * nent);
>>
>>   		/*
>>   		 * do table walk to check if this table is necessary or not
>> @@ -755,7 +734,7 @@ static size_t iopgtable_clear_entry_core(struct omap_iommu *obj, u32 da)
>>   		bytes *= nent;
>>   	}
>>   	memset(iopgd, 0, nent * sizeof(*iopgd));
>> -	flush_iopgd_range(iopgd, iopgd + (nent - 1) * sizeof(*iopgd));
>> +	flush_pgtable(iopgd, sizeof(*iopgd) * nent);
>>   out:
>>   	return bytes;
>>   }
>> @@ -799,7 +778,7 @@ static void iopgtable_clear_entry_all(struct omap_iommu *obj)
>>   			iopte_free(iopte_offset(iopgd, 0));
>>
>>   		*iopgd = 0;
>> -		flush_iopgd_range(iopgd, iopgd);
>> +		flush_pgtable(iopgd, sizeof(*iopgd));
>>   	}
>>
>>   	flush_iotlb_all(obj);
>>
> 


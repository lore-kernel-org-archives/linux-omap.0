From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] iommu/omap: Remove virtual memory manager
Date: Fri, 18 Jul 2014 11:45:29 -0500
Message-ID: <53C94F29.9090403@ti.com>
References: <1405595355-7341-1-git-send-email-laurent.pinchart@ideasonboard.com> <53C7F15F.6030306@ti.com> <1779106.6LTfJHCcQh@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55357 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030383AbaGRQpj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jul 2014 12:45:39 -0400
In-Reply-To: <1779106.6LTfJHCcQh@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Florian Vaussard <florian.vaussard@epfl.ch>

On 07/18/2014 05:50 AM, Laurent Pinchart wrote:
> Hi Suman,
> 
> Thank you for the review.
> 
> On Thursday 17 July 2014 10:53:03 Suman Anna wrote:
>> On 07/17/2014 06:09 AM, Laurent Pinchart wrote:
>>> The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now that
>>> is has been ported to the DMA API, remove the unused virtual memory
>>> manager.
>>>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> ---
>>>
>>> Joerg, could you please pick this patch up for v3.17 if possible ?
>>
>> Need one minor change as below, otherwise patch is good.
>>
>>>  drivers/iommu/Kconfig            |  10 +-
>>>  drivers/iommu/Makefile           |   1 -
>>>  drivers/iommu/omap-iommu-debug.c | 114 ------
>>>  drivers/iommu/omap-iommu.c       |   2 -
>>>  drivers/iommu/omap-iommu.h       |   6 +-
>>>  drivers/iommu/omap-iovmm.c       | 791 ----------------------------------
>>>  include/linux/omap-iommu.h       |  37 +-
>>>  7 files changed, 8 insertions(+), 953 deletions(-)
>>>  delete mode 100644 drivers/iommu/omap-iovmm.c
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index d260605..a1f0fad 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -143,16 +143,12 @@ config OMAP_IOMMU
>>>  	depends on ARCH_OMAP2PLUS
>>>  	select IOMMU_API
>>>
>>> -config OMAP_IOVMM
>>> -	tristate "OMAP IO Virtual Memory Manager Support"
>>> -	depends on OMAP_IOMMU
>>> -
>>>  config OMAP_IOMMU_DEBUG
>>> -       tristate "Export OMAP IOMMU/IOVMM internals in DebugFS"
>>> -       depends on OMAP_IOVMM && DEBUG_FS
>>> +       tristate "Export OMAP IOMMU internals in DebugFS"
>>> +       depends on DEBUG_FS
>>
>> This module is relevant only when OMAP_IOMMU is enabled, so this should
>> be depends on OMAP_IOMMU && DEBUG_FS. The dependency is inherent before
>> through OMAP_IOVMM. Otherwise, this module can be built by itself and
>> results in some build errors.
> 
> Oops, my bad. I'll fix that in v2.
> 
>>>         help
>>>           Select this to see extensive information about
>>> -         the internal state of OMAP IOMMU/IOVMM in debugfs.
>>> +         the internal state of OMAP IOMMU in debugfs.
>>>
>>>           Say N unless you know you need this.
> 
> [snip]
> 
>>> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
>>> index ea920c3..36a85f3 100644
>>> --- a/drivers/iommu/omap-iommu.h
>>> +++ b/drivers/iommu/omap-iommu.h
>>> @@ -46,9 +46,6 @@ struct omap_iommu {
>>>
>>>  	int		nr_tlb_entries;
>>>
>>> -	struct list_head	mmap;
>>> -	struct mutex		mmap_lock; /* protect mmap */
>>> -
>>>  	void *ctx; /* iommu context: registres saved area */
>>>  	u32 da_start;
>>>  	u32 da_end;
>>
>> With the removal of omap-iovmm, the da_start and da_end can also be
>> removed. No need to block this patch for that, it can be done in a
>> separate patch.
> 
> I'll remove the fields from struct omap_iommu in v2. I'll also remove them 
> from the platform data, but I'll need to do so in a separate patch, as arch/ 
> code needs to be touched as well.

Yeah, that's the reason I said separate patch :)

regards
Suman


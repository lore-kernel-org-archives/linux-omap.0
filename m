From: Joel Fernandes <joelf@ti.com>
Subject: Re: dma_unmap causing issues with __get_free_pages
Date: Thu, 15 Aug 2013 10:43:37 -0500
Message-ID: <520CF729.3030704@ti.com>
References: <520C84DF.5050707@ti.com> <20130815115545.GD25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54427 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756277Ab3HOPoM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Aug 2013 11:44:12 -0400
In-Reply-To: <20130815115545.GD25647@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On 08/15/2013 06:55 AM, Russell King - ARM Linux wrote:
> On Thu, Aug 15, 2013 at 02:35:59AM -0500, Joel Fernandes wrote:
>> Hi,
>>
>> I'm having some trouble with using the dma_map/unmap API.
>>
>> On unmapping a particular page using dma_unmap, it seems that the
>> PG_dcache_clean flag is set in the page->flags. This is set by the
>> following statement in __dma_page_dev_to_cpu function in
>> arch/arm/mm/dma-mapping.c
>>                 set_bit(PG_dcache_clean, &page->flags);
>>
>> Due to this, on any subsequent page allocations using __get_free_pages,
>> the following BUG gets triggered.
> 
> Are you calling dma_unmap() after the page has been freed?
> 
>> What is correct way to fix this? Why does the page allocator think its a
>> BAD page descriptor after the unmap?
> 
> Well, on free, this is done:
> 
>         if (page->flags & PAGE_FLAGS_CHECK_AT_PREP)
>                 page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> 
> which clears PG_arch_1.  On allocation:
> 
>         if (unlikely(page_mapcount(page) |
>                 (page->mapping != NULL)  |
>                 (atomic_read(&page->_count) != 0)  |
>                 (page->flags & PAGE_FLAGS_CHECK_AT_PREP) |
>                 (mem_cgroup_bad_page_check(page)))) {
>                 bad_page(page);
>                 return 1;
>         }
> 
> As PG_arch_1 is part of the PAGE_FLAGS_CHECK_AT_PREP mask, this means that
> when a page is freed, it has PG_arch_1 cleared.  Therefore, if on allocation
> the page now has this bit set, it means that something touched the page
> after it was freed.  Quite simply, the page was freed while still being
> in use.  That's very bad and needs fixing.
> 

Absolutely you nailed it! I was doing alloc, map, free, unmap, changed
this to alloc, map, unmap, free and its working fine now and I learnt a
thing or 2 about page->flags. Thanks!

-Joel

From: Joel Fernandes <joelf@ti.com>
Subject: dma_unmap causing issues with __get_free_pages
Date: Thu, 15 Aug 2013 02:35:59 -0500
Message-ID: <520C84DF.5050707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33012 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765Ab3HOHg2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Aug 2013 03:36:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi,

I'm having some trouble with using the dma_map/unmap API.

On unmapping a particular page using dma_unmap, it seems that the
PG_dcache_clean flag is set in the page->flags. This is set by the
following statement in __dma_page_dev_to_cpu function in
arch/arm/mm/dma-mapping.c
                set_bit(PG_dcache_clean, &page->flags);

Due to this, on any subsequent page allocations using __get_free_pages,
the following BUG gets triggered.

[   15.267913] BUG: Bad page state in process insmod  pfn:acb26
[   15.274017] page:c151e4c0 count:0 mapcount:0 mapping:  (null) index:0x0
[   15.281097] page flags: 0x200(arch_1)
[   15.285003] Modules linked in: tcrypt(+)
[   15.289062] CPU: 0 PID: 1616 Comm: insmod Tainted: G    B
3.10.0-00038-gbafd29d-dirty #89
[   15.298706] [<c001c720>] (unwind_backtrace+0x0/0xfc) from
[<c0018794>] (show_stack+0x20/0x24)
[   15.307861] [<c0018794>] (show_stack+0x20/0x24) from [<c05a7284>]
(dump_stack+0x20/0x28)
[   15.316497] [<c05a7284>] (dump_stack+0x20/0x28) from [<c00fa220>]
(bad_page+0xbc/0x11c)
[   15.325195] [<c00fa220>] (bad_page+0xbc/0x11c) from [<c00fa8c8>]
(get_page_from_freelist+0x4dc/0x620)
[   15.335083] [<c00fa8c8>] (get_page_from_freelist+0x4dc/0x620) from
[<c00fb57c>] (__alloc_pages_nodemask+0x114/0x8b4)
[   15.346343] [<c00fb57c>] (__alloc_pages_nodemask+0x114/0x8b4) from
[<c00fbd3c>] (__get_free_pages+0x20/0x3c)
[   15.356872] [<c00fbd3c>] (__get_free_pages+0x20/0x3c) from
[<c0486bd0>] (omap_aes_copy_sgs+0x48/0x1bc)


If I don't do the unmap and leave the page alone, everything works just
fine.

What is correct way to fix this? Why does the page allocator think its a
BAD page descriptor after the unmap?

Thanks,

-Joel

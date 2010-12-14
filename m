From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Tue, 14 Dec 2010 14:23:51 +0200
Message-ID: <1292329431.6893.113.camel@tubuntu>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
	 <20101202215837.GW17222@atomide.com>
	 <20101202221612.GJ10461@n2100.arm.linux.org.uk>
	 <20101202223208.GA17222@atomide.com> <20101203030954.GD3367@linux-sh.org>
	 <20101203084102.GA30957@n2100.arm.linux.org.uk>
	 <AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
	 <20101203130724.GB30957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:56786 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758769Ab0LNMYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 07:24:20 -0500
In-Reply-To: <20101203130724.GB30957@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, 2010-12-03 at 13:07 +0000, ext Russell King - ARM Linux wrote:

> So please, 2MB, or if you object, at the _very_ _least_ 1MB.  But
> definitely not PAGE_SIZE.

Here's a patch for this. Works for me on OMAP3430SDP. If the patch is
ok, I'll send a pull request to Paul.



>From 6c54704730626e2683e05574b3cbba966980c956 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 14 Dec 2010 14:16:59 +0200
Subject: [PATCH] OMAP: DSS: VRAM: Align start & size of vram to 2M

Align the start address and size of VRAM area to 2M as per comments from
Russell King:

> > So, why SZ_2M?
>
> Firstly, that's the granularity which we allocate page tables - one
> Linux page table covers 2MB of memory.  We want to avoid creating page
> tables for the main memory mapping as that increases TLB pressure through
> the use of additional TLB entries, and more page table walks.
>
> Plus, we never used to allow the kernel's direct memory mapping to be
> mapped at anything less than section size - this restriction has since
> been lifted due to OMAP SRAM problems, but I'd rather we stuck with it
> to ensure that we have proper behaviour from all parts of the system.
>
> Secondly, we don't want to end up with lots of fragmentation at the end
> of the memory mapping as that'll reduce performance, not only by making
> the pfn_valid() search more expensive.
>
> Emsuring a minimum allocation size and alignment makes sure that the
> regions can be coalesced together into one block, and minimises run-time
> expenses.
>
> So please, 2MB, or if you object, at the _very_ _least_ 1MB.  But
> definitely not PAGE_SIZE.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/vram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 2fd7e52..9441e2e 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -551,7 +551,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
 	if (!size)
 		return;
 
-	size = PAGE_ALIGN(size);
+	size = ALIGN(size, SZ_2M);
 
 	if (paddr) {
 		if (paddr & ~PAGE_MASK) {
@@ -576,7 +576,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
 			return;
 		}
 	} else {
-		paddr = memblock_alloc(size, PAGE_SIZE);
+		paddr = memblock_alloc(size, SZ_2M);
 	}
 
 	memblock_free(paddr, size);
-- 
1.7.1




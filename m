From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] Allow memblock steal operations to remove memory from
	anywhere
Date: Sun, 12 Aug 2012 11:57:08 +0100
Message-ID: <20120812105708.GD18957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60634 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2HLK72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Aug 2012 06:59:28 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>

Found this with the cubox, which wants to obtain large blocks of
RAM for the GPU and VPU devices at boot time.  I don't believe
any other platforms care where the memory comes from, so I think
this is safe.

However, OMAP and iMX folk should check this patch - thanks.

8<===
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: ARM: Allow arm_memblock_steal() to remove memory from any RAM region

Allow arm_memblock_steal() to remove memory from any RAM region,
including highmem areas.  This allows memory to be stolen from the
very top of declared memory, including highmem areas, rather than
our precious lowmem.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index f54d592..04632f3 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -324,7 +324,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 
 	BUG_ON(!arm_memblock_steal_permitted);
 
-	phys = memblock_alloc(size, align);
+	phys = memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 

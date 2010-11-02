From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: tidspbridge: fix build failure on MEMBLOCK_REAL_LIMIT
Date: Tue,  2 Nov 2010 19:01:00 +0530
Message-ID: <1288704660-21683-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41489 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab0KBNbZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Nov 2010 09:31:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Lindgren <tony@atomide.com>

MEMBLOCK_REAL_LIMIT symbol was removed by the commit e63075a3c937
(memblock: Introduce default allocation limit and use it to replace
explicit ones). This breaks build as below when CONFIG_TIDSPBRIDGE
is selected. Fix this.

  CC      arch/arm/plat-omap/devices.o
arch/arm/plat-omap/devices.c: In function 'omap_dsp_reserve_sdram_memblock':
arch/arm/plat-omap/devices.c:287: error: 'MEMBLOCK_REAL_LIMIT' undeclared (first use in this function)
arch/arm/plat-omap/devices.c:287: error: (Each undeclared identifier is reported only once
arch/arm/plat-omap/devices.c:287: error: for each function it appears in.)
make[1]: *** [arch/arm/plat-omap/devices.o] Error 1
make: *** [arch/arm/plat-omap] Error 2

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tony Lindgren <tony@atomide.com>
---
Based on another similar patch [1] for vram.c. I've scrubbed the rest
of the tree for MEMBLOCK_REAL_LIMIT. Only other occurrence is in
a comment in arch/powerpc/kernel/setup_32.c [2]. Not sure what this
should be changed to.

[1] http://marc.info/?l=linux-omap&m=128862903431257&w=2
[2] http://lxr.free-electrons.com/source/arch/powerpc/kernel/setup_32.c#L249

 arch/arm/plat-omap/devices.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/arm/plat-omap/devices.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/devices.c
+++ linux-2.6/arch/arm/plat-omap/devices.c
@@ -284,7 +284,7 @@ void __init omap_dsp_reserve_sdram_membl
 	if (!size)
 		return;
 
-	paddr = __memblock_alloc_base(size, SZ_1M, MEMBLOCK_REAL_LIMIT);
+	paddr = __memblock_alloc_base(size, SZ_1M, MEMBLOCK_ALLOC_ACCESSIBLE);
 	if (!paddr) {
 		pr_err("%s: failed to reserve %x bytes\n",
 				__func__, size);

From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: fix build break in omapfb due to a typo
Date: Sat,  2 Oct 2010 02:05:11 +0530
Message-ID: <1285965311-18093-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42071 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299Ab0JAUfS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 16:35:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Lindgren <tony@atomide.com>

Fix this build break caused by a typo in commit dbe3039e64b1d
(memblock/arm: Use memblock_region_is_memory() for omap fb) in
linux-next as of 20101001.

s/memblock_region_is_memory/memblock_is_region_memory

  CC      drivers/video/omap2/vram.o
drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_memblock':
drivers/video/omap2/vram.c:568: error: implicit declaration of
function 'memblock_region_is_memory'

Reported-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>	
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/fb.c    |    2 +-
 drivers/video/omap2/vram.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/arm/plat-omap/fb.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/fb.c
+++ linux-2.6/arch/arm/plat-omap/fb.c
@@ -173,7 +173,7 @@ static int check_fbmem_region(int region
 
 static int valid_sdram(unsigned long addr, unsigned long size)
 {
-	return memblock_region_is_memory(addr, size);
+	return memblock_is_region_memory(addr, size);
 }
 
 static int reserve_sdram(unsigned long addr, unsigned long size)
Index: linux-2.6/drivers/video/omap2/vram.c
===================================================================
--- linux-2.6.orig/drivers/video/omap2/vram.c
+++ linux-2.6/drivers/video/omap2/vram.c
@@ -565,7 +565,7 @@ void __init omap_vram_reserve_sdram_memb
 
 	if (paddr) {
 		if ((paddr & ~PAGE_MASK) ||
-		    !memblock_region_is_memory(paddr, size)) {
+		    !memblock_is_region_memory(paddr, size)) {
 			pr_err("Illegal SDRAM region for VRAM\n");
 			return;
 		}

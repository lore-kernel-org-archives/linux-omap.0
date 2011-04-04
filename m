From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP4: SRAM: Fix warning: format '%08lx' expects type 'long unsigned int'
Date: Mon,  4 Apr 2011 14:34:56 +0530
Message-ID: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43520 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1DDJFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 05:05:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Fix below build warning.

 CC	arch/arm/plat-omap/sram.o
	arch/arm/plat-omap/sram.c: In function 'omap_map_sram':
	arch/arm/plat-omap/sram.c:224: warning: format '%08lx' expects
	type 'long unsigned int', but argument 2 has type 'unsigned int'

While at this, convert SRAM printk(* "") to pr_*("").

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a3f50b3..7857146 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -166,7 +166,7 @@ static void __init omap_detect_sram(void)
 		else if (cpu_is_omap1611())
 			omap_sram_size = SZ_256K;
 		else {
-			printk(KERN_ERR "Could not detect SRAM size\n");
+			pr_err("Could not detect SRAM size\n");
 			omap_sram_size = 0x4000;
 		}
 	}
@@ -221,7 +221,7 @@ static void __init omap_map_sram(void)
 	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
-	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
+	pr_info("SRAM: Mapped pa 0x%08x to va 0x%08lx size: 0x%lx\n",
 	__pfn_to_phys(omap_sram_io_desc[0].pfn),
 	omap_sram_io_desc[0].virtual,
 	       omap_sram_io_desc[0].length);
@@ -252,7 +252,7 @@ static void __init omap_map_sram(void)
 void *omap_sram_push_address(unsigned long size)
 {
 	if (size > (omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ))) {
-		printk(KERN_ERR "Not enough space in SRAM\n");
+		pr_err("Not enough space in SRAM\n");
 		return NULL;
 	}
 
-- 
1.6.0.4


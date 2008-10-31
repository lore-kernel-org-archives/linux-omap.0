From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] Revert "Add MT_MEMORY_SO, mark L3 and L4 to use it"
Date: Fri, 31 Oct 2008 12:21:10 -0700
Message-ID: <1225480873-30835-2-git-send-email-tony@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59090 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYJaTVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 15:21:19 -0400
In-Reply-To: <1225480873-30835-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This reverts commit acb7f883f1ec61fd4dcb840a66ddca051ad8f2ef.

Marking the IO areas as strongly ordered causes performance
penalties. Ensuring write posting should only be needed in
few selected places.

Conflicts:

	arch/arm/include/asm/mach/map.h

Signed-off-by: Tony Lindren <tony@atomide.com>
---
 arch/arm/include/asm/mach/map.h |   18 ++++++++++--------
 arch/arm/mach-omap2/io.c        |   12 ++++++------
 arch/arm/mm/mmu.c               |    4 ----
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index fa0e695..9eb936e 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -18,14 +18,16 @@ struct map_desc {
 	unsigned int type;
 };
 
-/* types 0-3 are defined in asm/io.h */
-#define MT_CACHECLEAN		4
-#define MT_MINICLEAN		5
-#define MT_LOW_VECTORS		6
-#define MT_HIGH_VECTORS		7
-#define MT_MEMORY		8
-#define MT_ROM			9
-#define MT_MEMORY_SO		10
+/* types 0-4 are defined in asm/io.h */
+#define MT_CACHECLEAN		5
+#define MT_MINICLEAN		6
+#define MT_LOW_VECTORS		7
+#define MT_HIGH_VECTORS		8
+#define MT_MEMORY		9
+#define MT_ROM			10
+
+#define MT_NONSHARED_DEVICE	MT_DEVICE_NONSHARED
+#define MT_IXP2000_DEVICE	MT_DEVICE_IXP2000
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c11c0e8..adbe21f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -119,13 +119,13 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 		.virtual	= L3_34XX_VIRT,
 		.pfn		= __phys_to_pfn(L3_34XX_PHYS),
 		.length		= L3_34XX_SIZE,
-		.type		= MT_MEMORY_SO
+		.type		= MT_DEVICE
 	},
 	{
 		.virtual	= L4_34XX_VIRT,
 		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
 		.length		= L4_34XX_SIZE,
-		.type		= MT_MEMORY_SO
+		.type		= MT_DEVICE
 	},
 	{
 		.virtual	= L4_WK_34XX_VIRT,
@@ -137,19 +137,19 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 		.virtual	= OMAP34XX_GPMC_VIRT,
 		.pfn		= __phys_to_pfn(OMAP34XX_GPMC_PHYS),
 		.length		= OMAP34XX_GPMC_SIZE,
-		.type		= MT_MEMORY_SO
+		.type		= MT_DEVICE
 	},
 	{
 		.virtual	= OMAP343X_SMS_VIRT,
 		.pfn		= __phys_to_pfn(OMAP343X_SMS_PHYS),
 		.length		= OMAP343X_SMS_SIZE,
-		.type		= MT_MEMORY_SO
+		.type		= MT_DEVICE
 	},
 	{
 		.virtual	= OMAP343X_SDRC_VIRT,
 		.pfn		= __phys_to_pfn(OMAP343X_SDRC_PHYS),
 		.length		= OMAP343X_SDRC_SIZE,
-		.type		= MT_MEMORY_SO
+		.type		= MT_DEVICE
 	},
 	{
 		.virtual	= L4_PER_34XX_VIRT,
@@ -161,7 +161,7 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 		.virtual	= L4_EMU_34XX_VIRT,
 		.pfn		= __phys_to_pfn(L4_EMU_34XX_PHYS),
 		.length		= L4_EMU_34XX_SIZE,
-		.type		= MT_MEMORY_SO
+		.type		= MT_DEVICE
 	},
 };
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 64c5451..8ba7540 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -236,10 +236,6 @@ static struct mem_type mem_types[] = {
 		.prot_sect = PMD_TYPE_SECT,
 		.domain    = DOMAIN_KERNEL,
 	},
-	[MT_MEMORY_SO] = {
-		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_UNCACHED,
-		.domain    = DOMAIN_KERNEL,
-	},
 };
 
 const struct mem_type *get_mem_type(unsigned int type)
-- 
1.5.6.rc3.21.g8c6b5


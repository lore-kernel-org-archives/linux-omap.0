From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/7] ARM: OMAP4: Reduce the static IO mapping
Date: Wed, 2 May 2012 15:18:12 +0530
Message-ID: <1335952093-12541-7-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49955 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab2EBJsf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:48:35 -0400
In-Reply-To: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

EMIF, GMPC and DMM driver can ioremap() the address
space as part of driver intialisation and there is
no need to have static IO mapping for them.

Hence remove the un-used static IP space and let
the respective drivers manage it as part if driver
init.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/io.c    |   30 ------------------------------
 arch/arm/mach-omap2/iomap.h |   28 ----------------------------
 2 files changed, 0 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 065bd76..595a5dd 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -215,41 +215,11 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 		.type		= MT_DEVICE,
 	},
 	{
-		.virtual	= OMAP44XX_GPMC_VIRT,
-		.pfn		= __phys_to_pfn(OMAP44XX_GPMC_PHYS),
-		.length		= OMAP44XX_GPMC_SIZE,
-		.type		= MT_DEVICE,
-	},
-	{
-		.virtual	= OMAP44XX_EMIF1_VIRT,
-		.pfn		= __phys_to_pfn(OMAP44XX_EMIF1_PHYS),
-		.length		= OMAP44XX_EMIF1_SIZE,
-		.type		= MT_DEVICE,
-	},
-	{
-		.virtual	= OMAP44XX_EMIF2_VIRT,
-		.pfn		= __phys_to_pfn(OMAP44XX_EMIF2_PHYS),
-		.length		= OMAP44XX_EMIF2_SIZE,
-		.type		= MT_DEVICE,
-	},
-	{
-		.virtual	= OMAP44XX_DMM_VIRT,
-		.pfn		= __phys_to_pfn(OMAP44XX_DMM_PHYS),
-		.length		= OMAP44XX_DMM_SIZE,
-		.type		= MT_DEVICE,
-	},
-	{
 		.virtual	= L4_PER_44XX_VIRT,
 		.pfn		= __phys_to_pfn(L4_PER_44XX_PHYS),
 		.length		= L4_PER_44XX_SIZE,
 		.type		= MT_DEVICE,
 	},
-	{
-		.virtual	= L4_EMU_44XX_VIRT,
-		.pfn		= __phys_to_pfn(L4_EMU_44XX_PHYS),
-		.length		= L4_EMU_44XX_SIZE,
-		.type		= MT_DEVICE,
-	},
 #ifdef CONFIG_OMAP4_ERRATA_I688
 	{
 		.virtual	= OMAP4_SRAM_VA,
diff --git a/arch/arm/mach-omap2/iomap.h b/arch/arm/mach-omap2/iomap.h
index 0812b15..80b8892 100644
--- a/arch/arm/mach-omap2/iomap.h
+++ b/arch/arm/mach-omap2/iomap.h
@@ -37,9 +37,6 @@
 #define OMAP4_L3_PER_IO_OFFSET	0xb1100000
 #define OMAP4_L3_PER_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_PER_IO_OFFSET)
 
-#define OMAP4_GPMC_IO_OFFSET		0xa9000000
-#define OMAP4_GPMC_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_GPMC_IO_OFFSET)
-
 #define OMAP2_EMU_IO_OFFSET		0xaa800000	/* Emulation */
 #define OMAP2_EMU_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_EMU_IO_OFFSET)
 
@@ -170,28 +167,3 @@
 #define L4_ABE_44XX_VIRT	(L4_ABE_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_ABE_44XX_SIZE	SZ_1M
 
-#define L4_EMU_44XX_PHYS	L4_EMU_44XX_BASE
-						/* 0x54000000 --> 0xfe800000 */
-#define L4_EMU_44XX_VIRT	(L4_EMU_44XX_PHYS + OMAP2_EMU_IO_OFFSET)
-#define L4_EMU_44XX_SIZE	SZ_8M
-
-#define OMAP44XX_GPMC_PHYS	OMAP44XX_GPMC_BASE
-						/* 0x50000000 --> 0xf9000000 */
-#define OMAP44XX_GPMC_VIRT	(OMAP44XX_GPMC_PHYS + OMAP4_GPMC_IO_OFFSET)
-#define OMAP44XX_GPMC_SIZE	SZ_1M
-
-
-#define OMAP44XX_EMIF1_PHYS	OMAP44XX_EMIF1_BASE
-						/* 0x4c000000 --> 0xfd100000 */
-#define OMAP44XX_EMIF1_VIRT	(OMAP44XX_EMIF1_PHYS + OMAP4_L3_PER_IO_OFFSET)
-#define OMAP44XX_EMIF1_SIZE	SZ_1M
-
-#define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
-						/* 0x4d000000 --> 0xfd200000 */
-#define OMAP44XX_EMIF2_SIZE	SZ_1M
-#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + OMAP44XX_EMIF1_SIZE)
-
-#define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
-						/* 0x4e000000 --> 0xfd300000 */
-#define OMAP44XX_DMM_SIZE	SZ_1M
-#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + OMAP44XX_EMIF2_SIZE)
-- 
1.7.5.4


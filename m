From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 1/3] omap3: GPMC register definition at common location
Date: Wed, 12 May 2010 15:18:36 +0530
Message-ID: <1273657718-12517-2-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1273657718-12517-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971Ab0ELJtA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 05:49:00 -0400
In-Reply-To: <1273657718-12517-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, tony@atomide.com, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com, Sukumar Ghorai <s-ghorai@ti.com>

GPMC register definition move to common place in gpmc.h.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   38 +------------------------------
 arch/arm/plat-omap/include/plat/gpmc.h |   36 +++++++++++++++++++++++++++--
 drivers/mtd/nand/omap2.c               |   14 ++++-------
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5bc3ca0..9c77af0
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -28,40 +28,6 @@
 
 #include <plat/sdrc.h>
 
-/* GPMC register offsets */
-#define GPMC_REVISION		0x00
-#define GPMC_SYSCONFIG		0x10
-#define GPMC_SYSSTATUS		0x14
-#define GPMC_IRQSTATUS		0x18
-#define GPMC_IRQENABLE		0x1c
-#define GPMC_TIMEOUT_CONTROL	0x40
-#define GPMC_ERR_ADDRESS	0x44
-#define GPMC_ERR_TYPE		0x48
-#define GPMC_CONFIG		0x50
-#define GPMC_STATUS		0x54
-#define GPMC_PREFETCH_CONFIG1	0x1e0
-#define GPMC_PREFETCH_CONFIG2	0x1e4
-#define GPMC_PREFETCH_CONTROL	0x1ec
-#define GPMC_PREFETCH_STATUS	0x1f0
-#define GPMC_ECC_CONFIG		0x1f4
-#define GPMC_ECC_CONTROL	0x1f8
-#define GPMC_ECC_SIZE_CONFIG	0x1fc
-
-#define GPMC_CS0		0x60
-#define GPMC_CS_SIZE		0x30
-
-#define GPMC_MEM_START		0x00000000
-#define GPMC_MEM_END		0x3FFFFFFF
-#define BOOT_ROM_SPACE		0x100000	/* 1MB */
-
-#define GPMC_CHUNK_SHIFT	24		/* 16 MB */
-#define GPMC_SECTION_SHIFT	28		/* 128 MB */
-
-#define PREFETCH_FIFOTHRESHOLD	(0x40 << 8)
-#define CS_NUM_SHIFT		24
-#define ENABLE_PREFETCH		(0x1 << 7)
-#define DMA_MPU_MODE		2
-
 /* Structure to save gpmc cs context */
 struct gpmc_cs_config {
 	u32 config1;
@@ -112,7 +78,7 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
 	__raw_writel(val, reg_addr);
 }
 
@@ -120,7 +86,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
 	return __raw_readl(reg_addr);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 145838a..347d212 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -25,10 +25,40 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
-#define GPMC_CONFIG		0x50
-#define GPMC_STATUS		0x54
+/* GPMC register offsets */
+#define GPMC_REVISION           0x00
+#define GPMC_SYSCONFIG          0x10
+#define GPMC_SYSSTATUS          0x14
+#define GPMC_IRQSTATUS          0x18
+#define GPMC_IRQENABLE          0x1c
+#define GPMC_TIMEOUT_CONTROL    0x40
+#define GPMC_ERR_ADDRESS        0x44
+#define GPMC_ERR_TYPE           0x48
+#define GPMC_CONFIG             0x50
+#define GPMC_STATUS             0x54
+#define GPMC_PREFETCH_CONFIG1   0x1e0
+#define GPMC_PREFETCH_CONFIG2   0x1e4
+#define GPMC_PREFETCH_CONTROL   0x1ec
+#define GPMC_PREFETCH_STATUS    0x1f0
+#define GPMC_ECC_CONFIG         0x1f4
+#define GPMC_ECC_CONTROL        0x1f8
+#define GPMC_ECC_SIZE_CONFIG    0x1fc
+#define GPMC_ECC1_RESULT        0x200
+
 #define GPMC_CS0_BASE		0x60
-#define GPMC_CS_SIZE		0x30
+#define GPMC_CS_SIZE            0x30
+
+#define GPMC_MEM_START          0x00000000
+#define GPMC_MEM_END            0x3FFFFFFF
+#define BOOT_ROM_SPACE          0x100000        /* 1MB */
+
+#define GPMC_CHUNK_SHIFT        24              /* 16 MB */
+#define GPMC_SECTION_SHIFT      28              /* 128 MB */
+
+#define PREFETCH_FIFOTHRESHOLD  (0x40 << 8)
+#define CS_NUM_SHIFT            24
+#define ENABLE_PREFETCH         (0x1 << 7)
+#define DMA_MPU_MODE            2
 
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 7545568..258bf06
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -23,12 +23,6 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 
-#define GPMC_IRQ_STATUS		0x18
-#define GPMC_ECC_CONFIG		0x1F4
-#define GPMC_ECC_CONTROL	0x1F8
-#define GPMC_ECC_SIZE_CONFIG	0x1FC
-#define GPMC_ECC1_RESULT	0x200
-
 #define	DRIVER_NAME	"omap2-nand"
 
 #define	NAND_WP_OFF	0
@@ -37,6 +31,7 @@
 #define	GPMC_BUF_FULL	0x00000001
 #define	GPMC_BUF_EMPTY	0x00000000
 
+#ifdef CONFIG_MTD_NAND_OMAP_HWECC
 #define NAND_Ecc_P1e		(1 << 0)
 #define NAND_Ecc_P2e		(1 << 1)
 #define NAND_Ecc_P4e		(1 << 2)
@@ -103,6 +98,7 @@
 
 #define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0)
 #define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1)
+#endif /* CONFIG_MTD_NAND_OMAP_HWECC */
 
 #ifdef CONFIG_MTD_PARTITIONS
 static const char *part_probes[] = { "cmdlinepart", NULL };
@@ -854,20 +850,20 @@ static int omap_dev_ready(struct mtd_info *mtd)
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	unsigned int val = __raw_readl(info->gpmc_baseaddr + GPMC_IRQ_STATUS);
+	unsigned int val = __raw_readl(info->gpmc_baseaddr + GPMC_IRQSTATUS);
 
 	if ((val & 0x100) == 0x100) {
 		/* Clear IRQ Interrupt */
 		val |= 0x100;
 		val &= ~(0x0);
-		__raw_writel(val, info->gpmc_baseaddr + GPMC_IRQ_STATUS);
+		__raw_writel(val, info->gpmc_baseaddr + GPMC_IRQSTATUS);
 	} else {
 		unsigned int cnt = 0;
 		while (cnt++ < 0x1FF) {
 			if  ((val & 0x100) == 0x100)
 				return 0;
 			val = __raw_readl(info->gpmc_baseaddr +
-							GPMC_IRQ_STATUS);
+							GPMC_IRQSTATUS);
 		}
 	}
 

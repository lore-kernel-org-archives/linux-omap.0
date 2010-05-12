From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 2/3] omap3 nand: cleanup for not to use GPMC virtual address
Date: Wed, 12 May 2010 15:18:37 +0530
Message-ID: <1273657718-12517-3-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1273657718-12517-1-git-send-email-s-ghorai@ti.com>
 <1273657718-12517-2-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49295 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291Ab0ELJtF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 05:49:05 -0400
In-Reply-To: <1273657718-12517-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, tony@atomide.com, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com, Sukumar Ghorai <s-ghorai@ti.com>

Necessary function added in GPMC module and used by nand driver. This is for
not to use GPMC address directly from nand driver. Also it was passing GPMC
base address from board files and that is removed.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c         |    4 -
 arch/arm/mach-omap2/board-devkit8000.c     |    9 --
 arch/arm/mach-omap2/board-omap3beagle.c    |    8 --
 arch/arm/mach-omap2/board-omap3touchbook.c |    9 --
 arch/arm/mach-omap2/board-overo.c          |    7 --
 arch/arm/mach-omap2/gpmc.c                 |   29 ++++---
 arch/arm/plat-omap/include/plat/gpmc.h     |    5 +-
 arch/arm/plat-omap/include/plat/nand.h     |    6 +-
 drivers/mtd/nand/omap2.c                   |  117 ++++++++++-----------------
 9 files changed, 67 insertions(+), 127 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..fb23122
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -61,8 +61,6 @@
 #define SB_T35_SMSC911X_GPIO	65
 
 #define NAND_BLOCK_SIZE		SZ_128K
-#define GPMC_CS0_BASE		0x60
-#define GPMC_CS0_BASE_ADDR	(OMAP34XX_GPMC_VIRT + GPMC_CS0_BASE)
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
@@ -223,8 +221,6 @@ static struct omap_nand_platform_data cm_t35_nand_data = {
 	.nr_parts		= ARRAY_SIZE(cm_t35_nand_partitions),
 	.dma_channel		= -1,	/* disable DMA in OMAP NAND driver */
 	.cs			= 0,
-	.gpmc_cs_baseaddr	= (void __iomem *)GPMC_CS0_BASE_ADDR,
-	.gpmc_baseaddr		= (void __iomem *)OMAP34XX_GPMC_VIRT,
 
 };
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 47e3af2..be50d18
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -58,9 +58,6 @@
 #include "mux.h"
 #include "hsmmc.h"
 
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
-
 #define NAND_BLOCK_SIZE		SZ_128K
 
 #define OMAP_DM9000_GPIO_IRQ	25
@@ -581,8 +578,6 @@ static void __init devkit8000_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -604,10 +599,6 @@ static void __init devkit8000_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		devkit8000_nand_data.cs = nandcs;
-		devkit8000_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		devkit8000_nand_data.gpmc_baseaddr = (void *)
-			(gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (platform_device_register(&devkit8000_nand_device) < 0)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 962d377..becaebe
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -47,9 +47,6 @@
 #include "mux.h"
 #include "hsmmc.h"
 
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
-
 #define NAND_BLOCK_SIZE		SZ_128K
 
 static struct mtd_partition omap3beagle_nand_partitions[] = {
@@ -377,8 +374,6 @@ static void __init omap3beagle_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -400,9 +395,6 @@ static void __init omap3beagle_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		omap3beagle_nand_data.cs = nandcs;
-		omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		omap3beagle_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (platform_device_register(&omap3beagle_nand_device) < 0)
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2504d41..d6f1b12
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -54,9 +54,6 @@
 
 #include <asm/setup.h>
 
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
-
 #define NAND_BLOCK_SIZE		SZ_128K
 
 #define OMAP3_AC_GPIO		136
@@ -459,8 +456,6 @@ static void __init omap3touchbook_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -482,10 +477,6 @@ static void __init omap3touchbook_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		omap3touchbook_nand_data.cs = nandcs;
-		omap3touchbook_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		omap3touchbook_nand_data.gpmc_baseaddr =
-						(void *) (gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (platform_device_register(&omap3touchbook_nand_device) < 0)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8848c7c..d843a0a
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -58,8 +58,6 @@
 #define OVERO_GPIO_USBH_NRESET	183
 
 #define NAND_BLOCK_SIZE SZ_128K
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
 
 #define OVERO_SMSC911X_CS      5
 #define OVERO_SMSC911X_GPIO    176
@@ -239,8 +237,6 @@ static void __init overo_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -262,9 +258,6 @@ static void __init overo_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		overo_nand_data.cs = nandcs;
-		overo_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		overo_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (platform_device_register(&overo_nand_device) < 0)
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9c77af0..9210e10
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -64,16 +64,32 @@ static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
 
-static void gpmc_write_reg(int idx, u32 val)
+void gpmc_write_reg(int idx, u32 val)
 {
 	__raw_writel(val, gpmc_base + idx);
 }
 
-static u32 gpmc_read_reg(int idx)
+u32 gpmc_read_reg(int idx)
 {
 	return __raw_readl(gpmc_base + idx);
 }
 
+void gpmc_cs_write_byte(int cs, int idx, u32 val)
+{
+	void __iomem *reg_addr;
+
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
+	__raw_writeb(val, reg_addr);
+}
+
+u8 gpmc_cs_read_byte(int cs, int idx)
+{
+	void __iomem *reg_addr;
+
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
+	return __raw_readb(reg_addr);
+}
+
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
 {
 	void __iomem *reg_addr;
@@ -432,15 +448,6 @@ void gpmc_prefetch_reset(void)
 }
 EXPORT_SYMBOL(gpmc_prefetch_reset);
 
-/**
- * gpmc_prefetch_status - reads prefetch status of engine
- */
-int  gpmc_prefetch_status(void)
-{
-	return gpmc_read_reg(GPMC_PREFETCH_STATUS);
-}
-EXPORT_SYMBOL(gpmc_prefetch_status);
-
 static void __init gpmc_mem_init(void)
 {
 	int cs;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 347d212..c1e9807
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -128,8 +128,12 @@ extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
 extern unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns);
 extern unsigned long gpmc_get_fclk_period(void);
 
+extern void gpmc_write_reg(int idx, u32 val);
+extern u32 gpmc_read_reg(int idx);
 extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
 extern u32 gpmc_cs_read_reg(int cs, int idx);
+extern void gpmc_cs_write_byte(int cs, int idx, u32 val);
+extern u8 gpmc_cs_read_byte(int cs, int idx);
 extern int gpmc_cs_calc_divider(int cs, unsigned int sync_clk);
 extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
@@ -139,7 +143,6 @@ extern int gpmc_cs_reserved(int cs);
 extern int gpmc_prefetch_enable(int cs, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern void gpmc_prefetch_reset(void);
-extern int gpmc_prefetch_status(void);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
 extern void gpmc_init(void);
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index f8efd54..6562cd0
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -21,13 +21,11 @@ struct omap_nand_platform_data {
 	int			(*dev_ready)(struct omap_nand_platform_data *);
 	int			dma_channel;
 	unsigned long		phys_base;
-	void __iomem		*gpmc_cs_baseaddr;
-	void __iomem		*gpmc_baseaddr;
 	int			devsize;
 };
 
-/* size (4 KiB) for IO mapping */
-#define	NAND_IO_SIZE	SZ_4K
+/* minimum size for IO mapping */
+#define	NAND_IO_SIZE	4
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 extern int gpmc_nand_init(struct omap_nand_platform_data *d);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 258bf06..f4f6f01
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -135,9 +135,6 @@ struct omap_nand_info {
 
 	int				gpmc_cs;
 	unsigned long			phys_base;
-	void __iomem			*gpmc_cs_baseaddr;
-	void __iomem			*gpmc_baseaddr;
-	void __iomem			*nand_pref_fifo_add;
 	struct completion		comp;
 	int				dma_ch;
 };
@@ -149,17 +146,14 @@ struct omap_nand_info {
  */
 static void omap_nand_wp(struct mtd_info *mtd, int mode)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
-
-	unsigned long config = __raw_readl(info->gpmc_baseaddr + GPMC_CONFIG);
+	unsigned long config = gpmc_read_reg(GPMC_CONFIG);
 
 	if (mode)
 		config &= ~(NAND_WP_BIT);	/* WP is ON */
 	else
 		config |= (NAND_WP_BIT);	/* WP is OFF */
 
-	__raw_writel(config, (info->gpmc_baseaddr + GPMC_CONFIG));
+	gpmc_write_reg(GPMC_CONFIG, config);
 }
 
 /**
@@ -177,31 +171,20 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct omap_nand_info *info = container_of(mtd,
 					struct omap_nand_info, mtd);
-	switch (ctrl) {
-	case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_COMMAND;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
 
-	case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_ADDRESS;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
+	if (cmd != NAND_CMD_NONE) {
+		if (ctrl & NAND_CLE) {
+			gpmc_cs_write_byte(info->gpmc_cs,
+					GPMC_CS_NAND_COMMAND, cmd);
 
-	case NAND_CTRL_CHANGE | NAND_NCE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
-	}
+		} else if (ctrl & NAND_ALE) {
+			gpmc_cs_write_byte(info->gpmc_cs,
+					GPMC_CS_NAND_ADDRESS, cmd);
 
-	if (cmd != NAND_CMD_NONE)
-		__raw_writeb(cmd, info->nand.IO_ADDR_W);
+		} else /* NAND_NCE */
+			gpmc_cs_write_byte(info->gpmc_cs,
+					GPMC_CS_NAND_DATA, cmd);
+	}
 }
 
 /**
@@ -231,8 +214,9 @@ static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 
 	while (len--) {
 		iowrite8(*p++, info->nand.IO_ADDR_W);
-		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
-						GPMC_STATUS) & GPMC_BUF_FULL));
+		while (GPMC_BUF_EMPTY ==
+				(gpmc_read_reg(GPMC_STATUS) & GPMC_BUF_FULL))
+			;
 	}
 }
 
@@ -267,8 +251,8 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 	while (len--) {
 		iowrite16(*p++, info->nand.IO_ADDR_W);
 
-		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
-						GPMC_STATUS) & GPMC_BUF_FULL))
+		while (GPMC_BUF_EMPTY ==
+				(gpmc_read_reg(GPMC_STATUS) & GPMC_BUF_FULL))
 			;
 	}
 }
@@ -304,9 +288,9 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 			omap_read_buf8(mtd, buf, len);
 	} else {
 		do {
-			pfpw_status = gpmc_prefetch_status();
+			pfpw_status = gpmc_read_reg(GPMC_PREFETCH_STATUS);
 			r_count = ((pfpw_status >> 24) & 0x7F) >> 2;
-			ioread32_rep(info->nand_pref_fifo_add, p, r_count);
+			ioread32_rep(info->nand.IO_ADDR_R, p, r_count);
 			p += r_count;
 			len -= r_count << 2;
 		} while (len);
@@ -347,12 +331,12 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 		else
 			omap_write_buf8(mtd, buf, len);
 	} else {
-		pfpw_status = gpmc_prefetch_status();
+		pfpw_status = gpmc_read_reg(GPMC_PREFETCH_STATUS);
 		while (pfpw_status & 0x3FFF) {
 			w_count = ((pfpw_status >> 24) & 0x7F) >> 1;
 			for (i = 0; (i < w_count) && len; i++, len -= 2)
-				iowrite16(*p++, info->nand_pref_fifo_add);
-			pfpw_status = gpmc_prefetch_status();
+				iowrite16(*p++, info->nand.IO_ADDR_W);
+			pfpw_status = gpmc_read_reg(GPMC_PREFETCH_STATUS);
 		}
 
 		/* disable and stop the PFPW engine */
@@ -444,7 +428,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	/* setup and start DMA using dma_addr */
 	wait_for_completion(&info->comp);
 
-	while (0x3fff & (prefetch_status = gpmc_prefetch_status()))
+	while (0x3fff & (prefetch_status = gpmc_read_reg(GPMC_PREFETCH_STATUS)))
 		;
 	/* disable and stop the PFPW engine */
 	gpmc_prefetch_reset();
@@ -498,7 +482,7 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 		omap_write_buf_pref(mtd, buf, len);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, buf, len, 0x1);
+		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
 }
 
 /**
@@ -529,22 +513,21 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
  */
 static void omap_hwecc_init(struct mtd_info *mtd)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
 	struct nand_chip *chip = mtd->priv;
 	unsigned long val = 0x0;
 
 	/* Read from ECC Control Register */
-	val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+	val = gpmc_read_reg(GPMC_ECC_CONTROL);
+
 	/* Clear all ECC | Enable Reg1 */
 	val = ((0x00000001<<8) | 0x00000001);
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+	gpmc_write_reg(GPMC_ECC_CONTROL, val);
 
 	/* Read from ECC Size Config Register */
-	val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
+	val = gpmc_read_reg(GPMC_ECC_SIZE_CONFIG);
 	/* ECCSIZE1=512 | Select eccResultsize[0-3] */
 	val = ((((chip->ecc.size >> 1) - 1) << 22) | (0x0000000F));
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
+	gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
 }
 
 /**
@@ -746,19 +729,14 @@ static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
 static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 				u_char *ecc_code)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
 	unsigned long val = 0x0;
-	unsigned long reg;
 
 	/* Start Reading from HW ECC1_Result = 0x200 */
-	reg = (unsigned long)(info->gpmc_baseaddr + GPMC_ECC1_RESULT);
-	val = __raw_readl(reg);
+	val = gpmc_read_reg(GPMC_ECC1_RESULT);
 	*ecc_code++ = val;          /* P128e, ..., P1e */
 	*ecc_code++ = val >> 16;    /* P128o, ..., P1o */
 	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
 	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
-	reg += 4;
 
 	return 0;
 }
@@ -774,21 +752,21 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 							mtd);
 	struct nand_chip *chip = mtd->priv;
 	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
-	unsigned long val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONFIG);
+	unsigned long val = gpmc_read_reg(GPMC_ECC_CONFIG);
 
 	switch (mode) {
 	case NAND_ECC_READ:
-		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
 		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
 		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
 		break;
 	case NAND_ECC_READSYN:
-		 __raw_writel(0x100, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		 gpmc_write_reg(GPMC_ECC_CONTROL, 0x100);
 		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
 		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
 		break;
 	case NAND_ECC_WRITE:
-		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
 		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
 		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
 		break;
@@ -798,7 +776,7 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 		break;
 	}
 
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONFIG);
+	gpmc_write_reg(GPMC_ECC_CONFIG, val);
 }
 #endif
 
@@ -827,14 +805,11 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	else
 		timeo += (HZ * 20) / 1000;
 
-	this->IO_ADDR_W = (void *) info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_COMMAND;
-	this->IO_ADDR_R = (void *) info->gpmc_cs_baseaddr + GPMC_CS_NAND_DATA;
-
-	__raw_writeb(NAND_CMD_STATUS & 0xFF, this->IO_ADDR_W);
+	gpmc_cs_write_byte(info->gpmc_cs,
+		GPMC_CS_NAND_COMMAND, (NAND_CMD_STATUS & 0xFF));
 
 	while (time_before(jiffies, timeo)) {
-		status = __raw_readb(this->IO_ADDR_R);
+		status = gpmc_cs_read_byte(info->gpmc_cs, GPMC_CS_NAND_DATA);
 		if (status & NAND_STATUS_READY)
 			break;
 		cond_resched();
@@ -848,22 +823,19 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
  */
 static int omap_dev_ready(struct mtd_info *mtd)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
-	unsigned int val = __raw_readl(info->gpmc_baseaddr + GPMC_IRQSTATUS);
+	unsigned int val = gpmc_read_reg(GPMC_IRQSTATUS);
 
 	if ((val & 0x100) == 0x100) {
 		/* Clear IRQ Interrupt */
 		val |= 0x100;
 		val &= ~(0x0);
-		__raw_writel(val, info->gpmc_baseaddr + GPMC_IRQSTATUS);
+		gpmc_write_reg(GPMC_IRQSTATUS, val);
 	} else {
 		unsigned int cnt = 0;
 		while (cnt++ < 0x1FF) {
 			if  ((val & 0x100) == 0x100)
 				return 0;
-			val = __raw_readl(info->gpmc_baseaddr +
-							GPMC_IRQSTATUS);
+			val = gpmc_read_reg(GPMC_IRQSTATUS);
 		}
 	}
 
@@ -894,8 +866,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 
 	info->gpmc_cs		= pdata->cs;
-	info->gpmc_baseaddr	= pdata->gpmc_baseaddr;
-	info->gpmc_cs_baseaddr	= pdata->gpmc_cs_baseaddr;
 	info->phys_base		= pdata->phys_base;
 
 	info->mtd.priv		= &info->nand;
@@ -942,7 +912,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 
 	if (use_prefetch) {
 		/* copy the virtual address of nand base for fifo access */
-		info->nand_pref_fifo_add = info->nand.IO_ADDR_R;
 
 		info->nand.read_buf   = omap_read_buf_pref;
 		info->nand.write_buf  = omap_write_buf_pref;
@@ -1032,7 +1001,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
-	iounmap(info->nand_pref_fifo_add);
+	iounmap(info->nand.IO_ADDR_R);
 	kfree(&info->mtd);
 	return 0;
 }

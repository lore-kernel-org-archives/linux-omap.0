From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC virtual address
Date: Fri, 14 May 2010 20:53:10 +0530
Message-ID: <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57975 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab0ENPXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 11:23:38 -0400
In-Reply-To: <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
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
 arch/arm/mach-omap2/board-devkit8000.c     |    9 -
 arch/arm/mach-omap2/board-omap3beagle.c    |    8 -
 arch/arm/mach-omap2/board-omap3touchbook.c |    9 -
 arch/arm/mach-omap2/board-overo.c          |    7 -
 arch/arm/mach-omap2/gpmc-nand.c            |   38 ++----
 arch/arm/mach-omap2/gpmc-onenand.c         |    2 +-
 arch/arm/mach-omap2/gpmc.c                 |  244 ++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/gpmc.h     |   36 ++++-
 arch/arm/plat-omap/include/plat/nand.h     |    6 +-
 drivers/mtd/nand/omap2.c                   |  190 ++++++----------------
 11 files changed, 301 insertions(+), 252 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index f4e8063..87bed2a
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
index 6d910df..ef9b677
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
index 5df89f6..e90dd2a
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
index c59050d..4a6c984
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
index 24b32d7..a9151fb
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -58,8 +58,6 @@
 #define OVERO_GPIO_USBH_NRESET	183
 
 #define NAND_BLOCK_SIZE SZ_128K
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
 
 #define OVERO_SMSC911X_CS      5
 #define OVERO_SMSC911X_GPIO    176
@@ -251,8 +249,6 @@ static void __init overo_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -274,9 +270,6 @@ static void __init overo_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		overo_nand_data.cs = nandcs;
-		overo_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		overo_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (platform_device_register(&overo_nand_device) < 0)
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index e57fb29..8aa74be
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -19,8 +19,6 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
-#define WR_RD_PIN_MONITORING	0x00600000
-
 static struct omap_nand_platform_data *gpmc_nand_data;
 
 static struct resource gpmc_nand_resource = {
@@ -71,10 +69,10 @@ static int omap2_nand_gpmc_retime(void)
 	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
 
 	/* Configure GPMC */
-	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG1,
-			GPMC_CONFIG1_DEVICESIZE(gpmc_nand_data->devsize) |
-			GPMC_CONFIG1_DEVICETYPE_NAND);
-
+	gpmc_hwcontrol(1, gpmc_nand_data->cs,
+			GPMC_CONFIG_DEV_SIZE, gpmc_nand_data->devsize, NULL);
+	gpmc_hwcontrol(1, gpmc_nand_data->cs,
+			GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NAND, NULL);
 	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
 	if (err)
 		return err;
@@ -82,27 +80,13 @@ static int omap2_nand_gpmc_retime(void)
 	return 0;
 }
 
-static int gpmc_nand_setup(void)
-{
-	struct device *dev = &gpmc_nand_device.dev;
-
-	/* Set timings in GPMC */
-	if (omap2_nand_gpmc_retime() < 0) {
-		dev_err(dev, "Unable to set gpmc timings\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
 {
-	unsigned int val;
 	int err	= 0;
 	struct device *dev = &gpmc_nand_device.dev;
 
 	gpmc_nand_data = _nand_data;
-	gpmc_nand_data->nand_setup = gpmc_nand_setup;
+	gpmc_nand_data->nand_setup = omap2_nand_gpmc_retime;
 	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
 
 	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
@@ -112,19 +96,17 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
 		return err;
 	}
 
-	err = gpmc_nand_setup();
+	 /* Set timings in GPMC */
+	err = omap2_nand_gpmc_retime();
 	if (err < 0) {
-		dev_err(dev, "NAND platform setup failed: %d\n", err);
+		dev_err(dev, "Unable to set gpmc timings: %d\n", err);
 		return err;
 	}
 
 	/* Enable RD PIN Monitoring Reg */
 	if (gpmc_nand_data->dev_ready) {
-		val  = gpmc_cs_read_reg(gpmc_nand_data->cs,
-						 GPMC_CS_CONFIG1);
-		val |= WR_RD_PIN_MONITORING;
-		gpmc_cs_write_reg(gpmc_nand_data->cs,
-						GPMC_CS_CONFIG1, val);
+		gpmc_hwcontrol(1, gpmc_nand_data->cs,
+						GPMC_CONFIG_RDY_BSY, 1, NULL);
 	}
 
 	err = platform_device_register(&gpmc_nand_device);
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 7bb6922..5d66817
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -301,7 +301,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 				(GPMC_CONFIG1_WAIT_READ_MON |
 				 GPMC_CONFIG1_WAIT_PIN_SEL(0))) |
 			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_DEVICETYPE_NOR |
+			  GPMC_CONFIG1_DEVICETYPE(GPMC_DEVICETYPE_NOR) |
 			  GPMC_CONFIG1_MUXADDDATA);
 
 	err = gpmc_cs_set_timings(cs, &t);
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5bc3ca0..a3fd1ed
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -29,27 +29,27 @@
 #include <plat/sdrc.h>
 
 /* GPMC register offsets */
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
+#define GPMC_CS0_BASE		0x60
+#define GPMC_CS_SIZE            0x30
 #define GPMC_MEM_START		0x00000000
 #define GPMC_MEM_END		0x3FFFFFFF
 #define BOOT_ROM_SPACE		0x100000	/* 1MB */
@@ -108,11 +108,27 @@ static u32 gpmc_read_reg(int idx)
 	return __raw_readl(gpmc_base + idx);
 }
 
+static void gpmc_cs_write_byte(int cs, int idx, u8 val)
+{
+	void __iomem *reg_addr;
+
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
+	__raw_writeb(val, reg_addr);
+}
+
+static u8 gpmc_cs_read_byte(int cs, int idx)
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
 
-	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
 	__raw_writel(val, reg_addr);
 }
 
@@ -120,7 +136,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
 	return __raw_readl(reg_addr);
 }
 
@@ -419,6 +435,96 @@ void gpmc_cs_free(int cs)
 EXPORT_SYMBOL(gpmc_cs_free);
 
 /**
+ * gpmc_hwcontrol - hardware specific access (read/ write) to control
+ * @write: need 1 for configure; 0 for reading the complete register
+ * @cs: chip select number
+ * @cmd: Command type
+ * @wval: value/information to write
+ * @rval: pointer to get the value back
+ */
+int gpmc_hwcontrol(int write, int cs, int cmd, int wval, int *rval)
+{
+	u32 reg = 0;
+	u32 regval = 0;
+
+	switch (cmd) {
+
+	case GPMC_GET_SET_STATUS:
+		reg = GPMC_STATUS;
+		if (write)
+			gpmc_write_reg(GPMC_STATUS, regval);
+		break;
+
+	case GPMC_GET_SET_IRQ_STATUS:
+		reg = GPMC_IRQSTATUS;
+		if (write)
+			gpmc_write_reg(GPMC_IRQSTATUS, regval);
+		break;
+
+	case GPMC_GET_PREF_STATUS:
+		reg = GPMC_PREFETCH_STATUS;
+		break;
+
+	case GPMC_CONFIG_WP:
+		reg = GPMC_CONFIG;
+		regval = gpmc_read_reg(GPMC_CONFIG);
+	    if (wval)
+			regval &= ~GPMC_CONFIG_WRITEPROTECT; /* WP is ON */
+		else
+			regval |= GPMC_CONFIG_WRITEPROTECT;  /* WP is OFF */
+		gpmc_write_reg(reg, regval);
+		break;
+
+	case GPMC_CONFIG_RDY_BSY:
+		#define WR_RD_PIN_MONITORING    0x00600000
+		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+		regval |= WR_RD_PIN_MONITORING;
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
+		break;
+
+	case GPMC_CONFIG_DEV_SIZE:
+		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+		regval |= GPMC_CONFIG1_DEVICESIZE(wval);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
+		break;
+
+	case GPMC_CONFIG_DEV_TYPE:
+		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+		regval |= GPMC_CONFIG1_DEVICETYPE(wval);
+		if (wval == GPMC_DEVICETYPE_NOR)
+			regval |= GPMC_CONFIG1_MUXADDDATA;
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
+		break;
+
+	case GPMC_NAND_COMMAND:
+		gpmc_cs_write_byte(cs, GPMC_CS_NAND_COMMAND, wval);
+		break;
+
+	case GPMC_NAND_ADDRESS:
+		gpmc_cs_write_byte(cs, GPMC_CS_NAND_ADDRESS, wval);
+		break;
+
+	case GPMC_NAND_DATA:
+		if (write)
+			gpmc_cs_write_byte(cs, GPMC_CS_NAND_DATA, wval);
+		else
+			*rval = gpmc_cs_read_byte(cs, GPMC_CS_NAND_DATA);
+		break;
+
+	default:
+		dump_stack();
+		printk(KERN_ERR "not supported\n");
+		return -1;
+	}
+
+	if (!write && reg)
+		*rval = gpmc_read_reg(reg);
+
+	return 0;
+}
+EXPORT_SYMBOL(gpmc_hwcontrol);
+
+/**
  * gpmc_prefetch_enable - configures and starts prefetch transfer
  * @cs: nand cs (chip select) number
  * @dma_mode: dma mode enable (1) or disable (0)
@@ -466,15 +572,6 @@ void gpmc_prefetch_reset(void)
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
@@ -615,3 +712,86 @@ void omap3_gpmc_restore_context(void)
 	}
 }
 #endif /* CONFIG_ARCH_OMAP3 */
+
+/**
+ * gmpc_ecc_init - Initialize the HW ECC for NAND flash in GPMC controller
+ * @cs: Chip select number
+ * @ecc_size: bytes for which ECC will be generated
+ */
+void gpmc_ecc_init(int cs, int ecc_size)
+{
+	unsigned int val = 0x0;
+
+	/* Read from ECC Control Register */
+	val = gpmc_read_reg(GPMC_ECC_CONTROL);
+
+	/* Clear all ECC | Enable Reg1 */
+	val = ((0x00000001<<8) | 0x00000001);
+	gpmc_write_reg(GPMC_ECC_CONTROL, val);
+
+	/* Read from ECC Size Config Register */
+	val = gpmc_read_reg(GPMC_ECC_SIZE_CONFIG);
+	/* ECCSIZE1=512 | Select eccResultsize[0-3] */
+	val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
+	gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
+}
+
+/**
+ * gpmc_calcuate_ecc - Generate non-inverted ECC bytes.
+ * @cs: Chip select number
+ * @dat: The pointer to data on which ecc is computed
+ * @ecc_code: The ecc_code buffer
+ *
+ * Using noninverted ECC can be considered ugly since writing a blank
+ * page ie. padding will clear the ECC bytes. This is no problem as long
+ * nobody is trying to write data on the seemingly unused page. Reading
+ * an erased page will produce an ECC mismatch between generated and read
+ * ECC bytes that has to be dealt with separately.
+ */
+int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
+{
+	unsigned int val = 0x0;
+
+	/* Start Reading from HW ECC1_Result = 0x200 */
+	val = gpmc_read_reg(GPMC_ECC1_RESULT);
+	*ecc_code++ = val;          /* P128e, ..., P1e */
+	*ecc_code++ = val >> 16;    /* P128o, ..., P1o */
+	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
+	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
+
+	return 0;
+}
+
+/**
+ * gpmc_enable_hwecc - This function enables the hardware ecc functionality
+ * @cs: Chip select number
+ * @mode: Read/Write mode
+ * @dev_width: device bus width
+ */
+void gpmc_enable_hwecc(int cs, int mode, int dev_width)
+{
+	unsigned int val = gpmc_read_reg(GPMC_ECC_CONFIG);
+
+	switch (mode) {
+	case GPMC_ECC_READ:
+		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+		val = (dev_width << 7) | (cs << 1) | (0x1);
+		break;
+	case GPMC_ECC_READSYN:
+		 gpmc_write_reg(GPMC_ECC_CONTROL, 0x100);
+		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+		val = (dev_width << 7) | (cs << 1) | (0x1);
+		break;
+	case GPMC_ECC_WRITE:
+		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+		val = (dev_width << 7) | (cs << 1) | (0x1);
+		break;
+	default:
+		printk(KERN_INFO "Error: Unrecognized Mode[%d]!\n", mode);
+		break;
+	}
+
+	gpmc_write_reg(GPMC_ECC_CONFIG, val);
+}
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 145838a..56e1407
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -25,10 +25,22 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
-#define GPMC_CONFIG		0x50
-#define GPMC_STATUS		0x54
-#define GPMC_CS0_BASE		0x60
-#define GPMC_CS_SIZE		0x30
+/* Control Commands */
+#define GPMC_GET_SET_STATUS	0x00000001
+#define GPMC_CONFIG_WP		0x00000002
+#define GPMC_CONFIG_RDY_BSY	0x00000003
+#define GPMC_CONFIG_DEV_SIZE	0x00000004
+#define GPMC_CONFIG_DEV_TYPE    0x00000005
+#define GPMC_NAND_COMMAND	0x00000006
+#define GPMC_NAND_ADDRESS	0x00000007
+#define GPMC_NAND_DATA		0x00000008
+#define GPMC_GET_PREF_STATUS	0x00000009
+#define GPMC_GET_SET_IRQ_STATUS	0x0000000a
+
+/* ECC commands */
+#define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
+#define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
+#define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
 
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
@@ -44,10 +56,7 @@
 #define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
 #define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
 #define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
-#define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
-#define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(2)
 #define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
 #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
@@ -56,6 +65,12 @@
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
 #define GPMC_CONFIG7_CSVALID		(1 << 6)
 
+#define GPMC_DEVICETYPE_NOR	0
+#define GPMC_DEVICETYPE_NAND	2
+#define GPMC_CONFIG_WRITEPROTECT	0x00000010
+#define GPMC_CONFIG1_DEVICESIZE_16	GPMC_CONFIG1_DEVICESIZE(1)
+
+
 /*
  * Note that all values in this struct are in nanoseconds, while
  * the register values are in gpmc_fck cycles.
@@ -109,9 +124,14 @@ extern int gpmc_cs_reserved(int cs);
 extern int gpmc_prefetch_enable(int cs, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern void gpmc_prefetch_reset(void);
-extern int gpmc_prefetch_status(void);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
 extern void gpmc_init(void);
+extern int gpmc_hwcontrol(int write, int cs, int cmd, int wval, int *rval);
+
+void gpmc_ecc_init(int cs, int ecc_size);
+void gpmc_enable_hwecc(int cs, int mode, int dev_width);
+int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
+
 
 #endif
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
index 7545568..1858c42
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
@@ -139,34 +135,11 @@ struct omap_nand_info {
 
 	int				gpmc_cs;
 	unsigned long			phys_base;
-	void __iomem			*gpmc_cs_baseaddr;
-	void __iomem			*gpmc_baseaddr;
-	void __iomem			*nand_pref_fifo_add;
 	struct completion		comp;
 	int				dma_ch;
 };
 
 /**
- * omap_nand_wp - This function enable or disable the Write Protect feature
- * @mtd: MTD device structure
- * @mode: WP ON/OFF
- */
-static void omap_nand_wp(struct mtd_info *mtd, int mode)
-{
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
-
-	unsigned long config = __raw_readl(info->gpmc_baseaddr + GPMC_CONFIG);
-
-	if (mode)
-		config &= ~(NAND_WP_BIT);	/* WP is ON */
-	else
-		config |= (NAND_WP_BIT);	/* WP is OFF */
-
-	__raw_writel(config, (info->gpmc_baseaddr + GPMC_CONFIG));
-}
-
-/**
  * omap_hwcontrol - hardware specific access to control-lines
  * @mtd: MTD device structure
  * @cmd: command to device
@@ -181,31 +154,20 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
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
-
-	case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_ADDRESS;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
-
-	case NAND_CTRL_CHANGE | NAND_NCE:
-		info->nand.IO_ADDR_W = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		info->nand.IO_ADDR_R = info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_DATA;
-		break;
-	}
 
-	if (cmd != NAND_CMD_NONE)
-		__raw_writeb(cmd, info->nand.IO_ADDR_W);
+	if (cmd != NAND_CMD_NONE) {
+		if (ctrl & NAND_CLE) {
+			gpmc_hwcontrol(1, info->gpmc_cs,
+					GPMC_NAND_COMMAND, cmd, NULL);
+
+		} else if (ctrl & NAND_ALE) {
+			gpmc_hwcontrol(1, info->gpmc_cs,
+					GPMC_NAND_ADDRESS, cmd, NULL);
+
+		} else /* NAND_NCE */
+			gpmc_hwcontrol(1, info->gpmc_cs,
+					GPMC_NAND_DATA, cmd, NULL);
+	}
 }
 
 /**
@@ -229,14 +191,15 @@ static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int len)
  */
 static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	u32	status;
+	struct nand_chip *nand = mtd->priv;
 	u_char *p = (u_char *)buf;
 
 	while (len--) {
-		iowrite8(*p++, info->nand.IO_ADDR_W);
-		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
-						GPMC_STATUS) & GPMC_BUF_FULL));
+		iowrite8(*p++, nand->IO_ADDR_W);
+		gpmc_hwcontrol(0, 0, GPMC_GET_SET_STATUS, 0, &status);
+		while (GPMC_BUF_EMPTY == (status & GPMC_BUF_FULL))
+			;
 	}
 }
 
@@ -261,18 +224,17 @@ static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
  */
 static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	u32     status;
+	struct nand_chip *nand = mtd->priv;
 	u16 *p = (u16 *) buf;
 
 	/* FIXME try bursts of writesw() or DMA ... */
 	len >>= 1;
 
 	while (len--) {
-		iowrite16(*p++, info->nand.IO_ADDR_W);
-
-		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
-						GPMC_STATUS) & GPMC_BUF_FULL))
+		iowrite16(*p++, nand->IO_ADDR_W);
+		gpmc_hwcontrol(0, 0, GPMC_GET_SET_STATUS, 0, &status);
+		while (GPMC_BUF_EMPTY == (status & GPMC_BUF_FULL))
 			;
 	}
 }
@@ -308,9 +270,10 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 			omap_read_buf8(mtd, buf, len);
 	} else {
 		do {
-			pfpw_status = gpmc_prefetch_status();
+			gpmc_hwcontrol(0, info->gpmc_cs,
+					GPMC_GET_PREF_STATUS, 0, &pfpw_status);
 			r_count = ((pfpw_status >> 24) & 0x7F) >> 2;
-			ioread32_rep(info->nand_pref_fifo_add, p, r_count);
+			ioread32_rep(info->nand.IO_ADDR_R, p, r_count);
 			p += r_count;
 			len -= r_count << 2;
 		} while (len);
@@ -351,12 +314,13 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 		else
 			omap_write_buf8(mtd, buf, len);
 	} else {
-		pfpw_status = gpmc_prefetch_status();
+		gpmc_hwcontrol(0, 0, GPMC_GET_PREF_STATUS, 0, &pfpw_status);
 		while (pfpw_status & 0x3FFF) {
 			w_count = ((pfpw_status >> 24) & 0x7F) >> 1;
 			for (i = 0; (i < w_count) && len; i++, len -= 2)
-				iowrite16(*p++, info->nand_pref_fifo_add);
-			pfpw_status = gpmc_prefetch_status();
+				iowrite16(*p++, info->nand.IO_ADDR_W);
+			gpmc_hwcontrol(0, 0,
+					GPMC_GET_PREF_STATUS, 0, &pfpw_status);
 		}
 
 		/* disable and stop the PFPW engine */
@@ -448,7 +412,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	/* setup and start DMA using dma_addr */
 	wait_for_completion(&info->comp);
 
-	while (0x3fff & (prefetch_status = gpmc_prefetch_status()))
+	while (0x3fff & (prefetch_status = gpmc_read_reg(GPMC_PREFETCH_STATUS)))
 		;
 	/* disable and stop the PFPW engine */
 	gpmc_prefetch_reset();
@@ -502,7 +466,7 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 		omap_write_buf_pref(mtd, buf, len);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, buf, len, 0x1);
+		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
 }
 
 /**
@@ -535,22 +499,8 @@ static void omap_hwecc_init(struct mtd_info *mtd)
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	struct nand_chip *chip = mtd->priv;
-	unsigned long val = 0x0;
-
-	/* Read from ECC Control Register */
-	val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-	/* Clear all ECC | Enable Reg1 */
-	val = ((0x00000001<<8) | 0x00000001);
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-
-	/* Read from ECC Size Config Register */
-	val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
-	/* ECCSIZE1=512 | Select eccResultsize[0-3] */
-	val = ((((chip->ecc.size >> 1) - 1) << 22) | (0x0000000F));
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
+	gpmc_ecc_init(info->gpmc_cs, info->nand.ecc.size);
 }
-
 /**
  * gen_true_ecc - This function will generate true ECC value
  * @ecc_buf: buffer to store ecc code
@@ -752,21 +702,8 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	unsigned long val = 0x0;
-	unsigned long reg;
-
-	/* Start Reading from HW ECC1_Result = 0x200 */
-	reg = (unsigned long)(info->gpmc_baseaddr + GPMC_ECC1_RESULT);
-	val = __raw_readl(reg);
-	*ecc_code++ = val;          /* P128e, ..., P1e */
-	*ecc_code++ = val >> 16;    /* P128o, ..., P1o */
-	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
-	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
-	reg += 4;
-
-	return 0;
+	return gpmc_calculate_ecc(info->gpmc_cs, dat, ecc_code);
 }
-
 /**
  * omap_enable_hwecc - This function enables the hardware ecc functionality
  * @mtd: MTD device structure
@@ -778,32 +715,10 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 							mtd);
 	struct nand_chip *chip = mtd->priv;
 	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
-	unsigned long val = __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONFIG);
-
-	switch (mode) {
-	case NAND_ECC_READ:
-		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
-		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
-		break;
-	case NAND_ECC_READSYN:
-		 __raw_writel(0x100, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
-		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
-		break;
-	case NAND_ECC_WRITE:
-		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
-		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
-		val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
-		break;
-	default:
-		DEBUG(MTD_DEBUG_LEVEL0, "Error: Unrecognized Mode[%d]!\n",
-					mode);
-		break;
-	}
 
-	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONFIG);
+	gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width);
 }
+
 #endif
 
 /**
@@ -831,14 +746,10 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	else
 		timeo += (HZ * 20) / 1000;
 
-	this->IO_ADDR_W = (void *) info->gpmc_cs_baseaddr +
-						GPMC_CS_NAND_COMMAND;
-	this->IO_ADDR_R = (void *) info->gpmc_cs_baseaddr + GPMC_CS_NAND_DATA;
-
-	__raw_writeb(NAND_CMD_STATUS & 0xFF, this->IO_ADDR_W);
-
+	gpmc_hwcontrol(1, info->gpmc_cs,
+			GPMC_NAND_COMMAND, (NAND_CMD_STATUS & 0xFF), NULL);
 	while (time_before(jiffies, timeo)) {
-		status = __raw_readb(this->IO_ADDR_R);
+		gpmc_hwcontrol(0, info->gpmc_cs, GPMC_NAND_DATA, 0, &status);
 		if (status & NAND_STATUS_READY)
 			break;
 		cond_resched();
@@ -852,22 +763,20 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
  */
 static int omap_dev_ready(struct mtd_info *mtd)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
-	unsigned int val = __raw_readl(info->gpmc_baseaddr + GPMC_IRQ_STATUS);
+	unsigned int val = 0;
 
+	gpmc_hwcontrol(0, 0, GPMC_GET_SET_IRQ_STATUS, 0, &val);
 	if ((val & 0x100) == 0x100) {
 		/* Clear IRQ Interrupt */
 		val |= 0x100;
 		val &= ~(0x0);
-		__raw_writel(val, info->gpmc_baseaddr + GPMC_IRQ_STATUS);
+		gpmc_hwcontrol(1, 0, GPMC_GET_SET_IRQ_STATUS, val, NULL);
 	} else {
 		unsigned int cnt = 0;
 		while (cnt++ < 0x1FF) {
 			if  ((val & 0x100) == 0x100)
 				return 0;
-			val = __raw_readl(info->gpmc_baseaddr +
-							GPMC_IRQ_STATUS);
+			gpmc_hwcontrol(0, 0, GPMC_GET_SET_IRQ_STATUS, 0, &val);
 		}
 	}
 
@@ -898,8 +807,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 
 	info->gpmc_cs		= pdata->cs;
-	info->gpmc_baseaddr	= pdata->gpmc_baseaddr;
-	info->gpmc_cs_baseaddr	= pdata->gpmc_cs_baseaddr;
 	info->phys_base		= pdata->phys_base;
 
 	info->mtd.priv		= &info->nand;
@@ -910,7 +817,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 
 	/* NAND write protect off */
-	omap_nand_wp(&info->mtd, NAND_WP_OFF);
+	gpmc_hwcontrol(1, info->gpmc_cs, GPMC_CONFIG_WP, 0, NULL);
 
 	if (!request_mem_region(info->phys_base, NAND_IO_SIZE,
 				pdev->dev.driver->name)) {
@@ -946,7 +853,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 
 	if (use_prefetch) {
 		/* copy the virtual address of nand base for fifo access */
-		info->nand_pref_fifo_add = info->nand.IO_ADDR_R;
 
 		info->nand.read_buf   = omap_read_buf_pref;
 		info->nand.write_buf  = omap_write_buf_pref;
@@ -1036,7 +942,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
-	iounmap(info->nand_pref_fifo_add);
+	iounmap(info->nand.IO_ADDR_R);
 	kfree(&info->mtd);
 	return 0;
 }

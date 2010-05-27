From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v4 1/3] omap3 gpmc: functionality enhancement
Date: Thu, 27 May 2010 18:54:05 +0530
Message-ID: <1274966647-32500-2-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1274966647-32500-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54825 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab0E0NYM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 May 2010 09:24:12 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4RDO9IW004433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 08:24:11 -0500
In-Reply-To: <1274966647-32500-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

few functions added in gpmc module and to be used by other drivers like NAND.
E.g.: - ioctl function
      - ecc functions

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |  219 ++++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/gpmc.h |   33 +++++-
 drivers/mtd/nand/omap2.c               |    4 +-
 3 files changed, 239 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5bc3ca0..48b5af0
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -46,8 +46,9 @@
 #define GPMC_ECC_CONFIG		0x1f4
 #define GPMC_ECC_CONTROL	0x1f8
 #define GPMC_ECC_SIZE_CONFIG	0x1fc
+#define GPMC_ECC1_RESULT        0x200
 
-#define GPMC_CS0		0x60
+#define GPMC_CS0_BASE		0x60
 #define GPMC_CS_SIZE		0x30
 
 #define GPMC_MEM_START		0x00000000
@@ -92,7 +93,8 @@ struct omap3_gpmc_regs {
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
-static unsigned		gpmc_cs_map;
+static unsigned	int gpmc_cs_map;	/* flag for cs which are initialized */
+static int gpmc_ecc_used = -EINVAL;	/* cs using ecc engine */
 
 static void __iomem *gpmc_base;
 
@@ -108,11 +110,27 @@ static u32 gpmc_read_reg(int idx)
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
 
@@ -120,7 +138,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
+	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
 	return __raw_readl(reg_addr);
 }
 
@@ -419,8 +437,100 @@ void gpmc_cs_free(int cs)
 EXPORT_SYMBOL(gpmc_cs_free);
 
 /**
+ * gpmc_hwcontrol - hardware specific access (read/ write) control
+ * @cs: chip select number
+ * @cmd: command type
+ * @write: 1 for write; 0 for read
+ * @wval: value to write
+ * @rval: read pointer
+ */
+int gpmc_hwcontrol(int cs, int cmd, int write, int wval, int *rval)
+{
+	u32 regval = 0;
+
+	if (!write && !rval)
+		return -EINVAL;
+
+	switch (cmd) {
+	case GPMC_STATUS_BUFFER:
+		regval = gpmc_read_reg(GPMC_STATUS);
+		/* 1 : buffer is available to write */
+		*rval = regval & GPMC_STATUS_BUFF_EMPTY;
+		break;
+
+	case GPMC_GET_SET_IRQ_STATUS:
+		if (write)
+			gpmc_write_reg(GPMC_IRQSTATUS, wval);
+		else
+			*rval = gpmc_read_reg(GPMC_IRQSTATUS);
+		break;
+
+	case GPMC_PREFETCH_FIFO_CNT:
+		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
+		*rval = GPMC_PREFETCH_STATUS_FIFO_CNT(regval);
+		break;
+
+	case GPMC_PREFETCH_COUNT:
+		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
+		*rval = GPMC_PREFETCH_STATUS_COUNT(regval);
+		break;
+
+	case GPMC_CONFIG_WP:
+		regval = gpmc_read_reg(GPMC_CONFIG);
+		if (wval)
+			regval &= ~GPMC_CONFIG_WRITEPROTECT; /* WP is ON */
+		else
+			regval |= GPMC_CONFIG_WRITEPROTECT;  /* WP is OFF */
+		gpmc_write_reg(GPMC_CONFIG, regval);
+		break;
+
+	case GPMC_CONFIG_RDY_BSY:
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
+		printk(KERN_ERR "gpmc_hwcontrol: Not supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(gpmc_hwcontrol);
+
+/**
  * gpmc_prefetch_enable - configures and starts prefetch transfer
- * @cs: nand cs (chip select) number
+ * @cs: cs (chip select) number
  * @dma_mode: dma mode enable (1) or disable (0)
  * @u32_count: number of bytes to be transferred
  * @is_write: prefetch read(0) or write post(1) mode
@@ -428,7 +538,6 @@ EXPORT_SYMBOL(gpmc_cs_free);
 int gpmc_prefetch_enable(int cs, int dma_mode,
 				unsigned int u32_count, int is_write)
 {
-	uint32_t prefetch_config1;
 
 	if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
 		/* Set the amount of bytes to be prefetched */
@@ -437,17 +546,17 @@ int gpmc_prefetch_enable(int cs, int dma_mode,
 		/* Set dma/mpu mode, the prefetch read / post write and
 		 * enable the engine. Set which cs is has requested for.
 		 */
-		prefetch_config1 = ((cs << CS_NUM_SHIFT) |
+		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, ((cs << CS_NUM_SHIFT) |
 					PREFETCH_FIFOTHRESHOLD |
 					ENABLE_PREFETCH |
 					(dma_mode << DMA_MPU_MODE) |
-					(0x1 & is_write));
-		gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch_config1);
+					(0x1 & is_write)));
+
+		/*  Start the prefetch engine */
+		gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x1);
 	} else {
 		return -EBUSY;
 	}
-	/*  Start the prefetch engine */
-	gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x1);
 
 	return 0;
 }
@@ -456,13 +565,22 @@ EXPORT_SYMBOL(gpmc_prefetch_enable);
 /**
  * gpmc_prefetch_reset - disables and stops the prefetch engine
  */
-void gpmc_prefetch_reset(void)
+int gpmc_prefetch_reset(int cs)
 {
+	u32 config1;
+
+	/* check if the same module/cs is trying to reset */
+	config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+	if (((config1 >> CS_NUM_SHIFT) & 0x7) != cs)
+		return -EINVAL;
+
 	/* Stop the PFPW engine */
 	gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
 
 	/* Reset/disable the PFPW engine */
 	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x0);
+
+	return 0;
 }
 EXPORT_SYMBOL(gpmc_prefetch_reset);
 
@@ -615,3 +733,80 @@ void omap3_gpmc_restore_context(void)
 	}
 }
 #endif /* CONFIG_ARCH_OMAP3 */
+
+/**
+ * gpmc_enable_hwecc - enable hardware ecc functionality
+ * @cs: chip select number
+ * @mode: read/write mode
+ * @dev_width: device bus width(1 for x16, 0 for x8)
+ * @ecc_size: bytes for which ECC will be generated
+ */
+int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
+{
+	unsigned int val;
+
+	/* check if ecc module is in used */
+	if (gpmc_ecc_used != -EINVAL)
+		return -EINVAL;
+
+	gpmc_ecc_used = cs;
+
+	/* clear ecc and enable bits */
+	val = ((0x00000001<<8) | 0x00000001);
+	gpmc_write_reg(GPMC_ECC_CONTROL, val);
+
+	/* program ecc and result sizes */
+	val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
+	gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
+
+	switch (mode) {
+	case GPMC_ECC_READ:
+		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+		break;
+	case GPMC_ECC_READSYN:
+		 gpmc_write_reg(GPMC_ECC_CONTROL, 0x100);
+		break;
+	case GPMC_ECC_WRITE:
+		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+		break;
+	default:
+		printk(KERN_INFO "Error: Unrecognized Mode[%d]!\n", mode);
+		break;
+	}
+
+	/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+	val = (dev_width << 7) | (cs << 1) | (0x1);
+	gpmc_write_reg(GPMC_ECC_CONFIG, val);
+	return 0;
+}
+
+/**
+ * gpmc_calculate_ecc - generate non-inverted ecc bytes
+ * @cs: chip select number
+ * @dat: data pointer over which ecc is computed
+ * @ecc_code: ecc code buffer
+ *
+ * Using non-inverted ECC is considered ugly since writing a blank
+ * page (padding) will clear the ECC bytes. This is not a problem as long
+ * no one is trying to write data on the seemingly unused page. Reading
+ * an erased page will produce an ECC mismatch between generated and read
+ * ECC bytes that has to be dealt with separately.
+ */
+int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
+{
+	unsigned int val = 0x0;
+
+	if (gpmc_ecc_used != cs)
+		return -EINVAL;
+
+	/* read ecc result */
+	val = gpmc_read_reg(GPMC_ECC1_RESULT);
+	*ecc_code++ = val;          /* P128e, ..., P1e */
+	*ecc_code++ = val >> 16;    /* P128o, ..., P1o */
+	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
+	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
+
+	gpmc_ecc_used = -EINVAL;
+	return 0;
+}
+
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 145838a..8a1e9d9
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -27,8 +27,24 @@
 
 #define GPMC_CONFIG		0x50
 #define GPMC_STATUS		0x54
-#define GPMC_CS0_BASE		0x60
-#define GPMC_CS_SIZE		0x30
+
+/* Control Commands */
+#define GPMC_CONFIG_WP		0x00000001
+#define GPMC_CONFIG_RDY_BSY	0x00000002
+#define GPMC_CONFIG_DEV_SIZE	0x00000003
+#define GPMC_CONFIG_DEV_TYPE	0x00000004
+#define GPMC_NAND_COMMAND	0x00000005
+#define GPMC_NAND_ADDRESS	0x00000006
+#define GPMC_NAND_DATA		0x00000007
+#define GPMC_STATUS_BUFFER	0x00000008 /* 1: buffer is available to write */
+#define GPMC_PREFETCH_FIFO_CNT	0x00000009 /* bytes available in FIFO for r/w */
+#define GPMC_PREFETCH_COUNT	0x0000000A /* remaining bytes to be read/write*/
+#define GPMC_GET_SET_IRQ_STATUS	0x0000000B
+
+/* ECC commands */
+#define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
+#define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
+#define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
 
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
@@ -56,6 +72,14 @@
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
 #define GPMC_CONFIG7_CSVALID		(1 << 6)
 
+#define GPMC_DEVICETYPE_NOR		0
+#define GPMC_DEVICETYPE_NAND		2
+#define GPMC_CONFIG_WRITEPROTECT	0x00000010
+#define GPMC_STATUS_BUFF_EMPTY		0x00000001
+#define WR_RD_PIN_MONITORING		0x00600000
+#define GPMC_PREFETCH_STATUS_FIFO_CNT(val)	((val >> 24) & 0x7F)
+#define GPMC_PREFETCH_STATUS_COUNT(val)	(val & 0x00003fff)
+
 /*
  * Note that all values in this struct are in nanoseconds, while
  * the register values are in gpmc_fck cycles.
@@ -108,10 +132,13 @@ extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
 extern int gpmc_prefetch_enable(int cs, int dma_mode,
 					unsigned int u32_count, int is_write);
-extern void gpmc_prefetch_reset(void);
+extern int gpmc_prefetch_reset(int cs);
 extern int gpmc_prefetch_status(void);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
 extern void gpmc_init(void);
+extern int gpmc_hwcontrol(int cs, int cmd, int write, int wval, int *rval);
 
+int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size);
+int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
 #endif
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index ee87325..ec8eb31
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -319,7 +319,7 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 		} while (len);
 
 		/* disable and stop the PFPW engine */
-		gpmc_prefetch_reset();
+		gpmc_prefetch_reset(info->gpmc_cs);
 	}
 }
 
@@ -363,7 +363,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 		}
 
 		/* disable and stop the PFPW engine */
-		gpmc_prefetch_reset();
+		gpmc_prefetch_reset(info->gpmc_cs);
 	}
 }
 

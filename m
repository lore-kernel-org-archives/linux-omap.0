From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 11/16] mtd: nand: omap: Move NAND write protect code from
 GPMC to NAND driver
Date: Wed, 21 May 2014 14:20:59 +0300
Message-ID: <1400671264-10702-12-git-send-email-rogerq@ti.com>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1400671264-10702-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, robertcnelson@gmail.com, jg1.han@samsung.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The write protect (WP) pin is only used for NAND devices. So move
the code into the NAND driver.

Get rid of gpmc_configure() and gpmc_write_reg() as they are no longer
used.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc.c                   | 42 ----------------------------
 arch/arm/mach-omap2/gpmc.h                   |  4 ---
 drivers/mtd/nand/omap2.c                     | 23 +++++++++++++++
 include/linux/platform_data/mtd-nand-omap2.h |  1 +
 4 files changed, 24 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 4207dc9..132f786 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -154,11 +154,6 @@ static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
 
-static void gpmc_write_reg(int idx, u32 val)
-{
-	__raw_writel(val, gpmc_base + idx);
-}
-
 static u32 gpmc_read_reg(int idx)
 {
 	return __raw_readl(gpmc_base + idx);
@@ -597,35 +592,6 @@ void gpmc_cs_free(int cs)
 }
 EXPORT_SYMBOL(gpmc_cs_free);
 
-/**
- * gpmc_configure - write request to configure gpmc
- * @cmd: command type
- * @wval: value to write
- * @return status of the operation
- */
-int gpmc_configure(int cmd, int wval)
-{
-	u32 regval;
-
-	switch (cmd) {
-	case GPMC_CONFIG_WP:
-		regval = gpmc_read_reg(GPMC_CONFIG);
-		if (wval)
-			regval &= ~GPMC_CONFIG_WRITEPROTECT; /* WP is ON */
-		else
-			regval |= GPMC_CONFIG_WRITEPROTECT;  /* WP is OFF */
-		gpmc_write_reg(GPMC_CONFIG, regval);
-		break;
-
-	default:
-		pr_err("%s: command not supported\n", __func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(gpmc_configure);
-
 static void gpmc_mem_exit(void)
 {
 	int cs;
@@ -1471,7 +1437,6 @@ static int gpmc_nand_setup(struct platform_device *parent_pdev,
 			   struct gpmc_settings *settings)
 {
 	struct resource *res;
-	int rc;
 	struct resource *res_mem;
 
 	/* GPMC register space */
@@ -1486,13 +1451,6 @@ static int gpmc_nand_setup(struct platform_device *parent_pdev,
 	res[2].start = gpmc_irq;
 
 	settings->device_nand = true;
-	/*
-	 * Not sure why WP is explicitly turned OFF. we just moved it here
-	 * as is from mach-omap2/gpmc-nand.c
-	 */
-	rc = gpmc_configure(GPMC_CONFIG_WP, 0);
-	if (rc < 0)
-		return rc;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index 05974f0..8ebadf5 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -22,9 +22,6 @@
 #define GPMC_CS_CONFIG6		0x14
 #define GPMC_CS_CONFIG7		0x18
 
-/* Control Commands */
-#define GPMC_CONFIG_WP		0x00000005
-
 /* ECC commands */
 #define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
 #define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
@@ -57,7 +54,6 @@
 
 #define GPMC_DEVICETYPE_NOR		0
 #define GPMC_DEVICETYPE_NAND		2
-#define GPMC_CONFIG_WRITEPROTECT	0x00000010
 #define WR_RD_PIN_MONITORING		0x00600000
 #define GPMC_IRQ_FIFOEVENTENABLE	0x01
 #define GPMC_IRQ_COUNT_EVENT		0x02
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 7d12d92..fee0458 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -140,6 +140,9 @@
 #define GPMC_IRQ_FIFOEVENT	BIT(0)
 #define GPMC_IRQ_TERMCOUNT	BIT(1)
 
+/* GPMC_CONFIG register bits */
+#define GPMC_CONFIG_WRITEPROTECT	BIT(4)
+
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
@@ -206,6 +209,22 @@ struct omap_nand_info {
 };
 
 /**
+ * omap_nand_writeprotect - Control the WP line to the NAND chip
+ */
+static void omap_nand_writeprotect(struct omap_nand_info *info, bool on)
+{
+	u32 val;
+
+	val = readl(info->reg.gpmc_config);
+	if (on)
+		val |= GPMC_CONFIG_WRITEPROTECT;
+	else
+		val &= GPMC_CONFIG_WRITEPROTECT;
+
+	writel(val, info->reg.gpmc_config);
+}
+
+/**
  * omap_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
  * @fifo_th: fifo threshold to be used for read/ write
@@ -1622,6 +1641,7 @@ static void gpmc_update_nand_reg(struct omap_nand_info *info)
 	int cs = info->gpmc_cs;
 	void __iomem *gpmc_base = info->gpmc_base;
 
+	reg->gpmc_config = gpmc_base + GPMC_CONFIG;
 	reg->gpmc_status = gpmc_base + GPMC_STATUS;
 	reg->gpmc_irqstatus = gpmc_base + GPMC_IRQSTATUS;
 	reg->gpmc_irqenable = gpmc_base + GPMC_IRQENABLE;
@@ -2029,6 +2049,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
+	/* turn off write protect */
+	omap_nand_writeprotect(info, false);
+
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
 		err = -ENXIO;
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index b71cfbd..62a855e 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -34,6 +34,7 @@ enum omap_ecc {
 };
 
 struct gpmc_nand_regs {
+	void __iomem	*gpmc_config;
 	void __iomem	*gpmc_status;
 	void __iomem	*gpmc_irqstatus;
 	void __iomem	*gpmc_irqenable;
-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to NAND
 driver
Date: Fri, 10 Jul 2015 15:23:30 +0300
Message-ID: <1436531019-18088-4-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Since the Interrupt Events are used only by the NAND driver,
there is no point in managing the Interrupt registers
in the GPMC driver and complicating it with irqchip modeling.

Let's manage the interrupt registers directly in the NAND driver
and get rid of irqchip model from GPMC driver.

Get rid of IRQ commands and unused commands from gpmc_configure() in
the GPMC driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c              |   4 +-
 drivers/memory/omap-gpmc.c                   | 176 ++-------------------------
 drivers/mtd/nand/omap2.c                     |  76 ++++++------
 include/linux/omap-gpmc.h                    |   5 +-
 include/linux/platform_data/mtd-nand-omap2.h |   2 +
 5 files changed, 56 insertions(+), 207 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 72918c4..b960876 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -80,7 +80,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	struct resource gpmc_nand_res[] = {
 		{ .flags = IORESOURCE_MEM, },
 		{ .flags = IORESOURCE_IRQ, },
-		{ .flags = IORESOURCE_IRQ, },
 	};
 
 	BUG_ON(gpmc_nand_data->cs >= GPMC_CS_NUM);
@@ -93,8 +92,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		return err;
 	}
 	gpmc_nand_res[0].end = gpmc_nand_res[0].start + NAND_IO_SIZE - 1;
-	gpmc_nand_res[1].start = gpmc_get_client_irq(GPMC_IRQ_FIFOEVENTENABLE);
-	gpmc_nand_res[2].start = gpmc_get_client_irq(GPMC_IRQ_COUNT_EVENT);
+	gpmc_nand_res[1].start = gpmc_get_irq();
 
 	memset(&s, 0, sizeof(struct gpmc_settings));
 	if (gpmc_nand_data->of_node)
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 3a27a84..50806e7 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -121,12 +121,6 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
-/* Control Commands */
-#define GPMC_CONFIG_RDY_BSY	0x00000001
-#define GPMC_CONFIG_DEV_SIZE	0x00000002
-#define GPMC_CONFIG_DEV_TYPE	0x00000003
-#define GPMC_SET_IRQ_STATUS	0x00000004
-
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
 #define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
@@ -174,17 +168,11 @@
 #define GPMC_CONFIG_WRITEPROTECT	0x00000010
 #define WR_RD_PIN_MONITORING		0x00600000
 
-#define GPMC_ENABLE_IRQ		0x0000000d
-
 /* ECC commands */
 #define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
 #define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
 #define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
 
-/* XXX: Only NAND irq has been considered,currently these are the only ones used
- */
-#define	GPMC_NR_IRQ		2
-
 enum gpmc_clk_domain {
 	GPMC_CD_FCLK,
 	GPMC_CD_CLK
@@ -199,11 +187,6 @@ struct gpmc_cs_data {
 	struct resource mem;
 };
 
-struct gpmc_client_irq	{
-	unsigned		irq;
-	u32			bitmask;
-};
-
 /* Structure to save gpmc cs context */
 struct gpmc_cs_config {
 	u32 config1;
@@ -231,10 +214,6 @@ struct omap3_gpmc_regs {
 	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
 };
 
-static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
-static struct irq_chip gpmc_irq_chip;
-static int gpmc_irq_start;
-
 static struct resource	gpmc_mem_root;
 static struct gpmc_cs_data gpmc_cs[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
@@ -242,15 +221,13 @@ static DEFINE_SPINLOCK(gpmc_mem_lock);
 static unsigned int gpmc_cs_num = GPMC_CS_NUM;
 static unsigned int gpmc_nr_waitpins;
 static struct device *gpmc_dev;
-static int gpmc_irq;
+static int gpmc_irq = -EINVAL;
 static resource_size_t phys_base, mem_size;
 static unsigned gpmc_capability;
 static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
 
-static irqreturn_t gpmc_handle_irq(int irq, void *dev);
-
 static void gpmc_write_reg(int idx, u32 val)
 {
 	writel_relaxed(val, gpmc_base + idx);
@@ -1035,14 +1012,6 @@ int gpmc_configure(int cmd, int wval)
 	u32 regval;
 
 	switch (cmd) {
-	case GPMC_ENABLE_IRQ:
-		gpmc_write_reg(GPMC_IRQENABLE, wval);
-		break;
-
-	case GPMC_SET_IRQ_STATUS:
-		gpmc_write_reg(GPMC_IRQSTATUS, wval);
-		break;
-
 	case GPMC_CONFIG_WP:
 		regval = gpmc_read_reg(GPMC_CONFIG);
 		if (wval)
@@ -1066,6 +1035,8 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 	int i;
 
 	reg->gpmc_status = gpmc_base + GPMC_STATUS;
+	reg->gpmc_irqstatus = gpmc_base + GPMC_IRQSTATUS;
+	reg->gpmc_irqenable = gpmc_base + GPMC_IRQENABLE;
 	reg->gpmc_nand_command = gpmc_base + GPMC_CS0_OFFSET +
 				GPMC_CS_NAND_COMMAND + GPMC_CS_SIZE * cs;
 	reg->gpmc_nand_address = gpmc_base + GPMC_CS0_OFFSET +
@@ -1099,113 +1070,9 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 	}
 }
 
-int gpmc_get_client_irq(unsigned irq_config)
-{
-	int i;
-
-	if (hweight32(irq_config) > 1)
-		return 0;
-
-	for (i = 0; i < GPMC_NR_IRQ; i++)
-		if (gpmc_client_irq[i].bitmask & irq_config)
-			return gpmc_client_irq[i].irq;
-
-	return 0;
-}
-
-static int gpmc_irq_endis(unsigned irq, bool endis)
-{
-	int i;
-	u32 regval;
-
-	for (i = 0; i < GPMC_NR_IRQ; i++)
-		if (irq == gpmc_client_irq[i].irq) {
-			regval = gpmc_read_reg(GPMC_IRQENABLE);
-			if (endis)
-				regval |= gpmc_client_irq[i].bitmask;
-			else
-				regval &= ~gpmc_client_irq[i].bitmask;
-			gpmc_write_reg(GPMC_IRQENABLE, regval);
-			break;
-		}
-
-	return 0;
-}
-
-static void gpmc_irq_disable(struct irq_data *p)
-{
-	gpmc_irq_endis(p->irq, false);
-}
-
-static void gpmc_irq_enable(struct irq_data *p)
-{
-	gpmc_irq_endis(p->irq, true);
-}
-
-static void gpmc_irq_noop(struct irq_data *data) { }
-
-static unsigned int gpmc_irq_noop_ret(struct irq_data *data) { return 0; }
-
-static int gpmc_setup_irq(void)
-{
-	int i;
-	u32 regval;
-
-	if (!gpmc_irq)
-		return -EINVAL;
-
-	gpmc_irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
-	if (gpmc_irq_start < 0) {
-		pr_err("irq_alloc_descs failed\n");
-		return gpmc_irq_start;
-	}
-
-	gpmc_irq_chip.name = "gpmc";
-	gpmc_irq_chip.irq_startup = gpmc_irq_noop_ret;
-	gpmc_irq_chip.irq_enable = gpmc_irq_enable;
-	gpmc_irq_chip.irq_disable = gpmc_irq_disable;
-	gpmc_irq_chip.irq_shutdown = gpmc_irq_noop;
-	gpmc_irq_chip.irq_ack = gpmc_irq_noop;
-	gpmc_irq_chip.irq_mask = gpmc_irq_noop;
-	gpmc_irq_chip.irq_unmask = gpmc_irq_noop;
-
-	gpmc_client_irq[0].bitmask = GPMC_IRQ_FIFOEVENTENABLE;
-	gpmc_client_irq[1].bitmask = GPMC_IRQ_COUNT_EVENT;
-
-	for (i = 0; i < GPMC_NR_IRQ; i++) {
-		gpmc_client_irq[i].irq = gpmc_irq_start + i;
-		irq_set_chip_and_handler(gpmc_client_irq[i].irq,
-					&gpmc_irq_chip, handle_simple_irq);
-		set_irq_flags(gpmc_client_irq[i].irq,
-				IRQF_VALID | IRQF_NOAUTOEN);
-	}
-
-	/* Disable interrupts */
-	gpmc_write_reg(GPMC_IRQENABLE, 0);
-
-	/* clear interrupts */
-	regval = gpmc_read_reg(GPMC_IRQSTATUS);
-	gpmc_write_reg(GPMC_IRQSTATUS, regval);
-
-	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
-}
-
-static int gpmc_free_irq(void)
+int gpmc_get_irq(void)
 {
-	int i;
-
-	if (gpmc_irq)
-		free_irq(gpmc_irq, NULL);
-
-	for (i = 0; i < GPMC_NR_IRQ; i++) {
-		irq_set_handler(gpmc_client_irq[i].irq, NULL);
-		irq_set_chip(gpmc_client_irq[i].irq, &no_irq_chip);
-		irq_modify_status(gpmc_client_irq[i].irq, 0, 0);
-	}
-
-	irq_free_descs(gpmc_irq_start, GPMC_NR_IRQ);
-
-	return 0;
+	return gpmc_irq;
 }
 
 static void gpmc_mem_exit(void)
@@ -2105,10 +1972,12 @@ static int gpmc_probe(struct platform_device *pdev)
 		return PTR_ERR(gpmc_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL)
-		dev_warn(&pdev->dev, "Failed to get resource: irq\n");
-	else
-		gpmc_irq = res->start;
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get resource: irq\n");
+		return -EINVAL;
+	}
+
+	gpmc_irq = res->start;
 
 	gpmc_l3_clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(gpmc_l3_clk)) {
@@ -2150,9 +2019,6 @@ static int gpmc_probe(struct platform_device *pdev)
 
 	gpmc_mem_init();
 
-	if (gpmc_setup_irq() < 0)
-		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
-
 	if (!pdev->dev.of_node) {
 		gpmc_cs_num	 = GPMC_CS_NUM;
 		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
@@ -2170,7 +2036,6 @@ static int gpmc_probe(struct platform_device *pdev)
 
 static int gpmc_remove(struct platform_device *pdev)
 {
-	gpmc_free_irq();
 	gpmc_mem_exit();
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -2220,25 +2085,6 @@ static __exit void gpmc_exit(void)
 postcore_initcall(gpmc_init);
 module_exit(gpmc_exit);
 
-static irqreturn_t gpmc_handle_irq(int irq, void *dev)
-{
-	int i;
-	u32 regval;
-
-	regval = gpmc_read_reg(GPMC_IRQSTATUS);
-
-	if (!regval)
-		return IRQ_NONE;
-
-	for (i = 0; i < GPMC_NR_IRQ; i++)
-		if (regval & gpmc_client_irq[i].bitmask)
-			generic_handle_irq(gpmc_client_irq[i].irq);
-
-	gpmc_write_reg(GPMC_IRQSTATUS, regval);
-
-	return IRQ_HANDLED;
-}
-
 static struct omap3_gpmc_regs gpmc_context;
 
 void omap3_gpmc_save_context(void)
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 60fa899..9dbb2be 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -136,6 +136,10 @@
 
 #define BADBLOCK_MARKER_LENGTH		2
 
+/* GPMC IRQ REGISTER bits */
+#define GPMC_IRQ_FIFOEVENT	BIT(0)
+#define GPMC_IRQ_TERMCOUNT	BIT(1)
+
 static u_char bch16_vector[] = {0xf5, 0x24, 0x1c, 0xd0, 0x61, 0xb3, 0xf1, 0x55,
 				0x2e, 0x2c, 0x86, 0xa3, 0xed, 0x36, 0x1b, 0x78,
 				0x48, 0x76, 0xa9, 0x3b, 0x97, 0xd1, 0x7a, 0x93,
@@ -161,8 +165,7 @@ struct omap_nand_info {
 	enum omap_ecc			ecc_opt;
 	struct completion		comp;
 	struct dma_chan			*dma;
-	int				gpmc_irq_fifo;
-	int				gpmc_irq_count;
+	int				gpmc_irq;
 	enum {
 		OMAP_NAND_IO_READ = 0,	/* read */
 		OMAP_NAND_IO_WRITE,	/* write */
@@ -578,12 +581,16 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 {
 	struct omap_nand_info *info = (struct omap_nand_info *) dev;
 	u32 bytes;
+	u32 irqstatus;
+	u32 irqenable;
+
+	irqstatus = readl(info->reg.gpmc_irqstatus);
 
 	bytes = readl(info->reg.gpmc_prefetch_status);
 	bytes = PREFETCH_STATUS_FIFO_CNT(bytes);
 	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
 	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
-		if (this_irq == info->gpmc_irq_count)
+		if (irqstatus & GPMC_IRQ_TERMCOUNT)
 			goto done;
 
 		if (info->buf_len && (info->buf_len < bytes))
@@ -600,17 +607,27 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 						(u32 *)info->buf, bytes >> 2);
 		info->buf = info->buf + bytes;
 
-		if (this_irq == info->gpmc_irq_count)
+		if (irqstatus & GPMC_IRQ_TERMCOUNT)
 			goto done;
 	}
 
+	/* Clear FIFOEVENT STATUS */
+	irqstatus &= ~GPMC_IRQ_FIFOEVENT;
+	writel(irqstatus, info->reg.gpmc_irqstatus);
+
 	return IRQ_HANDLED;
 
 done:
 	complete(&info->comp);
 
-	disable_irq_nosync(info->gpmc_irq_fifo);
-	disable_irq_nosync(info->gpmc_irq_count);
+	/* Clear FIFOEVENT and TERMCOUNT STATUS */
+	irqstatus &= ~(GPMC_IRQ_TERMCOUNT | GPMC_IRQ_FIFOEVENT);
+	writel(irqstatus, info->reg.gpmc_irqstatus);
+
+	/* Disable Interrupt generation */
+	irqenable = readl(info->reg.gpmc_irqenable);
+	irqenable &= ~(GPMC_IRQ_TERMCOUNT | GPMC_IRQ_FIFOEVENT);
+	writel(irqenable, info->reg.gpmc_irqenable);
 
 	return IRQ_HANDLED;
 }
@@ -626,6 +643,7 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
 	int ret = 0;
+	u32 irqenable;
 
 	if (len <= mtd->oobsize) {
 		omap_read_buf_pref(mtd, buf, len);
@@ -645,8 +663,10 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 
 	info->buf_len = len;
 
-	enable_irq(info->gpmc_irq_count);
-	enable_irq(info->gpmc_irq_fifo);
+	/* Enable Interrupt generation */
+	irqenable = readl(info->reg.gpmc_irqenable);
+	irqenable |= (GPMC_IRQ_FIFOEVENT | GPMC_IRQ_TERMCOUNT);
+	writel(irqenable, info->reg.gpmc_irqenable);
 
 	/* waiting for read to complete */
 	wait_for_completion(&info->comp);
@@ -676,6 +696,7 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 	int ret = 0;
 	unsigned long tim, limit;
 	u32 val;
+	u32 irqenable;
 
 	if (len <= mtd->oobsize) {
 		omap_write_buf_pref(mtd, buf, len);
@@ -695,8 +716,10 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 
 	info->buf_len = len;
 
-	enable_irq(info->gpmc_irq_count);
-	enable_irq(info->gpmc_irq_fifo);
+	/* Enable Interrupt generation */
+	irqenable = readl(info->reg.gpmc_irqenable);
+	irqenable |= (GPMC_IRQ_FIFOEVENT | GPMC_IRQ_TERMCOUNT);
+	writel(irqenable, info->reg.gpmc_irqenable);
 
 	/* waiting for write to complete */
 	wait_for_completion(&info->comp);
@@ -1771,35 +1794,18 @@ static int omap_nand_probe(struct platform_device *pdev)
 		break;
 
 	case NAND_OMAP_PREFETCH_IRQ:
-		info->gpmc_irq_fifo = platform_get_irq(pdev, 0);
-		if (info->gpmc_irq_fifo <= 0) {
-			dev_err(&pdev->dev, "error getting fifo irq\n");
-			err = -ENODEV;
-			goto return_error;
-		}
-		err = devm_request_irq(&pdev->dev, info->gpmc_irq_fifo,
-					omap_nand_irq, IRQF_SHARED,
-					"gpmc-nand-fifo", info);
-		if (err) {
-			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
-						info->gpmc_irq_fifo, err);
-			info->gpmc_irq_fifo = 0;
-			goto return_error;
-		}
-
-		info->gpmc_irq_count = platform_get_irq(pdev, 1);
-		if (info->gpmc_irq_count <= 0) {
-			dev_err(&pdev->dev, "error getting count irq\n");
-			err = -ENODEV;
+		info->gpmc_irq = platform_get_irq(pdev, 0);
+		if (info->gpmc_irq < 0) {
+			dev_err(&pdev->dev, "error getting GPMC irq\n");
+			err = info->gpmc_irq;
 			goto return_error;
 		}
-		err = devm_request_irq(&pdev->dev, info->gpmc_irq_count,
-					omap_nand_irq, IRQF_SHARED,
-					"gpmc-nand-count", info);
+		err = devm_request_irq(&pdev->dev, info->gpmc_irq,
+				       omap_nand_irq, IRQF_SHARED,
+				       DRIVER_NAME, info);
 		if (err) {
 			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
-						info->gpmc_irq_count, err);
-			info->gpmc_irq_count = 0;
+				info->gpmc_irq, err);
 			goto return_error;
 		}
 
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index 2dcef1c..c7d291c 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -11,9 +11,6 @@
 
 #define GPMC_CONFIG_WP		0x00000005
 
-#define GPMC_IRQ_FIFOEVENTENABLE	0x01
-#define GPMC_IRQ_COUNT_EVENT		0x02
-
 extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 			     struct gpmc_settings *gpmc_s,
 			     struct gpmc_device_timings *dev_t);
@@ -22,7 +19,7 @@ struct gpmc_nand_regs;
 struct device_node;
 
 extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
-extern int gpmc_get_client_irq(unsigned irq_config);
+extern int gpmc_get_irq(void);
 
 extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 090bbab..5a48a43 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -46,6 +46,8 @@ enum omap_ecc {
 
 struct gpmc_nand_regs {
 	void __iomem	*gpmc_status;
+	void __iomem	*gpmc_irqstatus;
+	void __iomem	*gpmc_irqenable;
 	void __iomem	*gpmc_nand_command;
 	void __iomem	*gpmc_nand_address;
 	void __iomem	*gpmc_nand_data;
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

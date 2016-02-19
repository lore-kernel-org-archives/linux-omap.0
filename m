From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 07/26] memory: omap-gpmc: Implement IRQ domain for NAND IRQs
Date: Fri, 19 Feb 2016 23:15:29 +0200
Message-ID: <1455916548-3441-8-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
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
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

GPMC provides 2 interrupts for NAND use. i.e. fifoevent and termcount.
Use IRQ domain for this. NAND device tree node can then
get the necessary interrupts by using gpmc as the interrupt parent.

Legacy boot uses gpmc_get_client_irq to get the
NAND interrupts from the GPMC IRQ domain.
Get rid of custom bitmasks and use IRQ domain for that
as well.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 246 ++++++++++++++++++++++++---------------------
 include/linux/omap-gpmc.h  |   5 +-
 2 files changed, 136 insertions(+), 115 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 695be32..d75f417 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -127,7 +128,6 @@
 #define GPMC_CONFIG_RDY_BSY	0x00000001
 #define GPMC_CONFIG_DEV_SIZE	0x00000002
 #define GPMC_CONFIG_DEV_TYPE	0x00000003
-#define GPMC_SET_IRQ_STATUS	0x00000004
 
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
@@ -176,8 +176,6 @@
 #define GPMC_CONFIG_WRITEPROTECT	0x00000010
 #define WR_RD_PIN_MONITORING		0x00600000
 
-#define GPMC_ENABLE_IRQ		0x0000000d
-
 /* ECC commands */
 #define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
 #define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
@@ -201,11 +199,6 @@ struct gpmc_cs_data {
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
@@ -233,9 +226,13 @@ struct omap3_gpmc_regs {
 	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
 };
 
-static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
-static struct irq_chip gpmc_irq_chip;
-static int gpmc_irq_start;
+struct gpmc_device {
+	struct device *dev;
+	int irq;
+	struct irq_chip irq_chip;
+};
+
+static struct irq_domain *gpmc_irq_domain;
 
 static struct resource	gpmc_mem_root;
 static struct gpmc_cs_data gpmc_cs[GPMC_CS_NUM];
@@ -243,8 +240,6 @@ static DEFINE_SPINLOCK(gpmc_mem_lock);
 /* Define chip-selects as reserved by default until probe completes */
 static unsigned int gpmc_cs_num = GPMC_CS_NUM;
 static unsigned int gpmc_nr_waitpins;
-static struct device *gpmc_dev;
-static int gpmc_irq;
 static resource_size_t phys_base, mem_size;
 static unsigned gpmc_capability;
 static void __iomem *gpmc_base;
@@ -1036,14 +1031,6 @@ int gpmc_configure(int cmd, int wval)
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
@@ -1133,85 +1120,97 @@ EXPORT_SYMBOL_GPL(gpmc_omap_get_nand_ops);
 
 int gpmc_get_client_irq(unsigned irq_config)
 {
-	int i;
-
-	if (hweight32(irq_config) > 1)
+	if (!gpmc_irq_domain) {
+		pr_warn("%s called before GPMC IRQ domain available\n",
+		__func__);
 		return 0;
+	}
 
-	for (i = 0; i < GPMC_NR_IRQ; i++)
-		if (gpmc_client_irq[i].bitmask & irq_config)
-			return gpmc_client_irq[i].irq;
+	if (irq_config >= GPMC_NR_IRQ)
+		return 0;
 
-	return 0;
+	return irq_create_mapping(gpmc_irq_domain, irq_config);
 }
 
-static int gpmc_irq_endis(unsigned irq, bool endis)
+static int gpmc_irq_endis(unsigned long hwirq, bool endis)
 {
-	int i;
 	u32 regval;
 
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
+	regval = gpmc_read_reg(GPMC_IRQENABLE);
+	if (endis)
+		regval |= BIT(hwirq);
+	else
+		regval &= ~BIT(hwirq);
+	gpmc_write_reg(GPMC_IRQENABLE, regval);
 
 	return 0;
 }
 
 static void gpmc_irq_disable(struct irq_data *p)
 {
-	gpmc_irq_endis(p->irq, false);
+	gpmc_irq_endis(p->hwirq, false);
 }
 
 static void gpmc_irq_enable(struct irq_data *p)
 {
-	gpmc_irq_endis(p->irq, true);
+	gpmc_irq_endis(p->hwirq, true);
 }
 
 static void gpmc_irq_noop(struct irq_data *data) { }
 
 static unsigned int gpmc_irq_noop_ret(struct irq_data *data) { return 0; }
 
-static int gpmc_setup_irq(void)
+static int gpmc_irq_map(struct irq_domain *d, unsigned int virq,
+			irq_hw_number_t hw)
 {
-	int i;
+	struct gpmc_device *gpmc = d->host_data;
+
+	irq_set_chip_data(virq, gpmc);
+	irq_set_chip_and_handler(virq, &gpmc->irq_chip, handle_simple_irq);
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOAUTOEN);
+
+	return 0;
+}
+
+static const struct irq_domain_ops gpmc_irq_domain_ops = {
+	.map    = gpmc_irq_map,
+	.xlate  = irq_domain_xlate_twocell,
+};
+
+static irqreturn_t gpmc_handle_irq(int irq, void *data)
+{
+	int hwirq, virq;
 	u32 regval;
+	struct gpmc_device *gpmc = data;
 
-	if (!gpmc_irq)
-		return -EINVAL;
+	regval = gpmc_read_reg(GPMC_IRQSTATUS);
 
-	gpmc_irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
-	if (gpmc_irq_start < 0) {
-		pr_err("irq_alloc_descs failed\n");
-		return gpmc_irq_start;
-	}
+	if (!regval)
+		return IRQ_NONE;
 
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
-		irq_modify_status(gpmc_client_irq[i].irq, IRQ_NOREQUEST,
-				  IRQ_NOAUTOEN);
+	for (hwirq = 0; hwirq < GPMC_NR_IRQ; hwirq++) {
+		if (regval & BIT(hwirq)) {
+			virq = irq_find_mapping(gpmc_irq_domain, hwirq);
+			if (!virq) {
+				dev_warn(gpmc->dev,
+					 "spurious irq detected hwirq %d, virq %d\n",
+					 hwirq, virq);
+			}
+
+			generic_handle_irq(virq);
+		}
 	}
 
+	gpmc_write_reg(GPMC_IRQSTATUS, regval);
+
+	return IRQ_HANDLED;
+}
+
+static int gpmc_setup_irq(struct gpmc_device *gpmc)
+{
+	u32 regval;
+	int rc;
+
 	/* Disable interrupts */
 	gpmc_write_reg(GPMC_IRQENABLE, 0);
 
@@ -1219,22 +1218,46 @@ static int gpmc_setup_irq(void)
 	regval = gpmc_read_reg(GPMC_IRQSTATUS);
 	gpmc_write_reg(GPMC_IRQSTATUS, regval);
 
-	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
+	gpmc->irq_chip.name = "gpmc";
+	gpmc->irq_chip.irq_startup = gpmc_irq_noop_ret;
+	gpmc->irq_chip.irq_enable = gpmc_irq_enable;
+	gpmc->irq_chip.irq_disable = gpmc_irq_disable;
+	gpmc->irq_chip.irq_shutdown = gpmc_irq_noop;
+	gpmc->irq_chip.irq_ack = gpmc_irq_noop;
+	gpmc->irq_chip.irq_mask = gpmc_irq_noop;
+	gpmc->irq_chip.irq_unmask = gpmc_irq_noop;
+
+	gpmc_irq_domain = irq_domain_add_linear(gpmc->dev->of_node,
+						GPMC_NR_IRQ,
+						&gpmc_irq_domain_ops,
+						gpmc);
+	if (!gpmc_irq_domain) {
+		dev_err(gpmc->dev, "IRQ domain add failed\n");
+		return -ENODEV;
+	}
+
+	rc = request_irq(gpmc->irq, gpmc_handle_irq, 0, "gpmc", gpmc);
+	if (rc) {
+		dev_err(gpmc->dev, "failed to request irq %d: %d\n",
+			gpmc->irq, rc);
+		irq_domain_remove(gpmc_irq_domain);
+		gpmc_irq_domain = NULL;
+	}
+
+	return rc;
 }
 
-static int gpmc_free_irq(void)
+static int gpmc_free_irq(struct gpmc_device *gpmc)
 {
-	int i;
+	int hwirq;
 
-	if (gpmc_irq)
-		free_irq(gpmc_irq, NULL);
+	free_irq(gpmc->irq, gpmc);
 
-	for (i = 0; i < GPMC_NR_IRQ; i++) {
-		irq_set_handler(gpmc_client_irq[i].irq, NULL);
-		irq_set_chip(gpmc_client_irq[i].irq, &no_irq_chip);
-	}
+	for (hwirq = 0; hwirq < GPMC_NR_IRQ; hwirq++)
+		irq_dispose_mapping(irq_find_mapping(gpmc_irq_domain, hwirq));
 
-	irq_free_descs(gpmc_irq_start, GPMC_NR_IRQ);
+	irq_domain_remove(gpmc_irq_domain);
+	gpmc_irq_domain = NULL;
 
 	return 0;
 }
@@ -2124,6 +2147,14 @@ static int gpmc_probe(struct platform_device *pdev)
 	int rc;
 	u32 l;
 	struct resource *res;
+	struct gpmc_device *gpmc;
+
+	gpmc = devm_kzalloc(&pdev->dev, sizeof(*gpmc), GFP_KERNEL);
+	if (!gpmc)
+		return -ENOMEM;
+
+	gpmc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, gpmc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL)
@@ -2137,15 +2168,16 @@ static int gpmc_probe(struct platform_device *pdev)
 		return PTR_ERR(gpmc_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL)
-		dev_warn(&pdev->dev, "Failed to get resource: irq\n");
-	else
-		gpmc_irq = res->start;
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get resource: irq\n");
+		return -ENOENT;
+	}
+
+	gpmc->irq = res->start;
 
 	gpmc_l3_clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(gpmc_l3_clk)) {
 		dev_err(&pdev->dev, "Failed to get GPMC fck\n");
-		gpmc_irq = 0;
 		return PTR_ERR(gpmc_l3_clk);
 	}
 
@@ -2157,8 +2189,6 @@ static int gpmc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	gpmc_dev = &pdev->dev;
-
 	l = gpmc_read_reg(GPMC_REVISION);
 
 	/*
@@ -2177,13 +2207,16 @@ static int gpmc_probe(struct platform_device *pdev)
 		gpmc_capability = GPMC_HAS_WR_ACCESS | GPMC_HAS_WR_DATA_MUX_BUS;
 	if (GPMC_REVISION_MAJOR(l) > 0x5)
 		gpmc_capability |= GPMC_HAS_MUX_AAD;
-	dev_info(gpmc_dev, "GPMC revision %d.%d\n", GPMC_REVISION_MAJOR(l),
+	dev_info(gpmc->dev, "GPMC revision %d.%d\n", GPMC_REVISION_MAJOR(l),
 		 GPMC_REVISION_MINOR(l));
 
 	gpmc_mem_init();
 
-	if (gpmc_setup_irq() < 0)
-		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
+	rc = gpmc_setup_irq(gpmc);
+	if (rc) {
+		dev_err(gpmc->dev, "gpmc_setup_irq failed\n");
+		goto fail;
+	}
 
 	if (!pdev->dev.of_node) {
 		gpmc_cs_num	 = GPMC_CS_NUM;
@@ -2192,21 +2225,27 @@ static int gpmc_probe(struct platform_device *pdev)
 
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
-		pm_runtime_put_sync(&pdev->dev);
-		dev_err(gpmc_dev, "failed to probe DT parameters\n");
-		return rc;
+		dev_err(gpmc->dev, "failed to probe DT parameters\n");
+		gpmc_free_irq(gpmc);
+		goto fail;
 	}
 
 	return 0;
+
+fail:
+	pm_runtime_put_sync(&pdev->dev);
+	return rc;
 }
 
 static int gpmc_remove(struct platform_device *pdev)
 {
-	gpmc_free_irq();
+	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
+
+	gpmc_free_irq(gpmc);
 	gpmc_mem_exit();
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	gpmc_dev = NULL;
+
 	return 0;
 }
 
@@ -2252,25 +2291,6 @@ static __exit void gpmc_exit(void)
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
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index 7de9f9b..f660e17 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -11,8 +11,9 @@
 
 #define GPMC_CONFIG_WP		0x00000005
 
-#define GPMC_IRQ_FIFOEVENTENABLE	0x01
-#define GPMC_IRQ_COUNT_EVENT		0x02
+/* IRQ numbers in GPMC IRQ domain for legacy boot use */
+#define GPMC_IRQ_FIFOEVENTENABLE	0
+#define GPMC_IRQ_COUNT_EVENT		1
 
 enum gpmc_nand_irq {
 	GPMC_NAND_IRQ_FIFOEVENT = 0,
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

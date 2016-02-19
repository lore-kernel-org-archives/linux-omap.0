From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 15/26] memory: omap-gpmc: Support WAIT pin edge interrupts
Date: Fri, 19 Feb 2016 23:15:37 +0200
Message-ID: <1455916548-3441-16-git-send-email-rogerq@ti.com>
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

OMAPs can have 2 to 4 WAITPINs that can be used as edge triggered
interrupts if not used for memory wait state insertion.

Support these interrupts via the gpmc IRQ domain.

The gpmc IRQ domain interrupt map is:

0 - NAND_fifoevent
1 - NAND_termcount
2 - GPMC_WAIT0 edge
3 - GPMC_WAIT1 edge, and so on

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../bindings/memory-controllers/omap-gpmc.txt      |   8 ++
 drivers/memory/omap-gpmc.c                         | 106 +++++++++++++++++----
 2 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
index 8113a52..f64b29c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
@@ -35,6 +35,14 @@ Required properties:
  - gpio-controller:	The GPMC driver implements a GPIO controller for the
 			GPMC WAIT pins that can be used as general purpose inputs.
 			0 maps to GPMC_WAIT0 pin.
+ - interrupt-controller: The GPMC driver implements and interrupt controller for
+			the NAND events "fifoevent" and "termcount" plus the
+			rising/falling edges on the GPMC_WAIT pins.
+			The interrupt number mapping is as follows
+			0 - NAND_fifoevent
+			1 - NAND_termcount
+			2 - GPMC_WAIT0 pin edge
+			3 - GPMC_WAIT1 pin edge, and so on.
 
 Timing properties for child nodes. All are optional and default to 0.
 
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index af2d57f..d958fb6 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -189,9 +189,7 @@
 #define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
 #define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
 
-/* XXX: Only NAND irq has been considered,currently these are the only ones used
- */
-#define	GPMC_NR_IRQ		2
+#define	GPMC_NR_NAND_IRQS	2 /* number of NAND specific IRQs */
 
 enum gpmc_clk_domain {
 	GPMC_CD_FCLK,
@@ -239,6 +237,7 @@ struct gpmc_device {
 	int irq;
 	struct irq_chip irq_chip;
 	struct gpio_chip gpio_chip;
+	int nirqs;
 };
 
 static struct irq_domain *gpmc_irq_domain;
@@ -1135,7 +1134,8 @@ int gpmc_get_client_irq(unsigned irq_config)
 		return 0;
 	}
 
-	if (irq_config >= GPMC_NR_IRQ)
+	/* we restrict this to NAND IRQs only */
+	if (irq_config >= GPMC_NR_NAND_IRQS)
 		return 0;
 
 	return irq_create_mapping(gpmc_irq_domain, irq_config);
@@ -1145,6 +1145,10 @@ static int gpmc_irq_endis(unsigned long hwirq, bool endis)
 {
 	u32 regval;
 
+	/* bits GPMC_NR_NAND_IRQS to 8 are reserved */
+	if (hwirq >= GPMC_NR_NAND_IRQS)
+		hwirq += 8 - GPMC_NR_NAND_IRQS;
+
 	regval = gpmc_read_reg(GPMC_IRQENABLE);
 	if (endis)
 		regval |= BIT(hwirq);
@@ -1165,9 +1169,64 @@ static void gpmc_irq_enable(struct irq_data *p)
 	gpmc_irq_endis(p->hwirq, true);
 }
 
-static void gpmc_irq_noop(struct irq_data *data) { }
+static void gpmc_irq_mask(struct irq_data *d)
+{
+	gpmc_irq_endis(d->hwirq, false);
+}
+
+static void gpmc_irq_unmask(struct irq_data *d)
+{
+	gpmc_irq_endis(d->hwirq, true);
+}
+
+static void gpmc_irq_edge_config(unsigned long hwirq, bool rising_edge)
+{
+	u32 regval;
+
+	/* NAND IRQs polarity is not configurable */
+	if (hwirq < GPMC_NR_NAND_IRQS)
+		return;
+
+	/* WAITPIN starts at BIT 8 */
+	hwirq += 8 - GPMC_NR_NAND_IRQS;
+
+	regval = gpmc_read_reg(GPMC_CONFIG);
+	if (rising_edge)
+		regval &= ~BIT(hwirq);
+	else
+		regval |= BIT(hwirq);
+
+	gpmc_write_reg(GPMC_CONFIG, regval);
+}
+
+static void gpmc_irq_ack(struct irq_data *d)
+{
+	unsigned hwirq = d->hwirq;
+
+	/* skip reserved bits */
+	if (hwirq >= GPMC_NR_NAND_IRQS)
+		hwirq += 8 - GPMC_NR_NAND_IRQS;
+
+	/* Setting bit to 1 clears (or Acks) the interrupt */
+	gpmc_write_reg(GPMC_IRQSTATUS, BIT(hwirq));
+}
+
+static int gpmc_irq_set_type(struct irq_data *d, unsigned trigger)
+{
+	/* can't set type for NAND IRQs */
+	if (d->hwirq < GPMC_NR_NAND_IRQS)
+		return -EINVAL;
+
+	/* We can support either rising or falling edge at a time */
+	if (trigger == IRQ_TYPE_EDGE_FALLING)
+		gpmc_irq_edge_config(d->hwirq, false);
+	else if (trigger == IRQ_TYPE_EDGE_RISING)
+		gpmc_irq_edge_config(d->hwirq, true);
+	else
+		return -EINVAL;
 
-static unsigned int gpmc_irq_noop_ret(struct irq_data *data) { return 0; }
+	return 0;
+}
 
 static int gpmc_irq_map(struct irq_domain *d, unsigned int virq,
 			irq_hw_number_t hw)
@@ -1175,8 +1234,14 @@ static int gpmc_irq_map(struct irq_domain *d, unsigned int virq,
 	struct gpmc_device *gpmc = d->host_data;
 
 	irq_set_chip_data(virq, gpmc);
-	irq_set_chip_and_handler(virq, &gpmc->irq_chip, handle_simple_irq);
-	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOAUTOEN);
+	if (hw < GPMC_NR_NAND_IRQS) {
+		irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOAUTOEN);
+		irq_set_chip_and_handler(virq, &gpmc->irq_chip,
+					 handle_simple_irq);
+	} else {
+		irq_set_chip_and_handler(virq, &gpmc->irq_chip,
+					 handle_edge_irq);
+	}
 
 	return 0;
 }
@@ -1189,16 +1254,21 @@ static const struct irq_domain_ops gpmc_irq_domain_ops = {
 static irqreturn_t gpmc_handle_irq(int irq, void *data)
 {
 	int hwirq, virq;
-	u32 regval;
+	u32 regval, regvalx;
 	struct gpmc_device *gpmc = data;
 
 	regval = gpmc_read_reg(GPMC_IRQSTATUS);
+	regvalx = regval;
 
 	if (!regval)
 		return IRQ_NONE;
 
-	for (hwirq = 0; hwirq < GPMC_NR_IRQ; hwirq++) {
-		if (regval & BIT(hwirq)) {
+	for (hwirq = 0; hwirq < gpmc->nirqs; hwirq++) {
+		/* skip reserved status bits */
+		if (hwirq == GPMC_NR_NAND_IRQS)
+			regvalx >>= 8 - GPMC_NR_NAND_IRQS;
+
+		if (regvalx & BIT(hwirq)) {
 			virq = irq_find_mapping(gpmc_irq_domain, hwirq);
 			if (!virq) {
 				dev_warn(gpmc->dev,
@@ -1228,16 +1298,15 @@ static int gpmc_setup_irq(struct gpmc_device *gpmc)
 	gpmc_write_reg(GPMC_IRQSTATUS, regval);
 
 	gpmc->irq_chip.name = "gpmc";
-	gpmc->irq_chip.irq_startup = gpmc_irq_noop_ret;
 	gpmc->irq_chip.irq_enable = gpmc_irq_enable;
 	gpmc->irq_chip.irq_disable = gpmc_irq_disable;
-	gpmc->irq_chip.irq_shutdown = gpmc_irq_noop;
-	gpmc->irq_chip.irq_ack = gpmc_irq_noop;
-	gpmc->irq_chip.irq_mask = gpmc_irq_noop;
-	gpmc->irq_chip.irq_unmask = gpmc_irq_noop;
+	gpmc->irq_chip.irq_ack = gpmc_irq_ack;
+	gpmc->irq_chip.irq_mask = gpmc_irq_mask;
+	gpmc->irq_chip.irq_unmask = gpmc_irq_unmask;
+	gpmc->irq_chip.irq_set_type = gpmc_irq_set_type;
 
 	gpmc_irq_domain = irq_domain_add_linear(gpmc->dev->of_node,
-						GPMC_NR_IRQ,
+						gpmc->nirqs,
 						&gpmc_irq_domain_ops,
 						gpmc);
 	if (!gpmc_irq_domain) {
@@ -1262,7 +1331,7 @@ static int gpmc_free_irq(struct gpmc_device *gpmc)
 
 	free_irq(gpmc->irq, gpmc);
 
-	for (hwirq = 0; hwirq < GPMC_NR_IRQ; hwirq++)
+	for (hwirq = 0; hwirq < gpmc->nirqs; hwirq++)
 		irq_dispose_mapping(irq_find_mapping(gpmc_irq_domain, hwirq));
 
 	irq_domain_remove(gpmc_irq_domain);
@@ -2264,6 +2333,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	if (rc)
 		goto gpio_init_failed;
 
+	gpmc->nirqs = GPMC_NR_NAND_IRQS + gpmc_nr_waitpins;
 	rc = gpmc_setup_irq(gpmc);
 	if (rc) {
 		dev_err(gpmc->dev, "gpmc_setup_irq failed\n");
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 08/10] ARM: OMAP2+: gpmc: Modify interrupt handling
Date: Mon, 4 Jun 2012 12:17:08 +0530
Message-ID: <df4cf7f1d1d12db969ca6ede29a0007271f51475.1338790118.git.afzal@ti.com>
References: <cover.1338790117.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48376 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab2FDHDC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 03:03:02 -0400
In-Reply-To: <cover.1338790117.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Modify interrupt handling such that interrupts can be handled by GPMC
client drivers using standard interrupt APIs rather than requiring
the drivers to have knowledge about GPMC interrupt handling. Currently
only NAND related interrupts has been considered (which is the case
even without this change) as the only user of GPMC interrupt is NAND.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |  136 ++++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 2 files changed, 120 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index a2c0588..578fd4c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -78,6 +78,15 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
+/* XXX: Only NAND irq has been considered,currently these are the only ones used
+ */
+#define	GPMC_NR_IRQ		2
+
+struct gpmc_client_irq	{
+	unsigned		irq;
+	u32			bitmask;
+};
+
 /* Structure to save gpmc cs context */
 struct gpmc_cs_config {
 	u32 config1;
@@ -105,6 +114,10 @@ struct omap3_gpmc_regs {
 	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
 };
 
+static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
+static struct irq_chip gpmc_irq_chip;
+static unsigned gpmc_irq_start;
+
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
@@ -702,6 +715,97 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 	reg->gpmc_bch_result0 = gpmc_base + GPMC_ECC_BCH_RESULT_0;
 }
 
+int gpmc_get_client_irq(unsigned irq_config)
+{
+	int i;
+
+	if (hweight32(irq_config) > 1)
+		return 0;
+
+	for (i = 0; i < GPMC_NR_IRQ; i++)
+		if (gpmc_client_irq[i].bitmask & irq_config)
+			return gpmc_client_irq[i].irq;
+
+	return 0;
+}
+
+static int gpmc_irq_endis(unsigned irq, bool endis)
+{
+	int i;
+	u32 regval;
+
+	for (i = 0; i < GPMC_NR_IRQ; i++)
+		if (irq == gpmc_client_irq[i].irq) {
+			regval = gpmc_read_reg(GPMC_IRQENABLE);
+			if (endis)
+				regval |= gpmc_client_irq[i].bitmask;
+			else
+				regval &= ~gpmc_client_irq[i].bitmask;
+			gpmc_write_reg(GPMC_IRQENABLE, regval);
+			break;
+		}
+
+	return 0;
+}
+
+static void gpmc_irq_disable(struct irq_data *p)
+{
+	gpmc_irq_endis(p->irq, false);
+}
+
+static void gpmc_irq_enable(struct irq_data *p)
+{
+	gpmc_irq_endis(p->irq, true);
+}
+
+static void gpmc_irq_noop(struct irq_data *data) { }
+
+static unsigned int gpmc_irq_noop_ret(struct irq_data *data) { return 0; }
+
+static int gpmc_setup_irq(int gpmc_irq)
+{
+	int i;
+	u32 regval;
+
+	if (!gpmc_irq)
+		return -EINVAL;
+
+	gpmc_irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
+	if (IS_ERR_VALUE(gpmc_irq_start)) {
+		pr_err("irq_alloc_descs failed\n");
+		return gpmc_irq_start;
+	}
+
+	gpmc_irq_chip.name = "gpmc";
+	gpmc_irq_chip.irq_startup = gpmc_irq_noop_ret;
+	gpmc_irq_chip.irq_enable = gpmc_irq_enable;
+	gpmc_irq_chip.irq_disable = gpmc_irq_disable;
+	gpmc_irq_chip.irq_shutdown = gpmc_irq_noop;
+	gpmc_irq_chip.irq_ack = gpmc_irq_noop;
+	gpmc_irq_chip.irq_mask = gpmc_irq_noop;
+	gpmc_irq_chip.irq_unmask = gpmc_irq_noop;
+
+	gpmc_client_irq[0].bitmask = GPMC_IRQ_FIFOEVENTENABLE;
+	gpmc_client_irq[1].bitmask = GPMC_IRQ_COUNT_EVENT;
+
+	for (i = 0; i < GPMC_NR_IRQ; i++) {
+		gpmc_client_irq[i].irq = gpmc_irq_start + i;
+		irq_set_chip_and_handler(gpmc_client_irq[i].irq,
+					&gpmc_irq_chip, handle_simple_irq);
+		set_irq_flags(gpmc_client_irq[i].irq,
+				IRQF_VALID | IRQF_NOAUTOEN);
+	}
+
+	/* Disable interrupts */
+	gpmc_write_reg(GPMC_IRQENABLE, 0);
+
+	/* clear interrupts */
+	regval = gpmc_read_reg(GPMC_IRQSTATUS);
+	gpmc_write_reg(GPMC_IRQSTATUS, regval);
+
+	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
+}
+
 static void __init gpmc_mem_init(void)
 {
 	int cs;
@@ -731,8 +835,8 @@ static void __init gpmc_mem_init(void)
 
 static int __init gpmc_init(void)
 {
-	u32 l, irq;
-	int cs, ret = -EINVAL;
+	u32 l;
+	int ret = -EINVAL;
 	int gpmc_irq;
 	char *ck = NULL;
 
@@ -780,16 +884,7 @@ static int __init gpmc_init(void)
 	gpmc_write_reg(GPMC_SYSCONFIG, l);
 	gpmc_mem_init();
 
-	/* initalize the irq_chained */
-	irq = OMAP_GPMC_IRQ_BASE;
-	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
-		irq_set_chip_and_handler(irq, &dummy_irq_chip,
-						handle_simple_irq);
-		set_irq_flags(irq, IRQF_VALID);
-		irq++;
-	}
-
-	ret = request_irq(gpmc_irq, gpmc_handle_irq, IRQF_SHARED, "gpmc", NULL);
+	ret = gpmc_setup_irq(gpmc_irq);
 	if (ret)
 		pr_err("gpmc: irq-%d could not claim: err %d\n",
 						gpmc_irq, ret);
@@ -799,12 +894,19 @@ postcore_initcall(gpmc_init);
 
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
-	u8 cs;
+	int i;
+	u32 regval;
+
+	regval = gpmc_read_reg(GPMC_IRQSTATUS);
+
+	if (!regval)
+		return IRQ_NONE;
+
+	for (i = 0; i < GPMC_NR_IRQ; i++)
+		if (regval & gpmc_client_irq[i].bitmask)
+			generic_handle_irq(gpmc_client_irq[i].irq);
 
-	/* check cs to invoke the irq */
-	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
-	if (OMAP_GPMC_IRQ_BASE+cs <= OMAP_GPMC_IRQ_END)
-		generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
+	gpmc_write_reg(GPMC_IRQSTATUS, regval);
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 06198a5..2e6e259 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -150,6 +150,7 @@ struct gpmc_nand_regs {
 };
 
 extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
+extern int gpmc_get_client_irq(unsigned irq_config);
 
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
 extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
-- 
1.7.10.2


From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: gpmc: Modify interrupt handling
Date: Tue, 15 May 2012 20:08:34 +0530
Message-ID: <d193f1d968843c2580006bf3cde51f951de13892.1337090835.git.afzal@ti.com>
References: <cover.1337090835.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39860 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104Ab2EOOzN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 10:55:13 -0400
In-Reply-To: <cover.1337090835.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com, dedekind1@gmail.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Modify interrupt handling such that interrupts can be handled by GPMC
client drivers using standard interrupt APIs rather than requiring
the drivers to have knowledge about GPMC interrupt handling. Currently
only NAND related interrupts has been considered (which is the case
even without this change) as the only user of GPMC interrupt is NAND.

This helps in smooth migration of GPMC to driver.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |  137 ++++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 2 files changed, 121 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index a409a3e..2b9aad1 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -78,6 +78,20 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
+/* TODO: Handle waitpin interrupts also. Present boards make use of only NAND
+ * interrupts, hence only NAND interrupts has been considered
+ */
+#define	GPMC_NR_IRQ		2
+
+struct gpmc_client_irq	{
+	unsigned		irq;
+	u32			bitmask;
+};
+
+static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
+static struct irq_chip gpmc_irq_chip;
+static unsigned gpmc_irq_start;
+
 /* Structure to save gpmc cs context */
 struct gpmc_cs_config {
 	u32 config1;
@@ -702,6 +716,97 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
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
@@ -731,8 +836,8 @@ static void __init gpmc_mem_init(void)
 
 static int __init gpmc_init(void)
 {
-	u32 l, irq;
-	int cs, ret = -EINVAL;
+	u32 l;
+	int ret = -EINVAL;
 	int gpmc_irq;
 	char *ck = NULL;
 
@@ -780,16 +885,7 @@ static int __init gpmc_init(void)
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
@@ -799,12 +895,19 @@ postcore_initcall(gpmc_init);
 
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
index 6a8078e..e6fa0cf 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -148,6 +148,7 @@ struct gpmc_nand_regs {
 };
 
 extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
+extern int gpmc_get_client_irq(unsigned irq_config);
 
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
 extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
-- 
1.7.10


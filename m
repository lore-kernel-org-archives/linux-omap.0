From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 08/22] memory: omap-gpmc: Add IRQ ops for GPMC-NAND interface
Date: Fri, 7 Aug 2015 12:12:18 +0300
Message-ID: <1438938752-31010-9-git-send-email-rogerq@ti.com>
References: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Provide functions to enable/disable NAND IRQs, get
NAND event status and clear NAND events.

The NAND events of interest are TERMCOUNT and FIFOEVENT.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/omap-gpmc.h  |  4 ++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index e70a8df..713d7af 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1078,8 +1078,58 @@ static bool gpmc_nand_writebuffer_empty(void)
 	return false;
 }
 
+static int gpmc_nand_irq_enable(enum gpmc_nand_irq irq)
+{
+	u32 reg;
+
+	if (irq > GPMC_NAND_IRQ_TERMCOUNT)
+		return -EINVAL;
+
+	reg = gpmc_read_reg(GPMC_IRQENABLE);
+	reg |= BIT(irq);
+	gpmc_write_reg(GPMC_IRQENABLE, reg);
+
+	return 0;
+}
+
+static int gpmc_nand_irq_disable(enum gpmc_nand_irq irq)
+{
+	u32 reg;
+
+	if (irq > GPMC_NAND_IRQ_TERMCOUNT)
+		return -EINVAL;
+
+	reg = gpmc_read_reg(GPMC_IRQENABLE);
+	reg &= ~BIT(irq);
+	gpmc_write_reg(GPMC_IRQENABLE, reg);
+
+	return 0;
+}
+
+static void gpmc_nand_irq_clear(enum gpmc_nand_irq irq)
+{
+	if (irq > GPMC_NAND_IRQ_TERMCOUNT)
+		return;
+
+	/* setting bit to 1 clears the bit in IRQSTATUS */
+	gpmc_write_reg(GPMC_IRQSTATUS, BIT(irq));
+}
+
+static u32 gpmc_nand_irq_status(void)
+{
+	u32 reg = gpmc_read_reg(GPMC_IRQSTATUS);
+
+	/* Mask out non-NAND bits */
+	reg &= GPMC_IRQENABLE_FIFOEVENT | GPMC_IRQENABLE_TERMCOUNT;
+	return reg;
+}
+
 static struct gpmc_nand_ops nand_ops = {
 	.nand_writebuffer_empty = gpmc_nand_writebuffer_empty,
+	.nand_irq_enable = gpmc_nand_irq_enable,
+	.nand_irq_disable = gpmc_nand_irq_disable,
+	.nand_irq_clear = gpmc_nand_irq_clear,
+	.nand_irq_status = gpmc_nand_irq_status,
 };
 
 /**
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index 44e322f..063a84f 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -11,6 +11,10 @@
 
 #define GPMC_CONFIG_WP		0x00000005
 
+/* GPMC IRQENABLE/IRQSTATUS BIT defs */
+#define GPMC_IRQENABLE_FIFOEVENT	BIT(0)
+#define GPMC_IRQENABLE_TERMCOUNT	BIT(1)
+
 enum gpmc_nand_irq {
 	GPMC_NAND_IRQ_FIFOEVENT = 0,
 	GPMC_NAND_IRQ_TERMCOUNT,
-- 
2.1.4

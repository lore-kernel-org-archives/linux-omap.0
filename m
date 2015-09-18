From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 08/27] memory: omap-gpmc: Add IRQ ops for GPMC-NAND
 interface
Date: Fri, 18 Sep 2015 17:53:30 +0300
Message-ID: <1442588029-13769-9-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, computersforpeace@gmail.com, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
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
index a9071bb..e75226d 100644
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
index 58f6bd2..b76cec3 100644
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


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

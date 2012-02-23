From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 4/5] ARM: OMAP2+: gpmc: Use irq_alloc_descs instead of static IRQ range
Date: Thu, 23 Feb 2012 23:23:20 +0100
Message-ID: <1330035801-14937-5-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54067 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080Ab2BWWXt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 17:23:49 -0500
In-Reply-To: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The gpmc code is still not a proper driver and is still using the bad old
static way of declaring its IRQ range for the various CS it can handle (8).

Use irq_alloc_descs to get dynamically a set of IRQ descriptors.
Clean some bad line wrapping here and there.

Please note that this code is still not a real driver after this fix, and
will require a massive cleanup...

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index dfffbbf..95ea50a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -103,6 +103,8 @@ static struct clk *gpmc_l3_clk;
 
 static irqreturn_t gpmc_handle_irq(int irq, void *dev);
 
+static int irq_base;
+
 static void gpmc_write_reg(int idx, u32 val)
 {
 	__raw_writel(val, gpmc_base + idx);
@@ -747,7 +749,13 @@ static int __init gpmc_init(void)
 	gpmc_mem_init();
 
 	/* initalize the irq_chained */
-	irq = OMAP_GPMC_IRQ_BASE;
+	irq_base = irq_alloc_descs(-1, 0, GPMC_CS_NUM, 0);
+	if (irq_base < 0) {
+		pr_err("%s() Couldn't allocate IRQs\n", __func__);
+		return -ENODEV;
+	}
+
+	irq = irq_base;
 	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
 		irq_set_chip_and_handler(irq, &dummy_irq_chip,
 						handle_simple_irq);
@@ -755,11 +763,11 @@ static int __init gpmc_init(void)
 		irq++;
 	}
 
-	ret = request_irq(gpmc_irq,
-			gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base);
+	ret = request_irq(gpmc_irq, gpmc_handle_irq, IRQF_SHARED, "gpmc",
+			  gpmc_base);
 	if (ret)
-		pr_err("gpmc: irq-%d could not claim: err %d\n",
-						gpmc_irq, ret);
+		pr_err("gpmc: irq-%d could not claim: err %d\n", gpmc_irq, ret);
+
 	return ret;
 }
 postcore_initcall(gpmc_init);
@@ -770,8 +778,8 @@ static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 
 	/* check cs to invoke the irq */
 	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
-	if (OMAP_GPMC_IRQ_BASE+cs <= OMAP_GPMC_IRQ_END)
-		generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
+	if (cs <= GPMC_CS_NUM)
+		generic_handle_irq(irq_base + cs);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.4


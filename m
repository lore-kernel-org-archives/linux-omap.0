From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/14] dmaengine: ti: omap-dma: Use cpu notifier to block idle
 for omap2
Date: Mon, 16 Dec 2019 16:19:23 -0800
Message-ID: <20191217001925.44558-13-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

For omap2, we need to block idle if SDMA is busy. Let's do this with a
cpu notifier and remove the custom call.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm24xx.c | 22 +++++++++----------
 drivers/dma/ti/omap-dma.c    | 41 +++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -83,8 +83,6 @@ static int omap2_enter_full_retention(void)
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
 	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
 
-	cpu_cluster_pm_enter();
-
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
 	if (omap_irq_pending())
@@ -96,8 +94,6 @@ static int omap2_enter_full_retention(void)
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
 no_sleep:
-	cpu_cluster_pm_exit();
-
 	clk_enable(osc_ck);
 
 	/* clear CORE wake-up events */
@@ -162,25 +158,27 @@ static int omap2_can_sleep(void)
 		return 0;
 	if (__clk_is_enabled(osc_ck))
 		return 0;
-	if (omap_dma_running())
-		return 0;
 
 	return 1;
 }
 
 static void omap2_pm_idle(void)
 {
-	if (!omap2_can_sleep()) {
-		if (omap_irq_pending())
-			return;
-		omap2_enter_mpu_retention();
-		return;
-	}
+	int error;
 
 	if (omap_irq_pending())
 		return;
 
+	error = cpu_cluster_pm_enter();
+	if (error || !omap2_can_sleep()) {
+		omap2_enter_mpu_retention();
+		goto out_cpu_cluster_pm;
+	}
+
 	omap2_enter_full_retention();
+
+out_cpu_cluster_pm:
+	cpu_cluster_pm_exit();
 }
 
 static void __init prcm_setup_regs(void)
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -27,6 +27,7 @@
 struct omap_dma_config {
 	int lch_end;
 	unsigned int rw_priority:1;
+	unsigned int needs_busy_check:1;
 	unsigned int may_lose_context:1;
 	unsigned int needs_lch_clear:1;
 };
@@ -1521,6 +1522,40 @@ static void omap_dma_free(struct omap_dmadev *od)
 	}
 }
 
+/* Currently only used for omap2. For omap1, also a check for lcd_dma is needed */
+static int omap_dma_busy_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v)
+{
+	struct omap_dmadev *od;
+	struct omap_chan *c;
+	int lch = -1;
+
+	od = container_of(nb, struct omap_dmadev, nb);
+
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		while (1) {
+			lch = find_next_bit(od->lch_bitmap, od->lch_count,
+					    lch + 1);
+			if (lch >= od->lch_count)
+				break;
+			c = od->lch_map[lch];
+			if (!c)
+				continue;
+			if (omap_dma_chan_read(c, CCR) & CCR_ENABLE) {
+				pr_info("XXX %s: lch%i busy\n", __func__, lch);
+				return NOTIFY_BAD;
+			}
+		}
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 /*
  * We are using IRQENABLE_L1, and legacy DMA code was using IRQENABLE_L0.
  * As the DSP may be using IRQENABLE_L2 and L3, let's not touch those for
@@ -1778,7 +1813,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 	omap_dma_init_gcr(od, DMA_DEFAULT_ARB_RATE, DMA_DEFAULT_FIFO_DEPTH, 0);
 
-	if (od->cfg->may_lose_context) {
+	if (od->cfg->needs_busy_check) {
+		od->nb.notifier_call = omap_dma_busy_notifier;
+		cpu_pm_register_notifier(&od->nb);
+	} else if (od->cfg->may_lose_context) {
 		od->nb.notifier_call = omap_dma_context_notifier;
 		cpu_pm_register_notifier(&od->nb);
 	}
@@ -1822,6 +1860,7 @@ static const struct omap_dma_config omap2420_data = {
 	.lch_end = CCFN,
 	.rw_priority = true,
 	.needs_lch_clear = true,
+	.needs_busy_check = true,
 };
 
 static const struct omap_dma_config omap2430_data = {
-- 
2.24.1

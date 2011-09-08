From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 07/12] OMAP: dmtimer: pm_runtime support
Date: Fri, 9 Sep 2011 02:38:13 +0530
Message-ID: <1315516098-29761-8-git-send-email-tarun.kanti@ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add pm_runtime feature to dmtimer whereby *_runtime_get_sync()
is called within omap_dm_timer_enable(), pm_runtime_put()
is called in omap_dm_timer_disable(). In addition to calling
pm_runtime_enable, we are calling pm_runtime_irq_safe so that
they can be called from interrupt context.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   33 ++++++++--------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 854e735..39751f9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/dmtimer.h>
 
@@ -209,33 +210,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (timer->enabled)
-		return;
-
-	if (!pdata->needs_manual_reset) {
-		clk_enable(timer->fclk);
-		clk_enable(timer->iclk);
-	}
-
-	timer->enabled = 1;
+	pm_runtime_get_sync(&timer->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (!timer->enabled)
-		return;
-
-	if (!pdata->needs_manual_reset) {
-		clk_disable(timer->iclk);
-		clk_disable(timer->fclk);
-	}
-
-	timer->enabled = 0;
+	pm_runtime_put(&timer->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
@@ -475,7 +456,7 @@ int omap_dm_timers_active(void)
 	struct omap_dm_timer *timer;
 
 	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->enabled)
+		if (!timer->reserved)
 			continue;
 
 		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
@@ -550,6 +531,12 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
+	/* Skip pm_runtime_enable for OMAP1 */
+	if (!pdata->needs_manual_reset) {
+		pm_runtime_enable(&pdev->dev);
+		pm_runtime_irq_safe(&pdev->dev);
+	}
+
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index fc086ce..5368140 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -239,7 +239,6 @@ struct omap_dm_timer {
 	void __iomem *io_base;
 	unsigned long rate;
 	unsigned reserved:1;
-	unsigned enabled:1;
 	unsigned posted:1;
 	u8 func_offset;
 	u8 intr_offset;
-- 
1.7.0.4

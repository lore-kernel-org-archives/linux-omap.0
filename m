From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 09/12] OMAP: dmtimer: mark clocksource and clockevent
	timers reserved
Date: Fri, 9 Sep 2011 02:38:15 +0530
Message-ID: <1315516098-29761-10-git-send-email-tarun.kanti@ti.com>
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
Cc: khilman@ti.com, tony@atomide.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In driver probe use sys_timer_reserved to identify which all timers
have already been used for clocksource and clockevent. Mark all those
timers as reserved so that no one else can use them.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 39751f9..6312dfb 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -531,12 +531,17 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
-	/* Skip pm_runtime_enable for OMAP1 */
-	if (!pdata->needs_manual_reset) {
-		pm_runtime_enable(&pdev->dev);
-		pm_runtime_irq_safe(&pdev->dev);
-	}
-
+/*
+ * sys_timer_reserved is not defined for OMAP1.
+ * Use the macro to avoid compilation error on OMAP1.
+ */
+#if defined(CONFIG_ARCH_OMAP2PLUS)
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
+	/* Mark clocksource and clockevent timers as reserved */
+	if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
+		timer->reserved = 1;
+#endif
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
-- 
1.7.0.4

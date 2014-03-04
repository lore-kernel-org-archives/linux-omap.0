From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] drivers: bus: omap_l3: Convert to use devm_request_irq()
Date: Tue, 4 Mar 2014 11:01:48 +0200
Message-ID: <1393923710-10377-4-git-send-email-peter.ujfalusi@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With this we can remove the free_irq() calls from probe and remove.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>
---
 drivers/bus/omap_l3_noc.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index ca95d3db5055..2bbc87bdea2b 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -159,9 +159,8 @@ static int omap4_l3_probe(struct platform_device *pdev)
 	 * Setup interrupt Handlers
 	 */
 	l3->debug_irq = platform_get_irq(pdev, 0);
-	ret = request_irq(l3->debug_irq,
-			l3_interrupt_handler,
-			IRQF_DISABLED, "l3-dbg-irq", l3);
+	ret = devm_request_irq(&pdev->dev, l3->debug_irq, l3_interrupt_handler,
+			       IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
 						l3->debug_irq);
@@ -169,29 +168,17 @@ static int omap4_l3_probe(struct platform_device *pdev)
 	}
 
 	l3->app_irq = platform_get_irq(pdev, 1);
-	ret = request_irq(l3->app_irq,
-			l3_interrupt_handler,
-			IRQF_DISABLED, "l3-app-irq", l3);
-	if (ret) {
+	ret = devm_request_irq(&pdev->dev, l3->app_irq, l3_interrupt_handler,
+			       IRQF_DISABLED, "l3-app-irq", l3);
+	if (ret)
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
 						l3->app_irq);
-		goto err4;
-	}
-
-	return 0;
 
-err4:
-	free_irq(l3->debug_irq, l3);
 	return ret;
 }
 
 static int omap4_l3_remove(struct platform_device *pdev)
 {
-	struct omap4_l3 *l3 = platform_get_drvdata(pdev);
-
-	free_irq(l3->app_irq, l3);
-	free_irq(l3->debug_irq, l3);
-
 	return 0;
 }
 
-- 
1.9.0

From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/07] dma: rework dw_dmac
	suspend_late()/resume_early()
Date: Wed, 24 Jun 2009 18:23:24 +0900
Message-ID: <20090624092324.14276.5263.sendpatchset@rx1.opensource.se>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, akpm@linux-foundation.org, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for dw_dmac from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested and not test compiled due to lack of cross compiler.

 drivers/dma/dw_dmac.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- 0001/drivers/dma/dw_dmac.c
+++ work/drivers/dma/dw_dmac.c	2009-06-01 16:31:34.000000000 +0900
@@ -1399,8 +1399,9 @@ static void dw_shutdown(struct platform_
 	clk_disable(dw->clk);
 }
 
-static int dw_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+static int dw_suspend_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_dma	*dw = platform_get_drvdata(pdev);
 
 	dw_dma_off(platform_get_drvdata(pdev));
@@ -1408,23 +1409,27 @@ static int dw_suspend_late(struct platfo
 	return 0;
 }
 
-static int dw_resume_early(struct platform_device *pdev)
+static int dw_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_dma	*dw = platform_get_drvdata(pdev);
 
 	clk_enable(dw->clk);
 	dma_writel(dw, CFG, DW_CFG_DMA_EN);
 	return 0;
-
 }
 
+static struct dev_pm_ops dw_dev_pm_ops = {
+	.suspend_noirq = dw_suspend_noirq,
+	.resume_noirq = dw_resume_noirq,
+};
+
 static struct platform_driver dw_driver = {
 	.remove		= __exit_p(dw_remove),
 	.shutdown	= dw_shutdown,
-	.suspend_late	= dw_suspend_late,
-	.resume_early	= dw_resume_early,
 	.driver = {
 		.name	= "dw_dmac",
+		.pm	= &dw_dev_pm_ops,
 	},
 };
 

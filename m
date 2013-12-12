From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Thu, 12 Dec 2013 15:45:55 -0600
Message-ID: <1386884755-12366-1-git-send-email-balbi@ti.com>
References: <20131212214306.GS1939@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131212214306.GS1939@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, w-kwok2@ti.com, Felipe Balbi <balbi@ti.com>, kgene.kim@samsung.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

A bare-minimum PM implementation which will
server as building block for more complex
PM implementation in the future.

At the least will not leave clocks on unnecessarily
when e.g.  a user write mem to /sys/power/state.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

improve error path a little bit.

 drivers/usb/dwc3/dwc3-keystone.c | 94 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 1fad161..3b3761c 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
 
@@ -118,13 +119,22 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
 
-	error = clk_prepare_enable(kdwc->clk);
+	error = clk_prepare(kdwc->clk);
 	if (error < 0) {
 		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
 			error);
 		return error;
 	}
 
+	pm_runtime_enable(dev);
+
+	error = pm_runtime_get_sync(dev);
+	if (error < 0) {
+		dev_dbg(dev, "unable to pm_runtime_get_sync(), err %d\n",
+				error);
+		goto err_irq;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing irq\n");
@@ -151,8 +161,11 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 err_core:
 	kdwc3_disable_irqs(kdwc);
+
 err_irq:
-	clk_disable_unprepare(kdwc->clk);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	clk_unprepare(kdwc->clk);
 
 	return error;
 }
@@ -172,7 +185,9 @@ static int kdwc3_remove(struct platform_device *pdev)
 
 	kdwc3_disable_irqs(kdwc);
 	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
-	clk_disable_unprepare(kdwc->clk);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(kdwc->clk);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
@@ -184,6 +199,79 @@ static const struct of_device_id kdwc3_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, kdwc3_of_match);
 
+static int __kdwc3_suspend(struct dwc3_keystone *kdwc)
+{
+	clk_disable(kdwc->clk);
+
+	return 0;
+}
+
+static int __kdwc3_resume(struct dwc3_keystone *kdwc)
+{
+	return clk_enable(kdwc->clk);
+}
+
+static int kdwc3_prepare(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+
+	kdwc3_disable_irqs(kdwc);
+
+	return 0;
+}
+
+static void kdwc3_complete(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+
+	kdwc3_enable_irqs(kdwc);
+}
+
+static int kdwc3_suspend(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+
+	return __kdwc3_suspend(kdwc);
+}
+
+static int kdwc3_resume(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+	int			ret;
+
+	ret = __kdwc3_resume(kdwc);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int kdwc3_runtime_suspend(struct device *dev)
+{
+	struct dwc3_keystone *kdwc = dev_get_drvdata(dev);
+
+	return __kdwc3_suspend(kdwc);
+}
+
+static int kdwc3_runtime_resume(struct device *dev)
+{
+	struct dwc3_keystone *kdwc = dev_get_drvdata(dev);
+
+	return __kdwc3_resume(kdwc);
+}
+
+static const struct dev_pm_ops kdwc3_dev_pm_ops = {
+	.prepare	= kdwc3_prepare,
+	.complete	= kdwc3_complete,
+
+	SET_SYSTEM_SLEEP_PM_OPS(kdwc3_suspend, kdwc3_resume)
+	SET_RUNTIME_PM_OPS(kdwc3_runtime_suspend, kdwc3_runtime_resume, NULL)
+};
+
 static struct platform_driver kdwc3_driver = {
 	.probe		= kdwc3_probe,
 	.remove		= kdwc3_remove,
-- 
1.8.4.GIT

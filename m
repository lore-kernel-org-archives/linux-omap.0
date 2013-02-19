From: Philip Avinash <avinashphilip@ti.com>
Subject: [PATCH v3 3/3] mtd: devices: elm: Low power transition support
Date: Tue, 19 Feb 2013 18:20:19 +0530
Message-ID: <1361278219-23108-4-git-send-email-avinashphilip@ti.com>
References: <1361278219-23108-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361278219-23108-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@ti.com, tony@atomide.com, linux@arm.linux.org.uk, dwmw2@infradead.org
Cc: afzal@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, hvaibhav@ti.com, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

In low power modes of AM335X platforms, peripherals power is cut off.
This patch supports low power sleep transition support for ELM driver.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
Changes Since v2:
	- Removes wait queue mechanism. The order of device creation ensures
	  that nand driver got suspended well before elm module suspend.
	  Hence no need to check elm module state on suspend.

 drivers/mtd/devices/elm.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index f034239..a41c968 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/sched.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/elm.h>
 
@@ -379,6 +380,23 @@ static int elm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int elm_suspend(struct device *dev)
+{
+	pm_runtime_put_sync(dev);
+	return 0;
+}
+
+static int elm_resume(struct device *dev)
+{
+	struct elm_info *info = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(dev);
+	elm_config(dev, info->bch_type);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(elm_pm_ops, elm_suspend, elm_resume);
+
 #ifdef CONFIG_OF
 static const struct of_device_id elm_of_match[] = {
 	{ .compatible = "ti,am3352-elm" },
@@ -392,6 +410,7 @@ static struct platform_driver elm_driver = {
 		.name	= "elm",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(elm_of_match),
+		.pm	= &elm_pm_ops,
 	},
 	.probe	= elm_probe,
 	.remove	= elm_remove,
-- 
1.7.9.5

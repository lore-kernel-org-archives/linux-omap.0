From: Philip Avinash <avinashphilip@ti.com>
Subject: [PATCH v2 3/4] mtd: devices: elm: Low power transition support
Date: Thu, 7 Feb 2013 18:06:57 +0530
Message-ID: <1360240618-11094-4-git-send-email-avinashphilip@ti.com>
References: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@ti.com, tony@atomide.com, linux@arm.linux.org.uk, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com
Cc: afzal@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, hvaibhav@ti.com, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

In low power modes of AM335X platforms, peripherals power is cut off.
This patch supports low power sleep transition support for ELM driver.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 drivers/mtd/devices/elm.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index f034239..a9ac8f2 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/sched.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/elm.h>
 
@@ -62,6 +63,7 @@ struct elm_info {
 	struct completion elm_completion;
 	struct list_head list;
 	enum bch_ecc bch_type;
+	bool idle;
 };
 
 static LIST_HEAD(elm_devices);
@@ -86,9 +88,11 @@ void elm_config(struct device *dev, enum bch_ecc bch_type)
 	u32 reg_val;
 	struct elm_info *info = dev_get_drvdata(dev);
 
+	info->idle = true;
 	reg_val = (bch_type & ECC_BCH_LEVEL_MASK) | (ELM_ECC_SIZE << 16);
 	elm_write_reg(info, ELM_LOCATION_CONFIG, reg_val);
 	info->bch_type = bch_type;
+	info->idle = false;
 }
 EXPORT_SYMBOL(elm_config);
 
@@ -280,6 +284,7 @@ void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
 	struct elm_info *info = dev_get_drvdata(dev);
 	u32 reg_val;
 
+	info->idle = true;
 	/* Enable page mode interrupt */
 	reg_val = elm_read_reg(info, ELM_IRQSTATUS);
 	elm_write_reg(info, ELM_IRQSTATUS, reg_val & INTR_STATUS_PAGE_VALID);
@@ -298,6 +303,7 @@ void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
 	reg_val = elm_read_reg(info, ELM_IRQENABLE);
 	elm_write_reg(info, ELM_IRQENABLE, reg_val & ~INTR_EN_PAGE_MASK);
 	elm_error_correction(info, err_vec);
+	info->idle = false;
 }
 EXPORT_SYMBOL(elm_decode_bch_error_page);
 
@@ -368,6 +374,7 @@ static int elm_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&info->list);
 	list_add(&info->list, &elm_devices);
 	platform_set_drvdata(pdev, info);
+	info->idle = false;
 	return ret;
 }
 
@@ -379,6 +386,38 @@ static int elm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int elm_suspend(struct device *dev)
+{
+	struct elm_info *info = dev_get_drvdata(dev);
+	wait_queue_head_t wq;
+	DECLARE_WAITQUEUE(wait, current);
+
+	init_waitqueue_head(&wq);
+	while (1) {
+		/* Make sure that ELM not running */
+		if (info->idle) {
+			add_wait_queue(&wq, &wait);
+			schedule();
+			remove_wait_queue(&wq, &wait);
+		} else {
+			break;
+		}
+	}
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
@@ -392,6 +431,7 @@ static struct platform_driver elm_driver = {
 		.name	= "elm",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(elm_of_match),
+		.pm	= &elm_pm_ops,
 	},
 	.probe	= elm_probe,
 	.remove	= elm_remove,
-- 
1.7.9.5

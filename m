From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 6/9] wlcore: add initial device tree support to the sdio
 module
Date: Tue, 2 Jul 2013 17:55:45 +0300
Message-ID: <1372776948-24840-7-git-send-email-coelho@ti.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1372776948-24840-1-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: coelho-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If platform data is not available, try to get the required information
from the device tree.  Register an OF match table and parse the
appropriate device tree nodes.

Parse interrupt property only, for now.

Signed-off-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c |   69 ++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 4c7e8ac..9370d7e 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -30,7 +30,7 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
-#include <linux/gpio.h>
+#include <linux/of_irq.h>
 #include <linux/wl12xx.h>
 #include <linux/pm_runtime.h>
 #include <linux/printk.h>
@@ -214,6 +214,43 @@ static struct wl1271_if_operations sdio_ops = {
 	.set_block_size = wl1271_sdio_set_block_size,
 };
 
+static struct wl12xx_platform_data *wlcore_get_pdata_from_of(struct device *dev)
+{
+	struct wl12xx_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+
+	if (!np) {
+		np = of_find_matching_node(NULL, dev->driver->of_match_table);
+		if (!np) {
+			dev_notice(dev, "device tree node not available\n");
+			pdata = ERR_PTR(-ENODEV);
+			goto out;
+		}
+	}
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "can't allocate platform data\n");
+		pdata = ERR_PTR(-ENODEV);
+		goto out;
+	}
+
+	pdata->irq = irq_of_parse_and_map(np, 0);
+	if (pdata->irq < 0) {
+		dev_err(dev, "can't get interrupt gpio from the device tree\n");
+		goto out_free;
+	}
+
+	goto out;
+
+out_free:
+	kfree(pdata);
+	pdata = ERR_PTR(-ENODEV);
+
+out:
+	return pdata;
+}
+
 static int wl1271_probe(struct sdio_func *func,
 				  const struct sdio_device_id *id)
 {
@@ -248,11 +285,22 @@ static int wl1271_probe(struct sdio_func *func,
 	/* Use block mode for transferring over one block size of data */
 	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 
+	/* The pdata allocated here is freed when the device is freed,
+	 * so we don't need an additional out label to free it in case
+	 * of error further on.
+	 */
+
+	/* Try to get legacy platform data from the board file */
 	pdev_data->pdata = wl12xx_get_platform_data();
 	if (IS_ERR(pdev_data->pdata)) {
-		ret = PTR_ERR(pdev_data->pdata);
-		dev_err(glue->dev, "missing wlan platform data: %d\n", ret);
-		goto out_free_glue;
+		dev_info(&func->dev,
+			 "legacy platform data not found, trying device tree\n");
+
+		pdev_data->pdata = wlcore_get_pdata_from_of(&func->dev);
+		if (IS_ERR(pdev_data->pdata)) {
+			dev_err(&func->dev, "can't get platform data\n");
+			goto out_free_glue;
+		}
 	}
 
 	/* if sdio can keep power while host is suspended, enable wow */
@@ -386,16 +434,25 @@ static const struct dev_pm_ops wl1271_sdio_pm_ops = {
 };
 #endif
 
+static const struct of_device_id wlcore_sdio_of_match_table[] = {
+	{ .compatible = "ti,wilink6" },
+	{ .compatible = "ti,wilink7" },
+	{ .compatible = "ti,wilink8" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wlcore_sdio_of_match_table);
+
 static struct sdio_driver wl1271_sdio_driver = {
 	.name		= "wl1271_sdio",
 	.id_table	= wl1271_devices,
 	.probe		= wl1271_probe,
 	.remove		= wl1271_remove,
-#ifdef CONFIG_PM
 	.drv = {
+#ifdef CONFIG_PM
 		.pm = &wl1271_sdio_pm_ops,
-	},
 #endif
+		.of_match_table = of_match_ptr(wlcore_sdio_of_match_table),
+	},
 };
 
 static int __init wl1271_init(void)
-- 
1.7.10.4

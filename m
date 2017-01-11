From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v2 3/3] can: ti_hecc: Add DT support for TI HECC module
Date: Wed, 11 Jan 2017 15:05:21 +0100
Message-ID: <1484143521-4898-4-git-send-email-yegorslists@googlemail.com>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484143521-4898-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

These patch set adds device tree support for TI HECC module.

Signed-off-by: Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
Changes v1 -> v2:
	- change compatible to "ti,am3505"
	- remove CONFIG_OF
	- don't set int_line to 0 explicitly

 drivers/net/can/ti_hecc.c | 54 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 680d1ff..fd3d9fc 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -46,6 +46,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
@@ -872,19 +874,62 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
 	.ndo_change_mtu		= can_change_mtu,
 };
 
+static const struct of_device_id ti_hecc_dt_ids[] = {
+	{
+		.compatible = "ti,am3505",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_hecc_dt_ids);
+
+static struct ti_hecc_platform_data *hecc_parse_dt(struct device *dev)
+{
+	struct ti_hecc_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+
+	pdata = devm_kzalloc(dev, sizeof(struct ti_hecc_platform_data), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_property_read_u32(np, "ti,scc-ram-offset", &pdata->scc_ram_offset)) {
+		dev_err(dev, "Missing scc-ram-offset property in the DT.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(np, "ti,hecc-ram-offset", &pdata->hecc_ram_offset)) {
+		dev_err(dev, "Missing hecc-ram-offset property in the DT.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(np, "ti,mbx-offset", &pdata->mbx_offset)) {
+		dev_err(dev, "Missing mbx-offset property in the DT.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	of_property_read_u32(dev->of_node, "ti,int-line", &pdata->int_line);
+
+	return pdata;
+}
+
 static int ti_hecc_probe(struct platform_device *pdev)
 {
 	struct net_device *ndev = (struct net_device *)0;
 	struct ti_hecc_priv *priv;
-	struct ti_hecc_platform_data *pdata;
+	struct ti_hecc_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct resource *mem, *irq;
 	void __iomem *addr;
 	int err = -ENODEV;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata && np) {
+		pdata = hecc_parse_dt(&pdev->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
 	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		goto probe_exit;
+		dev_err(&pdev->dev, "Platform data missing\n");
+		return -EINVAL;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1037,6 +1082,7 @@ static int ti_hecc_resume(struct platform_device *pdev)
 static struct platform_driver ti_hecc_driver = {
 	.driver = {
 		.name    = DRV_NAME,
+		.of_match_table = ti_hecc_dt_ids,
 	},
 	.probe = ti_hecc_probe,
 	.remove = ti_hecc_remove,
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

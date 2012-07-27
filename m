From: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 05/11] usb: musb: dsps: add dt support
Date: Fri, 27 Jul 2012 14:02:01 +0530
Message-ID: <1343377927-7850-5-git-send-email-ravibabu@ti.com>
References: <1343377927-7850-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343377927-7850-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Added device tree support for dsps musb glue driver and updated the
Documentation with device tree binding information.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/usb/am33xx-usb.txt         |   14 +++++
 drivers/usb/musb/musb_dsps.c                       |   60 +++++++++++++++++---
 2 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/am33xx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
new file mode 100644
index 0000000..ca8fa56
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -0,0 +1,14 @@
+AM33XX MUSB GLUE
+ - compatible : Should be "ti,musb-am33xx"
+ - ti,hwmods : must be "usb_otg_hs"
+ - multipoint : Should be "1" indicating the musb controller supports
+   multipoint. This is a MUSB configuration-specific setting.
+ - num_eps : Specifies the number of endpoints. This is also a
+   MUSB configuration-specific setting. Should be set to "16"
+ - ram_bits : Specifies the ram address size. Should be set to "12"
+ - port0_mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
+   represents PERIPHERAL.
+ - port1_mode : Should be "1" to represent HOST. "3" signifies OTG and "2"
+   represents PERIPHERAL.
+ - power : Should be "250". This signifies the controller can supply upto
+   500mA when operating in host mode.
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 4fcfa1a..67d1f00 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -31,6 +31,7 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -45,6 +46,10 @@
 
 #include "musb_core.h"
 
+#ifdef CONFIG_OF
+static const struct of_device_id musb_dsps_of_match[];
+#endif
+
 /**
  * avoid using musb_readx()/musb_writex() as glue layer should not be
  * dependent on musb core layer symbols.
@@ -501,6 +506,8 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	struct device *dev = glue->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct musb_hdrc_platform_data  *pdata = dev->platform_data;
+	struct device_node *np = pdev->dev.of_node;
+	struct musb_hdrc_config	*config;
 	struct platform_device	*musb;
 	struct resource *res;
 	struct resource	resources[2];
@@ -567,14 +574,40 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 
 	glue->musb[id]			= musb;
 
-	pdata->platform_ops		= &dsps_ops;
-
 	ret = platform_device_add_resources(musb, resources, 2);
 	if (ret) {
 		dev_err(dev, "failed to add resources\n");
 		goto err2;
 	}
 
+	if (np) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev,
+				"failed to allocate musb platfrom data\n");
+			ret = -ENOMEM;
+			goto err2;
+		}
+
+		config = devm_kzalloc(&pdev->dev, sizeof(*config), GFP_KERNEL);
+		if (!config) {
+			dev_err(&pdev->dev,
+				"failed to allocate musb hdrc config\n");
+			goto err2;
+		}
+
+		of_property_read_u32(np, "num_eps", (u32 *)&config->num_eps);
+		of_property_read_u32(np, "ram_bits", (u32 *)&config->ram_bits);
+		sprintf(res_name, "port%d_mode", id);
+		of_property_read_u32(np, res_name, (u32 *)&pdata->mode);
+		of_property_read_u32(np, "power", (u32 *)&pdata->power);
+		config->multipoint = of_property_read_bool(np, "multipoint");
+
+		pdata->config		= config;
+	}
+
+	pdata->platform_ops		= &dsps_ops;
+
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(dev, "failed to add platform_data\n");
@@ -606,14 +639,22 @@ static void __devexit dsps_delete_musb_pdev(struct dsps_glue *glue, u8 id)
 
 static int __devinit dsps_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	const struct dsps_musb_wrapper *wrp =
-				(struct dsps_musb_wrapper *)id->driver_data;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+	const struct dsps_musb_wrapper *wrp;
 	struct dsps_glue *glue;
 	struct resource *iomem;
 	u32 __iomem *usbss;
 	int ret, i;
 
+	match = of_match_node(musb_dsps_of_match, np);
+	if (!match) {
+		dev_err(&pdev->dev, "fail to get matching of_match struct\n");
+		ret = -EINVAL;
+		goto err0;
+	}
+	wrp = match->data;
+
 	/* allocate glue */
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -773,13 +814,14 @@ static const struct platform_device_id musb_dsps_id_table[] __devinitconst = {
 };
 MODULE_DEVICE_TABLE(platform, musb_dsps_id_table);
 
+#ifdef CONFIG_OF
 static const struct of_device_id musb_dsps_of_match[] __devinitconst = {
-	{ .compatible = "musb-ti81xx", },
-	{ .compatible = "ti,ti81xx-musb", },
-	{ .compatible = "ti,am335x-musb", },
+	{ .compatible = "ti,musb-am33xx",
+		.data = (void *) &ti81xx_driver_data, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
+#endif
 
 static struct platform_driver dsps_usbss_driver = {
 	.probe		= dsps_probe,
@@ -787,7 +829,7 @@ static struct platform_driver dsps_usbss_driver = {
 	.driver         = {
 		.name   = "musb-dsps",
 		.pm	= &dsps_pm_ops,
-		.of_match_table	= musb_dsps_of_match,
+		.of_match_table	= of_match_ptr(musb_dsps_of_match),
 	},
 	.id_table	= musb_dsps_id_table,
 };
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

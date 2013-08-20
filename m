From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 5/8] usb: musb: omap2430: Don't use omap_get_control_dev()
Date: Tue, 20 Aug 2013 17:56:14 +0300
Message-ID: <1377010577-19355-6-git-send-email-rogerq@ti.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377010577-19355-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap_get_control_dev() is being deprecated as it doesn't support
multiple instances. As control device is present only from OMAP4
onwards which supports DT only, we use phandles to get the
reference to the control device.

Also get rid of "ti,has-mailbox" property as it is redundant and
we can determine that from whether "ctrl-module" property is present
or not. Get rid of has_mailbox from musb_hdrc_platform_data as well.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ---
 drivers/usb/musb/omap2430.c                        |   25 +++++++++++--------
 include/linux/usb/musb.h                           |    2 -
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index e24078f..4dc9100 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -3,9 +3,6 @@ OMAP GLUE AND OTHER OMAP SPECIFIC COMPONENTS
 OMAP MUSB GLUE
  - compatible : Should be "ti,omap4-musb" or "ti,omap3-musb"
  - ti,hwmods : must be "usb_otg_hs"
- - ti,has-mailbox : to specify that omap uses an external mailbox
-   (in control module) to communicate with the musb core during device connect
-   and disconnect.
  - multipoint : Should be "1" indicating the musb controller supports
    multipoint. This is a MUSB configuration-specific setting.
  - num-eps : Specifies the number of endpoints. This is also a
@@ -28,7 +25,6 @@ SOC specific device node entry
 usb_otg_hs: usb_otg_hs@4a0ab000 {
 	compatible = "ti,omap4-musb";
 	ti,hwmods = "usb_otg_hs";
-	ti,has-mailbox;
 	multipoint = <1>;
 	num-eps = <16>;
 	ram-bits = <12>;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ebb46ec..516795b 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/usb/musb-omap.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/of_platform.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -509,8 +510,12 @@ static int omap2430_probe(struct platform_device *pdev)
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
 	glue->status			= OMAP_MUSB_UNKNOWN;
+	glue->control_otghs = ERR_PTR(-ENODEV);
 
 	if (np) {
+		struct device_node *control_node;
+		struct platform_device *control_pdev;
+
 		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 		if (!pdata) {
 			dev_err(&pdev->dev,
@@ -539,22 +544,20 @@ static int omap2430_probe(struct platform_device *pdev)
 		of_property_read_u32(np, "ram-bits", (u32 *)&config->ram_bits);
 		of_property_read_u32(np, "power", (u32 *)&pdata->power);
 		config->multipoint = of_property_read_bool(np, "multipoint");
-		pdata->has_mailbox = of_property_read_bool(np,
-		    "ti,has-mailbox");
 
 		pdata->board_data	= data;
 		pdata->config		= config;
-	}
 
-	if (pdata->has_mailbox) {
-		glue->control_otghs = omap_get_control_dev();
-		if (IS_ERR(glue->control_otghs)) {
-			dev_vdbg(&pdev->dev, "Failed to get control device\n");
-			ret = PTR_ERR(glue->control_otghs);
-			goto err2;
+		control_node = of_parse_phandle(np, "ctrl-module", 0);
+		if (control_node) {
+			control_pdev = of_find_device_by_node(control_node);
+			if (!control_pdev) {
+				dev_err(&pdev->dev, "Failed to get control device\n");
+				ret = -EINVAL;
+				goto err2;
+			}
+			glue->control_otghs = &control_pdev->dev;
 		}
-	} else {
-		glue->control_otghs = ERR_PTR(-ENODEV);
 	}
 	pdata->platform_ops		= &omap2430_ops;
 
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 053c268..eb50525 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -99,8 +99,6 @@ struct musb_hdrc_platform_data {
 	/* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
 	u8		mode;
 
-	u8		has_mailbox:1;

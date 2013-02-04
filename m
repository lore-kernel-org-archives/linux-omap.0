From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/13] mfd: omap-usb-tll: Add device tree support
Date: Mon, 4 Feb 2013 17:58:51 +0200
Message-ID: <1359993540-20780-5-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Enable this driver to probe in device tree boot.

CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 +++++++++++++++++
 drivers/mfd/omap-usb-tll.c                         |    9 +++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt

diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
new file mode 100644
index 0000000..835cf4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
@@ -0,0 +1,17 @@
+OMAP HS USB Host TLL (Transceiver-Less Interface)
+
+Required properties:
+
+- compatible : should be "ti,usbhs-tll"
+- reg : should contain one register range i.e. start and length
+- interrupts : should contain the TLL module's interrupt
+- ti,hwmod : must contain "usb_tll_hs"
+
+Example:
+
+	usbhstll: usbhstll@0x4a062000 {
+		compatible = "ti,usbhs-tll";
+		reg = <0x4a062000 0x1000>;
+		interrupts = <78>;
+		ti,hwmods = "usb_tll_hs";
+	  };
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index f7d2568..f7afb22 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/usb-omap.h>
+#include <linux/of.h>
 
 #define USBTLL_DRIVER_NAME	"usbhs_tll"
 
@@ -311,10 +312,18 @@ static int usbtll_omap_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id usbtll_omap_dt_ids[] = {
+	{ .compatible = "ti,usbhs-tll" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, usbtll_omap_dt_ids);
+
 static struct platform_driver usbtll_omap_driver = {
 	.driver = {
 		.name		= (char *)usbtll_driver_name,
 		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(usbtll_omap_dt_ids),
 	},
 	.probe		= usbtll_omap_probe,
 	.remove		= usbtll_omap_remove,
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

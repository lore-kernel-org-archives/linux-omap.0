From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v9 13/13] usb: otg: nop: add dt support
Date: Fri, 31 Aug 2012 16:39:59 +0530
Message-ID: <1346411399-23964-14-git-send-email-ravibabu@ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346411399-23964-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added device tree support for nop transceiver driver and updated the
Documentation with device tree binding information for am33xx platform.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/usb/am33xx-usb.txt         |    3 +++
 drivers/usb/otg/nop-usb-xceiv.c                    |   10 ++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index b0caac3..e2702df 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -14,3 +14,6 @@ AM33XX MUSB GLUE
    500mA when operating in host mode.
  - usb0-phy : phandle for usb0 NOP PHY
  - usb1-phy : phandle for usb1 NOP PHY
+
+NOP USB PHY
+ - compatible : Should be "nop-xceiv-usb"
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 7e0dba3..fdbc285 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -27,6 +27,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/otg.h>
@@ -194,12 +195,21 @@ static int __devexit nop_usb_xceiv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id nop_xceiv_id_table[] = {
+	{ .compatible = "nop-xceiv-usb" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, nop_xceiv_id_table);
+#endif
+
 static struct platform_driver nop_usb_xceiv_driver = {
 	.probe		= nop_usb_xceiv_probe,
 	.remove		= __devexit_p(nop_usb_xceiv_remove),
 	.driver		= {
 		.name	= "nop_usb_xceiv",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(nop_xceiv_id_table),
 	},
 };
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

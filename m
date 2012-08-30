From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v8 13/13] usb: otg: nop: add dt support
Date: Thu, 30 Aug 2012 16:20:25 +0530
Message-ID: <1346323825-24385-14-git-send-email-ravibabu@ti.com>
References: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55567 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab2H3Kuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 06:50:40 -0400
In-Reply-To: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, ajayguptaj@gmail.com

Added device tree support for nop transceiver driver and updated the
Documentation with device tree binding information for am33xx platform.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
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


From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v7 07/11] usb: otg: nop: add dt support
Date: Thu, 2 Aug 2012 17:42:50 +0530
Message-ID: <1343909574-15633-8-git-send-email-ravibabu@ti.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541Ab2HBMNG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Aug 2012 08:13:06 -0400
In-Reply-To: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, ajayguptaj@gmail.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Added device tree support for nop transceiver driver and updated the
Documentation with device tree binding information for am33xx platform.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 .../devicetree/bindings/usb/am33xx-usb.txt         |    3 +++
 drivers/usb/otg/nop-usb-xceiv.c                    |   10 ++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index ca8fa56..9782585 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -12,3 +12,6 @@ AM33XX MUSB GLUE
    represents PERIPHERAL.
  - power : Should be "250". This signifies the controller can supply upto
    500mA when operating in host mode.
+
+NOP USB PHY
+ - compatible : Should be "nop-xceiv-usb"
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 04ddcee..a66e3bc 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -27,6 +27,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/otg.h>
@@ -188,12 +189,21 @@ static int __devexit nop_usb_xceiv_remove(struct platform_device *pdev)
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


From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 5/8] usb: musb: omap2430: Don't use omap_get_control_dev()
Date: Thu, 15 Aug 2013 16:15:09 +0300
Message-ID: <1376572512-9561-6-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46764 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab3HONQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Aug 2013 09:16:04 -0400
In-Reply-To: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com
Cc: tony@atomide.com, kishon@ti.com, george.cherian@ti.com, bigeasy@linutronix.de, dmurphy@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

omap_get_control_dev() is being deprecated as it doesn't support
multiple instances. As control device is present only from OMAP4
onwards which supports DT only, we use phandles to get the
reference to the control device.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/musb/omap2430.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ebb46ec..1db9588 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/usb/musb-omap.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/of_platform.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -547,12 +548,25 @@ static int omap2430_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->has_mailbox) {
-		glue->control_otghs = omap_get_control_dev();
-		if (IS_ERR(glue->control_otghs)) {
-			dev_vdbg(&pdev->dev, "Failed to get control device\n");
-			ret = PTR_ERR(glue->control_otghs);
+		struct device_node *control_node;
+		struct platform_device *control_pdev;
+
+		control_node = of_parse_phandle(np, "ctrl-module", 0);
+		if (!control_node) {
+			dev_err(&pdev->dev, "Failed to get control device phandle\n");
+			ret = -ENODEV;
+			goto err2;
+		}
+
+		control_pdev = of_find_device_by_node(control_node);
+		if (!control_pdev) {
+			dev_err(&pdev->dev, "Failed to get control device\n");
+			ret = -ENODEV;
 			goto err2;
 		}
+
+		glue->control_otghs = &control_pdev->dev;
+
 	} else {
 		glue->control_otghs = ERR_PTR(-ENODEV);
 	}
-- 
1.7.4.1


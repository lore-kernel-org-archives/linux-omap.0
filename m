From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 03/11] usb: dwc3-omap: use runtime API's to enable clocks
Date: Fri, 25 Jan 2013 08:30:47 +0530
Message-ID: <1359082855-7404-4-git-send-email-kishon@ti.com>
References: <1359082855-7404-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359082855-7404-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: rob.herring@calxeda.com, rob@landley.net, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, gregkh@linuxfoundation.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Before accessing any register, runtime API's should be invoked to enable
the clocks. runtime API's are added here to prevent abort during register
access.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 78bb2f6..8094230 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -43,6 +43,7 @@
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dwc3-omap.h>
+#include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -336,6 +337,13 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	omap->irq	= irq;
 	omap->base	= base;
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "get_sync failed with err %d\n", ret);
+		return ret;
+	}
+
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
 
 	utmi_mode = of_get_property(node, "utmi-mode", &size);
@@ -416,6 +424,8 @@ static int dwc3_omap_remove(struct platform_device *pdev)
 
 	platform_device_unregister(omap->usb2_phy);
 	platform_device_unregister(omap->usb3_phy);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	device_for_each_child(&pdev->dev, NULL, dwc3_omap_remove_core);
 
 	return 0;
-- 
1.7.9.5


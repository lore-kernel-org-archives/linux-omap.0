From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 1/7] usb: dwc3-omap: use device_for_each_child to handle child removal
Date: Mon, 8 Oct 2012 14:53:50 +0530
Message-ID: <1349688236-22814-2-git-send-email-kishon@ti.com>
References: <1349688236-22814-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1349688236-22814-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: sshtylyov@mvista.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, balbi@ti.com, gregkh@linuxfoundation.org, kishon@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Used device_for_each_child() to handle child device (dwc3 core) removal
during devexit of dwc3 omap.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 479dc04..e335da3 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -204,6 +204,15 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 	return IRQ_HANDLED;
 }
 
+static int dwc3_omap_remove_core(struct device *dev, void *c)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
 static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 {
 	struct dwc3_omap_data	*pdata = pdev->dev.platform_data;
@@ -370,9 +379,8 @@ static int __devexit dwc3_omap_remove(struct platform_device *pdev)
 {
 	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
 
-	platform_device_unregister(omap->dwc3);
-
 	dwc3_put_device_id(omap->dwc3->id);
+	device_for_each_child(&pdev->dev, NULL, dwc3_omap_remove_core);
 
 	return 0;
 }
-- 
1.7.9.5


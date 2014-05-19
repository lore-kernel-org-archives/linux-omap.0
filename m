From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v2 2/6] usb: dwc3: dwc3-omap: Add dwc3_omap_map_offset() function
Date: Mon, 19 May 2014 14:02:53 +0530
Message-ID: <1400488377-10605-3-git-send-email-george.cherian@ti.com>
References: <1400488377-10605-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400488377-10605-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Move map offset to its own seperate function.
Improve code readability, decrease the dwc3_probe() size.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 53f6490..0df8adf 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -378,6 +378,24 @@ static int dwc3_omap_vbus_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void dwc3_omap_map_offset(struct dwc3_omap *omap)
+{
+	struct device_node	*node = omap->dev->of_node;
+
+	/* Differentiate between OMAP5 and AM437x
+	 * For OMAP5(ES2.0) and AM437x x_major is 2 even though there are
+	 * changes in wrapper registers, Using dt compatible for AM437x
+	 */
+
+	if (of_device_is_compatible(node, "ti,am437x-dwc3")) {
+		omap->irq_eoi_offset = USBOTGSS_EOI_OFFSET;
+		omap->irq0_offset = USBOTGSS_IRQ0_OFFSET;
+		omap->irqmisc_offset = USBOTGSS_IRQMISC_OFFSET;
+		omap->utmi_otg_offset = USBOTGSS_UTMI_OTG_OFFSET;
+		omap->debug_offset = USBOTGSS_DEBUG_OFFSET;
+	}
+}
+
 static int dwc3_omap_probe(struct platform_device *pdev)
 {
 	struct device_node	*node = pdev->dev.of_node;
@@ -442,18 +460,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	/* Differentiate between OMAP5 and AM437x
-	 * For OMAP5(ES2.0) and AM437x x_major is 2 even though there are
-	 * changes in wrapper registers, Using dt compatible for AM437x
-	 */
-
-	if (of_device_is_compatible(node, "ti,am437x-dwc3")) {
-		omap->irq_eoi_offset = USBOTGSS_EOI_OFFSET;
-		omap->irq0_offset = USBOTGSS_IRQ0_OFFSET;
-		omap->irqmisc_offset = USBOTGSS_IRQMISC_OFFSET;
-		omap->utmi_otg_offset = USBOTGSS_UTMI_OTG_OFFSET;
-		omap->debug_offset = USBOTGSS_DEBUG_OFFSET;
-	}
+	dwc3_omap_map_offset(omap);
 
 	reg = dwc3_omap_read_utmi_status(omap);
 
-- 
1.8.3.1

From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v3 3/6] usb: dwc3: dwc3-omap: Add dwc3_omap_set_utmi_mode() function
Date: Thu, 22 May 2014 09:31:35 +0530
Message-ID: <1400731298-18442-4-git-send-email-george.cherian@ti.com>
References: <1400731298-18442-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400731298-18442-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Move find and set the utmi mode to its own seperate function.
Improve code readability, decrease the dwc3_probe() size.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 09918ac..56ec6eb 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -397,6 +397,30 @@ static void dwc3_omap_map_offset(struct dwc3_omap *omap)
 	}
 }
 
+static void dwc3_omap_set_utmi_mode(struct dwc3_omap *omap)
+{
+	u32			reg;
+	struct device_node	*node = omap->dev->of_node;
+	int			utmi_mode = 0;
+
+	reg = dwc3_omap_read_utmi_status(omap);
+
+	of_property_read_u32(node, "utmi-mode", &utmi_mode);
+
+	switch (utmi_mode) {
+	case DWC3_OMAP_UTMI_MODE_SW:
+		reg |= USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
+		break;
+	case DWC3_OMAP_UTMI_MODE_HW:
+		reg &= ~USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
+		break;
+	default:
+		dev_dbg(omap->dev, "UNKNOWN utmi mode %d\n", utmi_mode);
+	}
+
+	dwc3_omap_write_utmi_status(omap, reg);
+}
+
 static int dwc3_omap_probe(struct platform_device *pdev)
 {
 	struct device_node	*node = pdev->dev.of_node;
@@ -410,8 +434,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	int			ret;
 	int			irq;
 
-	int			utmi_mode = 0;
-
 	u32			reg;
 
 	void __iomem		*base;
@@ -462,23 +484,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	}
 
 	dwc3_omap_map_offset(omap);
-
-	reg = dwc3_omap_read_utmi_status(omap);
-
-	of_property_read_u32(node, "utmi-mode", &utmi_mode);
-
-	switch (utmi_mode) {
-	case DWC3_OMAP_UTMI_MODE_SW:
-		reg |= USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
-		break;
-	case DWC3_OMAP_UTMI_MODE_HW:
-		reg &= ~USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
-		break;
-	default:
-		dev_dbg(dev, "UNKNOWN utmi mode %d\n", utmi_mode);
-	}
-
-	dwc3_omap_write_utmi_status(omap, reg);
+	dwc3_omap_set_utmi_mode(omap);
 
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
-- 
1.8.3.1

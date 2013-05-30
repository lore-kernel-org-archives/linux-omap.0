From: Ruchika Kharwar <ruchika@ti.com>
Subject: [PATCH] usb: dwc3: Addition of "dr_mode" dt property.
Date: Thu, 30 May 2013 12:56:31 -0500
Message-ID: <1369936591-29605-1-git-send-email-ruchika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, Ruchika Kharwar <ruchika@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch adds the possibility of the "mode" being specified in a device
tree. This allows the scenario when there maybe multiple USB subsystems
operating in different modes.

Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |    3 ++-
 drivers/usb/dwc3/core.c                        |   22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 7a95c65..5c4db93 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -10,7 +10,8 @@ Required properties:
 
 Optional properties:
  - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
-
+ - dr_mode: determines the mode of core. This could be "gadget", "host",
+   "drd".
 This is usually a subnode to DWC3 glue to which it is connected.
 
 dwc3@4a030000 {
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c35d49d..cf211be 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -378,7 +378,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	void			*mem;
 
 	u8			mode;
-
+	char			*dr_mode;
 	mem = devm_kzalloc(dev, sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
 	if (!mem) {
 		dev_err(dev, "not enough memory\n");
@@ -520,9 +520,23 @@ static int dwc3_probe(struct platform_device *pdev)
 		mode = DWC3_MODE_HOST;
 	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
 		mode = DWC3_MODE_DEVICE;
-	else
-		mode = DWC3_MODE_DRD;
-
+	else {
+		if (of_property_read_string(node, "dr_mode", &dr_mode)) {
+			dev_warn(dev, "Missing dr_mode so assuming DWC3_MODE_DRD\n");
+			mode = DWC3_MODE_DRD;
+		} else {
+			if (strcmp(dr_mode, "host") == 0)
+				mode = DWC3_MODE_HOST;
+			else if (strcmp(dr_mode, "gadget") == 0)
+				mode = DWC3_MODE_DEVICE;
+			else if (strcmp(dr_mode, "drd") == 0)
+				mode = DWC3_MODE_DRD;
+			else {
+				dev_err(dev, "invalid dr_mode property value\n");
+				goto err0;
+			}
+		}
+	}
 	switch (mode) {
 	case DWC3_MODE_DEVICE:
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-- 
1.7.5.4


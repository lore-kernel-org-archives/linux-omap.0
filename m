From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 6/7] phy: omap-usb2: Add a new compatible string for USB2 PHY2
Date: Tue, 4 Aug 2015 20:50:45 +0530
Message-ID: <1438701646-7876-7-git-send-email-kishon@ti.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438701646-7876-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
Cc: balbi@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

The USB2 PHY2 has a different register map compared to USB2 PHY1
to power on/off the PHY. In order to handle it, add a new
"compatible" string.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt |    2 ++
 drivers/phy/phy-omap-usb2.c                      |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 49e5b0c..a061077 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -31,6 +31,8 @@ OMAP USB2 PHY
 
 Required properties:
  - compatible: Should be "ti,omap-usb2"
+	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
+	       in DRA7x
  - reg : Address and length of the register set for the device.
  - #phy-cells: determine the number of cells that should be given in the
    phandle while referencing this phy.
diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index b5c266a..2f7220f 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -159,6 +159,11 @@ static const struct usb_phy_data dra7x_usb2_data = {
 	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
 };
 
+static const struct usb_phy_data dra7x_usb2_phy2_data = {
+	.label = "dra7x_usb2_phy2",
+	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
+};
+
 static const struct usb_phy_data am437x_usb2_data = {
 	.label = "am437x_usb2",
 	.flags =  0,
@@ -178,6 +183,10 @@ static const struct of_device_id omap_usb2_id_table[] = {
 		.data = &dra7x_usb2_data,
 	},
 	{
+		.compatible = "ti,dra7x-usb2-phy2",
+		.data = &dra7x_usb2_phy2_data,
+	},
+	{
 		.compatible = "ti,am437x-usb2",
 		.data = &am437x_usb2_data,
 	},
-- 
1.7.9.5

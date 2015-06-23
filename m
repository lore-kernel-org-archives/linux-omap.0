From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/17] phy: omap-usb2: Add a new compatible string for USB2 PHY2
Date: Tue, 23 Jun 2015 17:28:50 +0530
Message-ID: <1435060743-5511-6-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435060743-5511-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The USB2 PHY2 has a different register map compared to USB2 PHY1
to power on/off the PHY. In order to handle it, add a new
"compatible" string.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt |    2 ++
 drivers/phy/phy-omap-usb2.c                      |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 52c7a92..b9101b9 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -31,6 +31,8 @@ OMAP USB2 PHY
 
 Required properties:
  - compatible: Should be "ti,omap-usb2"
+	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
+			in DRA7x
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

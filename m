From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] phy: ti: usb2: Add support for AM654 USB2 PHY
Date: Wed, 5 Dec 2018 17:03:26 +0200
Message-ID: <1544022206-2300-5-git-send-email-rogerq@ti.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for the USB2 PHY on the AM654 SoC.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/ti/Kconfig         |  4 ++--
 drivers/phy/ti/phy-omap-usb2.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 4fdbe06..a55959b 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -33,11 +33,11 @@ config OMAP_CONTROL_PHY
 
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || ARCH_K3
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_PHY
-	select OMAP_CONTROL_PHY
+	select OMAP_CONTROL_PHY if ARCH_OMAP2PLUS
 	help
 	  Enable this to support the transceiver that is part of SOC. This
 	  driver takes care of all the PHY functionality apart from comparator.
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 418e7f1..e871f29 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -36,6 +36,10 @@
 #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
 #define USB2PHY_ANA_CONFIG1 0x4c
 
+#define AM654_USB2_OTG_PD		BIT(8)
+#define AM654_USB2_VBUS_DET_EN		BIT(5)
+#define AM654_USB2_VBUSVALID_DET_EN	BIT(4)
+
 /**
  * omap_usb2_set_comparator - links the comparator present in the sytem with
  *	this phy
@@ -245,6 +249,15 @@ static const struct usb_phy_data am437x_usb2_data = {
 	.power_off = AM437X_USB2_PHY_PD | AM437X_USB2_OTG_PD,
 };
 
+static const struct usb_phy_data am654_usb2_data = {
+	.label = "am654_usb2",
+	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
+	.mask = AM654_USB2_OTG_PD | AM654_USB2_VBUS_DET_EN |
+		AM654_USB2_VBUSVALID_DET_EN,
+	.power_on = AM654_USB2_VBUS_DET_EN | AM654_USB2_VBUSVALID_DET_EN,
+	.power_off = AM654_USB2_OTG_PD,
+};
+
 static const struct of_device_id omap_usb2_id_table[] = {
 	{
 		.compatible = "ti,omap-usb2",
@@ -266,6 +279,10 @@ static const struct of_device_id omap_usb2_id_table[] = {
 		.compatible = "ti,am437x-usb2",
 		.data = &am437x_usb2_data,
 	},
+	{
+		.compatible = "ti,am654-usb2",
+		.data = &am654_usb2_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_usb2_id_table);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

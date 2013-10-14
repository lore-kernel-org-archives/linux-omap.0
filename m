From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: phy: omap: Add omap-control Support for AM437x
Date: Mon, 14 Oct 2013 18:21:11 +0530
Message-ID: <1381755071-11931-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This adds omap control module support for USBSS in AM437x SoC.
Update DT binding information to reflect these changes.

Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt |  2 ++
 drivers/usb/phy/phy-omap-control.c                 | 17 +++++++++++++++++
 include/linux/usb/omap_control_usb.h               |  6 ++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index 090e5e2..c495135 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -87,6 +87,8 @@ Required properties:
 			e.g. USB3 PHY and SATA PHY on OMAP5.
  "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
 			DRA7 platform.
+ "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
+			AM437 platform.
  - reg : Address and length of the register set for the device. It contains
    the address of "otghs_control" for control-phy-otghs or "power" register
    for other types.
diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
index 09c5ace..c453b81 100644
--- a/drivers/usb/phy/phy-omap-control.c
+++ b/drivers/usb/phy/phy-omap-control.c
@@ -84,6 +84,18 @@ void omap_control_usb_phy_power(struct device *dev, int on)
 		else
 			val |= OMAP_CTRL_USB2_PHY_PD;
 		break;
+
+	case OMAP_CTRL_TYPE_AM437USB2:
+		if (on) {
+			val &= ~(AM437X_CTRL_USB2_PHY_PD |
+					AM437X_CTRL_USB2_OTG_PD);
+			val |= (AM437X_CTRL_USB2_OTGVDET_EN |
+					AM437X_CTRL_USB2_OTGSESSEND_EN);
+		} else {
+			val |= (AM437X_CTRL_USB2_PHY_PD |
+					 AM437X_CTRL_USB2_OTG_PD);
+		}
+		break;
 	default:
 		dev_err(dev, "%s: type %d not recognized\n",
 					__func__, control_usb->type);
@@ -197,6 +209,7 @@ static const enum omap_control_usb_type otghs_data = OMAP_CTRL_TYPE_OTGHS;
 static const enum omap_control_usb_type usb2_data = OMAP_CTRL_TYPE_USB2;
 static const enum omap_control_usb_type pipe3_data = OMAP_CTRL_TYPE_PIPE3;
 static const enum omap_control_usb_type dra7usb2_data = OMAP_CTRL_TYPE_DRA7USB2;
+static const enum omap_control_usb_type am437usb2_data = OMAP_CTRL_TYPE_AM437USB2;
 
 static const struct of_device_id omap_control_usb_id_table[] = {
 	{
@@ -215,6 +228,10 @@ static const struct of_device_id omap_control_usb_id_table[] = {
 		.compatible = "ti,control-phy-dra7usb2",
 		.data = &dra7usb2_data,
 	},
+	{
+		.compatible = "ti,control-phy-am437usb2",
+		.data = &am437usb2_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_control_usb_id_table);
diff --git a/include/linux/usb/omap_control_usb.h b/include/linux/usb/omap_control_usb.h
index 596b019..69ae383 100644
--- a/include/linux/usb/omap_control_usb.h
+++ b/include/linux/usb/omap_control_usb.h
@@ -24,6 +24,7 @@ enum omap_control_usb_type {
 	OMAP_CTRL_TYPE_USB2,	/* USB2_PHY, power down in CONTROL_DEV_CONF */
 	OMAP_CTRL_TYPE_PIPE3,	/* PIPE3 PHY, DPLL & seperate Rx/Tx power */
 	OMAP_CTRL_TYPE_DRA7USB2, /* USB2 PHY, power and power_aux e.g. DRA7 */
+	OMAP_CTRL_TYPE_AM437USB2, /* USB2 PHY, power e.g. AM437x */
 };
 
 struct omap_control_usb {
@@ -64,6 +65,11 @@ enum omap_control_usb_mode {
 
 #define OMAP_CTRL_USB2_PHY_PD		BIT(28)
 
+#define AM437X_CTRL_USB2_PHY_PD		BIT(0)
+#define AM437X_CTRL_USB2_OTG_PD		BIT(1)
+#define AM437X_CTRL_USB2_OTGVDET_EN	BIT(19)
+#define AM437X_CTRL_USB2_OTGSESSEND_EN	BIT(20)
+
 #if IS_ENABLED(CONFIG_OMAP_CONTROL_USB)
 extern void omap_control_usb_phy_power(struct device *dev, int on);
 extern void omap_control_usb_set_mode(struct device *dev,
-- 
1.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v12 5/7] ARM: dts: omap: update usb_otg_hs data
Date: Fri, 27 Sep 2013 11:53:29 +0530
Message-ID: <1380263012-9687-6-git-send-email-kishon@ti.com>
References: <1380263012-9687-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380263012-9687-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Updated the usb_otg_hs dt data to include the *phy* and *phy-names*
binding in order for the driver to use the new generic PHY framework.
Also updated the Documentation to include the binding information.
The PHY binding information can be found at
Documentation/devicetree/bindings/phy/phy-bindings.txt

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +++++
 Documentation/devicetree/bindings/usb/usb-phy.txt  |    6 ++++++
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    2 ++
 arch/arm/boot/dts/omap3-evm.dts                    |    2 ++
 arch/arm/boot/dts/omap3-overo.dtsi                 |    2 ++
 arch/arm/boot/dts/omap4.dtsi                       |    3 +++
 arch/arm/boot/dts/twl4030.dtsi                     |    1 +
 7 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index 9088ab0..661cb06 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -19,6 +19,9 @@ OMAP MUSB GLUE
  - power : Should be "50". This signifies the controller can supply up to
    100mA when operating in host mode.
  - usb-phy : the phandle for the PHY device
+ - phys : the phandle for the PHY device (used by generic PHY framework)
+ - phy-names : the names of the PHY corresponding to the PHYs present in the
+   *phy* phandle.
 
 Optional properties:
  - ctrl-module : phandle of the control module this glue uses to write to
@@ -33,6 +36,8 @@ usb_otg_hs: usb_otg_hs@4a0ab000 {
 	num-eps = <16>;
 	ram-bits = <12>;
 	ctrl-module = <&omap_control_usb>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
 };
 
 Board specific device node entry
diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/usb/usb-phy.txt
index 61496f5..c0245c8 100644
--- a/Documentation/devicetree/bindings/usb/usb-phy.txt
+++ b/Documentation/devicetree/bindings/usb/usb-phy.txt
@@ -5,6 +5,8 @@ OMAP USB2 PHY
 Required properties:
  - compatible: Should be "ti,omap-usb2"
  - reg : Address and length of the register set for the device.
+ - #phy-cells: determine the number of cells that should be given in the
+   phandle while referencing this phy.
 
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
@@ -16,6 +18,7 @@ usb2phy@4a0ad080 {
 	compatible = "ti,omap-usb2";
 	reg = <0x4a0ad080 0x58>;
 	ctrl-module = <&omap_control_usb>;
+	#phy-cells = <0>;
 };
 
 OMAP USB3 PHY
@@ -25,6 +28,8 @@ Required properties:
  - reg : Address and length of the register set for the device.
  - reg-names: The names of the register addresses corresponding to the registers
    filled in "reg".
+ - #phy-cells: determine the number of cells that should be given in the
+   phandle while referencing this phy.
 
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
@@ -39,4 +44,5 @@ usb3phy@4a084400 {
 	      <0x4a084c00 0x40>;
 	reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 	ctrl-module = <&omap_control_usb>;
+	#phy-cells = <0>;
 };
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 0c514dc..8483846 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -144,6 +144,8 @@
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
 	mode = <3>;
 	power = <50>;
 };
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 7d4329d..4134dd0 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -70,6 +70,8 @@
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
 	mode = <3>;
 	power = <50>;
 };
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 8f1abec..a461d2f 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -76,6 +76,8 @@
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
 	mode = <3>;
 	power = <50>;
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..1e8e2fe 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -520,6 +520,7 @@
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
 				ctrl-module = <&omap_control_usb>;
+				#phy-cells = <0>;
 			};
 		};
 
@@ -658,6 +659,8 @@
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
 			usb-phy = <&usb2_phy>;
+			phys = <&usb2_phy>;
+			phy-names = "usb2-phy";
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index ae6a17a..5aba238 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -86,6 +86,7 @@
 		usb1v8-supply = <&vusb1v8>;
 		usb3v1-supply = <&vusb3v1>;
 		usb_mode = <1>;
+		#phy-cells = <0>;
 	};
 
 	twl_pwm: pwm {
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

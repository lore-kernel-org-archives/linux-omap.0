From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 02/12] phy: omap-control: Update DT binding information
Date: Mon, 3 Mar 2014 17:07:24 +0200
Message-ID: <1393859254-10937-3-git-send-email-rogerq@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, balbi@ti.com, tony@atomide.com
Cc: george.cherian@ti.com, balajitk@ti.com, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Move omap-control binding information to the right location.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt   | 25 ++++++++++++++++++++++
 Documentation/devicetree/bindings/usb/omap-usb.txt | 24 ---------------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 207e14c..41dc132 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -1,5 +1,30 @@
 TI PHY: DT DOCUMENTATION FOR PHYs in TI PLATFORMs
 
+OMAP CONTROL PHY
+
+Required properties:
+ - compatible: Should be one of
+ "ti,control-phy-otghs" - if it has otghs_control mailbox register as on OMAP4.
+ "ti,control-phy-usb2" - if it has Power down bit in control_dev_conf register
+                        e.g. USB2_PHY on OMAP5.
+ "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
+                        e.g. USB3 PHY and SATA PHY on OMAP5.
+ "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
+                        DRA7 platform.
+ "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
+                        AM437 platform.
+ - reg : Address and length of the register set for the device. It contains
+   the address of "otghs_control" for control-phy-otghs or "power" register
+   for other types.
+ - reg-names: should be "otghs_control" control-phy-otghs and "power" for
+   other types.
+
+omap_control_usb: omap-control-usb@4a002300 {
+        compatible = "ti,control-phy-otghs";
+        reg = <0x4a00233c 0x4>;
+        reg-names = "otghs_control";
+};
+
 OMAP USB2 PHY
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index c495135..38b2fae 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -76,27 +76,3 @@ omap_dwc3 {
 	ranges;
 };
 
-OMAP CONTROL USB
-
-Required properties:
- - compatible: Should be one of
- "ti,control-phy-otghs" - if it has otghs_control mailbox register as on OMAP4.
- "ti,control-phy-usb2" - if it has Power down bit in control_dev_conf register
-			e.g. USB2_PHY on OMAP5.
- "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
-			e.g. USB3 PHY and SATA PHY on OMAP5.
- "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
-			DRA7 platform.
- "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
-			AM437 platform.
- - reg : Address and length of the register set for the device. It contains
-   the address of "otghs_control" for control-phy-otghs or "power" register
-   for other types.
- - reg-names: should be "otghs_control" control-phy-otghs and "power" for
-   other types.
-
-omap_control_usb: omap-control-usb@4a002300 {
-	compatible = "ti,control-phy-otghs";
-	reg = <0x4a00233c 0x4>;
-	reg-names = "otghs_control";
-};
-- 
1.8.3.2

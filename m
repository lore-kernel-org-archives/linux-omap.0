From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH][v4.0-rc] ARM: dts: dra7x-evm: beagle-x15: Fix USB Host
Date: Tue, 24 Feb 2015 14:37:07 +0200
Message-ID: <1424781427-15356-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In commit 87517d26d888 ("ARM: dts: dra7-evm: Add extcon nodes for USB")
we enabled Extcon USB gpio to tackle the USB ID pin and get
peripheral mode to work.

But the extcon-gpio-usb driver [1] didn't make it into v4.0
and this makes the USB driver defer probe indefinitely breaking
USB Host functionality.

As a temporary fix we remove the extcon handle from the
USB controller and add it back when the extcon driver
merges in v4.1.

[1] - https://lkml.org/lkml/2015/2/2/187

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 8 --------
 arch/arm/boot/dts/dra7-evm.dts          | 8 --------
 arch/arm/boot/dts/dra72-evm.dts         | 8 --------
 3 files changed, 24 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 03750af..6463f9e 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -549,14 +549,6 @@
 	pinctrl-0 = <&usb1_pins>;
 };
 
-&omap_dwc3_1 {
-	extcon = <&extcon_usb1>;
-};
-
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &usb2 {
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 746cddb..3290a96 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -543,14 +543,6 @@
 	};
 };
 
-&omap_dwc3_1 {
-	extcon = <&extcon_usb1>;
-};
-
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &usb1 {
 	dr_mode = "peripheral";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 4d87117..e0264d0 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -380,14 +380,6 @@
 	phy-supply = <&ldo4_reg>;
 };
 
-&omap_dwc3_1 {
-	extcon = <&extcon_usb1>;
-};
-
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &usb1 {
 	dr_mode = "peripheral";
 	pinctrl-names = "default";
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

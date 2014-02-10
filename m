From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: OMAP2+: Fix boot with multi_v7_defconfig
Date: Mon, 10 Feb 2014 20:10:35 +0200
Message-ID: <1392055835-6494-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP EHCI controller is not compatible with the EHCI
platform HCD driver so don't claim that we are.

This fixes boot on OMAP platforms with CONFIG_USB_EHCI_HCD_PLATFORM=y
e.g. multi_v7_defconfig

Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi | 2 +-
 arch/arm/boot/dts/omap4.dtsi | 2 +-
 arch/arm/boot/dts/omap5.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index a5fc83b..6b5dbf8 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -641,7 +641,7 @@
 			};
 
 			usbhsehci: ehci@48064800 {
-				compatible = "ti,ehci-omap", "usb-ehci";
+				compatible = "ti,ehci-omap";
 				reg = <0x48064800 0x400>;
 				interrupt-parent = <&intc>;
 				interrupts = <77>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..f5d754b 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -706,7 +706,7 @@
 			};
 
 			usbhsehci: ehci@4a064c00 {
-				compatible = "ti,ehci-omap", "usb-ehci";
+				compatible = "ti,ehci-omap";
 				reg = <0x4a064c00 0x400>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a..42fcffd 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -784,7 +784,7 @@
 			};
 
 			usbhsehci: ehci@4a064c00 {
-				compatible = "ti,ehci-omap", "usb-ehci";
+				compatible = "ti,ehci-omap";
 				reg = <0x4a064c00 0x400>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v8 13/14] ARM: dts: OMAP2+: Get rid of incompatible ids for USB host nodes
Date: Thu, 20 Feb 2014 13:40:08 +0200
Message-ID: <1392896409-5101-14-git-send-email-rogerq@ti.com>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392896409-5101-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP EHCI and OHCI controllers are not compatible with drivers
other than "ti,ehci-omap" and "ti,ohci-omap3" respectively, so get
rid of the incompatible ids.

CC: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi | 4 ++--
 arch/arm/boot/dts/omap4.dtsi | 4 ++--
 arch/arm/boot/dts/omap5.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index a5fc83b..8e7de9e 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -634,14 +634,14 @@
 			ranges;
 
 			usbhsohci: ohci@48064400 {
-				compatible = "ti,ohci-omap3", "usb-ohci";
+				compatible = "ti,ohci-omap3";
 				reg = <0x48064400 0x400>;
 				interrupt-parent = <&intc>;
 				interrupts = <76>;
 			};
 
 			usbhsehci: ehci@48064800 {
-				compatible = "ti,ehci-omap", "usb-ehci";
+				compatible = "ti,ehci-omap";
 				reg = <0x48064800 0x400>;
 				interrupt-parent = <&intc>;
 				interrupts = <77>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 39a05ce..ff1b057 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -705,14 +705,14 @@
 				      "refclk_60m_ext_p2";
 
 			usbhsohci: ohci@4a064800 {
-				compatible = "ti,ohci-omap3", "usb-ohci";
+				compatible = "ti,ohci-omap3";
 				reg = <0x4a064800 0x400>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			usbhsehci: ehci@4a064c00 {
-				compatible = "ti,ehci-omap", "usb-ehci";
+				compatible = "ti,ehci-omap";
 				reg = <0x4a064c00 0x400>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index d4dae48..f65aa65 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -783,14 +783,14 @@
 				      "refclk_60m_ext_p2";
 
 			usbhsohci: ohci@4a064800 {
-				compatible = "ti,ohci-omap3", "usb-ohci";
+				compatible = "ti,ohci-omap3";
 				reg = <0x4a064800 0x400>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
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
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

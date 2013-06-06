From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 2/4] ARM: dts: omap5-uevm: Add USB Host support
Date: Thu, 6 Jun 2013 23:18:37 +0530
Message-ID: <1370540919-4339-3-git-send-email-r.sricharan@ti.com>
References: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53449 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab3FFRt0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jun 2013 13:49:26 -0400
In-Reply-To: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, r.sricharan@ti.com, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Roger Quadros <rogerq@ti.com>

From: Roger Quadros <rogerq@ti.com>

Provide the RESET regulators for the USB PHYs, the USB Host
port modes and the PHY devices.

Also provide pin multiplexer information for the USB host
pins.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
[Sricharan R <r.sricharan@ti.com>: Replaced constants with preprocessor macros]
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 [v2] Removed the clk_alias node and removed the redundant comments

 arch/arm/boot/dts/omap5-uevm.dts |   70 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi     |   30 ++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 843a001..a31e42f 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -25,6 +25,40 @@
 		regulator-max-microvolt = <3000000>;
 	};
 
+	/* HS USB Port 2 RESET */
+	hsusb2_reset: hsusb2_reset_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb2_reset";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>; /* gpio3_80 HUB_NRESET */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Host PHY on PORT 2 */
+	hsusb2_phy: hsusb2_phy {
+		compatible = "usb-nop-xceiv";
+		reset-supply = <&hsusb2_reset>;
+	};
+
+	/* HS USB Port 3 RESET */
+	hsusb3_reset: hsusb3_reset_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb3_reset";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>; /* gpio3_79 ETH_NRESET */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Host PHY on PORT 3 */
+	hsusb3_phy: hsusb3_phy {
+		compatible = "usb-nop-xceiv";
+		reset-supply = <&hsusb3_reset>;
+	};
+
 };
 
 &omap5_pmx_core {
@@ -35,6 +69,7 @@
 			&dmic_pins
 			&mcbsp1_pins
 			&mcbsp2_pins
+			&usbhost_pins
 	>;
 
 	twl6040_pins: pinmux_twl6040_pins {
@@ -120,6 +155,32 @@
 			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
 		>;
 	};
+
+	usbhost_pins: pinmux_usbhost_pins {
+		pinctrl-single,pins = <
+			0x84 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe */
+			0x86 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_data */
+
+			0x19e (PIN_INPUT | MUX_MODE0) /* usbb3_hsic_strobe */
+			0x1a0 (PIN_INPUT | MUX_MODE0) /* usbb3_hsic_data */
+
+			0x70 (PIN_OUTPUT | MUX_MODE6) /* gpio3_80 HUB_NRESET */
+			0x6e (PIN_OUTPUT | MUX_MODE6) /* gpio3_79 ETH_NRESET */
+		>;
+	};
+};
+
+&omap5_pmx_wkup {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&usbhost_wkup_pins
+	>;
+
+	usbhost_wkup_pins: pinmux_usbhost_wkup_pins {
+		pinctrl-single,pins = <
+			0x1A (PIN_OUTPUT | MUX_MODE0) /* fref_clk1_out, USB hub clk */
+		>;
+	};
 };
 
 &mmc1 {
@@ -164,6 +225,15 @@
 	status = "disabled";
 };
 
+&usbhshost {
+	port2-mode = "ehci-hsic";
+	port3-mode = "ehci-hsic";
+};
+
+&usbhsehci {
+	phys = <0 &hsusb2_phy &hsusb3_phy>;
+};
+
 &mcspi1 {
 
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 1e84db8..accab62 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -666,5 +666,35 @@
 				ctrl-module = <&omap_control_usb>;
 			};
 		};
+
+		usbhstll: usbhstll@4a062000 {
+			compatible = "ti,usbhs-tll";
+			reg = <0x4a062000 0x1000>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "usb_tll_hs";
+		};
+
+		usbhshost: usbhshost@4a064000 {
+			compatible = "ti,usbhs-host";
+			reg = <0x4a064000 0x800>;
+			ti,hwmods = "usb_host_hs";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usbhsohci: ohci@4a064800 {
+				compatible = "ti,ohci-omap3", "usb-ohci";
+				reg = <0x4a064800 0x400>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			usbhsehci: ehci@4a064c00 {
+				compatible = "ti,ehci-omap", "usb-ehci";
+				reg = <0x4a064c00 0x400>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
 	};
 };
-- 
1.7.9.5


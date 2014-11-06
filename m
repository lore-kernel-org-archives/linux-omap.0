From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 01/11] ARM: dts: omap3-igep00x0: Fix UART2 pins that aren't common.
Date: Thu,  6 Nov 2014 13:01:41 +0100
Message-ID: <1415275311-6857-2-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43451 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaKFMCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:24 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

UART2 is used to connect the processor with the bluetooth chip, these pins
are not common between IGEPv2 boards and IGEP COM MODULE boards. This patch
muxes the correct pins for every board and removes UART2 configuration from
common omap3-igep.dtsi file.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi    | 12 ------------
 arch/arm/boot/dts/omap3-igep0020.dts | 14 ++++++++++++++
 arch/arm/boot/dts/omap3-igep0030.dts | 16 ++++++++++++++++
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index e2d163b..fb1040d 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -53,13 +53,6 @@
 		>;
 	};
 
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			0x14a (PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
-			0x148 (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
-		>;
-	};
-
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
 			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx.uart3_rx */
@@ -198,11 +191,6 @@
        pinctrl-0 = <&uart1_pins>;
 };
 
-&uart2 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart2_pins>;
-};
-
 &uart3 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart3_pins>;
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index cc9343e..87d77e4 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -149,6 +149,15 @@
 			0x0da (PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
 		>;
 	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)	/* uart2_rts .uart2_rts*/
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)	/* uart2_tx.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)	/* uart2_rx.uart2_rx */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -256,6 +265,11 @@
 	};
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
+
 &usbhshost {
 	port1-mode = "ehci-phy";
 };
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 84b7452..2df1396 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -46,6 +46,17 @@
 	};
 };
 
+&omap3_pmx_core {
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x216c, PIN_INPUT | MUX_MODE1)	/* mcbsp3_dx.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x216e, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_dr.uart2_rts */
+			OMAP3_CORE1_IOPAD(0x2170, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_clk.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE1)	/* mcbsp3_fsx.uart2_rx */
+		>;
+	};
+};
+
 &omap3_pmx_core2 {
 	leds_pins: pinmux_leds_pins {
 		pinctrl-single,pins = <
@@ -104,3 +115,8 @@
 		};
 	};
 };
+
+&uart2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart2_pins>;
+};
-- 
1.9.1


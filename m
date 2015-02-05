From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix USB dts configuration for dm816x
Date: Thu, 5 Feb 2015 09:12:01 -0800
Message-ID: <20150205171201.GG25198@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.ore.mailhop.org ([54.149.88.251]:47824 "EHLO
	smtp3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbbBEROn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 12:14:43 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org

Commit 7800064ba507 ("ARM: dts: Add basic dm816x device tree
configuration") added basic devices for dm816x, but I was not able
to test the USB completely because of a unconfigure USB phy, and
I only tested it to make sure the Mentor chips are detected and
clocked without a phy.

After testing the USB with actual devices I noticed a few issues
that should be tested to avoid confusion:

- The USB id pin on dm8168-evm is hardwired and can be changed
  only by software. As there are two USB-A type connectors, let's
  start both in host mode instead of otg.

- The Mentor core is configured in such a way on dm8168-evm that
  it's not capable for multipoint at least on revision c board
  that I have.

- We need ranges for the syscon to properly set up the phy as
  children of the SCM syscon area.

- Let's not disable the second interface, the board specific
  dts files can do that if really needed. Most boards should
  just keep it enabled to ensure the device is idled properly.

Note that also a phy and several musb fixes are still needed to
make the USB to work properly in addition to this fix.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -35,6 +35,18 @@
 			DM816X_IOPAD(0x0aac, PIN_INPUT | MUX_MODE0)	/* SPI_D1 */
 		>;
 	};
+
+	usb0_pins: pinmux_usb0_pins {
+		pinctrl-single,pins = <
+			DM816X_IOPAD(0x0d00, MUX_MODE0)			/* USB0_DRVVBUS */
+		>;
+	};
+
+	usb1_pins: pinmux_usb0_pins {
+		pinctrl-single,pins = <
+			DM816X_IOPAD(0x0d04, MUX_MODE0)			/* USB1_DRVVBUS */
+		>;
+	};
 };
 
 &i2c1 {
@@ -127,3 +139,16 @@
 &mmc1 {
 	vmmc-supply = <&vmmcsd_fixed>;
 };
+
+/* At least dm8168-evm rev c won't support multipoint, later may */
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	mentor,multipoint = <0>;
+};
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+	mentor,multipoint = <0>;
+};
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -97,10 +97,31 @@
 
 			/* Device Configuration Registers */
 			scm_conf: syscon@600 {
-				compatible = "syscon";
+				compatible = "syscon", "simple-bus";
 				reg = <0x600 0x110>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+				ranges = <0 0x600 0x110>;
+
+				usb_phy0: usb-phy@20 {
+					compatible = "ti,dm8168-usb-phy";
+					reg = <0x20 0x8>;
+					reg-names = "phy";
+					clocks = <&main_fapll 6>;
+					clock-names = "refclk";
+					#phy-cells = <0>;
+					syscon = <&scm_conf>;
+				};
+
+				usb_phy1: usb-phy@28 {
+					compatible = "ti,dm8168-usb-phy";
+					reg = <0x28 0x8>;
+					reg-names = "phy";
+					clocks = <&main_fapll 6>;
+					clock-names = "refclk";
+					#phy-cells = <0>;
+					syscon = <&scm_conf>;
+				};
 			};
 
 			scrm_clocks: clocks {
@@ -357,7 +378,10 @@
 				reg-names = "mc", "control";
 				interrupts = <18>;
 				interrupt-names = "mc";
-				dr_mode = "otg";
+				dr_mode = "host";
+				interface-type = <0>;
+				phys = <&usb_phy0>;
+				phy-names = "usb2-phy";
 				mentor,multipoint = <1>;
 				mentor,num-eps = <16>;
 				mentor,ram-bits = <12>;
@@ -366,13 +390,15 @@
 
 			usb1: usb@47401800 {
 				compatible = "ti,musb-am33xx";
-				status = "disabled";
 				reg = <0x47401c00 0x400
 				       0x47401800 0x200>;
 				reg-names = "mc", "control";
 				interrupts = <19>;
 				interrupt-names = "mc";
-				dr_mode = "otg";
+				dr_mode = "host";
+				interface-type = <0>;
+				phys = <&usb_phy1>;
+				phy-names = "usb2-phy";
 				mentor,multipoint = <1>;
 				mentor,num-eps = <16>;
 				mentor,ram-bits = <12>;

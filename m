From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix dm816x pinctrl and syscon so they are children
 of SCM
Date: Mon, 26 Jan 2015 18:02:55 -0800
Message-ID: <20150127020254.GI7696@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.ore.mailhop.org ([54.149.88.251]:38007 "EHLO
	smtp3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391AbbA0CGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 21:06:07 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 21 Jan 2015 16:21:52 -0800
Subject: [PATCH] ARM: dts: Fix dm816x pinctrl and syscon so they are children of SCM

Looks like I only got half done with moving pinctrl and syscon to
be children of the SCM. I've set up the FAPLL clocks that way already,
but did not complete the job as I copied the syscon values from
am33xx.dtsi.

To make sure the syscon mapping works, I've verfified that we can
set up davinci_emac mac address the same way as cpsw already does
with the syscon mapping. So let's add that too.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -50,15 +50,6 @@
 		};
 	};
 
-	dm816x_pinmux: pinmux@44e10800 {
-		compatible = "pinctrl-single";
-		reg = <0x48140800 0x50a>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-single,register-width = <16>;
-		pinctrl-single,function-mask = <0xf>;
-	};
-
 	/*
 	 * XXX: Use a flat representation of the dm816x interconnect.
 	 * The real dm816x interconnect network is quite complex. Since
@@ -89,12 +80,29 @@
 		};
 
 		scrm: scrm@48140000 {
-			compatible = "ti,dm816-scrm";
+			compatible = "ti,dm816-scrm", "simple-bus";
 			reg = <0x48140000 0x21000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x48140000 0x21000>;
 
+			dm816x_pinmux: pinmux@800 {
+				compatible = "pinctrl-single";
+				reg = <0x800 0x50a>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0xf>;
+			};
+
+			/* Device Configuration Registers */
+			scm_conf: syscon@600 {
+				compatible = "syscon";
+				reg = <0x600 0x110>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
 			scrm_clocks: clocks {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -104,11 +112,6 @@
 			};
 		};
 
-		cm: syscon@44e10000 {
-			compatible = "ti,am33xx-controlmodule", "syscon";
-			reg = <0x44e10000 0x800>;
-		};
-
 		edma: edma@49000000 {
 			compatible = "ti,edma3";
 			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2", "tptc3";
@@ -213,6 +216,7 @@
 			reg = <0x4a100000 0x800
 			       0x4a100900 0x3700>;
 			clocks = <&sysclk24_ck>;
+			syscon = <&scm_conf>;
 			ti,davinci-ctrl-reg-offset = <0>;
 			ti,davinci-ctrl-mod-reg-offset = <0x900>;
 			ti,davinci-ctrl-ram-offset = <0x2000>;
@@ -226,6 +230,7 @@
 			ti,hwmods = "emac1";
 			reg = <0x4a120000 0x4000>;
 			clocks = <&sysclk24_ck>;
+			syscon = <&scm_conf>;
 			ti,davinci-ctrl-reg-offset = <0>;
 			ti,davinci-ctrl-mod-reg-offset = <0x900>;
 			ti,davinci-ctrl-ram-offset = <0x2000>;

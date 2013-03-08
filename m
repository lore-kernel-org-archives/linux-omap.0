From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 7/9] ARM: dts: Add OMAP2 gpio bindings
Date: Fri, 8 Mar 2013 11:27:31 -0600
Message-ID: <1362763654-9660-8-git-send-email-jon-hunter@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44480 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933767Ab3CHR2D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 12:28:03 -0500
In-Reply-To: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Add gpios bindings for OMAP2420 and OMAP2430 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi |   44 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index d4ce6c2..eee902f 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -29,6 +29,50 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		gpio1: gpio@48018000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x48018000 0x200>;
+			interrupts = <29>;
+			ti,hwmods = "gpio1";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio2: gpio@4801a000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4801a000 0x200>;
+			interrupts = <30>;
+			ti,hwmods = "gpio2";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio3: gpio@4801c000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4801c000 0x200>;
+			interrupts = <31>;
+			ti,hwmods = "gpio3";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio4: gpio@4801e000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4801e000 0x200>;
+			interrupts = <32>;
+			ti,hwmods = "gpio4";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
 		gpmc: gpmc@6800a000 {
 			compatible = "ti,omap2420-gpmc";
 			reg = <0x6800a000 0x1000>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 832f184..fb74382 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -29,6 +29,61 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		gpio1: gpio@4900c000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4900c000 0x200>;
+			interrupts = <29>;
+			ti,hwmods = "gpio1";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio2: gpio@4900e000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4900e000 0x200>;
+			interrupts = <30>;
+			ti,hwmods = "gpio2";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio3: gpio@49010000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x49010000 0x200>;
+			interrupts = <31>;
+			ti,hwmods = "gpio3";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio4: gpio@49012000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x49012000 0x200>;
+			interrupts = <32>;
+			ti,hwmods = "gpio4";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio5: gpio@480b6000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x480b6000 0x200>;
+			interrupts = <33>;
+			ti,hwmods = "gpio5";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
 		gpmc: gpmc@6e000000 {
 			compatible = "ti,omap2430-gpmc";
 			reg = <0x6e000000 0x1000>;
-- 
1.7.10.4


From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 4/8] ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
Date: Fri, 15 Mar 2013 08:57:37 -0500
Message-ID: <1363355861-11773-5-git-send-email-jon-hunter@ti.com>
References: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53189 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab3CON57 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 09:57:59 -0400
In-Reply-To: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Add the device-tree node for GPMC on OMAP2, OMAP4 and OMAP5 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi |   11 +++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   11 +++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   11 +++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   11 +++++++++++
 4 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index af65609..d4ce6c2 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -29,6 +29,17 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		gpmc: gpmc@6800a000 {
+			compatible = "ti,omap2420-gpmc";
+			reg = <0x6800a000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			interrupts = <20>;
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <4>;
+			ti,hwmods = "gpmc";
+		};
+
 		mcbsp1: mcbsp@48074000 {
 			compatible = "ti,omap2420-mcbsp";
 			reg = <0x48074000 0xff>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index c392445..832f184 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -29,6 +29,17 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		gpmc: gpmc@6e000000 {
+			compatible = "ti,omap2430-gpmc";
+			reg = <0x6e000000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			interrupts = <20>;
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <4>;
+			ti,hwmods = "gpmc";
+		};
+
 		mcbsp1: mcbsp@48074000 {
 			compatible = "ti,omap2430-mcbsp";
 			reg = <0x48074000 0xff>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 6669311..bcd64f5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -196,6 +196,17 @@
 			#interrupt-cells = <1>;
 		};
 
+		gpmc: gpmc@50000000 {
+			compatible = "ti,omap4430-gpmc";
+			reg = <0x50000000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			interrupts = <0 20 0x4>;
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <4>;
+			ti,hwmods = "gpmc";
+		};
+
 		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index f840499..61cbd1c 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -208,6 +208,17 @@
 			#interrupt-cells = <1>;
 		};
 
+		gpmc: gpmc@50000000 {
+			compatible = "ti,omap4430-gpmc";
+			reg = <0x50000000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			interrupts = <0 20 0x4>;
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <4>;
+			ti,hwmods = "gpmc";
+		};
+
 		i2c1: i2c@48070000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48070000 0x100>;
-- 
1.7.10.4


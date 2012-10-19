From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 1/2] ARM: dts: OMAP: Add counter-32k nodes
Date: Fri, 19 Oct 2012 10:05:50 -0500
Message-ID: <1350659151-13898-2-git-send-email-jon-hunter@ti.com>
References: <1350659151-13898-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51928 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab2JSPGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 11:06:06 -0400
In-Reply-To: <1350659151-13898-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Adds the counter-32k timers nodes present in OMAP2/3/4 devices and
device-tree binding documentation for OMAP counter-32k.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/arm/omap/counter.txt       |   15 +++++++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    6 ++++++
 arch/arm/boot/dts/omap2430.dtsi                    |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 ++++++
 arch/arm/boot/dts/omap4.dtsi                       |    6 ++++++
 5 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/counter.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/counter.txt b/Documentation/devicetree/bindings/arm/omap/counter.txt
new file mode 100644
index 0000000..f6baa09
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/counter.txt
@@ -0,0 +1,15 @@
+OMAP Counter-32K bindings
+
+Required properties:
+- compatible:	Must be "ti,omap-counter32k" for OMAP controllers
+- reg:		Contains timer register address range (base address and length)
+- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
+		"counter_32k"
+
+Example:
+
+counter32k: counter@4a304000 {
+	compatible = "ti,omap-counter32k";
+	reg = <0x4a304000 0x001f>;
+	ti,hwmods = "counter_32k";
+};
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index 13cfa2c..7f1a705 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -14,6 +14,12 @@
 	compatible = "ti,omap2420", "ti,omap2";
 
 	ocp {
+		counter32k: counter@48004000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x48004000 0x001f>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap2420_pmx: pinmux@48000030 {
 			compatible = "ti,omap2420-padconf", "pinctrl-single";
 			reg = <0x48000030 0x0113>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 886b825..c3f9f2d 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -14,6 +14,12 @@
 	compatible = "ti,omap2430", "ti,omap2";
 
 	ocp {
+		counter32k: counter@49020000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x49020000 0x001f>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap2430_pmx: pinmux@49002030 {
 			compatible = "ti,omap2430-padconf", "pinctrl-single";
 			reg = <0x49002030 0x0154>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1fba998..4e958a7 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -60,6 +60,12 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
+		counter32k: counter@48320000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x48320000 0x001f>;
+			ti,hwmods = "counter_32k";
+		};
+
 		intc: interrupt-controller@48200000 {
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index f9572bf..321839d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -95,6 +95,12 @@
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
+		counter32k: counter@4a304000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4a304000 0x001f>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap4_pmx_core: pinmux@4a100040 {
 			compatible = "ti,omap4-padconf", "pinctrl-single";
 			reg = <0x4a100040 0x0196>;
-- 
1.7.9.5


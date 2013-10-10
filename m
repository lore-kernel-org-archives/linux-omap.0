From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 1/2] arm: dts: omap4+: Add DMM bindings
Date: Thu, 10 Oct 2013 12:06:33 +0530
Message-ID: <1381386994-24747-2-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
 <1381386994-24747-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51659 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193Ab3JJGhb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 02:37:31 -0400
In-Reply-To: <1381386994-24747-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, tomi.valkeinen@ti.com, robdclark@gmail.com
Cc: linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>

Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 devices. DMM
only requires address and irq information.

Add documentation for the DMM bindings.

Originally worked on by Andy Gross <andygro@gmail.com>

Cc: Andy Gross <andygro@gmail.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/dmm.txt | 16 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
 3 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Documentation/devicetree/bindings/arm/omap/dmm.txt
new file mode 100644
index 0000000..6fc3d79
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
@@ -0,0 +1,16 @@
+OMAP Dynamic Memory Manager (DMM) bindings
+
+Required properties:
+- compatible:	Must be "ti,omap4-dmm" for OMAP4 family
+		Must be "ti,omap5-dmm" for OMAP5 and DRA7x family
+- reg:		Contains timer register address range (base address and length)
+- interrupts:	Contains interrupt information (source, etc) for the DMM IRQ
+- ti,hwmods:	Name of the hwmod associated to DMM, which is typically "dmm"
+
+Example:
+
+dmm@4e000000 {
+	compatible = "ti,omap4-dmm";
+	reg = <0x4e000000 0x800>;
+	ti,hwmods = "dmm";
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..b6bf288 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -487,6 +487,13 @@
 			ti,hwmods = "kbd";
 		};
 
+		dmm@4e000000 {
+			compatible = "ti,omap4-dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
+
 		emif1: emif@4c000000 {
 			compatible = "ti,emif-4d";
 			reg = <0x4c000000 0x100>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 7cdea1b..e405458 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -604,6 +604,13 @@
 			ti,hwmods = "wd_timer2";
 		};
 
+		dmm@4e000000 {
+			compatible = "ti,omap5-dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
+
 		emif1: emif@0x4c000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif1";
-- 
1.8.1.2


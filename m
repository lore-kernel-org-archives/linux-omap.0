From: Archit Taneja <archit@ti.com>
Subject: [PATCH v5 1/2] arm: dts: omap4+: Add DMM bindings
Date: Tue, 17 Dec 2013 15:32:21 +0530
Message-ID: <1387274542-29645-2-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
 <1387274542-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46786 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab3LQKCl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 05:02:41 -0500
In-Reply-To: <1387274542-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, mark.rutland@arm.com
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>

Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 and DRA7x devices.
DMM only requires address and irq information.

Add documentation for the DMM bindings.

Originally worked on by Andy Gross <andygro@gmail.com>

Cc: Andy Gross <andygro@gmail.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/dmm.txt | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                        |  7 +++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
 4 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Documentation/devicetree/bindings/arm/omap/dmm.txt
new file mode 100644
index 0000000..8bd6d0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
@@ -0,0 +1,22 @@
+OMAP Dynamic Memory Manager (DMM) bindings
+
+The dynamic memory manager (DMM) is a module located immediately in front of the
+SDRAM controllers (called EMIFs on OMAP). DMM manages various aspects of memory
+accesses such as priority generation amongst initiators, configuration of SDRAM
+interleaving, optimizing transfer of 2D block objects, and provide MMU-like page
+translation for initiators which need contiguous dma bus addresses.
+
+Required properties:
+- compatible:	Should contain "ti,omap4-dmm" for OMAP4 family
+		Should contain "ti,omap5-dmm" for OMAP5 and DRA7x family
+- reg:		Contains DMM register address range (base address and length)
+- interrupts:	Should contain an interrupt-specifier for DMM_IRQ.
+- ti,hwmods:	Name of the hwmod associated to DMM, which is typically "dmm"
+
+Example:
+
+dmm@4e000000 {
+	compatible = "ti,omap4-dmm";
+	reg = <0x4e000000 0x800>;
+	ti,hwmods = "dmm";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..c9bb006 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -425,6 +425,13 @@
 			ti,hwmods = "wd_timer2";
 		};
 
+		dmm@4e000000 {
+			compatible = "ti,omap5-dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
+
 		i2c1: i2c@48070000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48070000 0x100>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e0585..3c67b2f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -502,6 +502,13 @@
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
index fc3fad5..878f635 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -621,6 +621,13 @@
 			ti,hwmods = "wd_timer2";
 		};
 
+		dmm@4e000000 {
+			compatible = "ti,omap5-dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
+
 		emif1: emif@4c000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif1";
-- 
1.8.3.2


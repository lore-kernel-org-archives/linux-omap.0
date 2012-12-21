From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 15/15] ARM: dts: Add AES data and documentation for AM33XX
Date: Fri, 21 Dec 2012 09:28:15 -0700
Message-ID: <1356107295-11121-16-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38834 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab2LUQ2e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 11:28:34 -0500
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Add the generic AM33XX AES module's device tree data and
enable it for the am335x-evm, am335x-evmsk, and am335x-bone
platforms.  Also add Documentation file describing the data
for the AES module.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 .../devicetree/bindings/crypto/omap-aes.txt        | 37 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  4 +++
 arch/arm/boot/dts/am335x-evm.dts                   |  4 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  4 +++
 arch/arm/boot/dts/am33xx.dtsi                      | 13 ++++++++
 5 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt

diff --git a/Documentation/devicetree/bindings/crypto/omap-aes.txt b/Documentation/devicetree/bindings/crypto/omap-aes.txt
new file mode 100644
index 0000000..6b21256
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/omap-aes.txt
@@ -0,0 +1,37 @@
+OMAP SoC AES crypto Module
+
+Required properties:
+
+- compatible : Should contain entries for this and backward compatible
+  AES versions:
+  - "ti,omap2-aes" for OMAP2.
+  - "ti,omap3-aes" for OMAP3.
+  - "ti,omap4-aes" for OMAP4 and AM33XX.
+  Note that the OMAP2 and 3 versions are compatible (OMAP3 supports
+  more algorithms) but they are incompatible with OMAP4.
+- ti,hwmods: Name of the hwmod associated with the AES odule
+- reg : Offset and length of the register set for the module
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this module.
+- interrupts : the interrupt number for the AES odule.
+
+Optional properties:
+- dmas: DMA controller phandle and DMA request ordered pairs.
+- dma-names: DMA request names. This string corresponds 1:1 with
+	the ordered pairs in dmas. The string naming is to be
+	"tx" for TX request and "rx" for RX request.
+
+Example:
+	/* AM335x */
+	aes: aes@53500000 {
+		compatible = "ti,omap4-aes";
+		ti,hwmods = "aes";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x53500000 0xa0>;
+		interrupt-parent = <&intc>;
+		interrupts = <102>;
+		dmas = <&edma 6
+			&edma 5>;
+		dma-names = "tx", "rx";
+	};
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 1c35f83..4ade888 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -196,3 +196,7 @@
 &sham {
 	status = "okay";
 };
+
+&aes {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 57515cd..743635b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -263,3 +263,7 @@
 &sham {
 	status = "okay";
 };
+
+&aes {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index b322919..1cf8fe1 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -252,3 +252,7 @@
 &sham {
 	status = "okay";
 };
+
+&aes {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 671135e..0aa1a53 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -467,5 +467,18 @@
 			dmas = <&edma 36>;
 			dma-names = "rx";
 		};
+
+		aes: aes@53500000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x53500000 0xa0>;
+			interrupt-parent = <&intc>;
+			interrupts = <102>;
+			dmas = <&edma 6
+				&edma 5>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
1.7.12


From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 08/15] ARM: dts: Add SHAM data and documentation for AM33XX
Date: Fri, 21 Dec 2012 09:28:08 -0700
Message-ID: <1356107295-11121-9-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38959 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab2LUQ2l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 11:28:41 -0500
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Add the generic AM33XX SHAM module's device tree data and
enable it for the am335x-evm, am335x-evmsk, and am335x-bone
platforms.  Also add Documentation file describing the data
for the SHAM module.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 .../devicetree/bindings/crypto/omap-sham.txt       | 35 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  4 +++
 arch/arm/boot/dts/am335x-evm.dts                   |  4 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  4 +++
 arch/arm/boot/dts/am33xx.dtsi                      | 12 ++++++++
 5 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
new file mode 100644
index 0000000..53839cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/omap-sham.txt
@@ -0,0 +1,35 @@
+OMAP SoC SHA crypto Module
+
+Required properties:
+
+- compatible : Should contain entries for this and backward compatible
+  SHAM versions:
+  - "ti,omap2-sham" for OMAP2 & OMAP3.
+  - "ti,omap4-sham" for OMAP4 and AM33XX.
+  Note that these two versions are incompatible.
+- ti,hwmods: Name of the hwmod associated with the SHAM module
+- reg : Offset and length of the register set for the module
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this module.
+- interrupts : the interrupt number for the SHAM module.
+
+Optional properties:
+- dmas: DMA controller phandle and DMA request ordered pair.
+	Only one rx pair is valid per SHAM module.
+- dma-names: DMA request name. This string corresponds 1:1 with
+	the ordered pair in dmas. The string naming is to be
+	"rx" for RX request.
+
+Example:
+	/* AM335x */
+	sham: sham@53100000 {
+		compatible = "ti,omap4-sham";
+		ti,hwmods = "sham";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x53100000 0x200>;
+		interrupt-parent = <&intc>;
+		interrupts = <109>;
+		dmas = <&edma 36>;
+		dma-names = "rx";
+	};
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 9075198..1c35f83 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -192,3 +192,7 @@
 &edma {
 	ti,edma-xbar-event-map = <32 12>;
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 70ac496..57515cd 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -259,3 +259,7 @@
 		reg = <0>;
 	};
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f5a6162..b322919 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -248,3 +248,7 @@
 		};
 	};
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c02ade7..671135e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -455,5 +455,17 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		sham: sham@53100000 {
+			compatible = "ti,omap4-sham";
+			ti,hwmods = "sham";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x53100000 0x200>;
+			interrupt-parent = <&intc>;
+			interrupts = <109>;
+			dmas = <&edma 36>;
+			dma-names = "rx";
+		};
 	};
 };
-- 
1.7.12


From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v2 2/2] ARM: dts: Add AES data and documentation for AM33XX
Date: Wed, 17 Jul 2013 09:23:42 -0700
Message-ID: <1374078222-12883-3-git-send-email-mgreer@animalcreek.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:51897
	"EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756440Ab3GQQX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 12:23:57 -0400
In-Reply-To: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Add the generic AM33XX AES module's device tree data and
enable it for the am335x-evm, am335x-evmsk, and am335x-bone
platforms.  Also add Documentation file describing the data
for the AES module.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 .../devicetree/bindings/crypto/omap-aes.txt        | 35 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  4 +++
 arch/arm/boot/dts/am335x-evm.dts                   |  4 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  4 +++
 arch/arm/boot/dts/am33xx.dtsi                      | 11 +++++++
 5 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt

diff --git a/Documentation/devicetree/bindings/crypto/omap-aes.txt b/Documentation/devicetree/bindings/crypto/omap-aes.txt
new file mode 100644
index 0000000..b51d12f
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/omap-aes.txt
@@ -0,0 +1,35 @@
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
+		reg = <0x53500000 0xa0>;
+		interrupt-parent = <&intc>;
+		interrupts = <102>;
+		dmas = <&edma 6
+			&edma 5>;
+		dma-names = "tx", "rx";
+	};
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index bc75b2c..0cb454e 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -238,3 +238,7 @@
 &sham {
 	status = "okay";
 };
+
+&aes {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 9b8c56d..76ba004 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -492,3 +492,7 @@
 &sham {
 	status = "okay";
 };
+
+&aes {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 61dc5d4..025a47e 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -406,3 +406,7 @@
 &sham {
 	status = "okay";
 };
+
+&aes {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 63a5e95..2a7ff0f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -540,5 +540,16 @@
 			dmas = <&edma 36>;
 			dma-names = "rx";
 		};
+
+		aes: aes@53500000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
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


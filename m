From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 1/2] ARM: dts: Add SHAM data and documentation for AM33XX
Date: Tue, 16 Jul 2013 16:29:27 -0700
Message-ID: <1374017368-5267-2-git-send-email-mgreer@animalcreek.com>
References: <1374017368-5267-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:36550
	"EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933546Ab3GPX35 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jul 2013 19:29:57 -0400
In-Reply-To: <1374017368-5267-1-git-send-email-mgreer@animalcreek.com>
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
 .../devicetree/bindings/crypto/omap-sham.txt       | 33 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  4 +++
 arch/arm/boot/dts/am335x-evm.dts                   |  4 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  3 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  9 ++++++
 5 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
new file mode 100644
index 0000000..c6d1202
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/omap-sham.txt
@@ -0,0 +1,33 @@
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
+		reg = <0x53100000 0x200>;
+		interrupt-parent = <&intc>;
+		interrupts = <109>;
+		dmas = <&edma 36>;
+		dma-names = "rx";
+	};
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 444b4ed..bc75b2c 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -234,3 +234,7 @@
 	pinctrl-0 = <&davinci_mdio_default>;
 	pinctrl-1 = <&davinci_mdio_sleep>;
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 3aee1a4..9b8c56d 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -488,3 +488,7 @@
 		ti,adc-channels = <4 5 6 7>;
 	};
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 0c8ad17..b04aea1 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -401,4 +401,7 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii-txid";
+
+&sham {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..eb0e719 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -529,6 +529,15 @@
 			#address-cells = <2>;
 			#size-cells = <1>;
 			status = "disabled";
+
+		sham: sham@53100000 {
+			compatible = "ti,omap4-sham";
+			ti,hwmods = "sham";
+			reg = <0x53100000 0x200>;
+			interrupt-parent = <&intc>;
+			interrupts = <109>;
+			dmas = <&edma 36>;
+			dma-names = "rx";
 		};
 	};
 };
-- 
1.7.12


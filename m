From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH] ARM: dts: cm-t3x: add NAND support
Date: Sun, 28 Dec 2014 15:15:03 +0200
Message-ID: <1419772503-11671-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:44860 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbaL1NP3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 28 Dec 2014 08:15:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add NAND support

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   58 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-sbc-t3517.dts |    4 ++
 arch/arm/boot/dts/omap3-sbc-t3530.dts |   10 ++----
 arch/arm/boot/dts/omap3-sbc-t3730.dts |    5 ++-
 4 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 6ea6d46..4d091ca 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -259,3 +259,61 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcbsp2_pins>;
 };
+
+&gpmc {
+	ranges = <0 0 0x00000000 0x01000000>;
+
+	nand@0,0 {
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		ti,nand-ecc-opt = "sw";
+
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <120>;
+		gpmc,cs-wr-off-ns = <120>;
+
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <120>;
+		gpmc,adv-wr-off-ns = <120>;
+
+		gpmc,we-on-ns = <6>;
+		gpmc,we-off-ns = <90>;
+
+		gpmc,oe-on-ns = <6>;
+		gpmc,oe-off-ns = <90>;
+
+		gpmc,page-burst-access-ns = <6>;
+		gpmc,access-ns = <72>;
+		gpmc,cycle2cycle-delay-ns = <60>;
+
+		gpmc,rd-cycle-ns = <120>;
+		gpmc,wr-cycle-ns = <120>;
+		gpmc,wr-access-ns = <186>;
+		gpmc,wr-data-mux-bus-ns = <90>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "xloader";
+			reg = <0 0x80000>;
+		};
+		partition@0x80000 {
+			label = "uboot";
+			reg = <0x80000 0x1e0000>;
+		};
+		partition@0x260000 {
+			label = "uboot environment";
+			reg = <0x260000 0x40000>;
+		};
+		partition@0x2a0000 {
+			label = "linux";
+			reg = <0x2a0000 0x400000>;
+		};
+		partition@0x6a0000 {
+			label = "rootfs";
+			reg = <0x6a0000 0x1f880000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
index 1798653..c2d5c28 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
@@ -69,3 +69,7 @@
 	};
 };
 
+&gpmc {
+	ranges = <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
+		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
+};
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
index c994f0f..834bc78 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -26,14 +26,10 @@
 	};
 };
 
-/*
- * The following ranges correspond to SMSC9x eth chips on CM-T3530 CoM and
- * SB-T35 baseboard respectively.
- * This setting includes both chips in SBC-T3530 board device tree.
- */
 &gpmc {
-	ranges = <5 0 0x2c000000 0x01000000>,
-		 <4 0 0x2d000000 0x01000000>;
+	ranges = <5 0 0x2c000000 0x01000000>,	/* CM-T3x30 SMSC9x Eth */
+		 <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
+		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
 };
 
 &mmc1 {
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index 5bdddf2..73c7bf4 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -27,8 +27,9 @@
 };
 
 &gpmc {
-	ranges = <5 0 0x2c000000 0x01000000>,
-		 <4 0 0x2d000000 0x01000000>;
+	ranges = <5 0 0x2c000000 0x01000000>,	/* CM-T3x30 SMSC9x Eth */
+		 <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
+		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
 };
 
 &dss {
-- 
1.7.5.4


From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 02/11] ARM: dts: omap3-igep00x0: Move NAND configuration to a common place.
Date: Thu,  6 Nov 2014 13:01:42 +0100
Message-ID: <1415275311-6857-3-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63301 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaKFMCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:23 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

At this moment all supported boards use same NAND chip, so has more sense
move the GPMC and NAND configuration to the omap3-igep.dtsi common place.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi    | 49 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-igep0020.dts | 47 ---------------------------------
 arch/arm/boot/dts/omap3-igep0030.dts | 51 ------------------------------------
 3 files changed, 49 insertions(+), 98 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index fb1040d..04a58ab 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -128,6 +128,55 @@
 	};
 };
 
+&gpmc {
+	nand@0,0 {
+		linux,mtd-name= "micron,mt29c4g96maz";
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		ti,nand-ecc-opt = "bch8";
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "SPL";
+			reg = <0 0x100000>;
+		};
+		partition@80000 {
+			label = "U-Boot";
+			reg = <0x100000 0x180000>;
+		};
+		partition@1c0000 {
+			label = "Environment";
+			reg = <0x280000 0x100000>;
+		};
+		partition@280000 {
+			label = "Kernel";
+			reg = <0x380000 0x300000>;
+		};
+		partition@780000 {
+			label = "Filesystem";
+			reg = <0x680000 0x1f980000>;
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 87d77e4..731ab8f 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -209,53 +209,6 @@
 	ranges = <0 0 0x00000000 0x1000000>,	/* CS0: 16MB for NAND */
 		 <5 0 0x2c000000 0x01000000>;
 
-	nand@0,0 {
-		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
-		nand-bus-width = <16>;
-		gpmc,device-width = <2>;
-		ti,nand-ecc-opt = "bch8";
-
-		gpmc,sync-clk-ps = <0>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <44>;
-		gpmc,cs-wr-off-ns = <44>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <34>;
-		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-off-ns = <40>;
-		gpmc,oe-off-ns = <54>;
-		gpmc,access-ns = <64>;
-		gpmc,rd-cycle-ns = <82>;
-		gpmc,wr-cycle-ns = <82>;
-		gpmc,wr-access-ns = <40>;
-		gpmc,wr-data-mux-bus-ns = <0>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			label = "SPL";
-			reg = <0 0x100000>;
-		};
-		partition@80000 {
-			label = "U-Boot";
-			reg = <0x100000 0x180000>;
-		};
-		partition@1c0000 {
-			label = "Environment";
-			reg = <0x280000 0x100000>;
-		};
-		partition@280000 {
-			label = "Kernel";
-			reg = <0x380000 0x300000>;
-		};
-		partition@780000 {
-			label = "Filesystem";
-			reg = <0x680000 0x1f980000>;
-		};
-	};
-
 	ethernet@gpmc {
 		pinctrl-names = "default";
 		pinctrl-0 = <&smsc9221_pins>;
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 2df1396..5862380 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -65,57 +65,6 @@
 	};
 };
 
-&gpmc {
-	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
-
-	nand@0,0 {
-		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
-		nand-bus-width = <16>;
-		gpmc,device-width = <2>;
-		ti,nand-ecc-opt = "bch8";
-
-		gpmc,sync-clk-ps = <0>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <44>;
-		gpmc,cs-wr-off-ns = <44>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <34>;
-		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-off-ns = <40>;
-		gpmc,oe-off-ns = <54>;
-		gpmc,access-ns = <64>;
-		gpmc,rd-cycle-ns = <82>;
-		gpmc,wr-cycle-ns = <82>;
-		gpmc,wr-access-ns = <40>;
-		gpmc,wr-data-mux-bus-ns = <0>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			label = "SPL";
-			reg = <0 0x100000>;
-		};
-		partition@80000 {
-			label = "U-Boot";
-			reg = <0x100000 0x180000>;
-		};
-		partition@1c0000 {
-			label = "Environment";
-			reg = <0x280000 0x100000>;
-		};
-		partition@280000 {
-			label = "Kernel";
-			reg = <0x380000 0x300000>;
-		};
-		partition@780000 {
-			label = "Filesystem";
-			reg = <0x680000 0x1f980000>;
-		};
-	};
-};
-
 &uart2 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart2_pins>;
-- 
1.9.1


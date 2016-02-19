From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 26/26] ARM: dts: omap3: Fix gpmc and NAND nodes
Date: Fri, 19 Feb 2016 23:15:48 +0200
Message-ID: <1455916548-3441-27-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

The GPMC driver now implements gpiochip and irqchip so
enable gpio-controller and interrupt-controller properties.

With this the interrupt parent of NAND node changes so fix it
accordingly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |  3 ++-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi        |  8 ++++++--
 arch/arm/boot/dts/omap3-beagle.dts                |  5 ++++-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi               |  6 +++++-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi    |  4 ++++
 arch/arm/boot/dts/omap3-evm-37xx.dts              |  8 ++++++--
 arch/arm/boot/dts/omap3-gta04.dtsi                |  4 ++++
 arch/arm/boot/dts/omap3-igep.dtsi                 |  6 +++++-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi      |  4 ++--
 arch/arm/boot/dts/omap3-igep0030-common.dtsi      |  4 ++++
 arch/arm/boot/dts/omap3-ldp.dts                   | 10 +++++++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi           |  6 +++++-
 arch/arm/boot/dts/omap3-overo-base.dtsi           |  6 +++++-
 arch/arm/boot/dts/omap3-pandora-common.dtsi       |  4 ++++
 arch/arm/boot/dts/omap3-tao3530.dtsi              |  6 +++++-
 arch/arm/boot/dts/omap3.dtsi                      |  4 ++++
 arch/arm/boot/dts/omap3430-sdp.dts                |  6 +++++-
 17 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 874ce46..490f41a 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -93,7 +93,8 @@
 };
 
 &gpmc {
-	ranges = <1 0 0x08000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
+	ranges = <0 0 0x30000000 0x1000000	/* CS0: 16MB for NAND */
+		  1 0 0x2c000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 2eca34c..ed8a62a 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -35,11 +35,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
-		linux,mtd-name = "micron,mt29f4g16abbda3w";
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		linux,mtd-name = "micron,mt29f4g16abbda3w";
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 8ba465d..4602866 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -384,8 +384,11 @@
 
 	/* Chip select 0 */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;		/* NAND I/O window, 4 bytes */
-		interrupts = <20>;
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		ti,nand-ecc-opt = "ham1";
 		nand-bus-width = <16>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index e5f7f5c..a8127bc 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -261,10 +261,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <8>;
 		gpmc,device-width = <1>;
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index 86850bb..b1b8ebf 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -204,7 +204,11 @@
 	ranges = <0 0 0x30000000 0x1000000>;       /* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index ac18865..76056ba 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -154,12 +154,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x1000000>,	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
 		 <5 0 0x2c000000 0x01000000>;
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		linux,mtd-name= "hynix,h8kds0un0mer-4em";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 5e2d643..ab9fb8f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -492,7 +492,11 @@
 	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 4fc7e0f..41f5d38 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -99,8 +99,12 @@
 
 &gpmc {
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index d90f12c..d6f839c 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -210,8 +210,8 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>,
-		 <5 0 0x2c000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>,	/* CS0: 16MB for NAND */
+		 <5 0 0x2c000000 0x01000000>;	/* CS5: 16MB for ethernet */
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
index 63f8b9a..e94d942 100644
--- a/arch/arm/boot/dts/omap3-igep0030-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
@@ -99,3 +99,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
 };
+
+&gpmc {
+	ranges = <0 0 0x30000000 0x01000000>;   /* CS0: 16MB for NAND */
+};
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 5401630..2f353da 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -97,12 +97,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>,
-		 <1 0 0x08000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0 space, 16MB */
+		 <1 0 0x08000000 0x1000000>;	/* CS1 space, 16MB */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		linux,mtd-name= "micron,nand";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 93f8dfe..eff816e 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -362,7 +362,11 @@
 		<7 0 0x15000000 0x01000000>;
 
 	nand@0,0 {
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		/* no elm on omap3 */
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index a29ad16..de256fa 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -226,8 +226,12 @@
 	ranges = <0 0 0x00000000 0x20000000>;
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 0>;
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 13e9d1f..bcf39d6 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -546,7 +546,11 @@
 	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "sw";
 
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index ae5dbbd..644d3c8 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -275,10 +275,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;	/* GPMC_DEVWIDTH_16BIT */
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d1ffabb..9dbbcf6 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -723,6 +723,10 @@
 			gpmc,num-waitpins = <4>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		usb_otg_hs: usb_otg_hs@480ab000 {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 16b0cdf..a0dc8d8 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -103,10 +103,14 @@
 	};
 
 	nand@1,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		linux,mtd-name= "micron,mt29f1g08abb";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <1 0 4>;	/* CS1, offset 0, IO size 4 */
 		ti,nand-ecc-opt = "sw";
 		nand-bus-width = <8>;
 		gpmc,cs-on-ns = <0>;
-- 
2.1.4

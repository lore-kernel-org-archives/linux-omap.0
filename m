From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 27/27] ARM: dts: omap3: Fix gpmc and NAND nodes
Date: Fri, 18 Sep 2015 17:53:49 +0300
Message-ID: <1442588029-13769-28-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

The GPMC driver now implements gpiochip and irqchip so
enable gpio-controller and interrupt-controller properties.

With this the interrupt parent of NAND node changes so fix it
accordingly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi     | 7 +++++--
 arch/arm/boot/dts/omap3-beagle.dts             | 2 ++
 arch/arm/boot/dts/omap3-cm-t3x.dtsi            | 5 ++++-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi | 3 +++
 arch/arm/boot/dts/omap3-evm-37xx.dts           | 7 +++++--
 arch/arm/boot/dts/omap3-gta04.dtsi             | 3 +++
 arch/arm/boot/dts/omap3-igep.dtsi              | 5 ++++-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi   | 4 ++--
 arch/arm/boot/dts/omap3-igep0030-common.dtsi   | 4 ++++
 arch/arm/boot/dts/omap3-ldp.dts                | 9 ++++++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi        | 5 ++++-
 arch/arm/boot/dts/omap3-pandora-common.dtsi    | 3 +++
 arch/arm/boot/dts/omap3-tao3530.dtsi           | 5 ++++-
 arch/arm/boot/dts/omap3.dtsi                   | 4 ++++
 arch/arm/boot/dts/omap3430-sdp.dts             | 5 ++++-
 15 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 36387b1..4ba73c9 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -35,11 +35,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
-		linux,mtd-name = "micron,mt29f4g16abbda3w";
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
+		linux,mtd-name = "micron,mt29f4g16abbda3w";
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a547411..bb4df5d 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -384,7 +384,9 @@
 
 	/* Chip select 0 */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;		/* NAND I/O window, 4 bytes */
+		interrupt-parent = <&intc>;
 		interrupts = <20>;
 		ti,nand-ecc-opt = "ham1";
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 4d091ca..e9d7e28 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -261,10 +261,13 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		nand-bus-width = <8>;
 		gpmc,device-width = <1>;
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index 9ca2865..e7b46ad 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -204,7 +204,10 @@
 	ranges = <0 0 0x30000000 0x1000000>;       /* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index 16e8ce3..7081e07 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -154,12 +154,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x1000000>,	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
 		 <5 0 0x2c000000 0x01000000>;
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		linux,mtd-name= "hynix,h8kds0un0mer-4em";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7166d88..4c48b31 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -492,7 +492,10 @@
 	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index d5e5cd4..1324f51 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -101,8 +101,11 @@
 
 &gpmc {
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index e458c21..8b7b7c7 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -204,8 +204,8 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>,
-		 <5 0 0x2c000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>,	/* CS0: 16MB for NAND */
+		 <5 0 0x2c000000 0x01000000>;	/* CS5: 16MB for ethernet */
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
index 0cb1527..c5d8210 100644
--- a/arch/arm/boot/dts/omap3-igep0030-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
@@ -58,3 +58,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
 };
+
+&gpmc {
+	ranges = <0 0 0x30000000 0x01000000>;   /* CS0: 16MB for NAND */
+};
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index bd6e676..fb86131 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -97,12 +97,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>,
-		 <1 0 0x08000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0 space, 16MB */
+		 <1 0 0x08000000 0x1000000>;	/* CS1 space, 16MB */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		linux,mtd-name= "micron,nand";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index d0dd036..abc39f4 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -362,7 +362,10 @@
 		<7 0 0x15000000 0x01000000>;
 
 	nand@0,0 {
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		/* no elm on omap3 */
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index f2084e6..11ada97 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -546,7 +546,10 @@
 	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "sw";
 
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index 7bd8d9a..838e0da 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -275,10 +275,13 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;	/* GPMC_DEVWIDTH_16BIT */
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cf..f802bcf 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -720,6 +720,10 @@
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
index 16b0cdf..3f113c5 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -103,10 +103,13 @@
 	};
 
 	nand@1,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
 		linux,mtd-name= "micron,mt29f1g08abb";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <1 0 4>;	/* CS1, offset 0, IO size 4 */
 		ti,nand-ecc-opt = "sw";
 		nand-bus-width = <8>;
 		gpmc,cs-on-ns = <0>;
-- 
2.1.4

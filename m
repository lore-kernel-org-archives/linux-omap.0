From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 11/12] ARM: dts: OMAP2+: Fix NAND device nodes
Date: Fri, 10 Jul 2015 15:23:38 +0300
Message-ID: <1436531019-18088-12-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts   |  9 +++++++--
 arch/arm/boot/dts/am335x-chilisom.dtsi       |  8 ++++++--
 arch/arm/boot/dts/am335x-evm.dts             |  8 ++++++--
 arch/arm/boot/dts/am335x-igep0033.dtsi       |  8 ++++++--
 arch/arm/boot/dts/am437x-gp-evm.dts          |  8 ++++++--
 arch/arm/boot/dts/am43x-epos-evm.dts         |  8 ++++++--
 arch/arm/boot/dts/dm8168-evm.dts             |  8 ++++++--
 arch/arm/boot/dts/dra7-evm.dts               |  8 ++++++--
 arch/arm/boot/dts/dra72-evm.dts              |  8 ++++++--
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi   |  9 +++++++--
 arch/arm/boot/dts/omap3-beagle.dts           |  7 +++++--
 arch/arm/boot/dts/omap3-cm-t3x.dtsi          |  8 ++++++--
 arch/arm/boot/dts/omap3-devkit8000.dts       |  9 +++++++--
 arch/arm/boot/dts/omap3-evm-37xx.dts         | 10 +++++++---
 arch/arm/boot/dts/omap3-gta04.dtsi           |  8 ++++++--
 arch/arm/boot/dts/omap3-igep.dtsi            |  5 ++++-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi |  5 +++--
 arch/arm/boot/dts/omap3-igep0030-common.dtsi |  6 ++++++
 arch/arm/boot/dts/omap3-ldp.dts              | 10 +++++++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi      |  8 ++++++--
 arch/arm/boot/dts/omap3-lilly-dbb056.dts     |  7 ++++---
 arch/arm/boot/dts/omap3-pandora-common.dtsi  |  8 ++++++--
 arch/arm/boot/dts/omap3-tao3530.dtsi         |  8 ++++++--
 arch/arm/boot/dts/omap3430-sdp.dts           |  8 ++++++--
 24 files changed, 141 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 7d36601..9a504dd 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -236,11 +236,16 @@
 &gpmc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins_s0>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0x08000000 0x10000000>,	/* CS0: NAND */
+		 <255 0 0x50000000 0x36c>;	/* GPMC reg */
+
 	status = "okay";
 
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x36c>;	/* GPMC reg */
+		interrupts = <100>;
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		ti,nand-xfer-type = "polled";
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index 7e9a34d..e7a82ea 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -206,9 +206,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins>;
-	ranges = <0 0 0x08000000 0x01000000>; /* CS0 0 @addr 0x08000000, size 0x01000000 */
+	ranges = <0 0 0x08000000 0x01000000>,	/* CS0 0 @addr 0x08000000, size 0x01000000 */
+		 <255 0 0x50000000 0x36c>;	/* GPMC reg */
 	nand@0,0 {
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x36c>;	/* GPMC reg */
+		interrupts = <100>;
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 765be27..11d536c 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -494,9 +494,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins_s0>;
-	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x08000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x50000000 0x36c>;	/* GPMC reg */
 	nand@0,0 {
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x36c>;	/* GPMC reg */
+		interrupts = <100>;
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index c0e1135..6197dc6 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -126,10 +126,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins>;
 
-	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x08000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x50000000 0x36c>;	/* GPMC reg */
 
 	nand@0,0 {
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x36c>;	/* GPMC reg */
+		interrupts = <100>;
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-width = <1>;
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c..542c42e 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -654,9 +654,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>,	/* CS0 space. Min partition = 16MB */
+		 <255 0 0x50000000 0x36c>;	/* GPMC reg */
 	nand@0,0 {
-		reg = <0 0 4>;		/* device IO registers */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, I/O window 4 bytes */
+		      <255 0 0x400>;	/* GPMC reg */
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 795d68a..0b9336b 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -473,9 +473,13 @@
 	status = "okay";	/* Disable QSPI when enabling GPMC (NAND) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x08000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x50000000 0x36c>;	/* GPMC reg */
 	nand@0,0 {
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x36c>;	/* GPMC reg */
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 169a855..b7acb37 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -82,11 +82,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x04000000 0x01000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x04000000 0x01000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <100>;
 		linux,mtd-name= "micron,mt29f2g16aadwp";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index aa46590..f520987 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -569,9 +569,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x16>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>,	/* minimum GPMC partition = 16MB */
+		 <255 0 0x50000000 0x37c>;	/* GPMC reg */
 	nand@0,0 {
-		reg = <0 0 4>;		/* device IO registers */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* device IO registers */
+		      <255 0 0x37c>;	/* GPMC reg */
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 4e1b605..10975a4 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -379,13 +379,17 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_default>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>,	/* minimum GPMC partition = 16MB */
+		 <255 0 0x50000000 0x37c>;	/* GPMC reg */
 	nand@0,0 {
 		/* To use NAND, DIP switch SW5 must be set like so:
 		 * SW5.1 (NAND_SELn) = ON (LOW)
 		 * SW5.9 (GPMC_WPN) = OFF (HIGH)
 		 */
-		reg = <0 0 4>;		/* device IO registers */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* device IO registers */
+		      <255 0 0x37c>;	/* GPMC reg */
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 36387b1..c66ff60 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -35,11 +35,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x08000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
+
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <20>;
 		linux,mtd-name = "micron,mt29f4g16abbda3w";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a547411..4619490 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -380,11 +380,14 @@
 
 &gpmc {
 	status = "ok";
-	ranges = <0 0 0x30000000 0x1000000>;	/* CS0 space, 16MB */
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0 space, 16MB */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
 
 	/* Chip select 0 */
 	nand@0,0 {
-		reg = <0 0 4>;		/* NAND I/O window, 4 bytes */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
 		interrupts = <20>;
 		ti,nand-ecc-opt = "ham1";
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 4d091ca..b16f811 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -261,10 +261,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
 
 	nand@0,0 {
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <20>;
 		nand-bus-width = <8>;
 		gpmc,device-width = <1>;
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index be22971..6f7a9fd 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -105,10 +105,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x1000000>;       /* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
 
+	/* Chip select 0 */
 	nand@0,0 {
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index 16e8ce3..1840eb5 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -154,12 +154,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x1000000>,	/* CS0: 16MB for NAND */
-		 <5 0 0x2c000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <5 0 0x2c000000 0x1000000>,	/* CS5: 16MB for ethernet */
+		 <255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		linux,mtd-name= "hynix,h8kds0un0mer-4em";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7166d88..bbab05a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -489,10 +489,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
 
 	nand@0,0 {
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index d5e5cd4..50be7f8 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -101,8 +101,11 @@
 
 &gpmc {
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;   /* GPMC reg */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index e458c21..fad69b5 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -204,8 +204,9 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>,
-		 <5 0 0x2c000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>,	/* CS0: 16MB for NAND */
+		 <5 0 0x2c000000 0x01000000>,	/* CS5: 16MB for ethernet */
+		 <255 0 0x6e000000 0x02d4>;     /* GPMC reg */
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
index 0cb1527..8f8685f 100644
--- a/arch/arm/boot/dts/omap3-igep0030-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
@@ -58,3 +58,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
 };
+
+&gpmc {
+	ranges = <0 0 0x30000000 0x01000000>,   /* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;     /* GPMC reg */
+
+};
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index bd6e676..a1555d8 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -97,12 +97,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>,
-		 <1 0 0x08000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0 space, 16MB */
+		 <1 0 0x08000000 0x1000000>,	/* CS1 space, 16MB */
+		 <255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		interrupts = <20>;
 		linux,mtd-name= "micron,nand";
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC reg */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index e631333..71c8c34 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -359,10 +359,14 @@
 
 &gpmc {
 	ranges = <0 0 0x30000000 0x1000000>,
-		<7 0 0x15000000 0x01000000>;
+		 <7 0 0x15000000 0x1000000>,
+		 <255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
-		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		/* no elm on omap3 */
diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
index 834f7c6..80b19a1 100644
--- a/arch/arm/boot/dts/omap3-lilly-dbb056.dts
+++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
@@ -128,9 +128,10 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x1000000>,   /* nand assigned by COM a83x */
-		<4 0 0x20000000 0x01000000>,
-		<7 0 0x15000000 0x01000000>;   /* eth assigend by COM a83x */
+	ranges = <0 0 0x30000000 0x1000000>,	/* nand assigned by COM a83x */
+		 <4 0 0x20000000 0x1000000>,
+		 <7 0 0x15000000 0x1000000>,	/* eth assigend by COM a83x */
+		 <255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	ethernet@4,0 {
 		compatible = "smsc,lan9117", "smsc,lan9115";
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 782ab1f..320b240 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -497,10 +497,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
 
 	nand@0,0 {
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "sw";
 
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index 7bd8d9a..0332638 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -275,10 +275,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x01000000>,	/* CS0: 16MB for NAND */
+		 <255 0 0x6e000000 0x02d4>;	/* register space */
 
 	nand@0,0 {
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>,		/* CS0, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;	/* GPMC_DEVWIDTH_16BIT */
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 16b0cdf..4389d4b 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -52,7 +52,8 @@
 &gpmc {
 	ranges = <0 0 0x10000000 0x08000000>,
 		 <1 0 0x28000000 0x1000000>,	/* CS1: 16MB for NAND */
-		 <2 0 0x20000000 0x1000000>;	/* CS2: 16MB for OneNAND */
+		 <2 0 0x20000000 0x1000000>,	/* CS2: 16MB for OneNAND */
+		 <255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nor@0,0 {
 		compatible = "cfi-flash";
@@ -103,10 +104,13 @@
 	};
 
 	nand@1,0 {
+		compatible = "ti,omap2-nand";
+		interrupts = <20>;
 		linux,mtd-name= "micron,mt29f1g08abb";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <1 0 4>;	/* CS1, offset 0, IO size 4 */
+		reg = <1 0 4>,		/* CS1, offset 0, IO size 4 */
+		      <255 0 0x02d4>;	/* GPMC reg */
 		ti,nand-ecc-opt = "sw";
 		nand-bus-width = <8>;
 		gpmc,cs-on-ns = <0>;
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

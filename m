From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 10/36] ARM: dts: OMAP2+: Fix NAND device nodes
Date: Wed, 11 Jun 2014 11:56:15 +0300
Message-ID: <1402477001-31132-11-git-send-email-rogerq@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1402477001-31132-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-mtd@lists.infradead.org, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts         |  8 ++++++--
 arch/arm/boot/dts/am335x-igep0033.dtsi   |  8 ++++++--
 arch/arm/boot/dts/am43x-epos-evm.dts     |  8 ++++++--
 arch/arm/boot/dts/omap3-devkit8000.dts   |  9 +++++++--
 arch/arm/boot/dts/omap3-evm-37xx.dts     | 10 +++++++---
 arch/arm/boot/dts/omap3-igep0020.dts     | 10 +++++++---
 arch/arm/boot/dts/omap3-igep0030.dts     |  8 ++++++--
 arch/arm/boot/dts/omap3-ldp.dts          | 10 +++++++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi  | 10 +++++++---
 arch/arm/boot/dts/omap3-lilly-dbb056.dts |  7 ++++---
 arch/arm/boot/dts/omap3430-sdp.dts       |  8 ++++++--
 11 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 6028217..fa25f2b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -437,9 +437,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins_s0>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0x08000000 0x10000000	/* CS0 space, 16MB */
+		  255 0 0x50000000 0x36c>;	/* GPMC reg */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window 4 bytes */
+		       255 0 0x36c>;	/* GPMC reg */
+		interrupts = <100>;
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 9f22c18..4c3f21f 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -112,10 +112,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins>;
 
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0x08000000 0x10000000	/* CS0 space, 16MB */
+		  255 0 0x50000000 0x36c>;	/* GPMC reg */
 
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window 4 bytes */
+		       255 0 0x36c>;	/* GPMC reg */
+		interrupts = <100>;
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-width = <1>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 167dbc8..d757134 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -268,9 +268,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0x08000000 0x10000000	/* CS0 space, 16MB */
+		  255 0 0x50000000 0x36c>;	/* GPMC reg */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window 4 bytes */
+		       255 0 0x36c>;	/* GPMC reg */
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index da402f0..c5c7bbd 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -106,10 +106,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x04>;       /* CS0: NAND */
+	ranges = <0 0 0x30000000 0x1000000	/* CS0 space, 16MB */
+		  255 0 0x6e000000 0x02d4>;	/* register space */
 
+	/* Chip select 0 */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* NAND I/O window, 4 bytes */
+		       255 0 0x02d4>;	/* GPMC register space */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index 4df68ad..7b2b3f4 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -95,12 +95,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>,
-		 <5 0 0x2c000000 0x01000000>;
+	ranges = <0 0 0x00000000 0x1000000	/* CS0 space, 16MB */
+		  5 0 0x2c000000 0x1000000	/* CS5 space, 16MB */
+		  255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window, 4 bytes */
+		       255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		linux,mtd-name= "hynix,h8kds0un0mer-4em";
-		reg = <0 0 0>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index b22caaa..9bd1362 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -197,12 +197,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>,
-		 <5 0 0x2c000000 0x01000000>;
+	ranges = <0 0 0x00000000 0x1000000	/* CS0 space, 16MB */
+		  5 0 0x2c000000 0x1000000	/* CS5 space, 16MB */
+		  255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window, 4 bytes */
+		       255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 0>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 2793749..1508154 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -55,11 +55,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>;
+	ranges = <0 0 0x00000000 0x1000000	/* CS0 space, 16MB */
+		  255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window, 4 bytes */
+		       255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 0>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 0abe986..a219e11 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -96,12 +96,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x01000000>,
-		 <1 0 0x08000000 0x01000000>;
+	ranges = <0 0 0x00000000 0x1000000	/* CS0 space, 16MB */
+		  1 0 0x08000000 0x1000000	/* CS1 space, 16MB */
+		  255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window, 4 bytes */
+		       255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		linux,mtd-name= "micron,nand";
-		reg = <0 0 0>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index cc1dce6..d0b64e7 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -358,11 +358,15 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x1000000>,
-		<7 0 0x15000000 0x01000000>;
+	ranges = <0 0 0x30000000 0x1000000
+		  7 0 0x15000000 0x1000000
+		  255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nand@0,0 {
-		reg = <0 0 0x1000000>;
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4		/* CS0, I/O window, 4 bytes */
+		       255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		/* no elm on omap3 */
diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
index 834f7c6..3e09634 100644
--- a/arch/arm/boot/dts/omap3-lilly-dbb056.dts
+++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
@@ -128,9 +128,10 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x1000000>,   /* nand assigned by COM a83x */
-		<4 0 0x20000000 0x01000000>,
-		<7 0 0x15000000 0x01000000>;   /* eth assigend by COM a83x */
+	ranges = <0 0 0x30000000 0x1000000	/* nand assigned by COM a83x */
+		  4 0 0x20000000 0x1000000
+		  7 0 0x15000000 0x1000000	/* eth assigend by COM a83x */
+		  255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	ethernet@4,0 {
 		compatible = "smsc,lan9117", "smsc,lan9115";
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 02f69f4..bf5f8b9 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -52,7 +52,8 @@
 &gpmc {
 	ranges = <0 0 0x10000000 0x08000000>,
 		 <1 0 0x28000000 0x08000000>,
-		 <2 0 0x20000000 0x10000000>;
+		 <2 0 0x20000000 0x10000000>,
+		 <255 0 0x6e000000 0x02d4>;	/* GPMC reg */
 
 	nor@0,0 {
 		compatible = "cfi-flash";
@@ -103,10 +104,13 @@
 	};
 
 	nand@1,0 {
+		compatible = "ti,omap2-nand";
+		reg = <1 0 4		/* CS1, I/O window, 4 bytes */
+		       255 0 0x02d4>;	/* GPMC reg */
+		interrupts = <20>;
 		linux,mtd-name= "micron,mt29f1g08abb";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <1 0 0x08000000>;
 		ti,nand-ecc-opt = "ham1";
 		nand-bus-width = <8>;
 		gpmc,cs-on-ns = <0>;
-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

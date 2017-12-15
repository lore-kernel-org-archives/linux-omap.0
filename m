From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 25/25] arm: ste: dts: Remove leading 0x and 0s from bindings
 notation
Date: Fri, 15 Dec 2017 12:16:15 +0100
Message-ID: <20171215111620.20379-25-malat@debian.org>
References: <20171214165350.27850-1-malat@debian.org>
 <20171215111620.20379-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171215111620.20379-1-malat@debian.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@axis.com, Baoyou Xie <baoyou.xie@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Jesper Nilsson <jesper.nilsson@axis.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Alexandre Torgue <alexandre.torgue@st.com>, Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Niklas Cassel <niklas.cassel@axis.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree
List-Id: linux-omap@vger.kernel.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi          |   2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 130 ++++++++++++++---------------
 arch/arm/boot/dts/ste-u300.dts             |  50 +++++------
 3 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e97768..cff985f9fb77 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -474,7 +474,7 @@
 			clocks = <&prcc_pclk 5 0>;
 		};
 
-		dma: dma-controller@801C0000 {
+		dma: dma-controller@801c0000 {
 			compatible = "stericsson,db8500-dma40", "stericsson,dma40";
 			reg = <0x801C0000 0x1000 0x40010000 0x800>;
 			reg-names = "base", "lcpa";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 68aab50a73ab..2970719ed22c 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -195,7 +195,7 @@
 		 * MXTAL "Main Chrystal" is a chrystal oscillator @19.2 MHz
 		 * that is parent of TIMCLK, PLL1 and PLL2
 		 */
-		mxtal: mxtal@19.2M {
+		mxtal: mxtal@19.2m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <19200000>;
@@ -207,7 +207,7 @@
 		 * divided by 8. This clock is used by the timers and
 		 * watchdog. See page 105 ff.
 		 */
-		timclk: timclk@2.4M {
+		timclk: timclk@2.4m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <8>;
@@ -245,21 +245,21 @@
 			pll-id = <2>;
 			clocks = <&mxtal>;
 		};
-		clk216: clk216@216M {
+		clk216: clk216@216m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <4>;
 			clock-mult = <1>;
 			clocks = <&pll2>;
 		};
-		clk108: clk108@108M {
+		clk108: clk108@108m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <2>;
 			clock-mult = <1>;
 			clocks = <&clk216>;
 		};
-		clk72: clk72@72M {
+		clk72: clk72@72m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			/* The data sheet does not say how this is derived */
@@ -267,7 +267,7 @@
 			clock-mult = <1>;
 			clocks = <&pll2>;
 		};
-		clk48: clk48@48M {
+		clk48: clk48@48m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			/* The data sheet does not say how this is derived */
@@ -275,7 +275,7 @@
 			clock-mult = <1>;
 			clocks = <&pll2>;
 		};
-		clk27: clk27@27M {
+		clk27: clk27@27m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <4>;
@@ -284,7 +284,7 @@
 		};
 
 		/* This apparently exists as well */
-		ulpiclk: ulpiclk@60M {
+		ulpiclk: ulpiclk@60m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <60000000>;
@@ -295,193 +295,193 @@
 		 * peripheral clocking, clock gates.
 		 */
 
-		hclkdma0: hclkdma0@48M {
+		hclkdma0: hclkdma0@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <0>;
 			clocks = <&hclk>;
 		};
-		hclksmc: hclksmc@48M {
+		hclksmc: hclksmc@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <1>;
 			clocks = <&hclk>;
 		};
-		hclksdram: hclksdram@48M {
+		hclksdram: hclksdram@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <2>;
 			clocks = <&hclk>;
 		};
-		hclkdma1: hclkdma1@48M {
+		hclkdma1: hclkdma1@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <3>;
 			clocks = <&hclk>;
 		};
-		hclkclcd: hclkclcd@48M {
+		hclkclcd: hclkclcd@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <4>;
 			clocks = <&hclk>;
 		};
-		pclkirda: pclkirda@48M {
+		pclkirda: pclkirda@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <5>;
 			clocks = <&pclk>;
 		};
-		pclkssp: pclkssp@48M {
+		pclkssp: pclkssp@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <6>;
 			clocks = <&pclk>;
 		};
-		pclkuart0: pclkuart0@48M {
+		pclkuart0: pclkuart0@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <7>;
 			clocks = <&pclk>;
 		};
-		pclksdi: pclksdi@48M {
+		pclksdi: pclksdi@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <8>;
 			clocks = <&pclk>;
 		};
-		pclki2c0: pclki2c0@48M {
+		pclki2c0: pclki2c0@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <9>;
 			clocks = <&pclk>;
 		};
-		pclki2c1: pclki2c1@48M {
+		pclki2c1: pclki2c1@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <10>;
 			clocks = <&pclk>;
 		};
-		pclkuart1: pclkuart1@48M {
+		pclkuart1: pclkuart1@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <11>;
 			clocks = <&pclk>;
 		};
-		pclkmsp0: pclkmsp0@48M {
+		pclkmsp0: pclkmsp0@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <12>;
 			clocks = <&pclk>;
 		};
-		hclkusb: hclkusb@48M {
+		hclkusb: hclkusb@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <13>;
 			clocks = <&hclk>;
 		};
-		hclkdif: hclkdif@48M {
+		hclkdif: hclkdif@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <14>;
 			clocks = <&hclk>;
 		};
-		hclksaa: hclksaa@48M {
+		hclksaa: hclksaa@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <15>;
 			clocks = <&hclk>;
 		};
-		hclksva: hclksva@48M {
+		hclksva: hclksva@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <16>;
 			clocks = <&hclk>;
 		};
-		pclkhsi: pclkhsi@48M {
+		pclkhsi: pclkhsi@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <17>;
 			clocks = <&pclk>;
 		};
-		pclkxti: pclkxti@48M {
+		pclkxti: pclkxti@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <18>;
 			clocks = <&pclk>;
 		};
-		pclkuart2: pclkuart2@48M {
+		pclkuart2: pclkuart2@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <19>;
 			clocks = <&pclk>;
 		};
-		pclkmsp1: pclkmsp1@48M {
+		pclkmsp1: pclkmsp1@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <20>;
 			clocks = <&pclk>;
 		};
-		pclkmsp2: pclkmsp2@48M {
+		pclkmsp2: pclkmsp2@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <21>;
 			clocks = <&pclk>;
 		};
-		pclkowm: pclkowm@48M {
+		pclkowm: pclkowm@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <22>;
 			clocks = <&pclk>;
 		};
-		hclkhpi: hclkhpi@48M {
+		hclkhpi: hclkhpi@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <23>;
 			clocks = <&hclk>;
 		};
-		pclkske: pclkske@48M {
+		pclkske: pclkske@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <24>;
 			clocks = <&pclk>;
 		};
-		pclkhsem: pclkhsem@48M {
+		pclkhsem: pclkhsem@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <25>;
 			clocks = <&pclk>;
 		};
-		hclk3d: hclk3d@48M {
+		hclk3d: hclk3d@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <26>;
 			clocks = <&hclk>;
 		};
-		hclkhash: hclkhash@48M {
+		hclkhash: hclkhash@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <27>;
 			clocks = <&hclk>;
 		};
-		hclkcryp: hclkcryp@48M {
+		hclkcryp: hclkcryp@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <28>;
 			clocks = <&hclk>;
 		};
-		pclkmshc: pclkmshc@48M {
+		pclkmshc: pclkmshc@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <29>;
 			clocks = <&pclk>;
 		};
-		hclkusbm: hclkusbm@48M {
+		hclkusbm: hclkusbm@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <30>;
 			clocks = <&hclk>;
 		};
-		hclkrng: hclkrng@48M {
+		hclkrng: hclkrng@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <31>;
@@ -495,153 +495,153 @@
 			clock-id = <36>;
 			clocks = <&clk72 &clk48>;
 		};
-		irdaclk: irdaclk@48M {
+		irdaclk: irdaclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <37>;
 			clocks = <&clk48>;
 		};
-		sspiclk: sspiclk@48M {
+		sspiclk: sspiclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <38>;
 			clocks = <&clk48>;
 		};
-		uart0clk: uart0clk@48M {
+		uart0clk: uart0clk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <39>;
 			clocks = <&clk48>;
 		};
-		sdiclk: sdiclk@48M {
+		sdiclk: sdiclk@48m {
 			/* Also called MCCLK in some documents */
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <40>;
 			clocks = <&clk48>;
 		};
-		i2c0clk: i2c0clk@48M {
+		i2c0clk: i2c0clk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <41>;
 			clocks = <&clk48>;
 		};
-		i2c1clk: i2c1clk@48M {
+		i2c1clk: i2c1clk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <42>;
 			clocks = <&clk48>;
 		};
-		uart1clk: uart1clk@48M {
+		uart1clk: uart1clk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <43>;
 			clocks = <&clk48>;
 		};
-		mspclk0: mspclk0@48M {
+		mspclk0: mspclk0@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <44>;
 			clocks = <&clk48>;
 		};
-		usbclk: usbclk@48M {
+		usbclk: usbclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <45>;
 			clocks = <&clk48>; /* 48 MHz not ULPI */
 		};
-		difclk: difclk@72M {
+		difclk: difclk@72m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <46>;
 			clocks = <&clk72>;
 		};
-		ipi2cclk: ipi2cclk@48M {
+		ipi2cclk: ipi2cclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <47>;
 			clocks = <&clk48>; /* Guess */
 		};
-		ipbmcclk: ipbmcclk@48M {
+		ipbmcclk: ipbmcclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <48>;
 			clocks = <&clk48>; /* Guess */
 		};
-		hsiclkrx: hsiclkrx@216M {
+		hsiclkrx: hsiclkrx@216m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <49>;
 			clocks = <&clk216>;
 		};
-		hsiclktx: hsiclktx@108M {
+		hsiclktx: hsiclktx@108m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <50>;
 			clocks = <&clk108>;
 		};
-		uart2clk: uart2clk@48M {
+		uart2clk: uart2clk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <51>;
 			clocks = <&clk48>;
 		};
-		mspclk1: mspclk1@48M {
+		mspclk1: mspclk1@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <52>;
 			clocks = <&clk48>;
 		};
-		mspclk2: mspclk2@48M {
+		mspclk2: mspclk2@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <53>;
 			clocks = <&clk48>;
 		};
-		owmclk: owmclk@48M {
+		owmclk: owmclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <54>;
 			clocks = <&clk48>; /* Guess */
 		};
-		skeclk: skeclk@48M {
+		skeclk: skeclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <56>;
 			clocks = <&clk48>; /* Guess */
 		};
-		x3dclk: x3dclk@48M {
+		x3dclk: x3dclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <58>;
 			clocks = <&clk48>; /* Guess */
 		};
-		pclkmsp3: pclkmsp3@48M {
+		pclkmsp3: pclkmsp3@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <59>;
 			clocks = <&pclk>;
 		};
-		mspclk3: mspclk3@48M {
+		mspclk3: mspclk3@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <60>;
 			clocks = <&clk48>;
 		};
-		mshcclk: mshcclk@48M {
+		mshcclk: mshcclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <61>;
 			clocks = <&clk48>; /* Guess */
 		};
-		usbmclk: usbmclk@48M {
+		usbmclk: usbmclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <62>;
 			/* Stated as "48 MHz not ULPI clock" */
 			clocks = <&clk48>;
 		};
-		rngcclk: rngcclk@48M {
+		rngcclk: rngcclk@48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <63>;
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 62ecb6a2fa39..08edee80f022 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -39,88 +39,88 @@
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 		};
-		pll13: pll13@13M {
+		pll13: pll13@13m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <13000000>;
 		};
 		/* Slow bridge clocks under PLL13 */
-		slow_clk: slow_clk@13M {
+		slow_clk: slow_clk@13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <0>;
 			clocks = <&pll13>;
 		};
-		uart0_clk: uart0_clk@13M {
+		uart0_clk: uart0_clk@13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <1>;
 			clocks = <&slow_clk>;
 		};
-		gpio_clk: gpio_clk@13M {
+		gpio_clk: gpio_clk@13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <4>;
 			clocks = <&slow_clk>;
 		};
-		rtc_clk: rtc_clk@13M {
+		rtc_clk: rtc_clk@13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <6>;
 			clocks = <&slow_clk>;
 		};
-		apptimer_clk: app_tmr_clk@13M {
+		apptimer_clk: app_tmr_clk@13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <7>;
 			clocks = <&slow_clk>;
 		};
-		acc_tmr_clk@13M {
+		acc_tmr_clk@13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <8>;
 			clocks = <&slow_clk>;
 		};
-		pll208: pll208@208M {
+		pll208: pll208@208m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <208000000>;
 		};
-		app208: app_208_clk@208M {
+		app208: app_208_clk@208m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <1>;
 			clock-mult = <1>;
 			clocks = <&pll208>;
 		};
-		cpu_clk@208M {
+		cpu_clk@208m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <3>;
 			clocks = <&app208>;
 		};
-		app104: app_104_clk@104M {
+		app104: app_104_clk@104m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <2>;
 			clock-mult = <1>;
 			clocks = <&pll208>;
 		};
-		semi_clk@104M {
+		semi_clk@104m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <9>;
 			clocks = <&app104>;
 		};
-		app52: app_52_clk@52M {
+		app52: app_52_clk@52m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <4>;
@@ -128,49 +128,49 @@
 			clocks = <&pll208>;
 		};
 		/* AHB subsystem clocks */
-		ahb_clk: ahb_subsys_clk@52M {
+		ahb_clk: ahb_subsys_clk@52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <10>;
 			clocks = <&app52>;
 		};
-		intcon_clk@52M {
+		intcon_clk@52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <12>;
 			clocks = <&ahb_clk>;
 		};
-		emif_clk@52M {
+		emif_clk@52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <5>;
 			clocks = <&ahb_clk>;
 		};
-		dmac_clk: dmac_clk@52M {
+		dmac_clk: dmac_clk@52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <4>;
 			clocks = <&app52>;
 		};
-		fsmc_clk: fsmc_clk@52M {
+		fsmc_clk: fsmc_clk@52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <6>;
 			clocks = <&app52>;
 		};
-		xgam_clk: xgam_clk@52M {
+		xgam_clk: xgam_clk@52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <8>;
 			clocks = <&app52>;
 		};
-		app26: app_26_clk@26M {
+		app26: app_26_clk@26m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <2>;
@@ -178,28 +178,28 @@
 			clocks = <&app52>;
 		};
 		/* Fast bridge  clocks */
-		fast_clk: fast_clk@26M {
+		fast_clk: fast_clk@26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
 			clock-id = <0>;
 			clocks = <&app26>;
 		};
-		i2c0_clk: i2c0_clk@26M {
+		i2c0_clk: i2c0_clk@26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
 			clock-id = <1>;
 			clocks = <&fast_clk>;
 		};
-		i2c1_clk: i2c1_clk@26M {
+		i2c1_clk: i2c1_clk@26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
 			clock-id = <2>;
 			clocks = <&fast_clk>;
 		};
-		mmc_pclk: mmc_p_clk@26M {
+		mmc_pclk: mmc_p_clk@26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
@@ -211,7 +211,7 @@
 			compatible = "stericsson,u300-syscon-mclk";
 			clocks = <&mmc_pclk>;
 		};
-		spi_clk: spi_p_clk@26M {
+		spi_clk: spi_p_clk@26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
-- 
2.11.0

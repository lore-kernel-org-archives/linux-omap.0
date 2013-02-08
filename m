From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 1/2] ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
Date: Thu, 7 Feb 2013 19:05:05 -0600
Message-ID: <1360285506-22354-2-git-send-email-jon-hunter@ti.com>
References: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53245 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759707Ab3BHBFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 20:05:30 -0500
In-Reply-To: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jon-hunter@ti.com>

Add SDMA controller binding for OMAP2+ devices and populate DMA client
information for SPI and MMC periperhal on OMAP3+ devices. Please note
that OMAP24xx devices do not have SPI and MMC bindings available yet and
so DMA client information is not populated.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/dma/omap-sdma.txt          |   51 ++++++++++++++++++++
 arch/arm/boot/dts/omap2.dtsi                       |   12 +++++
 arch/arm/boot/dts/omap3.dtsi                       |   40 +++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   41 ++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi                       |   41 ++++++++++++++++
 5 files changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/omap-sdma.txt b/Documentation/devicetree/bindings/dma/omap-sdma.txt
new file mode 100644
index 0000000..22aab28
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/omap-sdma.txt
@@ -0,0 +1,51 @@
+* TI OMAP SDMA controller
+
+Required properties:
+- compatible:		Should be set to one of the following:
+
+			ti,omap2420-sdma (omap2420)
+			ti,omap2430-sdma (omap2430)
+			ti,omap3430-sdma (omap3430)
+			ti,omap3630-sdma (omap3630)
+			ti,omap4430-sdma (omap4430 & omap4460 & omap543x)
+
+- reg: 			Contains DMA registers location and length.
+- interrupts: 		Contains DMA interrupt information.
+- #dma-cells: 		Must be 1.
+- #dma-channels:	Contains total number of programmable DMA channels.
+- #dma-requests:	Contains total number of DMA requests.
+
+Example:
+
+	sdma: dma-controller@4A056000 {
+		compatible = "ti,omap-sdma";
+		reg = <0x4A056000 0x1000>;
+		interrupts = <0 12 0x4>,
+			     <0 13 0x4>,
+			     <0 14 0x4>,
+			     <0 15 0x4>;
+		#dma-cells = <1>;
+		#dma-channels = <32>;
+		#dma-requests = <127>;
+	};
+
+
+* TI OMAP SDMA clients
+
+Required properties:
+- dmas:			List of one or more DMA specifiers, each consisting of
+			- A phandle pointing to DMA controller node
+			- The DMA request number associated with client device
+- dma-names: 		Contains one identifier string for each dma specifier in
+			the dmas property. The specific strings that can be used
+			are defined in the binding of the DMA client device.
+
+Example:
+
+	mmc1: mmc@4809c000 {
+		...
+		dmas = <&sdma 61>,	/* TX channel */
+		       <&sdma 62>;	/* RX channel */
+		dma-names = "tx", "rx";
+		...
+	};
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 761c4b6..22dffa0 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -49,6 +49,18 @@
 			reg = <0x480FE000 0x1000>;
 		};
 
+		sdma: dma-controller@48056000 {
+			compatible = "ti,omap2430-sdma", "ti,omap2420-sdma";
+			reg = <0x48056000 0x1000>;
+			interrupts = <12>,
+				     <13>,
+				     <14>,
+				     <15>;
+			#dma-cells = <1>;
+			#dma-channels = <32>;
+			#dma-requests = <64>;
+		};
+
 		uart1: serial@4806a000 {
 			compatible = "ti,omap2-uart";
 			ti,hwmods = "uart1";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..4e7acb6 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -75,6 +75,18 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		sdma: dma-controller@48056000 {
+			compatible = "ti,omap3630-sdma", "ti,omap3430-sdma";
+			reg = <0x48056000 0x1000>;
+			interrupts = <12>,
+				     <13>,
+				     <14>,
+				     <15>;
+			#dma-cells = <1>;
+			#dma-channels = <32>;
+			#dma-requests = <96>;
+		};
+
 		omap3_pmx_core: pinmux@48002030 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
 			reg = <0x48002030 0x05cc>;
@@ -192,6 +204,16 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
 			ti,spi-num-cs = <4>;
+			dmas = <&sdma 35>,
+			       <&sdma 36>,
+			       <&sdma 37>,
+			       <&sdma 38>,
+			       <&sdma 39>,
+			       <&sdma 40>,
+			       <&sdma 41>,
+			       <&sdma 42>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
 		};
 
 		mcspi2: spi@4809a000 {
@@ -200,6 +222,11 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
 			ti,spi-num-cs = <2>;
+			dmas = <&sdma 43>,
+			       <&sdma 44>,
+			       <&sdma 45>,
+			       <&sdma 46>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 		};
 
 		mcspi3: spi@480b8000 {
@@ -208,6 +235,11 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
 			ti,spi-num-cs = <2>;
+			dmas = <&sdma 15>,
+			       <&sdma 16>,
+			       <&sdma 23>,
+			       <&sdma 24>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 		};
 
 		mcspi4: spi@480ba000 {
@@ -216,22 +248,30 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
 			ti,spi-num-cs = <1>;
+			dmas = <&sdma 70>, <&sdma 71>;
+			dma-names = "tx0", "rx0";
 		};
 
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
+			dmas = <&sdma 61>, <&sdma 62>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc2";
+			dmas = <&sdma 47>, <&sdma 48>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc3: mmc@480ad000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
+			dmas = <&sdma 77>, <&sdma 78>;
+			dma-names = "tx", "rx";
 		};
 
 		wdt2: wdt@48314000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..827f6f3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -118,6 +118,18 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
+		sdma: dma-controller@4A056000 {
+			compatible = "ti,omap4430-sdma";
+			reg = <0x4A056000 0x1000>;
+			interrupts = <0 12 0x4>,
+				     <0 13 0x4>,
+				     <0 14 0x4>,
+				     <0 15 0x4>;
+			#dma-cells = <1>;
+			#dma-channels = <32>;
+			#dma-requests = <127>;
+		};
+
 		gpio1: gpio@4a310000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4a310000 0x200>;
@@ -260,6 +272,16 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
 			ti,spi-num-cs = <4>;
+			dmas = <&sdma 35>,
+			       <&sdma 36>,
+			       <&sdma 37>,
+			       <&sdma 38>,
+			       <&sdma 39>,
+			       <&sdma 40>,
+			       <&sdma 41>,
+			       <&sdma 42>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
 		};
 
 		mcspi2: spi@4809a000 {
@@ -270,6 +292,11 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
 			ti,spi-num-cs = <2>;
+			dmas = <&sdma 43>,
+			       <&sdma 44>,
+			       <&sdma 45>,
+			       <&sdma 46>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 		};
 
 		mcspi3: spi@480b8000 {
@@ -280,6 +307,8 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
 			ti,spi-num-cs = <2>;
+			dmas = <&sdma 15>, <&sdma 16>;
+			dma-names = "tx0", "rx0";
 		};
 
 		mcspi4: spi@480ba000 {
@@ -290,6 +319,8 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
 			ti,spi-num-cs = <1>;
+			dmas = <&sdma 70>, <&sdma 71>;
+			dma-names = "tx0", "rx0";
 		};
 
 		mmc1: mmc@4809c000 {
@@ -299,6 +330,8 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			dmas = <&sdma 61>, <&sdma 62>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc2: mmc@480b4000 {
@@ -307,6 +340,8 @@
 			interrupts = <0 86 0x4>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
+			dmas = <&sdma 47>, <&sdma 48>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc3: mmc@480ad000 {
@@ -315,6 +350,8 @@
 			interrupts = <0 94 0x4>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
+			dmas = <&sdma 77>, <&sdma 78>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc4: mmc@480d1000 {
@@ -323,6 +360,8 @@
 			interrupts = <0 96 0x4>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
+			dmas = <&sdma 57>, <&sdma 58>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc5: mmc@480d5000 {
@@ -331,6 +370,8 @@
 			interrupts = <0 59 0x4>;
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
+			dmas = <&sdma 59>, <&sdma 60>;
+			dma-names = "tx", "rx";
 		};
 
 		wdt2: wdt@4a314000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 9e182a9..06d21d6 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -108,6 +108,18 @@
 			      <0x48212000 0x1000>;
 		};
 
+		sdma: dma-controller@4A056000 {
+			compatible = "ti,omap4430-sdma";
+			reg = <0x4A056000 0x1000>;
+			interrupts = <0 12 0x4>,
+				     <0 13 0x4>,
+				     <0 14 0x4>,
+				     <0 15 0x4>;
+			#dma-cells = <1>;
+			#dma-channels = <32>;
+			#dma-requests = <127>;
+		};
+
 		gpio1: gpio@4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
@@ -249,6 +261,16 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
 			ti,spi-num-cs = <4>;
+			dmas = <&sdma 35>,
+			       <&sdma 36>,
+			       <&sdma 37>,
+			       <&sdma 38>,
+			       <&sdma 39>,
+			       <&sdma 40>,
+			       <&sdma 41>,
+			       <&sdma 42>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
 		};
 
 		mcspi2: spi@4809a000 {
@@ -259,6 +281,11 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
 			ti,spi-num-cs = <2>;
+			dmas = <&sdma 43>,
+			       <&sdma 44>,
+			       <&sdma 45>,
+			       <&sdma 46>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 		};
 
 		mcspi3: spi@480b8000 {
@@ -269,6 +296,8 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
 			ti,spi-num-cs = <2>;
+			dmas = <&sdma 15>, <&sdma 16>;
+			dma-names = "tx0", "rx0";
 		};
 
 		mcspi4: spi@480ba000 {
@@ -279,6 +308,8 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
 			ti,spi-num-cs = <1>;
+			dmas = <&sdma 70>, <&sdma 71>;
+			dma-names = "tx0", "rx0";
 		};
 
 		uart1: serial@4806a000 {
@@ -336,6 +367,8 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			dmas = <&sdma 61>, <&sdma 62>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc2: mmc@480b4000 {
@@ -344,6 +377,8 @@
 			interrupts = <0 86 0x4>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
+			dmas = <&sdma 47>, <&sdma 48>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc3: mmc@480ad000 {
@@ -352,6 +387,8 @@
 			interrupts = <0 94 0x4>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
+			dmas = <&sdma 77>, <&sdma 78>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc4: mmc@480d1000 {
@@ -360,6 +397,8 @@
 			interrupts = <0 96 0x4>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
+			dmas = <&sdma 57>, <&sdma 58>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc5: mmc@480d5000 {
@@ -368,6 +407,8 @@
 			interrupts = <0 59 0x4>;
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
+			dmas = <&sdma 59>, <&sdma 60>;
+			dma-names = "tx", "rx";
 		};
 
 		keypad: keypad@4ae1c000 {
-- 
1.7.10.4


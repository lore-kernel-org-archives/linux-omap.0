From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 12/21] ARM: omap: convert wakeupgen to stacked domains
Date: Wed,  7 Jan 2015 17:42:47 +0000
Message-ID: <1420652576-22309-13-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:57106 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbbAGRnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 12:43:41 -0500
In-Reply-To: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

OMAP4/5 has been (ab)using the gic_arch_extn to provide
wakeup from suspend, and it makes a lot of sense to convert
this code to use stacked domains instead.

This patch does just this, updating the DT files to actually
reflect what the HW provides.

BIG FAT WARNING: because the DTs were so far lying by not
exposing the WUGEN HW block, kernels with this patch applied
won't have any suspend-resume facility when booted with old DTs,
and old kernels with updated DTs won't even boot.

On a platform with this patch applied, the system looks like
this:

root@bacon-fat:~# cat /proc/interrupts
            CPU0       CPU1
 16:          0          0     WUGEN  37  gp_timer
 19:     233799     155916       GIC  27  arch_timer
 23:          0          0     WUGEN   9  l3-dbg-irq
 24:          1          0     WUGEN  10  l3-app-irq
 27:        282          0     WUGEN  13  omap-dma-engine
 44:          0          0  4ae10000.gpio  13  DMA
294:          0          0     WUGEN  20  gpmc
297:        506          0     WUGEN  56  48070000.i2c
298:          0          0     WUGEN  57  48072000.i2c
299:          0          0     WUGEN  61  48060000.i2c
300:          0          0     WUGEN  62  4807a000.i2c
301:          8          0     WUGEN  60  4807c000.i2c
308:       2439          0     WUGEN  74  OMAP UART2
312:        362          0     WUGEN  83  mmc2
313:        502          0     WUGEN  86  mmc0
314:         13          0     WUGEN  94  mmc1
350:          0          0      PRCM  pinctrl, pinctrl
406:   35155709          0       GIC 109  ehci_hcd:usb1
407:          0          0     WUGEN   7  palmas
409:          0          0     WUGEN 119  twl6040
410:          0          0   twl6040   5  twl6040_irq_ready
411:          0          0   twl6040   0  twl6040_irq_th
IPI0:          0          1  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:      95334     902334  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:        479        648  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:          0          0  IRQ work interrupts
IPI7:          0          0  completion interrupts
Err:          0

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/am4372.dtsi             |  11 ++-
 arch/arm/boot/dts/dra7.dtsi               |  12 ++-
 arch/arm/boot/dts/dra72x.dtsi             |   2 +-
 arch/arm/boot/dts/dra74x.dtsi             |   2 +-
 arch/arm/boot/dts/omap4-duovero.dtsi      |   2 -
 arch/arm/boot/dts/omap4-panda-common.dtsi |   8 +-
 arch/arm/boot/dts/omap4-sdp.dts           |   8 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi |   2 -
 arch/arm/boot/dts/omap4.dtsi              |  18 ++++-
 arch/arm/boot/dts/omap5-cm-t54.dts        |   1 -
 arch/arm/boot/dts/omap5-uevm.dts          |   2 -
 arch/arm/boot/dts/omap5.dtsi              |  24 ++++--
 arch/arm/mach-omap2/omap-wakeupgen.c      | 125 +++++++++++++++++++++++-------
 arch/arm/mach-omap2/omap-wakeupgen.h      |   1 -
 arch/arm/mach-omap2/omap4-common.c        |   1 -
 15 files changed, 154 insertions(+), 65 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index b62a1cd..9d672a7 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -15,7 +15,7 @@
 
 / {
 	compatible = "ti,am4372", "ti,am43";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&wakeupgen>;
 
 
 	aliases {
@@ -48,6 +48,15 @@
 		#interrupt-cells = <3>;
 		reg = <0x48241000 0x1000>,
 		      <0x48240100 0x0100>;
+		interrupt-parent = <&gic>;
+	};
+
+	wakeupgen: interrupt-controller@48281000 {
+		compatible = "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
 	};
 
 	l2-cache-controller@48242000 {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 59ec0e6..a5741ae 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -64,6 +64,14 @@
 		interrupt-parent = <&gic>;
 	};
 
+	wakeupgen: interrupt-controller@48281000 {
+		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
@@ -92,7 +100,7 @@
 		reg = <0x44000000 0x1000000>,
 		      <0x45000000 0x1000>;
 		interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-				      <&gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
 		prm: prm@4ae06000 {
 			compatible = "ti,dra7-prm";
@@ -1337,7 +1345,7 @@
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
 			interrupt-controller;
-			interrupt-parent = <&gic>;
+			interrupt-parent = <&wakeupgen>;
 			#interrupt-cells = <3>;
 			ti,max-irqs = <160>;
 			ti,max-crossbar-sources = <MAX_SOURCES>;
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index e782bf1..f7fb0d0 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -25,7 +25,7 @@
 
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
-		interrupt-parent = <&gic>;
+		interrupt-parent = <&wakeupgen>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 0fc758d..00eeed7 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -41,7 +41,7 @@
 
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
-		interrupt-parent = <&gic>;
+		interrupt-parent = <&wakeupgen>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 	};
diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
index e860ccd..f2a94fa 100644
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -173,14 +173,12 @@
 	twl: twl@48 {
 		reg = <0x48>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;		/* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
 	};
 
 	twl6040: twl@4b {
 		compatible = "ti,twl6040";
 		reg = <0x4b>;
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;		/* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = <&gpio6 0 GPIO_ACTIVE_HIGH>;		/* gpio_160 */
 
 		vio-supply = <&v1v8>;
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 1505135..7c15fb2 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -372,7 +372,6 @@
 		reg = <0x48>;
 		/* IRQ# = 7 */
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
 	};
 
 	twl6040: twl@4b {
@@ -384,7 +383,6 @@
 
 		/* IRQ# = 119 */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = <&gpio4 31 GPIO_ACTIVE_HIGH>;  /* gpio line 127 */
 
 		vio-supply = <&v1v8>;
@@ -479,17 +477,17 @@
 };
 
 &uart2 {
-	interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART2_RX>;
 };
 
 &uart3 {
-	interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART3_RX>;
 };
 
 &uart4 {
-	interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART4_RX>;
 };
 
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 3e1da43..8aca8da 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -363,7 +363,6 @@
 		reg = <0x48>;
 		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
 	};
 
 	twl6040: twl@4b {
@@ -375,7 +374,6 @@
 
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
 
 		vio-supply = <&v1v8>;
@@ -570,21 +568,21 @@
 };
 
 &uart2 {
-	interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART2_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
-	interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART3_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
 
 &uart4 {
-	interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART4_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins>;
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
index 062701e..a4f1ba2 100644
--- a/arch/arm/boot/dts/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
@@ -185,7 +185,6 @@
 		reg = <0x48>;
 		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
 	};
 
 	twl6040: twl@4b {
@@ -197,7 +196,6 @@
 
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = <&gpio6 22 0>; /* gpio 182 */
 
 		vio-supply = <&v1v8>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 074147c..7cb5236 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -14,7 +14,7 @@
 
 / {
 	compatible = "ti,omap4430", "ti,omap4";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&wakeupgen>;
 
 	aliases {
 		i2c0 = &i2c1;
@@ -56,6 +56,7 @@
 		#interrupt-cells = <3>;
 		reg = <0x48241000 0x1000>,
 		      <0x48240100 0x0100>;
+		interrupt-parent = <&gic>;
 	};
 
 	L2: l2-cache-controller@48242000 {
@@ -70,6 +71,15 @@
 		clocks = <&mpu_periphclk>;
 		reg = <0x48240600 0x20>;
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
+	wakeupgen: interrupt-controller@48281000 {
+		compatible = "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
 	};
 
 	/*
@@ -319,7 +329,7 @@
 		uart2: serial@4806c000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
@@ -327,7 +337,7 @@
 		uart3: serial@48020000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
@@ -335,7 +345,7 @@
 		uart4: serial@4806e000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index b54b271..61ad2ea 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -412,7 +412,6 @@
 	palmas: palmas@48 {
 		compatible = "ti,palmas";
 		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
-		interrupt-parent = <&gic>;
 		reg = <0x48>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 159720d..74777a6 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -311,7 +311,6 @@
 	palmas: palmas@48 {
 		compatible = "ti,palmas";
 		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
-		interrupt-parent = <&gic>;
 		reg = <0x48>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
@@ -521,7 +520,6 @@
 		pinctrl-0 = <&twl6040_pins>;
 
 		interrupts = <GIC_SPI 119 IRQ_TYPE_NONE>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = <&gpio5 13 0>;  /* gpio line 141 */
 
 		vio-supply = <&smps7_reg>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf..f9c75c7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -18,7 +18,7 @@
 	#size-cells = <1>;
 
 	compatible = "ti,omap5";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&wakeupgen>;
 
 	aliases {
 		i2c0 = &i2c1;
@@ -79,6 +79,7 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
 	};
 
 	pmu {
@@ -95,6 +96,15 @@
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
 		      <0x48216000 0x2000>;
+		interrupt-parent = <&gic>;
+	};
+
+	wakeupgen: interrupt-controller@48281000 {
+		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
 	};
 
 	/*
@@ -458,7 +468,7 @@
 		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
@@ -466,7 +476,7 @@
 		uart2: serial@4806c000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
@@ -474,7 +484,7 @@
 		uart3: serial@48020000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
@@ -482,7 +492,7 @@
 		uart4: serial@4806e000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
@@ -490,7 +500,7 @@
 		uart5: serial@48066000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48066000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 		};
@@ -498,7 +508,7 @@
 		uart6: serial@48068000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48068000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 		};
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index f961c46..fde487d 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -20,11 +20,12 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/cpu_pm.h>
-#include <linux/irqchip/arm-gic.h>
 
 #include "omap-wakeupgen.h"
 #include "omap-secure.h"
@@ -78,29 +79,12 @@ static inline void sar_writel(u32 val, u32 offset, u8 idx)
 
 static inline int _wakeupgen_get_irq_info(u32 irq, u32 *bit_posn, u8 *reg_index)
 {
-	unsigned int spi_irq;
-
-	/*
-	 * PPIs and SGIs are not supported.
-	 */
-	if (irq < OMAP44XX_IRQ_GIC_START)
-		return -EINVAL;
-
-	/*
-	 * Subtract the GIC offset.
-	 */
-	spi_irq = irq - OMAP44XX_IRQ_GIC_START;
-	if (spi_irq > MAX_IRQS) {
-		pr_err("omap wakeupGen: Invalid IRQ%d\n", irq);
-		return -EINVAL;
-	}
-
 	/*
 	 * Each WakeupGen register controls 32 interrupt.
 	 * i.e. 1 bit per SPI IRQ
 	 */
-	*reg_index = spi_irq >> 5;
-	*bit_posn = spi_irq %= 32;
+	*reg_index = irq >> 5;
+	*bit_posn = irq %= 32;
 
 	return 0;
 }
@@ -141,6 +125,7 @@ static void wakeupgen_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
 	_wakeupgen_clear(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
+	irq_chip_mask_parent(d);
 }
 
 /*
@@ -153,6 +138,7 @@ static void wakeupgen_unmask(struct irq_data *d)
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
 	_wakeupgen_set(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
+	irq_chip_unmask_parent(d);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -400,15 +386,88 @@ int omap_secure_apis_support(void)
 	return omap_secure_apis;
 }
 
+static struct irq_chip wakeupgen_chip = {
+	.name		= "WUGEN",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_mask	= wakeupgen_mask,
+	.irq_unmask	= wakeupgen_unmask,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int wakeupgen_domain_xlate(struct irq_domain *domain,
+				  struct device_node *controller,
+				  const u32 *intspec,
+				  unsigned int intsize,
+				  unsigned long *out_hwirq,
+				  unsigned int *out_type)
+{
+	if (domain->of_node != controller)
+		return -EINVAL;	/* Shouldn't happen, really... */
+	if (intsize != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (intspec[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2];
+	return 0;
+}
+
+static int wakeupgen_domain_alloc(struct irq_domain *domain,
+				  unsigned int virq,
+				  unsigned int nr_irqs, void *data)
+{
+	struct of_phandle_args *args = data;
+	struct of_phandle_args parent_args;
+	irq_hw_number_t hwirq;
+	int i;
+
+	if (args->args_count != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (args->args[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	hwirq = args->args[1];
+	if (hwirq >= MAX_IRQS)
+		return -EINVAL;	/* Can't deal with this */
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &wakeupgen_chip, NULL);
+
+	parent_args = *args;
+	parent_args.np = domain->parent->of_node;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+}
+
+static struct irq_domain_ops wakeupgen_domain_ops = {
+	.xlate	= wakeupgen_domain_xlate,
+	.alloc	= wakeupgen_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
 /*
  * Initialise the wakeupgen module.
  */
-int __init omap_wakeupgen_init(void)
+static int __init wakeupgen_init(struct device_node *node,
+				 struct device_node *parent)
 {
+	struct irq_domain *parent_domain, *domain;
 	int i;
 	unsigned int boot_cpu = smp_processor_id();
 	u32 val;
 
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		return -ENXIO;
+	}
 	/* Not supported on OMAP4 ES1.0 silicon */
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "WakeupGen: Not supported on OMAP4430 ES1.0\n");
@@ -416,7 +475,7 @@ int __init omap_wakeupgen_init(void)
 	}
 
 	/* Static mapping, never released */
-	wakeupgen_base = ioremap(OMAP_WKUPGEN_BASE, SZ_4K);
+	wakeupgen_base = of_iomap(node, 0);
 	if (WARN_ON(!wakeupgen_base))
 		return -ENOMEM;
 
@@ -429,6 +488,14 @@ int __init omap_wakeupgen_init(void)
 		max_irqs = AM43XX_IRQS;
 	}
 
+	domain = irq_domain_add_hierarchy(parent_domain, 0, max_irqs,
+					  node, &wakeupgen_domain_ops,
+					  NULL);
+	if (!domain) {
+		iounmap(wakeupgen_base);
+		return -ENOMEM;
+	}
+
 	/* Clear all IRQ bitmasks at wakeupGen level */
 	for (i = 0; i < irq_banks; i++) {
 		wakeupgen_writel(0, i, CPU0_ID);
@@ -437,14 +504,6 @@ int __init omap_wakeupgen_init(void)
 	}
 
 	/*
-	 * Override GIC architecture specific functions to add
-	 * OMAP WakeupGen interrupt controller along with GIC
-	 */
-	gic_arch_extn.irq_mask = wakeupgen_mask;
-	gic_arch_extn.irq_unmask = wakeupgen_unmask;
-	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
-
-	/*
 	 * FIXME: Add support to set_smp_affinity() once the core
 	 * GIC code has necessary hooks in place.
 	 */
@@ -474,3 +533,9 @@ int __init omap_wakeupgen_init(void)
 
 	return 0;
 }
+
+/*
+ * We cannot use the IRQCHIP_DECLARE macro that lives in
+ * drivers/irqchip, so we're forced to roll our own. Not very nice.
+ */
+OF_DECLARE_2(irqchip, ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.h b/arch/arm/mach-omap2/omap-wakeupgen.h
index b3c8ecc..a3491ad 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.h
+++ b/arch/arm/mach-omap2/omap-wakeupgen.h
@@ -33,7 +33,6 @@
 #define OMAP_TIMESTAMPCYCLELO			0xc08
 #define OMAP_TIMESTAMPCYCLEHI			0xc0c
 
-extern int __init omap_wakeupgen_init(void);
 extern void __iomem *omap_get_wakeupgen_base(void);
 extern int omap_secure_apis_support(void);
 #endif
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 490d95e..9f29831 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -272,6 +272,5 @@ void __init omap_gic_of_init(void)
 	WARN_ON(!twd_base);
 
 skip_errata_init:
-	omap_wakeupgen_init();
 	irqchip_init();
 }
-- 
2.1.4


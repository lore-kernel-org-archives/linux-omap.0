From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 04/21] ARM: tegra: update DTs to expose legacy interrupt controller
Date: Wed,  7 Jan 2015 17:42:39 +0000
Message-ID: <1420652576-22309-5-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Describe the legacy interrupt controller in every tegra DTSI files,
and make it the parent of most interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 16 +++++++++++++++-
 arch/arm/boot/dts/tegra124.dtsi | 16 +++++++++++++++-
 arch/arm/boot/dts/tegra20.dtsi  | 15 ++++++++++++++-
 arch/arm/boot/dts/tegra30.dtsi  | 16 +++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 4296b53..f70bed0 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	compatible = "nvidia,tegra114";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&ictlr>;
 
 	host1x@50000000 {
 		compatible = "nvidia,tegra114-host1x", "simple-bus";
@@ -134,6 +134,19 @@
 		      <0x50046000 0x2000>;
 		interrupts = <GIC_PPI 9
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
+	ictlr: interrupt-controller@60004000 {
+		compatible = "nvidia,tegra114-ictlr", "nvidia,tegra-ictlr";
+		reg = <0x60004000 64>,
+		      <0x60004100 64>,
+		      <0x60004200 64>,
+		      <0x60004300 64>,
+		      <0x60004400 64>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	timer@60005000 {
@@ -766,5 +779,6 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			<GIC_PPI 10
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 4be06c6..6ed6ca0 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	compatible = "nvidia,tegra124";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&ictlr>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -173,6 +173,7 @@
 		      <0x0 0x50046000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
 	};
 
 	gpu@0,57000000 {
@@ -190,6 +191,18 @@
 		status = "disabled";
 	};
 
+	ictlr: interrupt-controller@60004000 {
+		compatible = "nvidia,tegra124-ictlr", "nvidia,tegra-ictlr";
+		reg = <0x0 0x60004000 0x0 0x40>,
+		      <0x0 0x60004100 0x0 0x40>,
+		      <0x0 0x60004200 0x0 0x40>,
+		      <0x0 0x60004300 0x0 0x40>,
+		      <0x0 0x60004400 0x0 0x40>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+	};
+
 	timer@0,60005000 {
 		compatible = "nvidia,tegra124-timer", "nvidia,tegra20-timer";
 		reg = <0x0 0x60005000 0x0 0x400>;
@@ -955,5 +968,6 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 8acf5d8..ab2f004 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -7,7 +7,7 @@
 
 / {
 	compatible = "nvidia,tegra20";
-	interrupt-parent = <&intc>;
+	interrupt-parent = <&ictlr>;
 
 	host1x@50000000 {
 		compatible = "nvidia,tegra20-host1x", "simple-bus";
@@ -142,6 +142,7 @@
 
 	timer@50004600 {
 		compatible = "arm,cortex-a9-twd-timer";
+		interrupt-parent = <&intc>;
 		reg = <0x50040600 0x20>;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
@@ -154,6 +155,7 @@
 		       0x50040100 0x0100>;
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
 	};
 
 	cache-controller@50043000 {
@@ -165,6 +167,17 @@
 		cache-level = <2>;
 	};
 
+	ictlr: interrupt-controller@60004000 {
+		compatible = "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";
+		reg = <0x60004000 64>,
+		      <0x60004100 64>,
+		      <0x60004200 64>,
+		      <0x60004300 64>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+	};
+
 	timer@60005000 {
 		compatible = "nvidia,tegra20-timer";
 		reg = <0x60005000 0x60>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 99475f6..c621e30 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	compatible = "nvidia,tegra30";
-	interrupt-parent = <&intc>;
+	interrupt-parent = <&ictlr>;
 
 	pcie-controller@00003000 {
 		compatible = "nvidia,tegra30-pcie";
@@ -228,6 +228,7 @@
 	timer@50004600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
+		interrupt-parent = <&intc>;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clocks = <&tegra_car TEGRA30_CLK_TWD>;
@@ -239,6 +240,7 @@
 		       0x50040100 0x0100>;
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
 	};
 
 	cache-controller@50043000 {
@@ -250,6 +252,18 @@
 		cache-level = <2>;
 	};
 
+	ictlr: interrupt-controller@60004000 {
+		compatible = "nvidia,tegra30-ictlr", "nvidia,tegra-ictlr";
+		reg = <0x60004000 64>,
+		      <0x60004100 64>,
+		      <0x60004200 64>,
+		      <0x60004300 64>,
+		      <0x60004400 64>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+	};
+
 	timer@60005000 {
 		compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
 		reg = <0x60005000 0x400>;
-- 
2.1.4

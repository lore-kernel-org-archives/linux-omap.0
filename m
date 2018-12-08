From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Add missing ranges for dra7 mcasp l3 ports
Date: Fri,  7 Dec 2018 16:54:03 -0800
Message-ID: <20181208005403.26330-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We need to add mcasp l3 port ranges for mcasp to use a correct l3
data port address for dma. And we're also missing the optional clocks
that we have tagged with HWMOD_OPT_CLKS_NEEDED in omap_hwmod_7xx_data.c.

Note that for reading the module revision register HWMOD_OPT_CLKS_NEEDED
do not seem to be needed. So they could be probably directly managed
only by the mcasp driver, and then we could leave them out for the
interconnect target module.

Fixes: 4ed0dfe3cf39 ("ARM: dts: dra7: Move l4 child devices to probe
them with ti-sysc")
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 92 ++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -2296,7 +2296,15 @@
 	reg-names = "ap", "la", "ia0", "ia1", "ia2";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	ranges = <0x00000000 0x48400000 0x400000>;	/* segment 0 */
+	ranges = <0x00000000 0x48400000 0x400000>,	/* segment 0 */
+		 <0x45800000 0x45800000 0x400000>,	/* L3 data port */
+		 <0x45c00000 0x45c00000 0x400000>,	/* L3 data port */
+		 <0x46000000 0x46000000 0x400000>,	/* L3 data port */
+		 <0x48436000 0x48436000 0x400000>,	/* L3 data port */
+		 <0x4843a000 0x4843a000 0x400000>,	/* L3 data port */
+		 <0x4844c000 0x4844c000 0x400000>,	/* L3 data port */
+		 <0x48450000 0x48450000 0x400000>,	/* L3 data port */
+		 <0x48454000 0x48454000 0x400000>;	/* L3 data port */
 
 	segment@0 {					/* 0x48400000 */
 		compatible = "simple-bus";
@@ -2364,7 +2372,15 @@
 			 <0x0005b000 0x0005b000 0x001000>,	/* ap 59 */
 			 <0x0005c000 0x0005c000 0x001000>,	/* ap 60 */
 			 <0x0005d000 0x0005d000 0x001000>,	/* ap 61 */
-			 <0x0005e000 0x0005e000 0x001000>;	/* ap 62 */
+			 <0x0005e000 0x0005e000 0x001000>,	/* ap 62 */
+			 <0x45800000 0x45800000 0x400000>,	/* L3 data port */
+			 <0x45c00000 0x45c00000 0x400000>,	/* L3 data port */
+			 <0x46000000 0x46000000 0x400000>,	/* L3 data port */
+			 <0x48436000 0x48436000 0x400000>,	/* L3 data port */
+			 <0x4843a000 0x4843a000 0x400000>,	/* L3 data port */
+			 <0x4844c000 0x4844c000 0x400000>,	/* L3 data port */
+			 <0x48450000 0x48450000 0x400000>,	/* L3 data port */
+			 <0x48454000 0x48454000 0x400000>;	/* L3 data port */
 
 		target-module@20000 {			/* 0x48420000, ap 47 02.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
@@ -2727,11 +2743,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): ipu_pwrdm, ipu_clkdm */
-			clocks = <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 0>,
+				 <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 24>,
+				 <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x60000 0x2000>;
+			ranges = <0x0 0x60000 0x2000>,
+				 <0x45800000 0x45800000 0x400000>;
 
 			mcasp1: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2761,11 +2780,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x64000 0x2000>;
+			ranges = <0x0 0x64000 0x2000>,
+				 <0x45c00000 0x45c00000 0x400000>;
 
 			mcasp2: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2795,11 +2817,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x68000 0x2000>;
+			ranges = <0x0 0x68000 0x2000>,
+				 <0x46000000 0x46000000 0x400000>;
 
 			mcasp3: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2828,11 +2853,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x6c000 0x2000>;
+			ranges = <0x0 0x6c000 0x2000>,
+				 <0x48436000 0x48436000 0x400000>;
 
 			mcasp4: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2861,11 +2889,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x70000 0x2000>;
+			ranges = <0x0 0x70000 0x2000>,
+				 <0x4843a000 0x4843a000 0x400000>;
 
 			mcasp5: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2894,11 +2925,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x74000 0x2000>;
+			ranges = <0x0 0x74000 0x2000>,
+				 <0x4844c000 0x4844c000 0x400000>;
 
 			mcasp6: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2927,11 +2961,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x78000 0x2000>;
+			ranges = <0x0 0x78000 0x2000>,
+				 <0x48450000 0x48450000 0x400000>;
 
 			mcasp7: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2960,11 +2997,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x7c000 0x2000>;
+			ranges = <0x0 0x7c000 0x2000>,
+				 <0x48454000 0x48454000 0x400000>;
 
 			mcasp8: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
-- 
2.19.2

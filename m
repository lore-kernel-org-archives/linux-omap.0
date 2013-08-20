From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] ARM: OMAP2+: Let DT say what devices should not to idled or reset
Date: Tue, 20 Aug 2013 13:02:46 +0530
Message-ID: <1376983966-16490-4-git-send-email-rnayak@ti.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1376983966-16490-1-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Now that we have DT bindings to specify which devices on the SoC should not
be reset or idled, get rid of the same information existing as part of the
hwmod data files and pass this info from DT instead.

For GPMC, the HWMOD_INIT_NO_RESET flag seems to be added in hwmod not due to
any errata around the GPMC IP, but rather because any timings
set by the bootloader are not being correctly programmed by the kernel.
This seems like something that needs to be fixed as part of GPMC driver
in the kernel, and hence the flag is left as is in hwmod, which can be
removed once the driver does what its expected to.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi              |    2 ++
 arch/arm/boot/dts/omap4.dtsi               |    3 +++
 arch/arm/boot/dts/omap5.dtsi               |    2 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    2 --
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..402d373 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -492,6 +492,7 @@
 			reg = <0x44d00000 0x4000	/* M3 UMEM */
 			       0x44d80000 0x2000>;	/* M3 DMEM */
 			ti,hwmods = "wkup_m3";
+			ti,no-reset;
 		};
 
 		elm: elm@48080000 {
@@ -522,6 +523,7 @@
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
+			ti,no-idle;
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
 			gpmc,num-cs = <7>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..9e22399 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -214,6 +214,7 @@
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
+			ti,no-idle;
 		};
 
 		uart1: serial@4806a000 {
@@ -492,6 +493,7 @@
 			reg = <0x4c000000 0x100>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "emif1";
+			ti,no-idle;
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
@@ -503,6 +505,7 @@
 			reg = <0x4d000000 0x100>;
 			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "emif2";
+			ti,no-idle;
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..85d20af 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -607,6 +607,7 @@
 		emif1: emif@0x4c000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif1";
+			ti,no-idle;
 			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
 			reg = <0x4c000000 0x400>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -618,6 +619,7 @@
 		emif2: emif@0x4d000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif2";
+			ti,no-idle;
 			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
 			reg = <0x4d000000 0x400>;
 			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index d4f0531..f34612b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -198,7 +198,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.class		= &am33xx_wkup_m3_hwmod_class,
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	/* Keep hardreset asserted */
-	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
+	.flags		= HWMOD_NO_IDLEST,
 	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
@@ -926,7 +926,7 @@ static struct omap_hwmod am33xx_gpmc_hwmod = {
 	.name		= "gpmc",
 	.class		= &am33xx_gpmc_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_RESET,
 	.main_clk	= "l3s_gclk",
 	.prcm		= {
 		.omap4	= {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1e5b12c..a507a70 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -914,7 +914,6 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
 	.name		= "emif1",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -930,7 +929,6 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 	.name		= "emif2",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -1184,7 +1182,7 @@ static struct omap_hwmod omap44xx_gpmc_hwmod = {
 	 * the kernel from the board file or DT data.
 	 * HWMOD_INIT_NO_RESET should be removed ASAP.
 	 */
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 5483c6d..2cdc194 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -353,7 +353,6 @@ static struct omap_hwmod omap54xx_emif1_hwmod = {
 	.name		= "emif1",
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -369,7 +368,6 @@ static struct omap_hwmod omap54xx_emif2_hwmod = {
 	.name		= "emif2",
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
-- 
1.7.9.5


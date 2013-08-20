From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: hwmod: cleanup HWMOD_INIT_NO_RESET usage
Date: Tue, 20 Aug 2013 13:02:44 +0530
Message-ID: <1376983966-16490-2-git-send-email-rnayak@ti.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1376983966-16490-1-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

For modules/IPs/hwmods which do not have
-1- sys->class->reset()
and
-2- hardreset lines
and
-3- No way to do an ocp reset (no sysc control)
the flag 'HWMOD_INIT_NO_RESET' is not much useful.

Cleanup all such instances across various hwmod data files.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   18 +++++++++---------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index eb2f3b9..d4f0531 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -52,7 +52,7 @@ static struct omap_hwmod am33xx_emif_hwmod = {
 	.name		= "emif",
 	.class		= &am33xx_emif_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_ddr_m2_div2_ck",
 	.prcm		= {
 		.omap4	= {
@@ -74,7 +74,7 @@ static struct omap_hwmod am33xx_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &am33xx_l3_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -96,7 +96,7 @@ static struct omap_hwmod am33xx_l3_instr_hwmod = {
 	.name		= "l3_instr",
 	.class		= &am33xx_l3_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -119,7 +119,7 @@ static struct omap_hwmod am33xx_l4_ls_hwmod = {
 	.name		= "l4_ls",
 	.class		= &am33xx_l4_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -134,7 +134,7 @@ static struct omap_hwmod am33xx_l4_hs_hwmod = {
 	.name		= "l4_hs",
 	.class		= &am33xx_l4_hwmod_class,
 	.clkdm_name	= "l4hs_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "l4hs_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -150,7 +150,7 @@ static struct omap_hwmod am33xx_l4_wkup_hwmod = {
 	.name		= "l4_wkup",
 	.class		= &am33xx_l4_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
@@ -170,7 +170,7 @@ static struct omap_hwmod am33xx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &am33xx_mpu_hwmod_class,
 	.clkdm_name	= "mpu_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm		= {
 		.omap4	= {
@@ -472,7 +472,7 @@ static struct omap_hwmod am33xx_ocmcram_hwmod = {
 	.name		= "ocmcram",
 	.class		= &am33xx_ocmcram_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -526,7 +526,7 @@ static struct omap_hwmod am33xx_control_hwmod = {
 	.name		= "control",
 	.class		= &am33xx_control_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9c3b504..1e5b12c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -914,7 +914,7 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
 	.name		= "emif1",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -930,7 +930,7 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 	.name		= "emif2",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -2193,7 +2193,7 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &omap44xx_mpu_hwmod_class,
 	.clkdm_name	= "mpuss_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm = {
 		.omap4 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 3c70f5c..5483c6d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -353,7 +353,7 @@ static struct omap_hwmod omap54xx_emif1_hwmod = {
 	.name		= "emif1",
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -369,7 +369,7 @@ static struct omap_hwmod omap54xx_emif2_hwmod = {
 	.name		= "emif2",
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -1103,7 +1103,7 @@ static struct omap_hwmod omap54xx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &omap54xx_mpu_hwmod_class,
 	.clkdm_name	= "mpu_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm = {
 		.omap4 = {
-- 
1.7.9.5


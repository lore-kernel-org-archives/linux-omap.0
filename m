From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/16] ARM: OMAP2+: Drop legacy platform data for am3 and am4
 dcan
Date: Wed, 11 Dec 2019 09:20:06 -0800
Message-ID: <20191211172014.35201-9-tony@atomide.com>
References: <20191211172014.35201-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211172014.35201-1-tony@atomide.com>
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
Cc: Vignesh R <vigneshr@ti.com>, Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

We can now probe devices with ti-sysc interconnect driver and dts
data. Let's drop the related platform data and custom ti,hwmods
dts property.

As we're just dropping data, and the early platform data init
is based on the custom ti,hwmods property, we want to drop both
the platform data and ti,hwmods property in a single patch.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am33xx-l4.dtsi              |  2 -
 arch/arm/boot/dts/am437x-l4.dtsi              |  2 -
 .../omap_hwmod_33xx_43xx_common_data.h        |  4 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c  | 16 --------
 .../omap_hwmod_33xx_43xx_ipblock_data.c       | 37 -------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    |  2 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    |  2 -
 7 files changed, 65 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1741,7 +1741,6 @@ target-module@cc000 {			/* 0x481cc000, ap 60 46.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0xcc020 0x4>;
 			reg-names = "rev";
-			ti,hwmods = "d_can0";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
 			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN0_CLKCTRL 0>,
 				 <&dcan0_fck>;
@@ -1765,7 +1764,6 @@ target-module@d0000 {			/* 0x481d0000, ap 62 42.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0xd0020 0x4>;
 			reg-names = "rev";
-			ti,hwmods = "d_can1";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
 			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN1_CLKCTRL 0>,
 				 <&dcan1_fck>;
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -1545,7 +1545,6 @@ target-module@cc000 {			/* 0x481cc000, ap 50 46.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0xcc020 0x4>;
 			reg-names = "rev";
-			ti,hwmods = "d_can0";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
 			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN0_CLKCTRL 0>;
 			clock-names = "fck";
@@ -1566,7 +1565,6 @@ target-module@d0000 {			/* 0x481d0000, ap 52 3a.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0xd0020 0x4>;
 			reg-names = "rev";
-			ti,hwmods = "d_can1";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
 			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN1_CLKCTRL 0>;
 			clock-names = "fck";
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -28,8 +28,6 @@ extern struct omap_hwmod_ocp_if am33xx_pruss__l3_main;
 extern struct omap_hwmod_ocp_if am33xx_gfx__l3_main;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__gfx;
 extern struct omap_hwmod_ocp_if am33xx_l4_wkup__rtc;
-extern struct omap_hwmod_ocp_if am33xx_l4_per__dcan0;
-extern struct omap_hwmod_ocp_if am33xx_l4_per__dcan1;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__elm;
 extern struct omap_hwmod_ocp_if am33xx_l3_s__gpmc;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer2;
@@ -51,8 +49,6 @@ extern struct omap_hwmod am33xx_prcm_hwmod;
 extern struct omap_hwmod am33xx_ocmcram_hwmod;
 extern struct omap_hwmod am33xx_smartreflex0_hwmod;
 extern struct omap_hwmod am33xx_smartreflex1_hwmod;
-extern struct omap_hwmod am33xx_dcan0_hwmod;
-extern struct omap_hwmod am33xx_dcan1_hwmod;
 extern struct omap_hwmod am33xx_elm_hwmod;
 extern struct omap_hwmod am33xx_gpmc_hwmod;
 extern struct omap_hwmod am33xx_rtc_hwmod;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -106,22 +106,6 @@ struct omap_hwmod_ocp_if am33xx_l4_wkup__rtc = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4 per/ls -> DCAN0 */
-struct omap_hwmod_ocp_if am33xx_l4_per__dcan0 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_dcan0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 per/ls -> DCAN1 */
-struct omap_hwmod_ocp_if am33xx_l4_per__dcan1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_dcan1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__elm = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_elm_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -271,39 +271,6 @@ struct omap_hwmod_class am33xx_control_hwmod_class = {
 	.name		= "control",
 };
 
-/*
- * dcan class
- */
-static struct omap_hwmod_class am33xx_dcan_hwmod_class = {
-	.name = "d_can",
-};
-
-/* dcan0 */
-struct omap_hwmod am33xx_dcan0_hwmod = {
-	.name		= "d_can0",
-	.class		= &am33xx_dcan_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dcan0_fck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* dcan1 */
-struct omap_hwmod am33xx_dcan1_hwmod = {
-	.name		= "d_can1",
-	.class		= &am33xx_dcan_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dcan1_fck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /* elm */
 static struct omap_hwmod_class_sysconfig am33xx_elm_sysc = {
 	.rev_offs	= 0x0000,
@@ -530,8 +497,6 @@ struct omap_hwmod am33xx_tptc2_hwmod = {
 
 static void omap_hwmod_am33xx_clkctrl(void)
 {
-	CLKCTRL(am33xx_dcan0_hwmod, AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_dcan1_hwmod, AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_elm_hwmod, AM33XX_CM_PER_ELM_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_timer2_hwmod, AM33XX_CM_PER_TIMER2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_smartreflex0_hwmod,
@@ -571,8 +536,6 @@ void omap_hwmod_am33xx_reg(void)
 
 static void omap_hwmod_am43xx_clkctrl(void)
 {
-	CLKCTRL(am33xx_dcan0_hwmod, AM43XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_dcan1_hwmod, AM43XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_elm_hwmod, AM43XX_CM_PER_ELM_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_timer2_hwmod, AM43XX_CM_PER_TIMER2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_smartreflex0_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -377,8 +377,6 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__rtc,
 	&am33xx_l4_wkup__adc_tsc,
 	&am33xx_l4_hs__pruss,
-	&am33xx_l4_per__dcan0,
-	&am33xx_l4_per__dcan1,
 	&am33xx_l4_ls__timer2,
 	&am33xx_l3_main__tpcc,
 	&am33xx_l4_ls__elm,
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -508,8 +508,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_wkup__smartreflex1,
 	&am43xx_l4_wkup__timer1,
 	&am43xx_l4_wkup__adc_tsc,
-	&am33xx_l4_per__dcan0,
-	&am33xx_l4_per__dcan1,
 	&am33xx_l4_ls__timer2,
 	&am33xx_l3_main__tpcc,
 	&am33xx_l4_ls__elm,
-- 
2.24.1

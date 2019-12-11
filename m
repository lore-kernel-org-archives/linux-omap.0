From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/16] ARM: OMAP2+: Drop legacy platform data for dra7 epwmss
Date: Wed, 11 Dec 2019 09:20:00 -0800
Message-ID: <20191211172014.35201-3-tony@atomide.com>
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

Cc: Franklin S Cooper Jr <fcooper@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi            |  3 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 90 -----------------------
 2 files changed, 93 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -2518,7 +2518,6 @@ atl: atl@0 {
 
 		target-module@3e000 {			/* 0x4843e000, ap 25 30.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "epwmss0";
 			reg = <0x3e000 0x4>,
 			      <0x3e004 0x4>;
 			reg-names = "rev", "sysc";
@@ -2565,7 +2564,6 @@ ehrpwm0: pwm@200 {
 
 		target-module@40000 {			/* 0x48440000, ap 27 38.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "epwmss1";
 			reg = <0x40000 0x4>,
 			      <0x40004 0x4>;
 			reg-names = "rev", "sysc";
@@ -2612,7 +2610,6 @@ ehrpwm1: pwm@200 {
 
 		target-module@42000 {			/* 0x48442000, ap 29 20.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "epwmss2";
 			reg = <0x42000 0x4>,
 			      <0x42004 0x4>;
 			reg-names = "rev", "sysc";
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -324,69 +324,6 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
 	},
 };
 
-/* pwmss  */
-static struct omap_hwmod_class_sysconfig dra7xx_epwmss_sysc = {
-	.rev_offs	= 0x0,
-	.sysc_offs	= 0x4,
-	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			  SYSC_HAS_RESET_STATUS,
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type2,
-};
-
-/*
- * epwmss class
- */
-static struct omap_hwmod_class dra7xx_epwmss_hwmod_class = {
-	.name		= "epwmss",
-	.sysc		= &dra7xx_epwmss_sysc,
-};
-
-/* epwmss0 */
-static struct omap_hwmod dra7xx_epwmss0_hwmod = {
-	.name		= "epwmss0",
-	.class		= &dra7xx_epwmss_hwmod_class,
-	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "l4_root_clk_div",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS1_CLKCTRL_OFFSET,
-			.context_offs	= DRA7XX_RM_L4PER2_PWMSS1_CONTEXT_OFFSET,
-		},
-	},
-};
-
-/* epwmss1 */
-static struct omap_hwmod dra7xx_epwmss1_hwmod = {
-	.name		= "epwmss1",
-	.class		= &dra7xx_epwmss_hwmod_class,
-	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "l4_root_clk_div",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS2_CLKCTRL_OFFSET,
-			.context_offs	= DRA7XX_RM_L4PER2_PWMSS2_CONTEXT_OFFSET,
-		},
-	},
-};
-
-/* epwmss2 */
-static struct omap_hwmod dra7xx_epwmss2_hwmod = {
-	.name		= "epwmss2",
-	.class		= &dra7xx_epwmss_hwmod_class,
-	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "l4_root_clk_div",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS3_CLKCTRL_OFFSET,
-			.context_offs	= DRA7XX_RM_L4PER2_PWMSS3_CONTEXT_OFFSET,
-		},
-	},
-};
-
 /*
  * 'dma' class
  *
@@ -1703,30 +1640,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per2__vcp2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per2 -> epwmss0 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss0 = {
-	.master		= &dra7xx_l4_per2_hwmod,
-	.slave		= &dra7xx_epwmss0_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_per2 -> epwmss1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss1 = {
-	.master		= &dra7xx_l4_per2_hwmod,
-	.slave		= &dra7xx_epwmss1_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_per2 -> epwmss2 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss2 = {
-	.master		= &dra7xx_l4_per2_hwmod,
-	.slave		= &dra7xx_epwmss2_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__dmm,
 	&dra7xx_l3_main_2__l3_instr,
@@ -1777,9 +1690,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per2__vcp1,
 	&dra7xx_l3_main_1__vcp2,
 	&dra7xx_l4_per2__vcp2,
-	&dra7xx_l4_per2__epwmss0,
-	&dra7xx_l4_per2__epwmss1,
-	&dra7xx_l4_per2__epwmss2,
 	NULL,
 };
 
-- 
2.24.1

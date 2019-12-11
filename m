From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/13] ARM: OMAP2+: Drop legacy platform data for omap4
 smartreflex
Date: Wed, 11 Dec 2019 11:12:00 -0800
Message-ID: <20191211191206.12190-8-tony@atomide.com>
References: <20191211191206.12190-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211191206.12190-1-tony@atomide.com>
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
Cc: Keerthy <j-keerthy@ti.com>, Sebastian Reichel <sre@kernel.org>, Benoit Parrot <bparrot@ti.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

We can now probe devices with ti-sysc interconnect driver and dts
data. Let's drop the related platform data and custom ti,hwmods
dts property.

As we're just dropping data, and the early platform data init
is based on the custom ti,hwmods property, we want to drop both
the platform data and ti,hwmods property in a single patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-l4.dtsi            |   3 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 112 ---------------------
 2 files changed, 115 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -497,7 +497,6 @@ target-module@4d000 {			/* 0x4a0cd000, ap 78 58.0 */
 
 		target-module@59000 {			/* 0x4a0d9000, ap 13 1a.0 */
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
-			ti,hwmods = "smartreflex_mpu";
 			reg = <0x59038 0x4>;
 			reg-names = "sysc";
 			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
@@ -521,7 +520,6 @@ smartreflex_mpu: smartreflex@0 {
 
 		target-module@5b000 {			/* 0x4a0db000, ap 15 08.0 */
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
-			ti,hwmods = "smartreflex_iva";
 			reg = <0x5b038 0x4>;
 			reg-names = "sysc";
 			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
@@ -545,7 +543,6 @@ smartreflex_iva: smartreflex@0 {
 
 		target-module@5d000 {			/* 0x4a0dd000, ap 17 22.0 */
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
-			ti,hwmods = "smartreflex_core";
 			reg = <0x5d038 0x4>;
 			reg-names = "sysc";
 			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -18,8 +18,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/power/smartreflex.h>
-
 #include <linux/omap-dma.h>
 
 #include "omap_hwmod.h"
@@ -1291,89 +1289,6 @@ static struct omap_hwmod omap44xx_slimbus2_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(slimbus2_opt_clks),
 };
 
-/*
- * 'smartreflex' class
- * smartreflex module (monitor silicon performance and outputs a measure of
- * performance error)
- */
-
-/* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
-	.rev_offs	= -ENODEV,
-	.sysc_offs	= 0x0038,
-	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap36xx_sr_sysc_fields,
-};
-
-static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
-	.name	= "smartreflex",
-	.sysc	= &omap44xx_smartreflex_sysc,
-};
-
-/* smartreflex_core */
-static struct omap_smartreflex_dev_attr smartreflex_core_dev_attr = {
-	.sensor_voltdm_name   = "core",
-};
-
-static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
-	.name		= "smartreflex_core",
-	.class		= &omap44xx_smartreflex_hwmod_class,
-	.clkdm_name	= "l4_ao_clkdm",
-
-	.main_clk	= "smartreflex_core_fck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_ALWON_SR_CORE_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &smartreflex_core_dev_attr,
-};
-
-/* smartreflex_iva */
-static struct omap_smartreflex_dev_attr smartreflex_iva_dev_attr = {
-	.sensor_voltdm_name	= "iva",
-};
-
-static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
-	.name		= "smartreflex_iva",
-	.class		= &omap44xx_smartreflex_hwmod_class,
-	.clkdm_name	= "l4_ao_clkdm",
-	.main_clk	= "smartreflex_iva_fck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_ALWON_SR_IVA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &smartreflex_iva_dev_attr,
-};
-
-/* smartreflex_mpu */
-static struct omap_smartreflex_dev_attr smartreflex_mpu_dev_attr = {
-	.sensor_voltdm_name	= "mpu",
-};
-
-static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
-	.name		= "smartreflex_mpu",
-	.class		= &omap44xx_smartreflex_hwmod_class,
-	.clkdm_name	= "l4_ao_clkdm",
-	.main_clk	= "smartreflex_mpu_fck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_ALWON_SR_MPU_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &smartreflex_mpu_dev_attr,
-};
-
-
 /*
  * 'timer' class
  * general purpose timer module with accurate 1ms tick
@@ -2141,30 +2056,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> smartreflex_core */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_smartreflex_core_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> smartreflex_iva */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_smartreflex_iva_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> smartreflex_mpu */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_smartreflex_mpu_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__timer1 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
@@ -2288,9 +2179,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
 	&omap44xx_l4_per__slimbus2,
-	&omap44xx_l4_cfg__smartreflex_core,
-	&omap44xx_l4_cfg__smartreflex_iva,
-	&omap44xx_l4_cfg__smartreflex_mpu,
 	&omap44xx_l4_wkup__timer1,
 	/* &omap44xx_l4_cfg__usb_host_fs, */
 	&omap44xx_l4_cfg__usb_host_hs,
-- 
2.24.1

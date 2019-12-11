From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/13] ARM: OMAP2+: Drop legacy platform data for dra7 ocp2scp
Date: Wed, 11 Dec 2019 11:11:57 -0800
Message-ID: <20191211191206.12190-5-tony@atomide.com>
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

Cc: Keerthy <j-keerthy@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi            |  2 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 67 -----------------------
 2 files changed, 69 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -234,7 +234,6 @@ target-module@5e000 {			/* 0x4a05e000, ap 11 1a.0 */
 
 		target-module@80000 {			/* 0x4a080000, ap 13 20.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "ocp2scp1";
 			reg = <0x80000 0x4>,
 			      <0x80010 0x4>,
 			      <0x80014 0x4>;
@@ -302,7 +301,6 @@ usb3_phy1: phy@4400 {
 
 		target-module@90000 {			/* 0x4a090000, ap 59 42.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "ocp2scp3";
 			reg = <0x90000 0x4>,
 			      <0x90010 0x4>,
 			      <0x90014 0x4>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -590,55 +590,6 @@ static struct omap_hwmod dra7xx_mpu_hwmod = {
 	},
 };
 
-/*
- * 'ocp2scp' class
- *
- */
-
-static struct omap_hwmod_class_sysconfig dra7xx_ocp2scp_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class dra7xx_ocp2scp_hwmod_class = {
-	.name	= "ocp2scp",
-	.sysc	= &dra7xx_ocp2scp_sysc,
-};
-
-/* ocp2scp1 */
-static struct omap_hwmod dra7xx_ocp2scp1_hwmod = {
-	.name		= "ocp2scp1",
-	.class		= &dra7xx_ocp2scp_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_OCP2SCP1_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INIT_OCP2SCP1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-};
-
-/* ocp2scp3 */
-static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
-	.name		= "ocp2scp3",
-	.class		= &dra7xx_ocp2scp_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_OCP2SCP3_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INIT_OCP2SCP3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-};
 
 /*
  * 'PCIE' class
@@ -1314,22 +1265,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mpu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> ocp2scp1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp1 = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_ocp2scp1_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> ocp2scp3 */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp3 = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_ocp2scp3_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> pciess1 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess1 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -1523,8 +1458,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__hdmi,
 	&dra7xx_l3_main_1__gpmc,
 	&dra7xx_l4_cfg__mpu,
-	&dra7xx_l4_cfg__ocp2scp1,
-	&dra7xx_l4_cfg__ocp2scp3,
 	&dra7xx_l3_main_1__pciess1,
 	&dra7xx_l4_cfg__pciess1,
 	&dra7xx_l3_main_1__pciess2,
-- 
2.24.1

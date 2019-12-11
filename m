From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/13] ARM: OMAP2+: Drop legacy platform data for am4 vpfe
Date: Wed, 11 Dec 2019 11:11:58 -0800
Message-ID: <20191211191206.12190-6-tony@atomide.com>
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

Cc: Benoit Parrot <bparrot@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi           |  2 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 70 ----------------------
 2 files changed, 72 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -2064,7 +2064,6 @@ gpio5: gpio@0 {
 
 		target-module@26000 {			/* 0x48326000, ap 86 66.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "vpfe0";
 			reg = <0x26000 0x4>,
 			      <0x26104 0x4>;
 			reg-names = "rev", "sysc";
@@ -2091,7 +2090,6 @@ vpfe0: vpfe@0 {
 
 		target-module@28000 {			/* 0x48328000, ap 75 0e.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "vpfe1";
 			reg = <0x28000 0x4>,
 			      <0x28104 0x4>;
 			reg-names = "rev", "sysc";
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -225,44 +225,6 @@ static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
 };
 
 
-static struct omap_hwmod_class_sysconfig am43xx_vpfe_sysc = {
-	.rev_offs       = 0x0,
-	.sysc_offs      = 0x104,
-	.sysc_flags     = SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE,
-	.idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-				MSTANDBY_FORCE | MSTANDBY_SMART | MSTANDBY_NO),
-	.sysc_fields    = &omap_hwmod_sysc_type2,
-};
-
-static struct omap_hwmod_class am43xx_vpfe_hwmod_class = {
-	.name           = "vpfe",
-	.sysc           = &am43xx_vpfe_sysc,
-};
-
-static struct omap_hwmod am43xx_vpfe0_hwmod = {
-	.name           = "vpfe0",
-	.class          = &am43xx_vpfe_hwmod_class,
-	.clkdm_name     = "l3s_clkdm",
-	.prcm           = {
-		.omap4  = {
-			.modulemode     = MODULEMODE_SWCTRL,
-			.clkctrl_offs   = AM43XX_CM_PER_VPFE0_CLKCTRL_OFFSET,
-		},
-	},
-};
-
-static struct omap_hwmod am43xx_vpfe1_hwmod = {
-	.name           = "vpfe1",
-	.class          = &am43xx_vpfe_hwmod_class,
-	.clkdm_name     = "l3s_clkdm",
-	.prcm           = {
-		.omap4  = {
-			.modulemode     = MODULEMODE_SWCTRL,
-			.clkctrl_offs   = AM43XX_CM_PER_VPFE1_CLKCTRL_OFFSET,
-		},
-	},
-};
-
 /* Interfaces */
 static struct omap_hwmod_ocp_if am43xx_l3_main__emif = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -376,34 +338,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_ocp_if am43xx_l3__vpfe0 = {
-	.master         = &am43xx_vpfe0_hwmod,
-	.slave          = &am33xx_l3_main_hwmod,
-	.clk            = "l3_gclk",
-	.user           = OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-static struct omap_hwmod_ocp_if am43xx_l3__vpfe1 = {
-	.master         = &am43xx_vpfe1_hwmod,
-	.slave          = &am33xx_l3_main_hwmod,
-	.clk            = "l3_gclk",
-	.user           = OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-static struct omap_hwmod_ocp_if am43xx_l4_ls__vpfe0 = {
-	.master         = &am33xx_l4_ls_hwmod,
-	.slave          = &am43xx_vpfe0_hwmod,
-	.clk            = "l4ls_gclk",
-	.user           = OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-static struct omap_hwmod_ocp_if am43xx_l4_ls__vpfe1 = {
-	.master         = &am33xx_l4_ls_hwmod,
-	.slave          = &am43xx_vpfe1_hwmod,
-	.clk            = "l4ls_gclk",
-	.user           = OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l3_main__pruss,
@@ -438,10 +372,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__dss,
 	&am43xx_l4_ls__dss_dispc,
 	&am43xx_l4_ls__dss_rfbi,
-	&am43xx_l3__vpfe0,
-	&am43xx_l3__vpfe1,
-	&am43xx_l4_ls__vpfe0,
-	&am43xx_l4_ls__vpfe1,
 	NULL,
 };
 
-- 
2.24.1

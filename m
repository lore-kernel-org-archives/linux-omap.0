From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v6 05/10] OMAP3: PM: Adding smartreflex hwmod data
Date: Mon, 20 Dec 2010 22:29:12 +0530
Message-ID: <1292864357-13939-6-git-send-email-thara@ti.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57788 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932870Ab0LTQ7g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 11:59:36 -0500
In-Reply-To: <1292864357-13939-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com, Thara Gopinath <thara@ti.com>

This patch adds the smartreflex hwmod data for OMAP3430
and OMAP3630.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  176 ++++++++++++++++++++++++++++
 1 files changed, 176 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8eb81b4..c98cfc0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,6 +21,8 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/smartreflex.h>
+#include <plat/smartreflex.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -52,6 +54,8 @@ static struct omap_hwmod omap3xxx_gpio3_hwmod;
 static struct omap_hwmod omap3xxx_gpio4_hwmod;
 static struct omap_hwmod omap3xxx_gpio5_hwmod;
 static struct omap_hwmod omap3xxx_gpio6_hwmod;
+static struct omap_hwmod omap34xx_sr1_hwmod;
+static struct omap_hwmod omap34xx_sr2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -260,9 +264,47 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* L4 CORE -> SR1 interface */
+static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_SR1_BASE,
+		.pa_end		= OMAP34XX_SR1_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__sr1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_sr1_hwmod,
+	.clk		= "sr_l4_ick",
+	.addr		= omap3_sr1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3_sr1_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 CORE -> SR1 interface */
+static struct omap_hwmod_addr_space omap3_sr2_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_SR2_BASE,
+		.pa_end		= OMAP34XX_SR2_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_sr2_hwmod,
+	.clk		= "sr_l4_ick",
+	.addr		= omap3_sr2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3_sr2_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
+	&omap3_l4_core__sr1,
+	&omap3_l4_core__sr2,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
@@ -1092,6 +1134,135 @@ static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* SR common */
+static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
+	.clkact_shift	= 20,
+};
+
+static struct omap_hwmod_class_sysconfig omap34xx_sr_sysc = {
+	.sysc_offs	= 0x24,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_NO_CACHE),
+	.clockact	= CLOCKACT_TEST_ICLK,
+	.sysc_fields	= &omap34xx_sr_sysc_fields,
+};
+
+static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
+	.name = "smartreflex",
+	.sysc = &omap34xx_sr_sysc,
+	.rev  = 1,
+};
+
+static struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields = {
+	.sidle_shift	= 24,
+	.enwkup_shift	= 26
+};
+
+static struct omap_hwmod_class_sysconfig omap36xx_sr_sysc = {
+	.sysc_offs	= 0x38,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
+			SYSC_NO_CACHE),
+	.sysc_fields	= &omap36xx_sr_sysc_fields,
+};
+
+static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
+	.name = "smartreflex",
+	.sysc = &omap36xx_sr_sysc,
+	.rev  = 2,
+};
+
+/* SR1 */
+static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
+	&omap3_l4_core__sr1,
+};
+
+static struct omap_hwmod omap34xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.main_clk	= "sr1_fck",
+	.vdd_name	= "mpu",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_SR1_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_SR1_SHIFT,
+		},
+	},
+	.slaves		= omap3_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
+static struct omap_hwmod omap36xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.class		= &omap36xx_smartreflex_hwmod_class,
+	.main_clk	= "sr1_fck",
+	.vdd_name	= "mpu",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_SR1_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_SR1_SHIFT,
+		},
+	},
+	.slaves		= omap3_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
+/* SR2 */
+static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
+	&omap3_l4_core__sr2,
+};
+
+static struct omap_hwmod omap34xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.main_clk	= "sr2_fck",
+	.vdd_name	= "core",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_SR2_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_SR2_SHIFT,
+		},
+	},
+	.slaves		= omap3_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
+static struct omap_hwmod omap36xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.class		= &omap36xx_smartreflex_hwmod_class,
+	.main_clk	= "sr2_fck",
+	.vdd_name	= "core",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_SR2_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_SR2_SHIFT,
+		},
+	},
+	.slaves		= omap3_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -1107,6 +1278,11 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
+	&omap34xx_sr1_hwmod,
+	&omap34xx_sr2_hwmod,
+	&omap36xx_sr1_hwmod,
+	&omap36xx_sr2_hwmod,
+
 
 	/* gpio class */
 	&omap3xxx_gpio1_hwmod,
-- 
1.7.0.4


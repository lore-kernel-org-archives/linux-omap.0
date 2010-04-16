From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 01/22] OMAP3: PM: Adding hwmod data for Smartreflex
Date: Fri, 16 Apr 2010 14:32:56 +0530
Message-ID: <1271408597-3066-2-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55666 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756804Ab0DPJDa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:30 -0400
In-Reply-To: <1271408597-3066-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds the hwmod strucutres and other hwmod data for
OMAP3 Smartreflex IP's.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  135 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h          |   33 +++++++
 2 files changed, 168 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed60840..049e4e2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,10 +17,12 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/control.h>
 
 #include "omap_hwmod_common_data.h"
 
 #include "prm-regbits-34xx.h"
+#include "smartreflex.h"
 
 /*
  * OMAP3xxx hardware module integration data
@@ -35,6 +37,8 @@ static struct omap_hwmod omap3xxx_mpu_hwmod;
 static struct omap_hwmod omap3xxx_l3_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap34xx_sr1_hwmod;
+static struct omap_hwmod omap34xx_sr2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3__l4_core = {
@@ -88,9 +92,47 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* L4 CORE -> SR1 interface */
+static struct omap_hwmod_addr_space omap34xx_sr1_addr_space[] = {
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
+	.addr		= omap34xx_sr1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_sr1_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 CORE -> SR1 interface */
+static struct omap_hwmod_addr_space omap34xx_sr2_addr_space[] = {
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
+	.addr		= omap34xx_sr2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_sr2_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3__l4_core,
+	&omap3_l4_core__sr1,
+	&omap3_l4_core__sr2,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
@@ -164,12 +206,105 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
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
+/* SR1 */
+static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
+	&omap3_l4_core__sr1,
+};
+
+static u32 omap34xx_sr1_efuse_offs[] = {
+	OMAP343X_CONTROL_FUSE_OPP1_VDD1, OMAP343X_CONTROL_FUSE_OPP2_VDD1,
+	OMAP343X_CONTROL_FUSE_OPP3_VDD1, OMAP343X_CONTROL_FUSE_OPP4_VDD1,
+	OMAP343X_CONTROL_FUSE_OPP5_VDD1,
+};
+
+static u32 omap34xx_sr1_test_nvalues[] = {
+	0x9A90E6, 0xAABE9A, 0xBBF5C5, 0xBBB292, 0xBBF5C5,
+};
+
+static struct omap_smartreflex_dev_data omap34xx_sr1_dev_attr = {
+	.volts_supported	= 5,
+	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
+	.sennenable_shift	= OMAP343X_SR1_SENNENABLE_SHIFT,
+	.senpenable_shift	= OMAP343X_SR1_SENPENABLE_SHIFT,
+	.efuse_nvalues_offs	= omap34xx_sr1_efuse_offs,
+	.test_sennenable	= 0x3,
+	.test_senpenable	= 0x3,
+	.test_nvalues		= omap34xx_sr1_test_nvalues
+};
+
+static struct omap_hwmod omap34xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.main_clk	= "sr1_fck",
+	.slaves		= omap34xx_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
+	.dev_attr	= &omap34xx_sr1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
+/* SR2 */
+static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
+	&omap3_l4_core__sr2,
+};
+
+static u32 omap34xx_sr2_efuse_offs[] = {
+	OMAP343X_CONTROL_FUSE_OPP1_VDD2, OMAP343X_CONTROL_FUSE_OPP2_VDD2,
+	OMAP343X_CONTROL_FUSE_OPP3_VDD2,
+};
+
+static u32 omap34xx_sr2_test_nvalues[] = {
+	0x0, 0xAAC098, 0xAB89D9
+};
+
+static struct omap_smartreflex_dev_data omap34xx_sr2_dev_attr = {
+	.volts_supported	= 3,
+	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
+	.sennenable_shift	= OMAP343X_SR2_SENNENABLE_SHIFT,
+	.senpenable_shift	= OMAP343X_SR2_SENPENABLE_SHIFT,
+	.efuse_nvalues_offs	= omap34xx_sr2_efuse_offs,
+	.test_sennenable	= 0x3,
+	.test_senpenable	= 0x3,
+	.test_nvalues		= omap34xx_sr2_test_nvalues
+};
+
+static struct omap_hwmod omap34xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.main_clk	= "sr2_fck",
+	.slaves		= omap34xx_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
+	.dev_attr	= &omap34xx_sr2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_hwmod,
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
+	&omap34xx_sr1_hwmod,
+	&omap34xx_sr2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 2a0e823..d239eb2 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -237,6 +237,39 @@ extern u32 current_vdd2_opp;
 #define SR_TESTING_NVALUES 	0
 #endif
 
+/**
+ * omap_smartreflex_dev_data - Smartreflex device specific data
+ *
+ * @volts_supported	: Number of distinct voltages possible for the VDD
+ *			  associated with this smartreflex module.
+ * @efuse_sr_control	: The regisrter offset of control_fuse_sr efuse
+ *			  register from which sennenable and senpenable values
+ *			  are obtained.
+ * @sennenable_shift	: The shift in the control_fuse_sr register for
+ *			  obtaining the sennenable value for this smartreflex
+ *			  module.
+ * @senpenable_shift	: The shift in the control_fuse_sr register for
+ *			  obtaining the senpenable value for this smartreflex
+ *			  module.
+ * @efuse_nvalues_offs	: Array of efuse offsets from which ntarget values can
+ *			  be retrieved. Number of efuse offsets in this arrray
+ *			  is equal to the volts_supported value ie one efuse
+ *			  register per supported voltage.
+ * @test_sennenable	: SENNENABLE test value
+ * @test_senpenable	: SENPENABLE test value.
+ * @test_nvalues	: Array of test ntarget values.
+ */
+struct omap_smartreflex_dev_data {
+	int volts_supported;
+	u32 efuse_sr_control;
+	u32 sennenable_shift;
+	u32 senpenable_shift;
+	u32 *efuse_nvalues_offs;
+	u32 test_sennenable;
+	u32 test_senpenable;
+	u32 *test_nvalues;
+};
+
 /*
  * Smartreflex module enable/disable interface.
  * NOTE: if smartreflex is not enabled from sysfs, these functions will not
-- 
1.7.0.rc1.33.g07cf0f


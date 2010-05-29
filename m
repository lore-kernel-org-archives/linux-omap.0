From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 4/8] OMAP3: PM: Adding smartreflex hwmod data
Date: Sat, 29 May 2010 22:02:24 +0530
Message-ID: <1275150748-15386-5-git-send-email-thara@ti.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
 <1275150748-15386-2-git-send-email-thara@ti.com>
 <1275150748-15386-3-git-send-email-thara@ti.com>
 <1275150748-15386-4-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38807 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757387Ab0E2Qcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 12:32:39 -0400
In-Reply-To: <1275150748-15386-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds the smartreflex hwmod data for OMAP3430
and OMAP3630. A dev_attr is also added to the hwmod
structure for each smartreflex module which contains
SoC specific info like the efuse offsets, test n-values
etc.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  209 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/control.h  |   27 ++++
 2 files changed, 235 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed60840..43ffc8d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,9 +17,10 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/control.h>
+#include <plat/smartreflex.h>
 
 #include "omap_hwmod_common_data.h"
-
 #include "prm-regbits-34xx.h"
 
 /*
@@ -35,6 +36,8 @@ static struct omap_hwmod omap3xxx_mpu_hwmod;
 static struct omap_hwmod omap3xxx_l3_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap34xx_sr1_hwmod;
+static struct omap_hwmod omap34xx_sr2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3__l4_core = {
@@ -88,9 +91,47 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
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
 	&omap3xxx_l3__l4_core,
+	&omap3_l4_core__sr1,
+	&omap3_l4_core__sr2,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
@@ -164,12 +205,178 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
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
+static struct omap_sr_dev_data omap34xx_sr1_dev_attr = {
+	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
+	.sennenable_shift	= OMAP343X_SR1_SENNENABLE_SHIFT,
+	.senpenable_shift	= OMAP343X_SR1_SENPENABLE_SHIFT,
+	.efuse_nvalues_offs	= omap34xx_sr1_efuse_offs,
+	.test_sennenable	= 0x3,
+	.test_senpenable	= 0x3,
+	.test_nvalues		= omap34xx_sr1_test_nvalues,
+};
+
+static struct omap_hwmod omap34xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.main_clk	= "sr1_fck",
+	.slaves		= omap3_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr	= &omap34xx_sr1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
+static u32 omap36xx_sr1_efuse_offs[] = {
+	OMAP3630_CONTROL_FUSE_OPP50_VDD1, OMAP3630_CONTROL_FUSE_OPP100_VDD1,
+	OMAP3630_CONTROL_FUSE_OPP120_VDD1, OMAP3630_CONTROL_FUSE_OPP1G_VDD1,
+};
+
+static u32 omap36xx_sr1_test_nvalues[] = {
+	0x898beb, 0x999b83, 0xaac5a8, 0xaab197,
+};
+
+static struct omap_sr_dev_data omap36xx_sr1_dev_attr = {
+	.efuse_nvalues_offs	= omap36xx_sr1_efuse_offs,
+	.test_sennenable	= 0x1,
+	.test_senpenable	= 0x1,
+	.test_nvalues		= omap36xx_sr1_test_nvalues,
+};
+
+static struct omap_hwmod omap36xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.class		= &omap36xx_smartreflex_hwmod_class,
+	.main_clk	= "sr1_fck",
+	.slaves		= omap3_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr	= &omap36xx_sr1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
+/* SR2 */
+static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
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
+static struct omap_sr_dev_data omap34xx_sr2_dev_attr = {
+	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
+	.sennenable_shift	= OMAP343X_SR2_SENNENABLE_SHIFT,
+	.senpenable_shift	= OMAP343X_SR2_SENPENABLE_SHIFT,
+	.efuse_nvalues_offs	= omap34xx_sr2_efuse_offs,
+	.test_sennenable	= 0x3,
+	.test_senpenable	= 0x3,
+	.test_nvalues		= omap34xx_sr2_test_nvalues,
+};
+
+static struct omap_hwmod omap34xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.main_clk	= "sr2_fck",
+	.slaves		= omap3_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr	= &omap34xx_sr2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
+static u32 omap36xx_sr2_efuse_offs[] = {
+	OMAP3630_CONTROL_FUSE_OPP50_VDD2, OMAP3630_CONTROL_FUSE_OPP100_VDD2,
+};
+
+static u32 omap36xx_sr2_test_nvalues[] = {
+	0x898beb, 0x9a8cee,
+};
+
+static struct omap_sr_dev_data omap36xx_sr2_dev_attr = {
+	.efuse_nvalues_offs	= omap36xx_sr2_efuse_offs,
+	.test_sennenable	= 0x1,
+	.test_senpenable	= 0x1,
+	.test_nvalues		= omap36xx_sr2_test_nvalues,
+};
+
+static struct omap_hwmod omap36xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.class		= &omap36xx_smartreflex_hwmod_class,
+	.main_clk	= "sr2_fck",
+	.slaves		= omap3_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr	= &omap36xx_sr2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_hwmod,
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
+	&omap34xx_sr1_hwmod,
+	&omap34xx_sr2_hwmod,
+	&omap36xx_sr1_hwmod,
+	&omap36xx_sr2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index a56deee..6c179ae 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -144,6 +144,15 @@
 #define OMAP343X_CONTROL_TEST_KEY_11	(OMAP2_CONTROL_GENERAL + 0x00f4)
 #define OMAP343X_CONTROL_TEST_KEY_12	(OMAP2_CONTROL_GENERAL + 0x00f8)
 #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
+#define OMAP343X_CONTROL_FUSE_OPP1_VDD1 (OMAP2_CONTROL_GENERAL + 0x0110)
+#define OMAP343X_CONTROL_FUSE_OPP2_VDD1 (OMAP2_CONTROL_GENERAL + 0x0114)
+#define OMAP343X_CONTROL_FUSE_OPP3_VDD1 (OMAP2_CONTROL_GENERAL + 0x0118)
+#define OMAP343X_CONTROL_FUSE_OPP4_VDD1 (OMAP2_CONTROL_GENERAL + 0x011c)
+#define OMAP343X_CONTROL_FUSE_OPP5_VDD1 (OMAP2_CONTROL_GENERAL + 0x0120)
+#define OMAP343X_CONTROL_FUSE_OPP1_VDD2 (OMAP2_CONTROL_GENERAL + 0x0124)
+#define OMAP343X_CONTROL_FUSE_OPP2_VDD2 (OMAP2_CONTROL_GENERAL + 0x0128)
+#define OMAP343X_CONTROL_FUSE_OPP3_VDD2 (OMAP2_CONTROL_GENERAL + 0x012c)
+#define OMAP343X_CONTROL_FUSE_SR        (OMAP2_CONTROL_GENERAL + 0x0130)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
 #define OMAP343X_CONTROL_DEBOBS(i)	(OMAP2_CONTROL_GENERAL + 0x01B0 \
@@ -160,6 +169,14 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
+/* OMAP3630 only CONTROL_GENERAL register offsets */
+#define OMAP3630_CONTROL_FUSE_OPP1G_VDD1        (OMAP2_CONTROL_GENERAL + 0x0110)
+#define OMAP3630_CONTROL_FUSE_OPP50_VDD1        (OMAP2_CONTROL_GENERAL + 0x0114)
+#define OMAP3630_CONTROL_FUSE_OPP100_VDD1       (OMAP2_CONTROL_GENERAL + 0x0118)
+#define OMAP3630_CONTROL_FUSE_OPP120_VDD1       (OMAP2_CONTROL_GENERAL + 0x0120)
+#define OMAP3630_CONTROL_FUSE_OPP50_VDD2        (OMAP2_CONTROL_GENERAL + 0x0128)
+#define OMAP3630_CONTROL_FUSE_OPP100_VDD2       (OMAP2_CONTROL_GENERAL + 0x012C)
+
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
 #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
@@ -240,6 +257,16 @@
 #define OMAP2_SYSBOOT_1_MASK		(1 << 1)
 #define OMAP2_SYSBOOT_0_MASK		(1 << 0)
 
+/* CONTROL_FUSE_SR bits */
+#define OMAP343X_SR2_SENNENABLE_MASK    (0x3 << 10)
+#define OMAP343X_SR2_SENNENABLE_SHIFT   10
+#define OMAP343X_SR2_SENPENABLE_MASK    (0x3 << 8)
+#define OMAP343X_SR2_SENPENABLE_SHIFT   8
+#define OMAP343X_SR1_SENNENABLE_MASK    (0x3 << 2)
+#define OMAP343X_SR1_SENNENABLE_SHIFT   2
+#define OMAP343X_SR1_SENPENABLE_MASK    (0x3 << 0)
+#define OMAP343X_SR1_SENPENABLE_SHIFT   0
+
 /* CONTROL_PBIAS_LITE bits */
 #define OMAP343X_PBIASLITESUPPLY_HIGH1	(1 << 15)
 #define OMAP343X_PBIASLITEVMODEERROR1	(1 << 11)
-- 
1.7.0.rc1.33.g07cf0f


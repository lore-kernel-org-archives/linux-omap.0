From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 2/2] OMAP3: PM: Adding OMAP3630 support in smartreflex driver
Date: Fri, 16 Apr 2010 15:49:56 +0530
Message-ID: <1271413196-6087-3-git-send-email-thara@ti.com>
References: <1271413196-6087-1-git-send-email-thara@ti.com>
 <1271413196-6087-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696Ab0DPKUL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 06:20:11 -0400
In-Reply-To: <1271413196-6087-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adapts smartreflex driver to support OMAP3630 also.
Changes involve:
1. Separate hwmod structures for OMAP3630 distinguished from
   3430 structures using omap_chip attribute.
2. Introducing new test nvalues for OMAP3630.
3. OMAP3630 specific changes for srconfig err_minlimit field,
   vpx_config errorgain field and vpx_vlimitto vddmax and vddmin
   fields.
4. Adding 3630 voltage tables in voltage.c

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c        |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   86 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/smartreflex.c          |    2 +-
 arch/arm/mach-omap2/voltage.c              |   45 +++++++++++++-
 arch/arm/mach-omap2/voltage.h              |   22 ++++++-
 arch/arm/plat-omap/include/plat/control.h  |    8 +++
 6 files changed, 154 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 2fc1d0b..b06f59a 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -27,6 +27,7 @@
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 #include "pm.h"
 #include "omap3-opp.h"
+#include "smartreflex-class3.h"
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -107,6 +108,7 @@ static void __init omap_sdp_init(void)
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 1f41310..994d65f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -225,6 +225,25 @@ static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
 	.rev  = 1,
 };
 
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
 /* SR1 */
 static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
 	&omap3_l4_core__sr1,
@@ -257,10 +276,41 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.slaves		= omap34xx_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
 	.dev_attr	= &omap34xx_sr1_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+static u32 omap36xx_sr1_efuse_offs[] = {
+	OMAP3630_CONTROL_FUSE_OPP50_VDD1, OMAP3630_CONTROL_FUSE_OPP100_VDD1,
+	OMAP3630_CONTROL_FUSE_OPP120_VDD1, OMAP3630_CONTROL_FUSE_OPPTM_VDD1,
+};
+
+static u32 omap36xx_sr1_test_nvalues[] = {
+	0x898beb, 0x999b83, 0xaac5a8, 0xaab197,
+};
+
+static struct omap_smartreflex_dev_data omap36xx_sr1_dev_attr = {
+	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
+	.sennenable_shift	= OMAP343X_SR1_SENNENABLE_SHIFT,
+	.senpenable_shift	= OMAP343X_SR1_SENPENABLE_SHIFT,
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
+	.slaves		= omap34xx_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
+	.dev_attr	= &omap36xx_sr1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 /* SR2 */
 static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
 	&omap3_l4_core__sr2,
@@ -292,10 +342,40 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.slaves		= omap34xx_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
 	.dev_attr	= &omap34xx_sr2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+static u32 omap36xx_sr2_efuse_offs[] = {
+	OMAP3630_CONTROL_FUSE_OPP50_VDD2, OMAP3630_CONTROL_FUSE_OPP100_VDD2,
+};
+
+static u32 omap36xx_sr2_test_nvalues[] = {
+	0x898beb, 0x9a8cee,
+};
+
+static struct omap_smartreflex_dev_data omap36xx_sr2_dev_attr = {
+	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
+	.sennenable_shift	= OMAP343X_SR2_SENNENABLE_SHIFT,
+	.senpenable_shift	= OMAP343X_SR2_SENPENABLE_SHIFT,
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
+	.slaves		= omap34xx_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
+	.dev_attr	= &omap36xx_sr2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -304,6 +384,8 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_mpu_hwmod,
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	&omap36xx_sr1_hwmod,
+	&omap36xx_sr2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index b81f9f3..a6a29d1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -183,7 +183,7 @@ static void sr_set_regfields(struct omap_sr *sr)
 	 * file or pmic specific data structure. In that case these structure
 	 * fields will have to be populated using the pdata or pmic structure.
 	 */
-	if (cpu_is_omap343x()) {
+	if (cpu_is_omap34xx()) {
 		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
 		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
 		sr->accum_data = OMAP3430_SR_ACCUMDATA;
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 554f137..c5e9c42 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -161,6 +161,13 @@ static struct omap_volt_data omap34xx_vdd1_volt_data[] = {
 	{1350000, 0, 0xF9, 0x18},
 };
 
+static struct omap_volt_data omap36xx_vdd1_volt_data[] = {
+	{930000, 0, 0xF4, 0x0C},
+	{1100000, 0, 0xF9, 0x16},
+	{1260000, 0, 0xFA, 0x23},
+	{1350000, 0, 0xFA, 0x27},
+};
+
 /* VDD2 */
 static struct omap_volt_data omap34xx_vdd2_volt_data[] = {
 	{975000, 0, 0xF4, 0x0C},
@@ -168,6 +175,12 @@ static struct omap_volt_data omap34xx_vdd2_volt_data[] = {
 	{1150000, 0, 0xF9, 0x18},
 };
 
+static struct omap_volt_data omap36xx_vdd2_volt_data[] = {
+	{930000, 0, 0xF4, 0x0C},
+	{1137500, 0, 0xF9, 0x16},
+};
+
+
 /* By default VPFORCEUPDATE is the chosen method of voltage scaling */
 static bool voltscale_vpforceupdate = true;
 
@@ -322,24 +335,48 @@ static void __init vp_data_configure(int vp_id)
 
 		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
 		if (vp_id == VDD1) {
+			u8 vlimitto_vddmin, vlimitto_vddmax;
+
+			if (cpu_is_omap3630()) {
+				vlimitto_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
+			vp_reg[vp_id].volt_data = omap36xx_vdd1_volt_data;
+			vp_reg[vp_id].volt_data_count =
+					ARRAY_SIZE(omap36xx_vdd1_volt_data);
+			} else {
+				vlimitto_vddmin = OMAP3430_VP1_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3430_VP1_VLIMITTO_VDDMAX;
 			vp_reg[vp_id].volt_data = omap34xx_vdd1_volt_data;
 			vp_reg[vp_id].volt_data_count =
 					ARRAY_SIZE(omap34xx_vdd1_volt_data);
+			}
 			curr_volt = get_curr_vdd1_voltage();
-			vp_reg[vp_id].vp_vddmin = (OMAP3_VP1_VLIMITTO_VDDMIN <<
+			vp_reg[vp_id].vp_vddmin = (vlimitto_vddmin <<
 					OMAP3430_VDDMIN_SHIFT);
-			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
+			vp_reg[vp_id].vp_vddmax = (vlimitto_vddmax <<
 					OMAP3430_VDDMAX_SHIFT);
 			vp_reg[vp_id].vp_tranxdone_status =
 					OMAP3430_VP1_TRANXDONE_ST;
 		} else if (vp_id == VDD2) {
+			u8 vlimitto_vddmin, vlimitto_vddmax;
+
+			if (cpu_is_omap3630()) {
+				vlimitto_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+			vp_reg[vp_id].volt_data = omap36xx_vdd2_volt_data;
+			vp_reg[vp_id].volt_data_count =
+					ARRAY_SIZE(omap36xx_vdd2_volt_data);
+			} else {
+				vlimitto_vddmin = OMAP3430_VP2_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3430_VP2_VLIMITTO_VDDMAX;
 			vp_reg[vp_id].volt_data = omap34xx_vdd2_volt_data;
 			vp_reg[vp_id].volt_data_count =
 					ARRAY_SIZE(omap34xx_vdd2_volt_data);
+			}
 			curr_volt = get_curr_vdd2_voltage();
-			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
+			vp_reg[vp_id].vp_vddmin = (vlimitto_vddmin <<
 					OMAP3430_VDDMIN_SHIFT);
-			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
+			vp_reg[vp_id].vp_vddmax = (vlimitto_vddmax <<
 					OMAP3430_VDDMAX_SHIFT);
 			vp_reg[vp_id].vp_tranxdone_status =
 					OMAP3430_VP2_TRANXDONE_ST;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 473a953..c6445c5 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -58,12 +58,26 @@
 #define OMAP3_VP_VSTEPMIN_VSTEPMIN		0x1
 #define OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX	0x3C
 #define OMAP3_VP_VSTEPMAX_VSTEPMAX		0x04
-#define OMAP3_VP1_VLIMITTO_VDDMIN		0x14
-#define OMAP3_VP1_VLIMITTO_VDDMAX		0x42
-#define OMAP3_VP2_VLIMITTO_VDDMAX		0x2C
-#define OMAP3_VP2_VLIMITTO_VDDMIN		0x18
 #define OMAP3_VP_VLIMITTO_TIMEOUT_US		0x200
 
+/*
+ * Omap3430 specific VP register values. Maybe these need to come from
+ * board file or PMIC data structure
+ */
+#define OMAP3430_VP1_VLIMITTO_VDDMIN		0x14
+#define OMAP3430_VP1_VLIMITTO_VDDMAX		0x42
+#define OMAP3430_VP2_VLIMITTO_VDDMAX		0x2C
+#define OMAP3430_VP2_VLIMITTO_VDDMIN		0x18
+
+/*
+ * Omap3630 specific VP register values. Maybe these need to come from
+ * board file or PMIC data structure
+ */
+#define OMAP3630_VP1_VLIMITTO_VDDMIN		0x18
+#define OMAP3630_VP1_VLIMITTO_VDDMAX		0x3C
+#define OMAP3630_VP2_VLIMITTO_VDDMIN		0x18
+#define OMAP3630_VP2_VLIMITTO_VDDMAX		0x30
+
 /* TODO OMAP4 VP register values if the same file is used for OMAP4*/
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index d540ae8..7a94feb 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -169,6 +169,14 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
+/* OMAP3630 only CONTROL_GENERAL register offsets */
+#define OMAP3630_CONTROL_FUSE_OPP50_VDD1	(OMAP2_CONTROL_GENERAL + 0x0114)
+#define OMAP3630_CONTROL_FUSE_OPP100_VDD1	(OMAP2_CONTROL_GENERAL + 0x0118)
+#define OMAP3630_CONTROL_FUSE_OPP120_VDD1	(OMAP2_CONTROL_GENERAL + 0x011C)
+#define OMAP3630_CONTROL_FUSE_OPPTM_VDD1	(OMAP2_CONTROL_GENERAL + 0x0120)
+#define OMAP3630_CONTROL_FUSE_OPP50_VDD2	(OMAP2_CONTROL_GENERAL + 0x0128)
+#define OMAP3630_CONTROL_FUSE_OPP100_VDD2	(OMAP2_CONTROL_GENERAL + 0x012C)
+
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
 #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
-- 
1.7.0.rc1.33.g07cf0f


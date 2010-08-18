From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 01/10] OMAP4: PM debugfs support
Date: Wed, 18 Aug 2010 16:46:22 +0530
Message-ID: <1282130191-9062-2-git-send-email-thara@ti.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42880 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0HRLQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 07:16:43 -0400
In-Reply-To: <1282130191-9062-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch extends pm debugfs to support OMAP4 debug entries
also. Currently for register dumps only CM1 and PRM modules
are added. CM2 is not added as the clockdomain read write
APIs assume CM1 base. Once this is fixed CM2 can also be
added in the OMAP4 register module table.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |   53 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 05fe48b..0b2eaa6 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -221,7 +221,34 @@ static const struct pm_module_def omap3_pm_reg_modules[] = {
 	{ "USB", MOD_PRM, OMAP3430ES2_USBHOST_MOD, 0x58, 0xe8 },
 	{ "", 0, 0, 0, 0 },
 };
-
+static const struct pm_module_def omap4_pm_reg_modules[] = {
+	{ "CM1_OCP", MOD_CM, OMAP4430_CM1_OCP_SOCKET_MOD, 0, 0x40 },
+	{ "CKGEN", MOD_CM, OMAP4430_CM1_CKGEN_MOD, 0, 0x180 },
+	{ "MPU", MOD_CM, OMAP4430_CM1_MPU_MOD, 0, 0x20 },
+	{ "TESLA", MOD_CM, OMAP4430_CM1_TESLA_MOD, 0, 0x20 },
+	{ "ABE", MOD_CM, OMAP4430_CM1_ABE_MOD, 0, 0x88 },
+	{ "RESTORE", MOD_CM, OMAP4430_CM1_RESTORE_MOD, 0, 0x34 },
+	{ "INSTR", MOD_CM, OMAP4430_CM1_INSTR_MOD, 0, 0x30 },
+	{ "OCP", MOD_PRM, OMAP4430_PRM_OCP_SOCKET_MOD, 0, 0x40 },
+	{ "CLKGEN", MOD_PRM, OMAP4430_PRM_CKGEN_MOD, 0, 0x10 },
+	{ "MPU", MOD_PRM, OMAP4430_PRM_MPU_MOD, 0, 0x24 },
+	{ "TESLA", MOD_PRM, OMAP4430_PRM_TESLA_MOD, 0, 0x24 },
+	{ "ABE", MOD_PRM, OMAP4430_PRM_ABE_MOD, 0, 0x8C },
+	{ "AWYS_ON", MOD_PRM, OMAP4430_PRM_ALWAYS_ON_MOD, 0x24, 0x3C },
+	{ "CORE", MOD_PRM, OMAP4430_PRM_CORE_MOD, 0, 0x744 },
+	{ "IVAHD", MOD_PRM, OMAP4430_PRM_IVAHD_MOD, 0, 0x2C },
+	{ "CAM", MOD_PRM, OMAP4430_PRM_CAM_MOD, 0, 0x2C },
+	{ "DSS", MOD_PRM, OMAP4430_PRM_DSS_MOD, 0, 0x24 },
+	{ "GFX", MOD_PRM, OMAP4430_PRM_GFX_MOD, 0, 0x24 },
+	{ "L3INIT", MOD_PRM, OMAP4430_PRM_L3INIT_MOD, 0, 0xe4 },
+	{ "L4PER", MOD_PRM, OMAP4430_PRM_L4PER_MOD, 0, 0x168 },
+	{ "WKUP", MOD_PRM, OMAP4430_PRM_WKUP_MOD, 0x24, 0x84 },
+	{ "WKUP_CM", MOD_PRM, OMAP4430_PRM_WKUP_CM_MOD, 0, 0x88 },
+	{ "EMU", MOD_PRM, OMAP4430_PRM_EMU_MOD, 0, 0x24 },
+	{ "EMU_CM", MOD_PRM, OMAP4430_PRM_EMU_CM_MOD, 0, 0x20 },
+	{ "DEVICE", MOD_PRM, OMAP4430_PRM_DEVICE_MOD, 0, 0xf0 },
+	{ "", 0, 0, 0, 0 },
+};
 #define PM_DBG_MAX_REG_SETS 4
 
 static void *pm_dbg_reg_set[PM_DBG_MAX_REG_SETS];
@@ -247,11 +274,21 @@ static int pm_dbg_show_regs(struct seq_file *s, void *unused)
 	int i, j;
 	unsigned long val;
 	int reg_set = (int)s->private;
-	u32 *ptr;
+	u32 *ptr, cm_base, prm_base;
 	void *store = NULL;
 	int regs;
 	int linefeed;
 
+	if (cpu_is_omap34xx()) {
+		cm_base = OMAP3430_CM_BASE;
+		prm_base = OMAP3430_PRM_BASE;
+	} else if (cpu_is_omap44xx()) {
+		cm_base = OMAP4430_CM_BASE;
+		prm_base = OMAP4430_PRM_BASE;
+	} else {
+		return -EINVAL;
+	}
+
 	if (reg_set == 0) {
 		store = kmalloc(pm_dbg_get_regset_size(), GFP_KERNEL);
 		ptr = store;
@@ -268,12 +305,12 @@ static int pm_dbg_show_regs(struct seq_file *s, void *unused)
 		if (pm_dbg_reg_modules[i].type == MOD_CM)
 			seq_printf(s, "MOD: CM_%s (%08x)\n",
 				pm_dbg_reg_modules[i].name,
-				(u32)(OMAP3430_CM_BASE +
+				(u32)(cm_base +
 				pm_dbg_reg_modules[i].offset));
 		else
 			seq_printf(s, "MOD: PRM_%s (%08x)\n",
 				pm_dbg_reg_modules[i].name,
-				(u32)(OMAP3430_PRM_BASE +
+				(u32)(prm_base +
 				pm_dbg_reg_modules[i].offset));
 
 		for (j = pm_dbg_reg_modules[i].low;
@@ -592,10 +629,12 @@ static int __init pm_dbg_init(void)
 	if (pm_dbg_init_done)
 		return 0;
 
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
 		pm_dbg_reg_modules = omap3_pm_reg_modules;
-	else {
-		printk(KERN_ERR "%s: only OMAP3 supported\n", __func__);
+	} else if (cpu_is_omap44xx()) {
+		pm_dbg_reg_modules = omap4_pm_reg_modules;
+	} else {
+		printk(KERN_ERR "%s: only OMAP3/4 supported\n", __func__);
 		return -ENODEV;
 	}
 
-- 
1.7.1.GIT


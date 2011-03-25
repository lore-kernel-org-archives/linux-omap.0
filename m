From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP2+: VC: begin spliting out SoC specifics; start with i2c slave addr
Date: Thu, 24 Mar 2011 17:09:54 -0700
Message-ID: <1301011795-6754-1-git-send-email-khilman@ti.com>
References: <87lj04xe2t.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47017 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136Ab1CYAJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 20:09:33 -0400
Received: by mail-iw0-f181.google.com with SMTP id 2so592974iwn.40
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 17:09:30 -0700 (PDT)
In-Reply-To: <87lj04xe2t.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Each VC instance is given a new 'ops' field which contains SoC
specific implementations of various functions.  For starters, this
patch adds an operation for setting the i2c slave address.

Changes to VC data structures
 - add id field to be used by the SoC-specific PRM VC code
 - remove unused smps_sa_reg.  This is now part of the SoC specific VC code
 - remove smps_sa_shift from VC instance, use ffs(mask) to calculate shift

Special thanks to Paul Walmsley for brainstorming with me and giving
suggestions and guidance for the splitting up of this code.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/prm.h          |   24 +++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   37 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.c      |   44 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc.c           |   12 ++++-----
 arch/arm/mach-omap2/vc.h           |    9 ++-----
 arch/arm/mach-omap2/vc3xxx_data.c  |   10 ++++----
 arch/arm/mach-omap2/vc44xx_data.c  |   13 +++++-----
 7 files changed, 124 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 39d5621..4daee4a 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -16,6 +16,30 @@
 #include "prcm-common.h"
 
 /*
+ * Voltage Controller (VC) identifiers.
+ */
+#define OMAP3_PRM_VC_VDD_MPU_ID 0
+#define OMAP3_PRM_VC_VDD_CORE_ID 1
+#define OMAP4_PRM_VC_VDD_MPU_ID 0
+#define OMAP4_PRM_VC_VDD_IVA_ID 1
+#define OMAP4_PRM_VC_VDD_CORE_ID 2
+
+#ifndef __ASSEMBLY__
+
+/**
+ * struct omap_prm_vc_ops - SoC specific implementations of VC functions
+ * @set_i2c_slave_addr: set I2C slave address of PMIC SMPS
+ */
+struct omap_prm_vc_ops {
+	int (*set_i2c_slave_addr)(u8 vc_id, u8 addr);
+};
+
+extern struct omap_prm_vc_ops omap3_prm_vc_ops;
+extern struct omap_prm_vc_ops omap4_prm_vc_ops;
+
+#endif /* __ASSEMBLY__ */
+
+/*
  * 24XX: PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP
  *
  * 2430: PM_PWSTST_MDM
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 051213f..b0cc855 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -156,3 +156,40 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift)
 
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }
+
+/*
+ * OMAP3 VC
+ */
+struct omap3_prm_vc {
+	u32 smps_sa_mask;
+};
+
+static struct omap3_prm_vc vc_channels[] = {
+	[OMAP3_PRM_VC_VDD_MPU_ID] = {
+		.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
+	},
+	[OMAP3_PRM_VC_VDD_CORE_ID] = {
+		.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
+	},
+};
+
+#define MAX_VC_ID ARRAY_SIZE(vc_channels)
+
+int omap3_prm_vc_set_i2c_slave_addr(u8 vc_id, u8 slave_addr)
+{
+	struct omap3_prm_vc *vc = &vc_channels[vc_id];
+
+	if (WARN_ON(vc_id > MAX_VC_ID))
+		return -EINVAL;
+
+	omap2_prm_rmw_mod_reg_bits(vc->smps_sa_mask, 
+				   slave_addr << ffs(vc->smps_sa_mask),
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_SMPS_SA_OFFSET);
+
+	return 0;
+}
+
+struct omap_prm_vc_ops omap3_prm_vc_ops = {
+	.set_i2c_slave_addr = omap3_prm_vc_set_i2c_slave_addr,
+};
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index a2a04bf..2e4bdf5 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -21,8 +21,11 @@
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
+#include "prm.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
+#include "prminst44xx.h"
+#include "prcm44xx.h"
 
 /*
  * Address offset (in bytes) between the reset control and the reset
@@ -193,3 +196,44 @@ void omap4_prm_global_warm_sw_reset(void)
 	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
 				    OMAP4_RM_RSTCTRL);
 }
+
+/*
+ * OMAP4 VC
+ */
+struct omap4_prm_vc {
+	u32 smps_sa_mask;
+};
+
+static struct omap4_prm_vc vc_channels[] = {
+	[OMAP4_PRM_VC_VDD_MPU_ID] = {
+		.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
+	},
+	[OMAP4_PRM_VC_VDD_IVA_ID] = {
+		.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
+	},
+	[OMAP4_PRM_VC_VDD_CORE_ID] = {
+		.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
+	},
+};
+
+#define MAX_VC_ID ARRAY_SIZE(vc_channels)
+
+int omap4_prm_vc_set_i2c_slave_addr(u8 vc_id, u8 slave_addr)
+{
+	struct omap4_prm_vc *vc = &vc_channels[vc_id];
+
+	if (WARN_ON(vc_id > MAX_VC_ID))
+		return -EINVAL;
+
+	omap4_prminst_rmw_inst_reg_bits(vc->smps_sa_mask, 
+					slave_addr << ffs(vc->smps_sa_mask),
+					OMAP4430_PRM_PARTITION,
+					OMAP4430_PRM_DEVICE_INST,
+					OMAP4_PRM_VC_SMPS_SA_OFFSET);
+
+	return 0;
+}
+
+struct omap_prm_vc_ops omap4_prm_vc_ops = {
+	.set_i2c_slave_addr = omap4_prm_vc_set_i2c_slave_addr,
+};
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 1a4a71c..dd3b8a0 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -243,13 +243,11 @@ void __init omap_vc_init(struct voltagedomain *voltdm)
 		return;
 	}
 
-	/* Set up the SMPS_SA(i2c slave address in VC */
-	vc_val = vdd->read_reg(vc->common->prm_mod,
-			       vc->common->smps_sa_reg);
-	vc_val &= ~vc->smps_sa_mask;
-	vc_val |= vdd->pmic_info->i2c_slave_addr << vc->smps_sa_shift;
-	vdd->write_reg(vc_val, vc->common->prm_mod,
-		       vc->common->smps_sa_reg);
+	if (WARN_ON(!vc->ops))
+		return;
+
+	/* Set up the SMPS i2c slave address in VC */
+	vc->ops->set_i2c_slave_addr(vc->id, vdd->pmic_info->i2c_slave_addr);
 
 	/* Setup the VOLRA(pmic reg addr) in VC */
 	vc_val = vdd->read_reg(vc->common->prm_mod,
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 40632b6..4770117 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -26,7 +26,6 @@ struct voltagedomain;
  * @cmd_on_mask: ON bitmask in PRM_VC_CMD_VAL* register
  * @valid: VALID bitmask in PRM_VC_BYPASS_VAL register
  * @prm_mod: PRM module id used for PRM register access
- * @smps_sa_reg: Offset of PRM_VC_SMPS_SA reg from PRM start
  * @smps_volra_reg: Offset of PRM_VC_SMPS_VOL_RA reg from PRM start
  * @bypass_val_reg: Offset of PRM_VC_BYPASS_VAL reg from PRM start
  * @data_shift: DATA field shift in PRM_VC_BYPASS_VAL register
@@ -44,7 +43,6 @@ struct omap_vc_common {
 	u32 cmd_on_mask;
 	u32 valid;
 	s16 prm_mod;
-	u8 smps_sa_reg;
 	u8 smps_volra_reg;
 	u8 bypass_val_reg;
 	u8 data_shift;
@@ -59,9 +57,7 @@ struct omap_vc_common {
 /**
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
- * @smps_sa_mask: SA* bitmask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
- * @smps_sa_shift: SA* field shift in the PRM_VC_SMPS_SA register
  * @smps_volra_shift: VOLRA* field shift in the PRM_VC_VOL_RA register
  *
  * XXX It is not necessary to have both a *_mask and a *_shift -
@@ -69,11 +65,12 @@ struct omap_vc_common {
  */
 struct omap_vc_channel {
 	const struct omap_vc_common *common;
-	u32 smps_sa_mask;
 	u32 smps_volra_mask;
 	u8 cmdval_reg;
-	u8 smps_sa_shift;
 	u8 smps_volra_shift;
+
+	u8 id;
+	struct omap_prm_vc_ops *ops;
 };
 
 extern struct omap_vc_channel omap3_vc_mpu;
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 1a17ed4..6d40453 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -21,6 +21,7 @@
 #include <plat/common.h>
 
 #include "prm-regbits-34xx.h"
+#include "prm2xxx_3xxx.h"
 #include "voltage.h"
 
 #include "vc.h"
@@ -31,7 +32,6 @@
  */
 static struct omap_vc_common omap3_vc_common = {
 	.prm_mod         = OMAP3430_GR_MOD,
-	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
 	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
 	.data_shift	 = OMAP3430_DATA_SHIFT,
@@ -46,19 +46,19 @@ static struct omap_vc_common omap3_vc_common = {
 };
 
 struct omap_vc_channel omap3_vc_mpu = {
+	.id = OMAP3_PRM_VC_VDD_MPU_ID,
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
-	.smps_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT,
-	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
 	.smps_volra_shift = OMAP3430_VOLRA0_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
+	.ops = &omap3_prm_vc_ops,
 };
 
 struct omap_vc_channel omap3_vc_core = {
+	.id = OMAP3_PRM_VC_VDD_CORE_ID,
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
-	.smps_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT,
-	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
 	.smps_volra_shift = OMAP3430_VOLRA1_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
+	.ops = &omap3_prm_vc_ops,
 };
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 56f3f4a..5badd08 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -32,7 +32,6 @@
  */
 static const struct omap_vc_common omap4_vc_common = {
 	.prm_mod = OMAP4430_PRM_DEVICE_INST,
-	.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
 	.bypass_val_reg = OMAP4_PRM_VC_VAL_BYPASS_OFFSET,
 	.data_shift = OMAP4430_DATA_SHIFT,
@@ -48,29 +47,29 @@ static const struct omap_vc_common omap4_vc_common = {
 
 /* VC instance data for each controllable voltage line */
 struct omap_vc_channel omap4_vc_mpu = {
+	.id = OMAP4_PRM_VC_VDD_MPU_ID,
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_SHIFT,
-	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_MPU_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
+	.ops = &omap4_prm_vc_ops,
 };
 
 struct omap_vc_channel omap4_vc_iva = {
+	.id = OMAP4_PRM_VC_VDD_IVA_ID,
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_SHIFT,
-	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_IVA_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
+	.ops = &omap4_prm_vc_ops,
 };
 
 struct omap_vc_channel omap4_vc_core = {
+	.id = OMAP4_PRM_VC_VDD_CORE_ID,
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_CORE_L_0_6_SHIFT,
-	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_CORE_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
+	.ops = &omap4_prm_vc_ops,
 };
 
-- 
1.7.4


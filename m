From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 17/19] OMAP2+: voltage: VC: begin spliting out SoC specifics; start with i2c slave addr
Date: Wed, 23 Mar 2011 17:00:31 -0700
Message-ID: <1300924833-26745-18-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:36828 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933394Ab1CXAAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:48 -0400
Received: by mail-iy0-f180.google.com with SMTP id 40so12558165iyf.11
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:47 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Each VC instance is given a new 'ops' field which contains SoC
specific implementations of various functions.  For starters, this
patch adds an operation for setting the i2c slave address.

Changes to VC data structures
- remove unused smps_sa_reg.  This is now part of the SoC specific VC code
- remove smps_sa_shift from VC instancc, use ffs(mask) to calculate shift

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    5 ++-
 arch/arm/mach-omap2/vc.c          |    9 +-----
 arch/arm/mach-omap2/vc.h          |   20 ++++++++++++----
 arch/arm/mach-omap2/vc3xxx.c      |   45 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc3xxx_data.c |    5 +--
 arch/arm/mach-omap2/vc44xx.c      |   45 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc44xx_data.c |    8 ++----
 7 files changed, 115 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mach-omap2/vc3xxx.c
 create mode 100644 arch/arm/mach-omap2/vc44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bb82611..0d659ae 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -79,14 +79,15 @@ endif
 # PRCM
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
-					   vc3xxx_data.o vp3xxx_data.o
+					   vc3xxx_data.o vp3xxx_data.o \
+					   vc3xxx.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
 # will be removed once the OMAP4 part of the codebase is converted to
 # use OMAP4-specific PRCM functions.
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
 					   prminst44xx.o vc44xx_data.o \
-					   vp44xx_data.o
+					   vp44xx_data.o vc44xx.o
 
 # OMAP voltage domains
 ifeq ($(CONFIG_PM),y)
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 29fbebd..0c9a494 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -243,13 +243,8 @@ void __init omap_vc_init(struct voltagedomain *voltdm)
 		return;
 	}
 
-	/* Set up the SMPS_SA(i2c slave address in VC */
-	vc_val = vdd->read_reg(vc->common->prm_mod,
-			       vc->common->smps_sa_reg);
-	vc_val &= ~vc->smps_sa_mask;
-	vc_val |= vdd->pmic_info->i2c_slave_addr << vc->smps_sa_shift;
-	vdd->write_reg(vc_val, vc->common->prm_mod,
-		       vc->common->smps_sa_reg);
+	/* Set up the SMPS i2c slave address in VC */
+	vc->ops->set_i2c_slave_addr(vc, vdd->pmic_info->i2c_slave_addr);
 
 	/* Setup the VOLRA(pmic reg addr) in VC */
 	vc_val = vdd->read_reg(vc->common->prm_mod,
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 40632b6..a29e117 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -20,13 +20,21 @@
 #include <linux/kernel.h>
 
 struct voltagedomain;
+struct omap_vc_channel;
+
+/**
+ * struct omap_vc_ops - SoC specific implementations of VC functions
+ * @set_i2c_slave_addr: set I2C slave address of PMIC SMPS
+ */
+struct omap_vc_ops {
+	int (*set_i2c_slave_addr)(struct omap_vc_channel *vc, u8 addr);
+};
 
 /**
  * struct omap_vc_common - per-VC register/bitfield data
  * @cmd_on_mask: ON bitmask in PRM_VC_CMD_VAL* register
  * @valid: VALID bitmask in PRM_VC_BYPASS_VAL register
  * @prm_mod: PRM module id used for PRM register access
- * @smps_sa_reg: Offset of PRM_VC_SMPS_SA reg from PRM start
  * @smps_volra_reg: Offset of PRM_VC_SMPS_VOL_RA reg from PRM start
  * @bypass_val_reg: Offset of PRM_VC_BYPASS_VAL reg from PRM start
  * @data_shift: DATA field shift in PRM_VC_BYPASS_VAL register
@@ -44,7 +52,6 @@ struct omap_vc_common {
 	u32 cmd_on_mask;
 	u32 valid;
 	s16 prm_mod;
-	u8 smps_sa_reg;
 	u8 smps_volra_reg;
 	u8 bypass_val_reg;
 	u8 data_shift;
@@ -59,10 +66,10 @@ struct omap_vc_common {
 /**
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
- * @smps_sa_mask: SA* bitmask in the PRM_VC_SMPS_SA register
+ * @smps_sa_mask: slave address field mask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
- * @smps_sa_shift: SA* field shift in the PRM_VC_SMPS_SA register
  * @smps_volra_shift: VOLRA* field shift in the PRM_VC_VOL_RA register
+ * @ops: SoC-specific implementations of VC operations
  *
  * XXX It is not necessary to have both a *_mask and a *_shift -
  *     remove one
@@ -72,16 +79,19 @@ struct omap_vc_channel {
 	u32 smps_sa_mask;
 	u32 smps_volra_mask;
 	u8 cmdval_reg;
-	u8 smps_sa_shift;
 	u8 smps_volra_shift;
+
+	struct omap_vc_ops *ops;
 };
 
 extern struct omap_vc_channel omap3_vc_mpu;
 extern struct omap_vc_channel omap3_vc_core;
+extern struct omap_vc_ops omap3_vc_ops;
 
 extern struct omap_vc_channel omap4_vc_mpu;
 extern struct omap_vc_channel omap4_vc_iva;
 extern struct omap_vc_channel omap4_vc_core;
+extern struct omap_vc_ops omap4_vc_ops;
 
 void omap_vc_init(struct voltagedomain *voltdm);
 int omap_vc_pre_scale(struct voltagedomain *voltdm,
diff --git a/arch/arm/mach-omap2/vc3xxx.c b/arch/arm/mach-omap2/vc3xxx.c
new file mode 100644
index 0000000..020d148
--- /dev/null
+++ b/arch/arm/mach-omap2/vc3xxx.c
@@ -0,0 +1,45 @@
+#include <linux/types.h>
+#include <linux/bitops.h>
+
+#include "voltage.h"
+#include "vc.h"
+#include "prm-regbits-34xx.h"
+#include "prm2xxx_3xxx.h"
+
+static inline u32 omap3_vc_read(u8 offset)
+{
+	return omap2_prm_read_mod_reg(OMAP3430_GR_MOD, offset);
+}
+
+static inline void omap3_vc_write(u32 val, u8 offset)
+{
+	omap2_prm_write_mod_reg(val, OMAP3430_GR_MOD, offset);
+}
+
+static inline u32 omap3_vc_rmw(u32 mask, u32 bits, u8 offset)
+{
+	u32 val;
+
+	val = omap3_vc_read(offset);
+	val &= ~mask;
+	val |= bits;
+	omap3_vc_write(val, offset);
+
+	return val;
+}
+
+static int omap3_vc_set_i2c_slave_addr(struct omap_vc_channel *vc,
+				       u8 slave_addr)
+{
+	omap3_vc_rmw(vc->smps_sa_mask, slave_addr << ffs(vc->smps_sa_mask),
+		     OMAP3_PRM_VC_SMPS_SA_OFFSET);
+
+	/* XXX should should probably also set the slave address in 
+	 *     PRM_VC_BYPASS_VAL. */
+
+	return 0;
+}
+
+struct omap_vc_ops omap3_vc_ops = {
+	.set_i2c_slave_addr = omap3_vc_set_i2c_slave_addr,
+};
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 1a17ed4..51aa2b6 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -31,7 +31,6 @@
  */
 static struct omap_vc_common omap3_vc_common = {
 	.prm_mod         = OMAP3430_GR_MOD,
-	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
 	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
 	.data_shift	 = OMAP3430_DATA_SHIFT,
@@ -48,17 +47,17 @@ static struct omap_vc_common omap3_vc_common = {
 struct omap_vc_channel omap3_vc_mpu = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
-	.smps_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
 	.smps_volra_shift = OMAP3430_VOLRA0_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
+	.ops = &omap3_vc_ops,
 };
 
 struct omap_vc_channel omap3_vc_core = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
-	.smps_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
 	.smps_volra_shift = OMAP3430_VOLRA1_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
+	.ops = &omap3_vc_ops,
 };
diff --git a/arch/arm/mach-omap2/vc44xx.c b/arch/arm/mach-omap2/vc44xx.c
new file mode 100644
index 0000000..f53a6c7
--- /dev/null
+++ b/arch/arm/mach-omap2/vc44xx.c
@@ -0,0 +1,45 @@
+#include <linux/types.h>
+
+#include "voltage.h"
+#include "vc.h"
+#include "prm-regbits-44xx.h"
+#include "prm44xx.h"
+#include "prminst44xx.h"
+#include "prcm44xx.h"
+
+static inline u32 omap4_vc_read(u8 offset)
+{
+	return omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+					   OMAP4430_PRM_DEVICE_INST, offset);
+}
+
+static inline void omap4_vc_write(u32 val, u8 offset)
+{
+	omap4_prminst_write_inst_reg(val, OMAP4430_PRM_PARTITION,
+				     OMAP4430_PRM_DEVICE_INST, offset);
+}
+
+static inline u32 omap4_vc_rmw(u32 mask, u32 bits, u8 offset)
+{
+	u32 val;
+
+	val = omap4_vc_read(offset);
+	val &= ~mask;
+	val |= bits;
+	omap4_vc_write(val, offset);
+
+	return val;
+}
+
+static int omap4_vc_set_i2c_slave_addr(struct omap_vc_channel *vc,
+				       u8 slave_addr)
+{
+	omap4_vc_rmw(vc->smps_sa_mask, slave_addr << ffs(vc->smps_sa_mask),
+		     OMAP4_PRM_VC_SMPS_SA_OFFSET);
+
+	return 0;
+}
+
+struct omap_vc_ops omap4_vc_ops = {
+	.set_i2c_slave_addr = omap4_vc_set_i2c_slave_addr,
+};
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 56f3f4a..9dbf307 100644
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
@@ -50,27 +49,26 @@ static const struct omap_vc_common omap4_vc_common = {
 struct omap_vc_channel omap4_vc_mpu = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_MPU_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
+	.ops = &omap4_vc_ops,
 };
 
 struct omap_vc_channel omap4_vc_iva = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_IVA_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
+	.ops = &omap4_vc_ops,
 };
 
 struct omap_vc_channel omap4_vc_core = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_CORE_L_0_6_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_CORE_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
+	.ops = &omap4_vc_ops,
 };
-
-- 
1.7.4


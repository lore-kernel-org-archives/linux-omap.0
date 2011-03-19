From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 6/7] OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
Date: Fri, 18 Mar 2011 17:18:51 -0700
Message-ID: <1300493932-17362-7-git-send-email-khilman@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33735 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757732Ab1CSASs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Mar 2011 20:18:48 -0400
Received: by mail-iw0-f172.google.com with SMTP id 42so4302757iwl.3
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 17:18:47 -0700 (PDT)
In-Reply-To: <1300493932-17362-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

The prm_irqst_reg is not part of the VP.  Move it up into the common
voltage domain struct.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.c                 |   15 +++++++--------
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 ++
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +++
 arch/arm/mach-omap2/vp.h                      |    3 ---
 arch/arm/mach-omap2/vp3xxx_data.c             |    2 --
 arch/arm/mach-omap2/vp44xx_data.c             |    3 ---
 7 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c25df81..89b8e38 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -429,23 +429,21 @@ static int vp_forceupdate_scale_voltage(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd = voltdm->vdd;
 	u32 vpconfig;
-	u8 target_vsel, current_vsel, prm_irqst_reg;
+	u8 target_vsel, current_vsel;
 	int ret, timeout = 0;
 
 	ret = _pre_volt_scale(voltdm, target_volt, &target_vsel, &current_vsel);
 	if (ret)
 		return ret;
 
-	prm_irqst_reg = vdd->vp_data->prm_irqst_data->prm_irqst_reg;
-
 	/*
 	 * Clear all pending TransactionDone interrupt/status. Typical latency
 	 * is <3us
 	 */
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
 		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
-			       vdd->prm_irqst_mod, prm_irqst_reg);
-		if (!(vdd->read_reg(vdd->prm_irqst_mod, prm_irqst_reg) &
+			       vdd->prm_irqst_mod, vdd->prm_irqst_reg);
+		if (!(vdd->read_reg(vdd->prm_irqst_mod, vdd->prm_irqst_reg) &
 		      vdd->vp_data->prm_irqst_data->tranxdone_status))
 			break;
 		udelay(1);
@@ -478,7 +476,8 @@ static int vp_forceupdate_scale_voltage(struct voltagedomain *voltdm,
 	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
 	 */
 	timeout = 0;
-	omap_test_timeout((vdd->read_reg(vdd->prm_irqst_mod, prm_irqst_reg) &
+	omap_test_timeout((vdd->read_reg(vdd->prm_irqst_mod,
+					 vdd->prm_irqst_reg) &
 			   vdd->vp_data->prm_irqst_data->tranxdone_status),
 			  VP_TRANXDONE_TIMEOUT, timeout);
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
@@ -495,8 +494,8 @@ static int vp_forceupdate_scale_voltage(struct voltagedomain *voltdm,
 	timeout = 0;
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
 		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
-			       vdd->prm_irqst_mod, prm_irqst_reg);
-		if (!(vdd->read_reg(vdd->prm_irqst_mod, prm_irqst_reg) &
+			       vdd->prm_irqst_mod, vdd->prm_irqst_reg);
+		if (!(vdd->read_reg(vdd->prm_irqst_mod, vdd->prm_irqst_reg) &
 		      vdd->vp_data->prm_irqst_data->tranxdone_status))
 			break;
 		udelay(1);
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 8e25126..f805478 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -147,6 +147,7 @@ struct omap_vdd_info {
 
 	s16 prm_mod;
 	s16 prm_irqst_mod;
+	u8 prm_irqst_reg;
 	u32 (*read_reg) (u16 mod, u8 offset);
 	void (*write_reg) (u32 val, u16 mod, u8 offset);
 	int (*volt_scale) (struct voltagedomain *voltdm,
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index bd60468..80c2e95 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -40,6 +40,7 @@ static const struct omap_vfsm_instance_data omap3_vdd1_vfsm_data = {
 static struct omap_vdd_info omap3_vdd1_info = {
 	.prm_mod = OMAP3430_GR_MOD,
 	.prm_irqst_mod = OCP_MOD,
+	.prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
 	.vp_data = &omap3_vp1_data,
 	.vc_data = &omap3_vc1_data,
 	.vfsm = &omap3_vdd1_vfsm_data,
@@ -54,6 +55,7 @@ static const struct omap_vfsm_instance_data omap3_vdd2_vfsm_data = {
 static struct omap_vdd_info omap3_vdd2_info = {
 	.prm_mod = OMAP3430_GR_MOD,
 	.prm_irqst_mod = OCP_MOD,
+	.prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
 	.vp_data = &omap3_vp2_data,
 	.vc_data = &omap3_vc2_data,
 	.vfsm = &omap3_vdd2_vfsm_data,
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index a13fbb7..bb3dc61 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -39,6 +39,7 @@ static const struct omap_vfsm_instance_data omap4_vdd_mpu_vfsm_data = {
 static struct omap_vdd_info omap4_vdd_mpu_info = {
 	.prm_mod = OMAP4430_PRM_DEVICE_INST,
 	.prm_irqst_mod = OMAP4430_PRM_OCP_SOCKET_INST,
+	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
 	.vp_data = &omap4_vp_mpu_data,
 	.vc_data = &omap4_vc_mpu_data,
 	.vfsm = &omap4_vdd_mpu_vfsm_data,
@@ -51,6 +52,7 @@ static const struct omap_vfsm_instance_data omap4_vdd_iva_vfsm_data = {
 static struct omap_vdd_info omap4_vdd_iva_info = {
 	.prm_mod = OMAP4430_PRM_DEVICE_INST,
 	.prm_irqst_mod = OMAP4430_PRM_OCP_SOCKET_INST,
+	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
 	.vp_data = &omap4_vp_iva_data,
 	.vc_data = &omap4_vc_iva_data,
 	.vfsm = &omap4_vdd_iva_vfsm_data,
@@ -63,6 +65,7 @@ static const struct omap_vfsm_instance_data omap4_vdd_core_vfsm_data = {
 static struct omap_vdd_info omap4_vdd_core_info = {
 	.prm_mod = OMAP4430_PRM_DEVICE_INST,
 	.prm_irqst_mod = OMAP4430_PRM_OCP_SOCKET_INST,
+	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
 	.vp_data = &omap4_vp_core_data,
 	.vc_data = &omap4_vc_core_data,
 	.vfsm = &omap4_vdd_core_vfsm_data,
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 7ce134f..77fb634 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -68,16 +68,13 @@ struct omap_vp_common_data {
 
 /**
  * struct omap_vp_prm_irqst_data - PRM_IRQSTATUS_MPU.VP_TRANXDONE_ST data
- * @prm_irqst_reg: reg offset for PRM_IRQSTATUS_MPU from top of PRM
  * @tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
  *
- * XXX prm_irqst_reg does not belong here
  * XXX Note that on OMAP3, VP_TRANXDONE interrupt may not work due to a
  *     hardware bug
  * XXX This structure is probably not needed
  */
 struct omap_vp_prm_irqst_data {
-	u8 prm_irqst_reg;
 	u32 tranxdone_status;
 };
 
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index 6452170..d05eff8 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -50,7 +50,6 @@ static const struct omap_vp_common_data omap3_vp_common = {
 };
 
 static const struct omap_vp_prm_irqst_data omap3_vp1_prm_irqst_data = {
-	.prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
 	.tranxdone_status = OMAP3430_VP1_TRANXDONE_ST_MASK,
 };
 
@@ -66,7 +65,6 @@ struct omap_vp_instance_data omap3_vp1_data = {
 };
 
 static const struct omap_vp_prm_irqst_data omap3_vp2_prm_irqst_data = {
-	.prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
 	.tranxdone_status = OMAP3430_VP2_TRANXDONE_ST_MASK,
 };
 
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index 65d1ad6..86221c8 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -51,7 +51,6 @@ static const struct omap_vp_common_data omap4_vp_common = {
 };
 
 static const struct omap_vp_prm_irqst_data omap4_vp_mpu_prm_irqst_data = {
-	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
 	.tranxdone_status = OMAP4430_VP_MPU_TRANXDONE_ST_MASK,
 };
 
@@ -67,7 +66,6 @@ struct omap_vp_instance_data omap4_vp_mpu_data = {
 };
 
 static const struct omap_vp_prm_irqst_data omap4_vp_iva_prm_irqst_data = {
-	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
 	.tranxdone_status = OMAP4430_VP_IVA_TRANXDONE_ST_MASK,
 };
 
@@ -83,7 +81,6 @@ struct omap_vp_instance_data omap4_vp_iva_data = {
 };
 
 static const struct omap_vp_prm_irqst_data omap4_vp_core_prm_irqst_data = {
-	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
 	.tranxdone_status = OMAP4430_VP_CORE_TRANXDONE_ST_MASK,
 };
 
-- 
1.7.4


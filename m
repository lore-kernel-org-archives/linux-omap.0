From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 08/13] OMAP3+: VC: cleanup voltage setup time configuration
Date: Fri,  1 Apr 2011 16:41:06 -0700
Message-ID: <1301701271-22096-9-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46920 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753698Ab1DAXkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:49 -0400
Received: by iyi12 with SMTP id 12so4021713iyi.9
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:48 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- add setup_time field to struct omap_vc_channel (init'd from PMIC data)
- use VC/VP register access helper for read/modify/write
- move VFSM structure from omap_vdd_info into struct voltagedomain

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c                      |   10 ++++------
 arch/arm/mach-omap2/vc.h                      |    1 +
 arch/arm/mach-omap2/voltage.h                 |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    4 ++--
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    6 +++---
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 3fdc3fb..7731794 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -214,7 +214,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
 	struct omap_vdd_info *vdd = voltdm->vdd;
-	u32 vc_val;
 
 	if (!vdd->pmic_info || !vdd->pmic_info->uv_to_vsel) {
 		pr_err("%s: PMIC info requried to configure vc for"
@@ -233,6 +232,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	vc->i2c_slave_addr = vdd->pmic_info->i2c_slave_addr;
 	vc->volt_reg_addr = vdd->pmic_info->volt_reg_addr;
 	vc->cmd_reg_addr = vdd->pmic_info->cmd_reg_addr;
+	vc->setup_time = vdd->pmic_info->volt_setup_time;
 
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
@@ -251,11 +251,9 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 			    vc->common->smps_cmdra_reg);
 
 	/* Configure the setup times */
-	vc_val = voltdm->read(vdd->vfsm->voltsetup_reg);
-	vc_val &= ~vdd->vfsm->voltsetup_mask;
-	vc_val |= vdd->pmic_info->volt_setup_time <<
-			vdd->vfsm->voltsetup_shift;
-	voltdm->write(vc_val, vdd->vfsm->voltsetup_reg);
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
+		    vc->setup_time << __ffs(voltdm->vfsm->voltsetup_mask),
+		    voltdm->vfsm->voltsetup_reg);
 
 	if (cpu_is_omap34xx())
 		omap3_vc_init_channel(voltdm);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 72c4ee2..ade35f7 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -66,6 +66,7 @@ struct omap_vc_channel {
 	u8 i2c_slave_addr;
 	u8 volt_reg_addr;
 	u8 cmd_reg_addr;
+	u16 setup_time;
 
 	/* register access data */
 	const struct omap_vc_common *common;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index a6f29fd..db08e2a 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -67,6 +67,7 @@ struct voltagedomain {
 	struct list_head node;
 	struct list_head pwrdm_list;
 	struct omap_vc_channel *vc;
+	const struct omap_vfsm_instance_data *vfsm;
 
 	/* VC/VP register access functions: SoC specific */
 	u32 (*read) (u8 offset);
@@ -147,7 +148,6 @@ struct omap_vdd_info {
 	struct omap_volt_pmic_info *pmic_info;
 	struct omap_vp_instance_data *vp_data;
 	struct omap_vp_runtime_data vp_rt_data;
-	const struct omap_vfsm_instance_data *vfsm;
 	struct dentry *debug_dir;
 	u32 curr_volt;
 	bool vp_enabled;
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 1d66749..44c7927 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -39,7 +39,6 @@ static const struct omap_vfsm_instance_data omap3_vdd1_vfsm_data = {
 
 static struct omap_vdd_info omap3_vdd1_info = {
 	.vp_data = &omap3_vp1_data,
-	.vfsm = &omap3_vdd1_vfsm_data,
 };
 
 static const struct omap_vfsm_instance_data omap3_vdd2_vfsm_data = {
@@ -50,7 +49,6 @@ static const struct omap_vfsm_instance_data omap3_vdd2_vfsm_data = {
 
 static struct omap_vdd_info omap3_vdd2_info = {
 	.vp_data = &omap3_vp2_data,
-	.vfsm = &omap3_vdd2_vfsm_data,
 };
 
 static struct voltagedomain omap3_voltdm_mpu = {
@@ -60,6 +58,7 @@ static struct voltagedomain omap3_voltdm_mpu = {
 	.write = omap3_prm_vcvp_write,
 	.rmw = omap3_prm_vcvp_rmw,
 	.vc = &omap3_vc_mpu,
+	.vfsm = &omap3_vdd1_vfsm_data,
 	.vdd = &omap3_vdd1_info,
 };
 
@@ -70,6 +69,7 @@ static struct voltagedomain omap3_voltdm_core = {
 	.write = omap3_prm_vcvp_write,
 	.rmw = omap3_prm_vcvp_rmw,
 	.vc = &omap3_vc_core,
+	.vfsm = &omap3_vdd2_vfsm_data,
 	.vdd = &omap3_vdd2_info,
 };
 
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index e435795..9dc919d 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -38,7 +38,6 @@ static const struct omap_vfsm_instance_data omap4_vdd_mpu_vfsm_data = {
 
 static struct omap_vdd_info omap4_vdd_mpu_info = {
 	.vp_data = &omap4_vp_mpu_data,
-	.vfsm = &omap4_vdd_mpu_vfsm_data,
 };
 
 static const struct omap_vfsm_instance_data omap4_vdd_iva_vfsm_data = {
@@ -47,7 +46,6 @@ static const struct omap_vfsm_instance_data omap4_vdd_iva_vfsm_data = {
 
 static struct omap_vdd_info omap4_vdd_iva_info = {
 	.vp_data = &omap4_vp_iva_data,
-	.vfsm = &omap4_vdd_iva_vfsm_data,
 };
 
 static const struct omap_vfsm_instance_data omap4_vdd_core_vfsm_data = {
@@ -56,7 +54,6 @@ static const struct omap_vfsm_instance_data omap4_vdd_core_vfsm_data = {
 
 static struct omap_vdd_info omap4_vdd_core_info = {
 	.vp_data = &omap4_vp_core_data,
-	.vfsm = &omap4_vdd_core_vfsm_data,
 };
 
 static struct voltagedomain omap4_voltdm_mpu = {
@@ -66,6 +63,7 @@ static struct voltagedomain omap4_voltdm_mpu = {
 	.write = omap4_prm_vcvp_write,
 	.rmw = omap4_prm_vcvp_rmw,
 	.vc = &omap4_vc_mpu,
+	.vfsm = &omap4_vdd_mpu_vfsm_data,
 	.vdd = &omap4_vdd_mpu_info,
 };
 
@@ -76,6 +74,7 @@ static struct voltagedomain omap4_voltdm_iva = {
 	.write = omap4_prm_vcvp_write,
 	.rmw = omap4_prm_vcvp_rmw,
 	.vc = &omap4_vc_iva,
+	.vfsm = &omap4_vdd_iva_vfsm_data,
 	.vdd = &omap4_vdd_iva_info,
 };
 
@@ -86,6 +85,7 @@ static struct voltagedomain omap4_voltdm_core = {
 	.write = omap4_prm_vcvp_write,
 	.rmw = omap4_prm_vcvp_rmw,
 	.vc = &omap4_vc_core,
+	.vfsm = &omap4_vdd_core_vfsm_data,
 	.vdd = &omap4_vdd_core_info,
 };
 
-- 
1.7.4


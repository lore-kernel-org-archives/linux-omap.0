From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/2] omap3: voltage: fix variable type and name
Date: Thu, 17 Mar 2011 20:42:37 +0530
Message-ID: <1300374757-23010-3-git-send-email-premi@ti.com>
References: <1300374757-23010-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34680 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab1CQPMw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 11:12:52 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2HFCnep017065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:12:51 -0500
In-Reply-To: <1300374757-23010-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

In all usages, variables prm_mod_offs and prm_irqst_ocp_mod_offs
are expected to be "u16" but have been declared as "s16".

In addition, renamed prm_irqst_ocp_mod_offs to ocp_sysreg_prm_offs
for better association with the TRM. Original name perhaps came
from the current usage of this offset to reach PRM_IRQSTATUS_MPU
offset.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index ce3098a..c686eca 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -51,8 +51,8 @@ static struct omap_vdd_info **vdd_info;
 static int nr_scalable_vdd;
 
 /* XXX document */
-static s16 prm_mod_offs;
-static s16 prm_irqst_ocp_mod_offs;
+static u16 prm_mod_offs;
+static u16 ocp_sysreg_prm_offs;
 
 static struct dentry *voltage_dir;
 
@@ -447,8 +447,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 */
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
 		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
-			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
-		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
+			       ocp_sysreg_prm_offs, prm_irqst_reg);
+		if (!(vdd->read_reg(ocp_sysreg_prm_offs, prm_irqst_reg) &
 		      vdd->vp_data->prm_irqst_data->tranxdone_status))
 			break;
 		udelay(1);
@@ -481,7 +481,7 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
 	 */
 	timeout = 0;
-	omap_test_timeout((vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
+	omap_test_timeout((vdd->read_reg(ocp_sysreg_prm_offs, prm_irqst_reg) &
 			   vdd->vp_data->prm_irqst_data->tranxdone_status),
 			  VP_TRANXDONE_TIMEOUT, timeout);
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
@@ -498,8 +498,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	timeout = 0;
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
 		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
-			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
-		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
+			       ocp_sysreg_prm_offs, prm_irqst_reg);
+		if (!(vdd->read_reg(ocp_sysreg_prm_offs, prm_irqst_reg) &
 		      vdd->vp_data->prm_irqst_data->tranxdone_status))
 			break;
 		udelay(1);
@@ -1101,10 +1101,10 @@ int __init omap_voltage_early_init(struct omap_vdd_info *omap_vdd_array[],
 {
 	if (cpu_is_omap44xx()) {
 		prm_mod_offs = OMAP4430_PRM_DEVICE_INST;
-		prm_irqst_ocp_mod_offs = OMAP4430_PRM_OCP_SOCKET_INST;
+		ocp_sysreg_prm_offs = OMAP4430_PRM_OCP_SOCKET_INST;
 	} else if (cpu_is_omap34xx()) {
 		prm_mod_offs = OMAP3430_GR_MOD;
-		prm_irqst_ocp_mod_offs = OCP_MOD;
+		ocp_sysreg_prm_offs = OCP_MOD;
 	} else {
 		/* TODO:
 		 * What should be done for OMAP24xx?
-- 
1.7.2.2


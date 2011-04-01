From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 02/13] OMAP3+ VP: replace transaction done check/clear with VP ops
Date: Fri,  1 Apr 2011 16:41:00 -0700
Message-ID: <1301701271-22096-3-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49568 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab1DAXkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:36 -0400
Received: by mail-iy0-f176.google.com with SMTP id 1so4758564iym.7
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:35 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Replace the VP tranxdone check/clear with helper functions from the
PRM layer.

In the process, remove prm_irqst_* voltage structure fields for IRQ
status checking which are no longer needed.

Since these reads/writes of the IRQ status bits were the only PRM
accesses that were not to VC/VP registers, this allows the rest of the
register accesses in the VC/VP code to use VC/VP specific register
access functions (done in the following patch.)

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.h                 |    2 --
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    4 ----
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    6 ------
 arch/arm/mach-omap2/vp.c                      |   16 +++++-----------
 4 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 65c5b81..a3e7d73 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -147,8 +147,6 @@ struct omap_vdd_info {
 	u32 curr_volt;
 	bool vp_enabled;
 
-	s16 prm_irqst_mod;
-	u8 prm_irqst_reg;
 	u32 (*read_reg) (u16 mod, u8 offset);
 	void (*write_reg) (u32 val, u16 mod, u8 offset);
 	int (*volt_scale) (struct voltagedomain *voltdm,
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 7cb27ec..ad8f05b 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -38,8 +38,6 @@ static const struct omap_vfsm_instance_data omap3_vdd1_vfsm_data = {
 };
 
 static struct omap_vdd_info omap3_vdd1_info = {
-	.prm_irqst_mod = OCP_MOD,
-	.prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
 	.vp_data = &omap3_vp1_data,
 	.vfsm = &omap3_vdd1_vfsm_data,
 };
@@ -51,8 +49,6 @@ static const struct omap_vfsm_instance_data omap3_vdd2_vfsm_data = {
 };
 
 static struct omap_vdd_info omap3_vdd2_info = {
-	.prm_irqst_mod = OCP_MOD,
-	.prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
 	.vp_data = &omap3_vp2_data,
 	.vfsm = &omap3_vdd2_vfsm_data,
 };
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index a05d90a..43e1d38 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -37,8 +37,6 @@ static const struct omap_vfsm_instance_data omap4_vdd_mpu_vfsm_data = {
 };
 
 static struct omap_vdd_info omap4_vdd_mpu_info = {
-	.prm_irqst_mod = OMAP4430_PRM_OCP_SOCKET_INST,
-	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
 	.vp_data = &omap4_vp_mpu_data,
 	.vfsm = &omap4_vdd_mpu_vfsm_data,
 };
@@ -48,8 +46,6 @@ static const struct omap_vfsm_instance_data omap4_vdd_iva_vfsm_data = {
 };
 
 static struct omap_vdd_info omap4_vdd_iva_info = {
-	.prm_irqst_mod = OMAP4430_PRM_OCP_SOCKET_INST,
-	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
 	.vp_data = &omap4_vp_iva_data,
 	.vfsm = &omap4_vdd_iva_vfsm_data,
 };
@@ -59,8 +55,6 @@ static const struct omap_vfsm_instance_data omap4_vdd_core_vfsm_data = {
 };
 
 static struct omap_vdd_info omap4_vdd_core_info = {
-	.prm_irqst_mod = OMAP4430_PRM_OCP_SOCKET_INST,
-	.prm_irqst_reg = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
 	.vp_data = &omap4_vp_core_data,
 	.vfsm = &omap4_vdd_core_vfsm_data,
 };
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index f3503de..113c839 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -111,10 +111,8 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	 * is <3us
 	 */
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		vdd->write_reg(vp->prm_irqst_data->tranxdone_status,
-			       vdd->prm_irqst_mod, vdd->prm_irqst_reg);
-		if (!(vdd->read_reg(vdd->prm_irqst_mod, vdd->prm_irqst_reg) &
-		      vp->prm_irqst_data->tranxdone_status))
+		vp->vp_common->ops->clear_txdone(vp->id);
+		if (!vp->vp_common->ops->check_txdone(vp->id))
 			break;
 		udelay(1);
 	}
@@ -146,9 +144,7 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
 	 */
 	timeout = 0;
-	omap_test_timeout((vdd->read_reg(vdd->prm_irqst_mod,
-					 vdd->prm_irqst_reg) &
-			   vp->prm_irqst_data->tranxdone_status),
+	omap_test_timeout(vp->vp_common->ops->check_txdone(vp->id),
 			  VP_TRANXDONE_TIMEOUT, timeout);
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
 		pr_err("%s: vdd_%s TRANXDONE timeout exceeded."
@@ -163,10 +159,8 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	 */
 	timeout = 0;
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		vdd->write_reg(vp->prm_irqst_data->tranxdone_status,
-			       vdd->prm_irqst_mod, vdd->prm_irqst_reg);
-		if (!(vdd->read_reg(vdd->prm_irqst_mod, vdd->prm_irqst_reg) &
-		      vp->prm_irqst_data->tranxdone_status))
+		vp->vp_common->ops->clear_txdone(vp->id);
+		if (!vp->vp_common->ops->check_txdone(vp->id))
 			break;
 		udelay(1);
 	}
-- 
1.7.4


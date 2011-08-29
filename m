From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 06/12] OMAP3+: VP: create VP helper function for updating error gain
Date: Mon, 29 Aug 2011 10:58:06 -0700
Message-ID: <1314640692-3386-7-git-send-email-khilman@ti.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53487 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754383Ab1H2R5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:57:54 -0400
Received: by mail-yi0-f52.google.com with SMTP id 13so8740312yie.25
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:57:54 -0700 (PDT)
In-Reply-To: <1314640692-3386-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Create new helper function in VP layer for updating VP error gain.
Currently used during pre-scale for VP force update and VC bypass.

TODO: determine if this can be removed from the pre-scale path and
moved to VP enable path.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c |   19 ++-----------------
 arch/arm/mach-omap2/vp.c |   19 +++++++++++++++++++
 arch/arm/mach-omap2/vp.h |    2 ++
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index d615a0d..38ba13b 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -96,9 +96,7 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		      u8 *target_vsel, u8 *current_vsel)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
-	struct omap_vdd_info *vdd = voltdm->vdd;
-	struct omap_volt_data *volt_data;
-	u32 vc_cmdval, vp_errgain_val;
+	u32 vc_cmdval;
 
 	/* Check if sufficient pmic info is available for this vdd */
 	if (!voltdm->pmic) {
@@ -120,11 +118,6 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		return -EINVAL;
 	}
 
-	/* Get volt_data corresponding to target_volt */
-	volt_data = omap_voltage_get_voltdata(voltdm, target_volt);
-	if (IS_ERR(volt_data))
-		volt_data = NULL;
-
 	*target_vsel = voltdm->pmic->uv_to_vsel(target_volt);
 	*current_vsel = voltdm->pmic->uv_to_vsel(vdd->curr_volt);
 
@@ -134,15 +127,7 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 	vc_cmdval |= (*target_vsel << vc->common->cmd_on_shift);
 	voltdm->write(vc_cmdval, vc->cmdval_reg);
 
-	/* Setting vp errorgain based on the voltage */
-	if (volt_data) {
-		vp_errgain_val = voltdm->read(voltdm->vp->vpconfig);
-		vdd->vp_rt_data.vpconfig_errorgain = volt_data->vp_errgain;
-		vp_errgain_val &= voltdm->vp->common->vpconfig_errorgain_mask;
-		vp_errgain_val |= vdd->vp_rt_data.vpconfig_errorgain <<
-			__ffs(voltdm->vp->common->vpconfig_errorgain_mask);
-		voltdm->write(vp_errgain_val, voltdm->vp->vpconfig);
-	}
+	omap_vp_update_errorgain(voltdm, target_volt);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index ea61a47..f68a6db 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -106,6 +106,25 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	voltdm->write(vp_val, vp->vlimitto);
 }
 
+int omap_vp_update_errorgain(struct voltagedomain *voltdm,
+			     unsigned long target_volt)
+{
+	struct omap_volt_data *volt_data;
+
+	/* Get volt_data corresponding to target_volt */
+	volt_data = omap_voltage_get_voltdata(voltdm, target_volt);
+	if (IS_ERR(volt_data))
+		return -EINVAL;
+
+	/* Setting vp errorgain based on the voltage */
+	voltdm->rmw(voltdm->vp->common->vpconfig_errorgain_mask,
+		    volt_data->vp_errgain <<
+		    __ffs(voltdm->vp->common->vpconfig_errorgain_mask),
+		    voltdm->vp->vpconfig);
+
+	return 0;
+}
+
 /* VP force update method of voltage scaling */
 int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 			      unsigned long target_volt)
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 2afe11d..71ac738 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -148,5 +148,7 @@ void omap_vp_disable(struct voltagedomain *voltdm);
 unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
 int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 			      unsigned long target_volt);
+int omap_vp_update_errorgain(struct voltagedomain *voltdm,
+			     unsigned long target_volt);
 
 #endif
-- 
1.7.6


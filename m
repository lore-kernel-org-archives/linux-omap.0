From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/7] OMAP3+: voltage: move/rename curr_volt from vdd_info into struct voltagedomain
Date: Mon, 29 Aug 2011 11:10:44 -0700
Message-ID: <1314641449-5089-3-git-send-email-khilman@ti.com>
References: <1314641449-5089-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49921 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754676Ab1H2SKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:10:37 -0400
Received: by mail-pz0-f41.google.com with SMTP id 4so9584071pzk.0
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:10:24 -0700 (PDT)
In-Reply-To: <1314641449-5089-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Track current nominal voltage as part of struct voltagedomain instead
of omap_vdd_info, which will soon be removed.

Also renames field from curr_volt to nominal_volt.

No functional changes.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c      |    5 ++---
 arch/arm/mach-omap2/voltage.c |    6 +-----
 arch/arm/mach-omap2/voltage.h |    4 ++--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 38ba13b..130df29 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -119,7 +119,7 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 	}
 
 	*target_vsel = voltdm->pmic->uv_to_vsel(target_volt);
-	*current_vsel = voltdm->pmic->uv_to_vsel(vdd->curr_volt);
+	*current_vsel = voltdm->pmic->uv_to_vsel(voltdm->nominal_volt);
 
 	/* Setting the ON voltage to the new target voltage */
 	vc_cmdval = voltdm->read(vc->cmdval_reg);
@@ -136,7 +136,6 @@ void omap_vc_post_scale(struct voltagedomain *voltdm,
 			unsigned long target_volt,
 			u8 target_vsel, u8 current_vsel)
 {
-	struct omap_vdd_info *vdd = voltdm->vdd;
 	u32 smps_steps = 0, smps_delay = 0;
 
 	smps_steps = abs(target_vsel - current_vsel);
@@ -145,7 +144,7 @@ void omap_vc_post_scale(struct voltagedomain *voltdm,
 			voltdm->pmic->slew_rate) + 2;
 	udelay(smps_delay);
 
-	vdd->curr_volt = target_volt;
+	voltdm->nominal_volt = target_volt;
 }
 
 /* vc_bypass_scale - VC bypass method of voltage scaling */
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 4afb368..1b39e68 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -81,16 +81,12 @@ ovdc_out:
  */
 unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
 {
-	struct omap_vdd_info *vdd;
-
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return 0;
 	}
 
-	vdd = voltdm->vdd;
-
-	return vdd->curr_volt;
+	return voltdm->nominal_volt;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index e3efbf9..3e32eda 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -61,6 +61,7 @@ struct omap_vfsm_instance {
  * @vdd: to be removed
  * @pwrdms: powerdomains in this voltagedomain
  * @scale: function used to scale the voltage of the voltagedomain
+ * @nominal_volt: current nominal voltage for this voltage domain
  */
 struct voltagedomain {
 	char *name;
@@ -84,6 +85,7 @@ struct voltagedomain {
 
 	int (*scale) (struct voltagedomain *voltdm,
 		      unsigned long target_volt);
+	u32 nominal_volt;
 
 	struct omap_vdd_info *vdd;
 };
@@ -144,11 +146,9 @@ struct omap_voltdm_pmic {
  *
  * @volt_data		: voltage table having the distinct voltages supported
  *			  by the domain and other associated per voltage data.
- * @curr_volt		: current voltage for this vdd.
  */
 struct omap_vdd_info {
 	struct omap_volt_data *volt_data;
-	u32 curr_volt;
 };
 
 void omap_voltage_get_volttable(struct voltagedomain *voltdm,
-- 
1.7.6


From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 05/12] OMAP3+: VP: move timing calculation/config into VP init
Date: Mon, 29 Aug 2011 10:58:05 -0700
Message-ID: <1314640692-3386-6-git-send-email-khilman@ti.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38626 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754457Ab1H2R5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:57:53 -0400
Received: by mail-iy0-f173.google.com with SMTP id z25so935975iab.32
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:57:52 -0700 (PDT)
In-Reply-To: <1314640692-3386-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Move VP timing calcluation (based on sys clock) and register programming
into VP init.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   22 ----------------------
 arch/arm/mach-omap2/vp.c      |   23 ++++++++++++++++++++++-
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 533ea38..4a15668 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -46,31 +46,9 @@ static LIST_HEAD(voltdm_list);
 static int __init _config_common_vdd_data(struct voltagedomain *voltdm)
 {
 	struct omap_vdd_info *vdd = voltdm->vdd;
-	u32 sys_clk_rate, timeout_val, waittime;
-
-	/* Divide to avoid overflow */
-	sys_clk_rate = voltdm->sys_clk.rate / 1000;
-	WARN_ON(!sys_clk_rate);
 
 	/* Generic voltage parameters */
 	vdd->volt_scale = omap_vp_forceupdate_scale;
-	voltdm->vp->enabled = false;
-
-	vdd->vp_rt_data.vpconfig_erroroffset =
-		(voltdm->pmic->vp_erroroffset <<
-		 __ffs(voltdm->vp->common->vpconfig_erroroffset_mask));
-
-	timeout_val = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vdd->vp_rt_data.vlimitto_timeout = timeout_val;
-	vdd->vp_rt_data.vlimitto_vddmin = voltdm->pmic->vp_vddmin;
-	vdd->vp_rt_data.vlimitto_vddmax = voltdm->pmic->vp_vddmax;
-
-	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
-		    sys_clk_rate) / 1000;
-	vdd->vp_rt_data.vstepmin_smpswaittimemin = waittime;
-	vdd->vp_rt_data.vstepmax_smpswaittimemax = waittime;
-	vdd->vp_rt_data.vstepmin_stepmin = voltdm->pmic->vp_vstepmin;
-	vdd->vp_rt_data.vstepmax_stepmax = voltdm->pmic->vp_vstepmax;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 297d094..ea61a47 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -50,7 +50,7 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 {
 	struct omap_vp_instance *vp = voltdm->vp;
 	struct omap_vdd_info *vdd = voltdm->vdd;
-	u32 vp_val;
+	u32 vp_val, sys_clk_rate, timeout_val, waittime;
 
 	if (!voltdm->read || !voltdm->write) {
 		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
@@ -58,6 +58,27 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 		return;
 	}
 
+	vp->enabled = false;
+
+	/* Divide to avoid overflow */
+	sys_clk_rate = voltdm->sys_clk.rate / 1000;
+
+	vdd->vp_rt_data.vpconfig_erroroffset =
+		(voltdm->pmic->vp_erroroffset <<
+		 __ffs(voltdm->vp->common->vpconfig_erroroffset_mask));
+
+	timeout_val = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
+	vdd->vp_rt_data.vlimitto_timeout = timeout_val;
+	vdd->vp_rt_data.vlimitto_vddmin = voltdm->pmic->vp_vddmin;
+	vdd->vp_rt_data.vlimitto_vddmax = voltdm->pmic->vp_vddmax;
+
+	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
+		    sys_clk_rate) / 1000;
+	vdd->vp_rt_data.vstepmin_smpswaittimemin = waittime;
+	vdd->vp_rt_data.vstepmax_smpswaittimemax = waittime;
+	vdd->vp_rt_data.vstepmin_stepmin = voltdm->pmic->vp_vstepmin;
+	vdd->vp_rt_data.vstepmax_stepmax = voltdm->pmic->vp_vstepmax;
+
 	vp_val = vdd->vp_rt_data.vpconfig_erroroffset |
 		(vdd->vp_rt_data.vpconfig_errorgain <<
 		 __ffs(vp->common->vpconfig_errorgain_mask)) |
-- 
1.7.6


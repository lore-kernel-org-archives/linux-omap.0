From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 11/12] OMAP3+: VP: remove unused omap_vp_get_curr_volt()
Date: Mon, 29 Aug 2011 10:58:11 -0700
Message-ID: <1314640692-3386-12-git-send-email-khilman@ti.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56603 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754486Ab1H2R6F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:58:05 -0400
Received: by yie30 with SMTP id 30so4182980yie.5
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:58:01 -0700 (PDT)
In-Reply-To: <1314640692-3386-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vp.c |   34 ----------------------------------
 arch/arm/mach-omap2/vp.h |    1 -
 2 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 29698ac..24020ea 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -209,40 +209,6 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 }
 
 /**
- * omap_vp_get_curr_volt() - API to get the current vp voltage.
- * @voltdm:	pointer to the VDD.
- *
- * This API returns the current voltage for the specified voltage processor
- */
-unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
-{
-	struct omap_vp_instance *vp = voltdm->vp;
-	u8 curr_vsel;
-
-	if (!voltdm || IS_ERR(voltdm)) {
-		pr_warning("%s: VDD specified does not exist!\n", __func__);
-		return 0;
-	}
-
-	if (!voltdm->read) {
-		pr_err("%s: No read API for reading vdd_%s regs\n",
-			__func__, voltdm->name);
-		return 0;
-	}
-
-	curr_vsel = (voltdm->read(vp->voltage) & vp->common->vpvoltage_mask)
-		>> __ffs(vp->common->vpvoltage_mask);
-
-	if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv) {
-		pr_warning("%s: PMIC function to convert vsel to voltage"
-			"in uV not registerd\n", __func__);
-		return 0;
-	}
-
-	return voltdm->pmic->vsel_to_uv(curr_vsel);
-}
-
-/**
  * omap_vp_enable() - API to enable a particular VP
  * @voltdm:	pointer to the VDD whose VP is to be enabled.
  *
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index f78752b..d9bc4f1 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -119,7 +119,6 @@ extern struct omap_vp_instance omap4_vp_core;
 void omap_vp_init(struct voltagedomain *voltdm);
 void omap_vp_enable(struct voltagedomain *voltdm);
 void omap_vp_disable(struct voltagedomain *voltdm);
-unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
 int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 			      unsigned long target_volt);
 int omap_vp_update_errorgain(struct voltagedomain *voltdm,
-- 
1.7.6


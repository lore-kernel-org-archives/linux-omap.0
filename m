From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 09/12] OMAP: VP: Explicitly mask VPVOLTAGE field
Date: Mon, 29 Aug 2011 10:58:09 -0700
Message-ID: <1314640692-3386-10-git-send-email-khilman@ti.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:49825 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754430Ab1H2R57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:57:59 -0400
Received: by iabu26 with SMTP id u26so828289iab.5
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:57:58 -0700 (PDT)
In-Reply-To: <1314640692-3386-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Todd Poynor <toddpoynor@google.com>

Reading the VPVOLTAGE field of PRM_VP_*_VOLTAGE registers currently
relies on a u32 -> u8 conversion to mask off the FORCEUPDATEWAIT field
in the upper bits.  Make this explicit using the mask symbol
already defined, added as a new field in struct omap_vp_common.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vp.c          |    3 ++-
 arch/arm/mach-omap2/vp.h          |    2 ++
 arch/arm/mach-omap2/vp3xxx_data.c |    2 ++
 arch/arm/mach-omap2/vp44xx_data.c |    1 +
 4 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index e7d38f6..3807620 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -227,7 +227,8 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 		return 0;
 	}
 
-	curr_vsel = voltdm->read(vp->voltage);
+	curr_vsel = (voltdm->read(vp->voltage) & vp->common->vpvoltage_mask)
+		>> __ffs(vp->common->vpvoltage_mask);
 
 	if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv) {
 		pr_warning("%s: PMIC function to convert vsel to voltage"
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 0d63267..f78752b 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -63,6 +63,7 @@ struct omap_vp_ops {
  * @vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
  * @vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
  * @vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
+ * @vpvoltage_mask: VPVOLTAGE field mask in PRM_VP*_VOLTAGE reg
  */
 struct omap_vp_common {
 	u32 vpconfig_erroroffset_mask;
@@ -79,6 +80,7 @@ struct omap_vp_common {
 	u8 vlimitto_vddmin_shift;
 	u8 vlimitto_vddmax_shift;
 	u8 vlimitto_timeout_shift;
+	u8 vpvoltage_mask;
 
 	const struct omap_vp_ops *ops;
 };
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index d429c44..260c554 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -51,6 +51,8 @@ static const struct omap_vp_common omap3_vp_common = {
 	.vlimitto_vddmin_shift = OMAP3430_VDDMIN_SHIFT,
 	.vlimitto_vddmax_shift = OMAP3430_VDDMAX_SHIFT,
 	.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT,
+	.vpvoltage_mask = OMAP3430_VPVOLTAGE_MASK,
+
 	.ops = &omap3_vp_ops,
 };
 
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index 0daf2a4..b4e7704 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -51,6 +51,7 @@ static const struct omap_vp_common omap4_vp_common = {
 	.vlimitto_vddmin_shift = OMAP4430_VDDMIN_SHIFT,
 	.vlimitto_vddmax_shift = OMAP4430_VDDMAX_SHIFT,
 	.vlimitto_timeout_shift = OMAP4430_TIMEOUT_SHIFT,
+	.vpvoltage_mask = OMAP4430_VPVOLTAGE_MASK,
 	.ops = &omap4_vp_ops,
 };
 
-- 
1.7.6


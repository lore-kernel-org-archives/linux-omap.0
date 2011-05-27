From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH pm_wip/voltdm_nm] ARM: OMAP: Explicitly mask VPVOLTAGE field
Date: Thu, 26 May 2011 20:03:46 -0700
Message-ID: <20110527030346.GA2720@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:30666 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab1E0DDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 23:03:53 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

Reading the VPVOLTAGE field of PRM_VP_*_VOLTAGE registers currently
relies on a u32 -> u8 conversion to mask off the FORCEUPDATEWAIT field
in the upper bits.  Make this explicit using the mask and shift symbols
already defined, added as new fields in struct omap_vp_common.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/mach-omap2/vp.c          |    3 ++-
 arch/arm/mach-omap2/vp.h          |    4 ++++
 arch/arm/mach-omap2/vp3xxx_data.c |    3 +++
 arch/arm/mach-omap2/vp44xx_data.c |    2 ++
 4 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index e7d38f6..c3b7fde 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -227,7 +227,8 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 		return 0;
 	}
 
-	curr_vsel = voltdm->read(vp->voltage);
+	curr_vsel = (voltdm->read(vp->voltage) & vp->common->vpvoltage_mask)
+		>> vp->common->vpvoltage_shift;
 
 	if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv) {
 		pr_warning("%s: PMIC function to convert vsel to voltage"
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 0d63267..cb62a7b 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -63,6 +63,8 @@ struct omap_vp_ops {
  * @vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
  * @vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
  * @vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
+ * @vpvoltage_mask: VPVOLTAGE field mask in PRM_VP*_VOLTAGE reg
+ * @vpvoltage_shift: VPVOLTAGE field shift in PRM_VP*_VOLTAGE reg
  */
 struct omap_vp_common {
 	u32 vpconfig_erroroffset_mask;
@@ -79,6 +81,8 @@ struct omap_vp_common {
 	u8 vlimitto_vddmin_shift;
 	u8 vlimitto_vddmax_shift;
 	u8 vlimitto_timeout_shift;
+	u8 vpvoltage_mask;
+	u8 vpvoltage_shift;
 
 	const struct omap_vp_ops *ops;
 };
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index d429c44..0b149e0 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -51,6 +51,9 @@ static const struct omap_vp_common omap3_vp_common = {
 	.vlimitto_vddmin_shift = OMAP3430_VDDMIN_SHIFT,
 	.vlimitto_vddmax_shift = OMAP3430_VDDMAX_SHIFT,
 	.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT,
+	.vpvoltage_mask = OMAP3430_VPVOLTAGE_MASK,
+	.vpvoltage_shift = OMAP3430_VPVOLTAGE_SHIFT,
+
 	.ops = &omap3_vp_ops,
 };
 
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index 0daf2a4..174d6f7 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -51,6 +51,8 @@ static const struct omap_vp_common omap4_vp_common = {
 	.vlimitto_vddmin_shift = OMAP4430_VDDMIN_SHIFT,
 	.vlimitto_vddmax_shift = OMAP4430_VDDMAX_SHIFT,
 	.vlimitto_timeout_shift = OMAP4430_TIMEOUT_SHIFT,
+	.vpvoltage_mask = OMAP4430_VPVOLTAGE_MASK,
+	.vpvoltage_shift = OMAP4430_VPVOLTAGE_SHIFT,
 	.ops = &omap4_vp_ops,
 };
 
-- 
1.7.3.1


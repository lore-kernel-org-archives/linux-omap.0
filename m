From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 05/19] OMAP3+: voltage: use IS_ERR_OR_NULL
Date: Sat,  5 Mar 2011 20:59:08 +0530
Message-ID: <1299338962-5602-6-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46596 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752616Ab1CEPaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:30:30 -0500
Received: by gyd12 with SMTP id 12so1451551gyd.16
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:30:28 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Use IS_ERR_OR_NULL macro instead of !xyz || IS_ERR(xyz) usage.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 53c399f..76bcaee 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -682,7 +682,7 @@ unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return 0;
 	}
@@ -703,7 +703,7 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 	struct omap_vdd_info *vdd;
 	u8 curr_vsel;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return 0;
 	}
@@ -738,7 +738,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
 	struct omap_vdd_info *vdd;
 	u32 vpconfig;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -776,7 +776,7 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 	u32 vpconfig;
 	int timeout;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -829,7 +829,7 @@ int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return -EINVAL;
 	}
@@ -858,7 +858,7 @@ void omap_voltage_reset(struct voltagedomain *voltdm)
 {
 	unsigned long target_uvdc;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -890,7 +890,7 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -921,7 +921,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 	struct omap_vdd_info *vdd;
 	int i;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -959,7 +959,7 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return -EINVAL;
 	}
@@ -986,7 +986,7 @@ struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm)
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return NULL;
 	}
@@ -1011,7 +1011,7 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
-- 
1.7.1


From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 4/7] OMAP3+: voltage: rename omap_voltage_get_nom_volt -> voltdm_get_voltage
Date: Mon, 29 Aug 2011 11:10:46 -0700
Message-ID: <1314641449-5089-5-git-send-email-khilman@ti.com>
References: <1314641449-5089-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:58655 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754665Ab1H2SK2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:10:28 -0400
Received: by mail-gy0-f180.google.com with SMTP id 15so11777088gyc.25
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:10:27 -0700 (PDT)
In-Reply-To: <1314641449-5089-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Use preferred voltdm_ naming for getting current nominal voltage.

No functional changes.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
 arch/arm/mach-omap2/voltage.c            |   14 ++++++++------
 arch/arm/mach-omap2/voltage.h            |    2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 4eac1bc..53d9d0a 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -15,7 +15,7 @@
 
 static int sr_class3_enable(struct voltagedomain *voltdm)
 {
-	unsigned long volt = omap_voltage_get_nom_volt(voltdm);
+	unsigned long volt = voltdm_get_voltage(voltdm);
 
 	if (!volt) {
 		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 2ba276f..441c2d9 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -45,13 +45,13 @@ static LIST_HEAD(voltdm_list);
 
 /* Public functions */
 /**
- * omap_voltage_get_nom_volt() - Gets the current non-auto-compensated voltage
- * @voltdm:	pointer to the VDD for which current voltage info is needed
+ * voltdm_get_voltage() - Gets the current non-auto-compensated voltage
+ * @voltdm:	pointer to the voltdm for which current voltage info is needed
  *
- * API to get the current non-auto-compensated voltage for a VDD.
- * Returns 0 in case of error else returns the current voltage for the VDD.
+ * API to get the current non-auto-compensated voltage for a voltage domain.
+ * Returns 0 in case of error else returns the current voltage.
  */
-unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
+unsigned long voltdm_get_voltage(struct voltagedomain *voltdm)
 {
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
@@ -72,6 +72,8 @@ unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
 int voltdm_scale(struct voltagedomain *voltdm,
 		 unsigned long target_volt)
 {
+	int ret;
+
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return -EINVAL;
@@ -104,7 +106,7 @@ void voltdm_reset(struct voltagedomain *voltdm)
 		return;
 	}
 
-	target_volt = omap_voltage_get_nom_volt(voltdm);
+	target_volt = voltdm_get_voltage(voltdm);
 	if (!target_volt) {
 		pr_err("%s: unable to find current voltage for vdd_%s\n",
 			__func__, voltdm->name);
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 68b1ed5..b4c6259 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -143,7 +143,6 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
-unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
 #ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 			       struct omap_voltdm_pmic *pmic);
@@ -178,4 +177,5 @@ int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
 				    struct powerdomain *pwrdm));
 int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 void voltdm_reset(struct voltagedomain *voltdm);
+unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
 #endif
-- 
1.7.6


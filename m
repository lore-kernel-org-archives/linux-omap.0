From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: voltage: ensure voltage used is exact voltage from OPP table
Date: Fri,  2 Mar 2012 14:42:01 -0800
Message-ID: <1330728121-26664-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:60152 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964821Ab2CBWl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 17:41:59 -0500
Received: by mail-pz0-f47.google.com with SMTP id o14so2274105dad.20
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 14:41:58 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

When using the SMPS regulators to scale voltages, the regulator
framework may pass a minimum voltage that is not an exact OPP voltage.
For the VC/VP controlled voltage domains, we must ensure that the
voltage requested is the exact voltage from the OPP table.  This is
especially critical when using SR.

To fix, voltdm_scale() uses the target voltage passed to walk through
the OPP voltages until it finds a voltage that is >= one of the OPP
voltages.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Unless there are any objections, this will be queued along with the
rest of the SMPS regulator series from Tero.  Currently availble in
my for_3.4/pm/smps-regulator branch at
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

 arch/arm/mach-omap2/voltage.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 8a36342..4dc60e8 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -73,7 +73,8 @@ unsigned long voltdm_get_voltage(struct voltagedomain *voltdm)
 int voltdm_scale(struct voltagedomain *voltdm,
 		 unsigned long target_volt)
 {
-	int ret;
+	int ret, i;
+	unsigned long volt = 0;
 
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
@@ -86,9 +87,23 @@ int voltdm_scale(struct voltagedomain *voltdm,
 		return -ENODATA;
 	}
 
-	ret = voltdm->scale(voltdm, target_volt);
+	/* Adjust voltage to the exact voltage from the OPP table */
+	for (i = 0; voltdm->volt_data[i].volt_nominal != 0; i++) {
+		if (voltdm->volt_data[i].volt_nominal >= target_volt) {
+			volt = voltdm->volt_data[i].volt_nominal;
+			break;
+		}
+	}
+
+	if (!volt) {
+		pr_warning("%s: not scaling. OPP voltage for %lu, not found.\n",
+			   __func__, target_volt);
+		return -EINVAL;
+	}
+
+	ret = voltdm->scale(voltdm, volt);
 	if (!ret)
-		voltdm->nominal_volt = target_volt;
+		voltdm->nominal_volt = volt;
 
 	return ret;
 }
-- 
1.7.9.2


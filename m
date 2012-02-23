From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] cpufreq: OMAP: specify range for voltage scaling
Date: Thu, 23 Feb 2012 19:19:24 +0530
Message-ID: <1330004964-22831-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52513 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003Ab2BWOIA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 09:08:00 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1NE7wkW024312
	for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 08:07:59 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1NE7wio024962
	for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 19:37:58 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Afzal Mohammed <afzal@ti.com>, Kevin Hilman <khilman@ti.com>, Sekhar Nori <nsekhar@ti.com>

Specify voltage in ranges for regulator. Range
used is tolerance specified for OPP.

This helps to achieve DVFS with a wider range of
regulators.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
Hi,

Tolerance specified here is that of AM335X, least value
of tolerance that I could find so far for OMAP family

This applies on top of Kevin Hilman's patch (v2),
"cpufreq: OMAP: scale voltage along with frequency"
http://www.spinics.net/lists/linux-omap/msg65002.html

Regards
Afzal

 drivers/cpufreq/omap-cpufreq.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 10b8e23..3cea51b 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -38,6 +38,9 @@
 
 #include <mach/hardware.h>
 
+/* OPP tolerance in percentage */
+#define	OPP_TOLERANCE	4
+
 #ifdef CONFIG_SMP
 struct lpj_info {
 	unsigned long	ref;
@@ -81,7 +84,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	int r, ret = 0;
 	struct cpufreq_freqs freqs;
 	struct opp *opp;
-	unsigned long freq, volt = 0, volt_old = 0;
+	unsigned long freq, volt = 0, volt_old = 0, tol = 0;
 
 	if (!freq_table) {
 		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
@@ -125,6 +128,7 @@ static int omap_target(struct cpufreq_policy *policy,
 			return -EINVAL;
 		}
 		volt = opp_get_voltage(opp);
+		tol = volt * OPP_TOLERANCE / 100;
 		volt_old = regulator_get_voltage(mpu_reg);
 	}
 
@@ -134,7 +138,7 @@ static int omap_target(struct cpufreq_policy *policy,
 
 	/* scaling up?  scale voltage before frequency */
 	if (mpu_reg && (freqs.new > freqs.old)) {
-		r = regulator_set_voltage(mpu_reg, volt, volt);
+		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
 		if (r < 0) {
 			dev_warn(mpu_dev, "%s: unable to scale voltage up.\n",
 				 __func__);
@@ -147,7 +151,7 @@ static int omap_target(struct cpufreq_policy *policy,
 
 	/* scaling down?  scale voltage after frequency */
 	if (mpu_reg && (freqs.new < freqs.old)) {
-		r = regulator_set_voltage(mpu_reg, volt, volt);
+		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
 		if (r < 0) {
 			dev_warn(mpu_dev, "%s: unable to scale voltage down.\n",
 				 __func__);
-- 
1.7.1


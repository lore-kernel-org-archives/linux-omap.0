From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] OMAP: PM: Correct the use of cpufreq
Date: Tue, 23 Jun 2009 12:53:29 +0300
Message-ID: <12457508091766-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43092 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbZFWJyB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 05:54:01 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n5N9rbqq014780
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 04:54:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Wrong info was used to feed the cpufreq. It is possible
now to get below the user defined limit defined at
"/cpufreq/scaling_min_freq". With this patch, the
user defined limits are being obeyed instead of
always using the absolute max and min values supported
by the device.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/plat-omap/cpu-omap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 843e8af..1868c0d 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -78,10 +78,10 @@ static int omap_target(struct cpufreq_policy *policy,
 
 	/* Ensure desired rate is within allowed range.  Some govenors
 	 * (ondemand) will just pass target_freq=0 to get the minimum. */
-	if (target_freq < policy->cpuinfo.min_freq)
-		target_freq = policy->cpuinfo.min_freq;
-	if (target_freq > policy->cpuinfo.max_freq)
-		target_freq = policy->cpuinfo.max_freq;
+	if (target_freq < policy->min)
+		target_freq = policy->min;
+	if (target_freq > policy->max)
+		target_freq = policy->max;
 
 	freqs.old = omap_getspeed(0);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
-- 
1.5.6.3


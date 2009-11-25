From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/10 V3] omap3: pm: use opp accessor functions for omap-target
Date: Tue, 24 Nov 2009 22:09:15 -0600
Message-ID: <1259122159-1583-7-git-send-email-nm@ti.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
 <1259122159-1583-2-git-send-email-nm@ti.com>
 <1259122159-1583-3-git-send-email-nm@ti.com>
 <1259122159-1583-4-git-send-email-nm@ti.com>
 <1259122159-1583-5-git-send-email-nm@ti.com>
 <1259122159-1583-6-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39451 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934502AbZKYEJ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Nov 2009 23:09:27 -0500
In-Reply-To: <1259122159-1583-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

The logic in omap-target can now be improved with the accessor
functions. Dont scan through the list manually, instead use
get_next_freq to do the scanning.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 449b6b6..7b3ca11 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -111,14 +111,17 @@ static int omap_target(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	if (mpu_opps) {
-		int ind;
-		for (ind = 1; ind <= MAX_VDD1_OPP; ind++) {
-			if (mpu_opps[ind].rate/1000 >= target_freq) {
-				omap_pm_cpu_set_freq
-					(mpu_opps[ind].rate);
-				break;
-			}
-		}
+		unsigned long freq = target_freq * 1000;
+		struct omap_opp *opp = NULL;
+		int res;
+		/* see if we have exact freq match */
+		res = opp_is_valid(&opp, mpu_opps, freq);
+		/* Get next best if we cant find a exact match */
+		if (res)
+			res = opp_get_higher_opp(&opp, &freq, mpu_opps);
+
+		if (!res)
+			omap_pm_cpu_set_freq(freq);
 	}
 #endif
 	return ret;
-- 
1.6.3.3


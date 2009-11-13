From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/9] omap3: pm: use opp accessor functions for omap-target
Date: Fri, 13 Nov 2009 00:05:17 -0600
Message-ID: <1258092322-30833-5-git-send-email-nm@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
 <1258092322-30833-2-git-send-email-nm@ti.com>
 <1258092322-30833-3-git-send-email-nm@ti.com>
 <1258092322-30833-4-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41339 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987AbZKMGFW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:05:22 -0500
In-Reply-To: <1258092322-30833-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

The logic in omap-target can now be improved with the accessor
functions. Dont scan through the list manually, instead use
get_next_freq to do the scanning.

Tested on: SDP3430, SDP3630

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: SuiLun Lam <s-lam@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 449b6b6..16b5da2 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -111,14 +111,10 @@ static int omap_target(struct cpufreq_policy *policy,
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
+		int res = get_next_freq(&freq, mpu_opps, true, true, false);
+		if (!res)
+			omap_pm_cpu_set_freq(freq);
 	}
 #endif
 	return ret;
-- 
1.6.3.3


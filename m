From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/10 V4] omap3: pm: use opp accessor functions for omap-target
Date: Wed,  9 Dec 2009 00:17:11 -0600
Message-ID: <1260339435-20294-7-git-send-email-nm@ti.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
 <1260339435-20294-2-git-send-email-nm@ti.com>
 <1260339435-20294-3-git-send-email-nm@ti.com>
 <1260339435-20294-4-git-send-email-nm@ti.com>
 <1260339435-20294-5-git-send-email-nm@ti.com>
 <1260339435-20294-6-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59786 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625AbZLIGRY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 01:17:24 -0500
In-Reply-To: <1260339435-20294-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

The logic in omap-target can now be improved with the accessor
functions. Dont scan through the list manually, instead use
get_next_freq to do the scanning.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 449b6b6..43d3da5 100644
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
+		if (!IS_ERR(opp_find_freq_approx(mpu_opps, &freq,
+					OPP_SEARCH_HIGH)))
+			omap_pm_cpu_set_freq(freq);
 	}
 #endif
 	return ret;
-- 
1.6.3.3


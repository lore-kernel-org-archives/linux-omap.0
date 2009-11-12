From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/9] omap3: pm: use opp accessor functions for omap-target
Date: Wed, 11 Nov 2009 23:45:16 -0600
Message-ID: <1258004721-7315-5-git-send-email-nm@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
 <1258004721-7315-2-git-send-email-nm@ti.com>
 <1258004721-7315-3-git-send-email-nm@ti.com>
 <1258004721-7315-4-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbZKLFpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 00:45:46 -0500
In-Reply-To: <1258004721-7315-4-git-send-email-nm@ti.com>
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
 arch/arm/plat-omap/cpu-omap.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index f9b480d..dac1eab 100644
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


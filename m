From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PM-WIP-OPP] [PATCH 1/1] OMAP3: PM: cpu-omap: Check governor limits before applying mpu frequency
Date: Wed, 24 Mar 2010 13:02:31 +0200
Message-ID: <1269428551-779-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21172 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab0CXLCv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 07:02:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch fix the sequence inside omap_target while setting
a frequency for OMAP3 devices.

Previously any frequency was set, even if out of range. Now
the range set by the governor is also checked for OMAP3.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/cpu-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index a69b557..0674405 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -88,7 +88,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 #endif
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	unsigned long freq = target_freq * 1000;
+	unsigned long freq;
 #endif
 	int ret = 0;
 
@@ -114,6 +114,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
+	freq = target_freq * 1000;
 	if (opp_find_freq_ceil(OPP_MPU, &freq))
 		omap_pm_cpu_set_freq(freq);
 #endif
-- 
1.7.0.2


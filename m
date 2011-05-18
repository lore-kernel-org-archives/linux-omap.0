From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 3/6 v2] OMAP2+: cpufreq: minor comment cleanup
Date: Wed, 18 May 2011 02:37:43 -0500
Message-ID: <1305704266-17623-4-git-send-email-nm@ti.com>
References: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:48107 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754924Ab1ERHh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 03:37:58 -0400
Received: by mail-gx0-f177.google.com with SMTP id 2so520806gxk.36
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:37:57 -0700 (PDT)
In-Reply-To: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

this should probably get squashed in..

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 6e3666a..45f1e9e 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -84,8 +84,10 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (is_smp() && (num_online_cpus() < NR_CPUS))
 		return ret;
 
-	/* Ensure desired rate is within allowed range.  Some govenors
-	 * (ondemand) will just pass target_freq=0 to get the minimum. */
+	/*
+	 * Ensure desired rate is within allowed range.  Some govenors
+	 * (ondemand) will just pass target_freq=0 to get the minimum.
+	 */
 	if (target_freq < policy->min)
 		target_freq = policy->min;
 	if (target_freq > policy->max)
-- 
1.7.1


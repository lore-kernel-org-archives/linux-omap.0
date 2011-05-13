From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-CPUFREQ][PATCH 3/5] OMAP2+: cpufreq: minor comment cleanup
Date: Fri, 13 May 2011 14:07:24 -0700
Message-ID: <1305320846-16147-4-git-send-email-nm@ti.com>
References: <1305320846-16147-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49328 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758649Ab1EMVH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 17:07:57 -0400
Received: by mail-gw0-f45.google.com with SMTP id 19so1373552gwb.18
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 14:07:46 -0700 (PDT)
In-Reply-To: <1305320846-16147-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
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


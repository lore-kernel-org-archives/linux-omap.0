From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/11] OMAP: PM: CPUfreq: obey min/max settings of policy
Date: Thu, 25 Jun 2009 10:08:22 -0700
Message-ID: <1245949702-26243-1-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:49738 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbZFYRIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 13:08:21 -0400
Received: by wf-out-1314.google.com with SMTP id 26so580213wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 10:08:25 -0700 (PDT)
In-Reply-To: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Use the min/max settings from CPUfreq policy rather than
processor defined min/max settings.

Without this patch, it's possible to scale frequency outside
the current policy range.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
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
1.6.3.2


From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP PM: Optimize cpufreq transition latency
Date: Thu, 25 Nov 2010 19:08:11 +0530
Message-ID: <1290692291-25073-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57107 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0KYNjK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 08:39:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-dev@lists.linaro.org, Vishwanath BS <vishwanath.bs@ti.com>

Currently cpufreq transition latency value does not really reflect the actual
OMAP OPP transition delay. This patch has the actual latency value.
I did profile the DVFS latency on OMAP3430, OMAP3630 and OMAP4 for worstcase(MPU and Core together) and found that in none of these platforms, transiton value 
goes beyong 10ms. Added a buffer of 20ms to avoid too frequent ondemand timer 
expiry.
With this change, performance of ondemand governor is improved when tested
using cpufreqbench tool. Without this patch, cpufreq-bench reported ondemand
performance as 40% of performance governor, and with this patch it's around 70%
(using below procedure).

cpufreq-bench: 
http://lwn.net/Articles/339862/
http://ftp.riken.go.jp/archives/Linux/suse/people/ckornacker/cpufreq-bench/

Command used for performance testing:
cpufreq-bench -l 50000 -s 100000 -x 50000 -y 100000 -g ondemand -r 5 -n 5 -v

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/cpu-omap.c

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
old mode 100644
new mode 100755
index c47faf8..d3fc423
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -158,8 +158,8 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 	policy->max = policy->cpuinfo.max_freq;
 	policy->cur = omap_getspeed(0);
 
-	/* FIXME: what's the actual transition time? */
-	policy->cpuinfo.transition_latency = 300 * 1000;
+	/* Program the actual transition time for worstcase */
+	policy->cpuinfo.transition_latency = 30 * 1000;
 
 	return 0;
 }
-- 
1.7.0.4


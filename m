From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH] PM: Prevent direct cpufreq scaling during initialization
Date: Wed, 02 Dec 2009 15:42:39 +0530
Message-ID: <1259748759.21203.11.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbZLBKMk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Dec 2009 05:12:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org


It is seen that the OMAP specific cpufreq initialization code tries to
scale the MPU frequency to the highest possible without taking care of
the voltage level. On power on reset the power IC does not provide the
necessary voltage for the highest available MPU frequency (that would
satisfy all Si families). This potentially is an window of opportunity
for things to go wrong.


Signed-off-by: Romit Dasgupta <romit@ti.com>
---
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 449b6b6..f94df20 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -149,8 +149,6 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 							VERY_HI_RATE) / 1000;
 	}
 
-	clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
-
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 	policy->cur = omap_getspeed(0);



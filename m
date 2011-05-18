From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 1/6 v2] OMAP2+: cpufreq: free up table on exit
Date: Wed, 18 May 2011 02:37:41 -0500
Message-ID: <1305704266-17623-2-git-send-email-nm@ti.com>
References: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38271 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754427Ab1ERHhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 03:37:53 -0400
Received: by yib12 with SMTP id 12so612160yib.15
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:37:52 -0700 (PDT)
In-Reply-To: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

freq_table allocated by opp_init_cpufreq_table in omap_cpu_init
needs to be freed in omap_cpu_exit.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index d53ce23..e38ebb8 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/opp.h>
+#include <linux/slab.h>
 #include <linux/cpu.h>
 
 #include <asm/system.h>
@@ -216,6 +217,8 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
 	clk_exit_cpufreq_table(&freq_table);
+	kfree(freq_table);
+	freq_table = NULL;
 	clk_put(mpu_clk);
 	return 0;
 }
-- 
1.7.1


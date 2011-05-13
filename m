From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-CPUFREQ][PATCH 1/5] OMAP2+: cpufreq: free up table on exit
Date: Fri, 13 May 2011 14:07:22 -0700
Message-ID: <1305320846-16147-2-git-send-email-nm@ti.com>
References: <1305320846-16147-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55984 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759155Ab1EMVHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 17:07:39 -0400
Received: by mail-yx0-f180.google.com with SMTP id 1so1282485yxe.25
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 14:07:38 -0700 (PDT)
In-Reply-To: <1305320846-16147-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
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


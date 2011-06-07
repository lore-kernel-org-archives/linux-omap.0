From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/cpufreq][PATCH 1/3] OMAP2+: cpufreq: minor flow beautification
Date: Mon,  6 Jun 2011 21:05:28 -0500
Message-ID: <1307412330-25798-2-git-send-email-nm@ti.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37151 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754406Ab1FGCFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:05:35 -0400
Received: by mail-gy0-f181.google.com with SMTP id 4so2453015gyh.40
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:05:34 -0700 (PDT)
In-Reply-To: <1307412330-25798-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Probably should be squashed to:
"OMAP2+: cpufreq: fix freq_table leak"

Looks like I've been lazy and added up a useless else case!

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 1406577..a962a31 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -186,11 +186,11 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	if (!result)
-		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-	else
+	if (result)
 		goto fail_table;
 
+	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 	policy->cur = omap_getspeed(policy->cpu);
-- 
1.7.1


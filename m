From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH][pm-wip/cpufreq] OMAP2+: CPUfreq: Remove superfluous check in target() for online CPU's.
Date: Fri, 3 Jun 2011 17:46:57 +0530
Message-ID: <1307103417-22721-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60709 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab1FCMRD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Jun 2011 08:17:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p53CGxYo027551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 3 Jun 2011 07:17:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>

Current OMAP2PLUS CPUfreq tagret() functions returns when all
the CPU's are not online. This breaks CPUfreq when secondary CPUs
are offlined on SMP system.

The intention of that check was just avoid CPU frequency change
during the window when CPU becomes online but it's cpufreq_init is
not done yet. Otherwise it can lead to notifiers being sent on
a CPU which is not yet registered to the governor.

But this race conditions is already managed by the CPUfreq
core driver by updating the available cpumask accordingly.

OMAP CPUFReq driver make use same cpumask for the notifiers
so the above problem doesn't exist. In my initial implementation
of the OMAP4 CPUFreq driver, I was using 'for_each_online_cpu()'
for notifiers which lead me to add that check. Later I fixed
the notifies but didn't realise that the check has become
redundant then.

Fix it by removing the superfluous check in target().

Thanks for Nishant Menon <nm@ti.com> for reporting issue
with hot-plug and Kevin Hilman <khilman@ti.com> for his
comment on excessive check in target().

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Nishanth Menon <nm@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
This change is an outcome of discussion on another patch to fix
the hot-plug issue. For details refer below thread:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50348.html

 arch/arm/mach-omap2/omap2plus-cpufreq.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 33a91ec..3bf1704 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -81,10 +81,6 @@ static int omap_target(struct cpufreq_policy *policy,
 	int i, ret = 0;
 	struct cpufreq_freqs freqs;
 
-	/* Changes not allowed until all CPUs are online */
-	if (is_smp() && (num_online_cpus() < NR_CPUS))
-		return ret;
-
 	/* Ensure desired rate is within allowed range.  Some govenors
 	 * (ondemand) will just pass target_freq=0 to get the minimum. */
 	if (target_freq < policy->min)
-- 
1.6.0.4


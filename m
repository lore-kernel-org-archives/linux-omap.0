From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/cpufreq][PATCH 2/3] OMAP2+: cpufreq: notify even with bad boot frequency
Date: Mon,  6 Jun 2011 21:05:29 -0500
Message-ID: <1307412330-25798-3-git-send-email-nm@ti.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49566 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754406Ab1FGCFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:05:44 -0400
Received: by yia27 with SMTP id 27so813865yia.32
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:05:42 -0700 (PDT)
In-Reply-To: <1307412330-25798-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Colin Cross <ccross@google.com>

From: Colin Cross <ccross@google.com>

Sometimes, bootloaders starts up with a frequency which is not
in the OPP table. At cpu_init, policy->cur contains the frequency
we pick at boot.  It is possible that system might have fixed
it's boot frequency later on as part of power initialization.
After this condition, the first call to omap_target results in the
following:

omap_getspeed(actual device frequency) != policy->cur(frequency that
cpufreq thinks that the system is at), and it is possible that
freqs.old == freqs.new (because the governor requested a scale down).

We exit without triggering the notifiers in the current code, which
does'nt let code which depends on cpufreq_notify_transition to have
accurate information as to what the system frequency is.

Instead, we do a normal transition if policy->cur is wrong, then,
freqs.old will be the actual cpu frequency, freqs.new will be the
actual new cpu frequency and all required notifiers have the accurate
information.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Colin Cross <ccross@google.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index a962a31..2177381 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -97,7 +97,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	freqs.old = omap_getspeed(policy->cpu);
 	freqs.cpu = policy->cpu;
 
-	if (freqs.old == freqs.new)
+	if (freqs.old == freqs.new && policy->cur == freqs.new)
 		return ret;
 
 	if (!is_smp()) {
-- 
1.7.1


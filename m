From: Mike Turquette <mturquette@gmail.com>
Subject: [PATCH] OMAP3: decrease cpufreq transition latency
Date: Thu, 29 Oct 2009 16:02:09 -0500
Message-ID: <1256850129-31618-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:58781 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZJ2VCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 17:02:36 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1220437fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 14:02:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Turquette <mturquette@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Vishwa Sripathy <vishwanath.bs@ti.com>

Adjust OMAP3 frequency transition latency from 10,000,000uS to a more
reasonable 300,000uS.  This causes ondemand and conservative governors to
sample CPU load more often resulting in more responsive behavior.

Tested on Android 2.6.29; using this value and conservative governor, CORE
power consumption on Zoom2 was comparable to the old and unresponsive
10,000,000uS value while UI responsiveness was greatly improved.

This patch applies against Tony's omap-fixes branch.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 1868c0d..341235c 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -127,7 +127,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	/* FIXME: what's the actual transition time? */
-	policy->cpuinfo.transition_latency = 10 * 1000 * 1000;
+	policy->cpuinfo.transition_latency = 300 * 1000;
 
 	return 0;
 }
-- 
1.6.3.2


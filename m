From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] omap3: Decrease cpufreq transition latency
Date: Tue, 10 Nov 2009 19:01:57 -0800
Message-ID: <20091111030157.31793.11032.stgit@localhost>
References: <20091111025907.31793.84134.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49874 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbZKKDBx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 22:01:53 -0500
In-Reply-To: <20091111025907.31793.84134.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Mike Turquette <mturquette@ti.com>

From: Mike Turquette <mturquette@gmail.com>

Adjust OMAP3 frequency transition latency from 10,000,000uS to a more
reasonable 300,000uS.  This causes ondemand and conservative governors to
sample CPU load more often resulting in more responsive behavior.

Tested on Android 2.6.29; using this value and conservative governor, CORE
power consumption on Zoom2 was comparable to the old and unresponsive
10,000,000uS value while UI responsiveness was greatly improved.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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


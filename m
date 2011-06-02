From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH v4 2/4] OMAP2+: cpufreq: use OPP library
Date: Thu, 02 Jun 2011 15:45:39 -0700
Message-ID: <87zklzq2cs.fsf@ti.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com>
	<1306463960-27340-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57855 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599Ab1FBWpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 18:45:53 -0400
Received: by mail-pw0-f47.google.com with SMTP id 9so770903pwj.20
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 15:45:51 -0700 (PDT)
In-Reply-To: <1306463960-27340-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 26 May 2011 19:39:18 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> OMAP2 is the only family using clk_[init|exit]_cpufreq_table, however,
> the cpufreq code has does not use clk_init_cpufreq_table. As a result,
> it is unusuable for OMAP2 and only usable only on platforms using OPP
> library.
>
> So move the compilation for cpufreq only if OPP is available for the
> architecture and deny OMAP2 in multi-OMAP builds until OMAP2 is fixed.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

I updated this patch slightly, preferring a more generic failure mode,
namely just failing with a warning on init when no OPPs are present.

I tested this on 3430/n900 by simply commenting out the
omap_init_opp_table() for OMAP3.  CPUfreq init fails predictably with

   platform mpu.0: opp_init_cpufreq_table: Device OPP not found (-19)
   platform mpu.0: omap_cpu_init: cpu0: failed creating freq table[-19]

So CPUfreq driver never gets registered.

Updated patch below.  If you're OK with this change, I'll apply it to
pm-wip/cpufreq.

Kevin


>From 22f1704e2ec30816e34b3d46a4c61513441fce8d Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Thu, 26 May 2011 19:39:18 -0700
Subject: [PATCH 2/4] OMAP2+: cpufreq: only supports OPP library

OMAP2 is the only family using clk_[init|exit]_cpufreq_table, however,
the cpufreq code does not currently use clk_init_cpufreq_table. As a
result, it is unusuable for OMAP2 and only usable only on platforms
using OPP library.

Remove the unbalanced clk_exit_cpufreq_table().  Any platforms where
OPPs are not availble will fail on init because a freq table will not
be properly initialized.

Signed-off-by: Nishanth Menon <nm@ti.com>
[khilman@ti.com: changelog edits, and graceful failure mode changes]
Acked-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index acf18e8..3af7cda 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -1,7 +1,7 @@
 /*
  *  OMAP2PLUS cpufreq driver
  *
- *  CPU frequency scaling for OMAP
+ *  CPU frequency scaling for OMAP using OPP information
  *
  *  Copyright (C) 2005 Nokia Corporation
  *  Written by Tony Lindgren <tony@atomide.com>
@@ -203,7 +203,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
-	clk_exit_cpufreq_table(&freq_table);
 	clk_put(mpu_clk);
 	return 0;
 }
-- 
1.7.4


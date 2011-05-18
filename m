From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 0/6 v2] Cleanups for cpufreq
Date: Wed, 18 May 2011 02:37:40 -0500
Message-ID: <1305704266-17623-1-git-send-email-nm@ti.com>
References: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39797 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754427Ab1ERHhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 03:37:51 -0400
Received: by gwb19 with SMTP id 19so532867gwb.32
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:37:49 -0700 (PDT)
In-Reply-To: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Rev 2 of cleanups for cpufreq to include a couple of bugfixes we found as part of
additional dvfs testing and code review.

Testing done: OMAP4SDP4430 +.39-rc7- I think the only other major platform would be
omap2 - but I doubt it was functional previously - if someone has a chance to give
it a whirl, please do, as I dont have access to an OMAP2 platform atm :(.

Applies on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm-wip/cpufreq

Changes since V1: http://marc.info/?l=linux-omap&m=130532085617487&w=2
	Patch 5 was reworked - return condition handling + lesser spam error msg
	Patch 6 was added - caught as part of kmemleak check
	
Nishanth Menon (6):
  OMAP2+: cpufreq: free up table on exit
  OMAP2+: cpufreq: handle invalid cpufreq table
  OMAP2+: cpufreq: minor comment cleanup
  OMAP2: cpufreq: use clk_init_cpufreq_table if OPPs not available
  OMAP2+: cpufreq: use cpufreq_frequency_table_target
  OMAP2+: cpufreq: fix freq_table leak

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   81 ++++++++++++++++++++++++++-----
 1 files changed, 69 insertions(+), 12 deletions(-)

Regards,
Nishanth Menon

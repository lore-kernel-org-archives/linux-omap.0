From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq
Date: Fri, 13 May 2011 14:07:21 -0700
Message-ID: <1305320846-16147-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47063 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758555Ab1EMVHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 17:07:34 -0400
Received: by mail-yx0-f178.google.com with SMTP id 15so1343962yxa.23
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 14:07:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Hi,
a few cleanups for cpufreq to include a couple of bugfixes we found as part of
dvfs testing and code review.

Testing done: OMAP4SDP4430 - I think the only major platform would be omap2 -
but I doubt it was functional previously - if someone has a chance to give
it a whirl, please do, as I dont have access to an OMAP2 platform atm :(.

Applies on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm-wip/cpufreq

Nishanth Menon (5):
  OMAP2+: cpufreq: free up table on exit
  OMAP2+: cpufreq: handle invalid cpufreq table
  OMAP2+: cpufreq: minor comment cleanup
  OMAP2: cpufreq: use clk_init_cpufreq_table if OPPs not available
  OMAP2+: cpufreq: use cpufreq_frequency_table_target

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   56 +++++++++++++++++++++++++------
 1 files changed, 45 insertions(+), 11 deletions(-)

Regards,
Nishanth Menon

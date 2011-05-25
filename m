From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Wed, 25 May 2011 16:38:45 -0700
Message-ID: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47957 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752130Ab1EYXjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:00 -0400
Received: by mail-yi0-f48.google.com with SMTP id 28so113659yia.35
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:38:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Rev 3 of cleanups for cpufreq to include a couple of bugfixes we found as part of
additional dvfs testing and code review.

Testing done: OMAP4SDP4430 +.39- I think the only other major platform would be
omap2 - but I doubt it was functional previously - if someone has a chance to give
it a whirl, please do, as I dont have access to an OMAP2 platform atm :(.

Applies on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm-wip/cpufreq

Depends on: http://marc.info/?t=130630947000002&r=1&w=2

v3:
   Changes:
      minor rewrite for OMAP2 Vs OMAP3+ handling - code deltas isolated
      dropped support for !freq_table (makes no sense for OMAP2+)
      couple of additional cleanups and review comment incorporated
      introduced OPP libary api(dependency)

v2: http://marc.info/?l=linux-omap&m=130570427214357&w=2
V1: http://marc.info/?l=linux-omap&m=130532085617487&w=2

Nishanth Menon (8):
  OMAP2+: cpufreq: move clk name decision to init
  OMAP2+: cpufreq: deny initialization if no mpudev
  OMAP2+: cpufreq: use opp/clk_*cpufreq_table based on silicon
  OMAP2+: cpufreq: dont support !freq_table
  OMAP2+: cpufreq: fix invalid cpufreq table with central alloc/free
  OMAP2+: cpufreq: fix freq_table leak
  OMAP2+: cpufreq: put clk if cpu_init failed
  OMAP: cpufreq: minor file header updates

 arch/arm/mach-omap1/omap1-cpufreq.c     |    1 -
 arch/arm/mach-omap2/omap2plus-cpufreq.c |  182 +++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 48 deletions(-)

Regards,
Nishanth Menon

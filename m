From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH v4 0/4] Cleanups for cpufreq
Date: Thu, 26 May 2011 19:39:16 -0700
Message-ID: <1306463960-27340-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43113 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974Ab1E0Cj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 22:39:29 -0400
Received: by mail-gy0-f181.google.com with SMTP id 4so674767gyh.12
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 19:39:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Rev 4 of cleanups for cpufreq to take care of the review comments on
the remaining rev3 patches.

Applies on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm-wip/cpufreq

Tested on SDP4430 - with a TI internal loadgenerator controlled on each cpu
while online/offline of cpu1 and using all governors. (Used a forked dvfs
for testing purposes)

Patch 4 Depends on: http://marc.info/?t=130630947000002&r=1&w=2
v4: changes:
	* we drop omap2 code for clk_init/exit and expect omap2 be
	supported once we get OPP/wrapper function to give us that
	function (http://marc.info/?l=linux-omap&m=130644155723048&w=2)
	* Dropped  the mutex infavor of atomic
	(http://marc.info/?l=linux-omap&m=130643487913294&w=2)

v3: http://marc.info/?l=linux-omap&m=130636674200733&w=2
v2: http://marc.info/?l=linux-omap&m=130570427214357&w=2
V1: http://marc.info/?l=linux-omap&m=130532085617487&w=2

Nishanth Menon (4):
  OMAP2+: cpufreq: dont support !freq_table
  OMAP2+: cpufreq: use OPP library
  OMAP2+: cpufreq: put clk if cpu_init failed
  OMAP2+: cpufreq: fix freq_table leak

 arch/arm/mach-omap2/Makefile            |    4 +-
 arch/arm/mach-omap2/omap2plus-cpufreq.c |  103 ++++++++++++++++++------------
 2 files changed, 64 insertions(+), 43 deletions(-)

Regards,
Nishanth Menon

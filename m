From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/cpufreq][PATCH 0/3] OMAP2+: cpufreq: fixes
Date: Mon,  6 Jun 2011 21:05:27 -0500
Message-ID: <1307412330-25798-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59233 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754406Ab1FGCFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:05:33 -0400
Received: by gxk28 with SMTP id 28so2643387gxk.27
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:05:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Hi,
Here are a set of fixes on cpufreq based.
Basic tests with ondemand, userspace governors on:
	SDP3630
	SDP4430
Applies on:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
cpufreq  8651d1b OMAP2+: cpufreq: fix freq_table leak

Colin Cross (1):
  OMAP2+: cpufreq: notify even with bad boot frequency

Nishanth Menon (2):
  OMAP2+: cpufreq: minor flow beautification
  OMAP2+: cpufreq: do lateinit

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Regards,
Nishanth Menon

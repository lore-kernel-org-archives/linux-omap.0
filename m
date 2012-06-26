From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP3 PM: preformance enhancements
Date: Tue, 26 Jun 2012 07:43:18 -0500
Message-ID: <87obo6dz15.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:59858 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756524Ab2FZMnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 08:43:12 -0400
Received: by vcdm8 with SMTP id m8so3252796vcd.23
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 05:43:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>

Tony,

Please pull the following PM/performance enhancements for v3.6.  I
recently rebased it on your devel-pm branch to avoid some conflicts
with the IO chain stuff recently merged from Paul.

This series had the goal of improving the responsiveness of the
shallowest idle states.  Several reports came in that even when only
hitting the shallowest idle states, there was a significant performance
hit.  This series addresses the major sources of latency in the
shallowest idle states.

Kevin

The following changes since commit 9a17d88e0586bb7189655f8f99484a872a474626:

  Merge tag 'omap-devel-c-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-pm (2012-06-25 07:41:17 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/pm/performance

for you to fetch changes up to 05011f711fc751456972d126bbb8081723629408:

  ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state (2012-06-25 11:24:24 -0700)

----------------------------------------------------------------
Jean Pihet (3):
      ARM: OMAP3: PM: cpuidle: default to C1 in next_valid_state
      ARM: OMAP3: PM: cpuidle: optimize the PER latency in C1 state
      ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state

Kevin Hilman (3):
      ARM: OMAP2+: powerdomain: allow pre/post transtion to be per pwrdm
      ARM: OMAP3: PM: call pre/post transition per powerdomain
      ARM: OMAP3: PM: cleanup cam_pwrdm leftovers

 arch/arm/mach-omap2/cpuidle34xx.c         |   71 +++++++++++------------------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 +-
 arch/arm/mach-omap2/pm34xx.c              |   21 ++++++---
 arch/arm/mach-omap2/powerdomain.c         |   16 +++++--
 arch/arm/mach-omap2/powerdomain.h         |    4 +-
 5 files changed, 57 insertions(+), 59 deletions(-)

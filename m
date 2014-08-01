From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few omap fixes for v3.17 merge window
Date: Fri, 1 Aug 2014 04:16:00 -0700
Message-ID: <20140801111600.GB26699@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10478 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaHALR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2014 07:17:26 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3965f5ba0489c01f419216c8909965b9a6a39388:

  Merge branch 'omap-for-v3.17/mailbox' into omap-for-v3.17/soc (2014-07-23 01:26:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/soc-fixes

for you to fetch changes up to ae21e6180a03c147514c606b4e649690e0cbd40e:

  ARM: OMAP3: Fix coding style problems in arch/arm/mach-omap2/control.c (2014-08-01 01:21:14 -0700)

----------------------------------------------------------------
Few fixes for the v3.17 merge window:

- Fix for DPLL rate rounding

- Fix for omap3 ES3.1.2 suspend

- Few coding style fixes

Note that these are based on earlier omap-for-v3.17/soc.
No strict dependency to it though, but I already merged in
the pull request from Paul for the first fix into it and
these are all SoC related.

----------------------------------------------------------------
Jeremy Vial (2):
      ARM: OMAP3: Fix choice of omap3_restore_es function in OMAP34XX rev3.1.2 case.
      ARM: OMAP3: Fix coding style problems in arch/arm/mach-omap2/control.c

Paul Walmsley (1):
      ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to round to next-lowest rate

Tony Lindgren (1):
      Merge tag 'for-v3.17/omap-clock-b' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.17/soc

 arch/arm/mach-omap2/clkt_dpll.c | 28 +++++++++++++++++++++-------
 arch/arm/mach-omap2/control.c   |  6 +++---
 arch/arm/mach-omap2/dpll3xxx.c  | 13 +++++++++++--
 3 files changed, 35 insertions(+), 12 deletions(-)

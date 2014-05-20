From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] omap soc changes for v3.16 merge window
Date: Mon, 19 May 2014 18:30:31 -0700
Message-ID: <20140520013030.GE15793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37954 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750948AbaETBag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 21:30:36 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Looks like I'm still having trouble sending out some pull requests,
so apologies you're seeing these as duplicates.

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/soc-signed

for you to fetch changes up to 733d20eeeeb31587aacd917fb0aaf2888c26a4b5:

  ARM: DRA752: add detection of SoC information (2014-05-19 15:38:03 -0700)

----------------------------------------------------------------
SoC related changes for omaps.

----------------------------------------------------------------
Archit Taneja (1):
      ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data

Dave Gerlach (1):
      ARM: OMAP2+: Remove suspend_set_ops from common pm late init

Nishanth Menon (1):
      ARM: DRA752: add detection of SoC information

Peter Ujfalusi (1):
      ARM: omap4: hwmod_data: Clean up audio related structures (remove/merge them)

Tony Lindgren (1):
      Merge tag 'for-v3.16/hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.16/soc

 arch/arm/mach-omap2/id.c                   |  37 ++++
 arch/arm/mach-omap2/io.c                   |   1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  99 +---------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 283 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                   |  17 +-
 arch/arm/mach-omap2/pm.h                   |   8 +-
 arch/arm/mach-omap2/pm24xx.c               |   4 +-
 arch/arm/mach-omap2/pm34xx.c               |   7 +-
 arch/arm/mach-omap2/pm44xx.c               |   6 +-
 arch/arm/mach-omap2/soc.h                  |   5 +
 10 files changed, 361 insertions(+), 106 deletions(-)

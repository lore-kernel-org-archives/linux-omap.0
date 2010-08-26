From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v2.6.36
Date: Thu, 26 Aug 2010 16:10:35 -0700
Message-ID: <20100826231035.GE12567@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63145 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0HZXKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:10:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Linus,

Please pull omap-fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 76be97c1fc945db08aae1f1b746012662d643e97:

  Linux 2.6.36-rc2 (2010-08-22 17:43:29 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Kevin Hilman (1):
      OMAP3: PM: ensure IO wakeups are properly disabled

Nishanth Menon (1):
      omap3: id: fix 3630 rev detection

Tony Lindgren (3):
      omap: Fix sev instruction usage for multi-omap
      omap: Use CONFIG_SMP for test_for_ipi and test_for_ltirq
      omap: Fix omap_4430sdp_defconfig for make oldconfig

stanley.miao (1):
      OMAP3: Fix a cpu type check problem

 arch/arm/configs/omap_4430sdp_defconfig        |    3 +++
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c           |   14 +++++++-------
 arch/arm/mach-omap2/id.c                       |    2 +-
 arch/arm/mach-omap2/include/mach/entry-macro.S |    6 ++++--
 arch/arm/mach-omap2/omap-smp.c                 |    3 +--
 arch/arm/mach-omap2/pm34xx.c                   |    4 +++-
 arch/arm/plat-omap/include/plat/smp.h          |    7 -------
 8 files changed, 20 insertions(+), 20 deletions(-)

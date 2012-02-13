From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.3-rc3
Date: Mon, 13 Feb 2012 09:45:58 -0800
Message-ID: <20120213174557.GB1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20848 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653Ab2BMRqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 12:46:03 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd and Olof,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

This contains a DT boot fix that was found sitting in the omap DT branch,
omap2 related PM fix for serial port, and few compile and warning fixes.

Note that Russell also has a series of omap fixes queued up that will get
merged via his tree. There should not be any conflicts between these
two series.

Regards,

Tony


The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
  Linus Torvalds (1):
        Linux 3.3-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Benoit Cousson (1):
      ARM: OMAP2+: board-generic: Add missing handle_irq callbacks

Igor Grinberg (1):
      ARM: OMAP3: cm-t35: fix section mismatch warning

Paul Walmsley (1):
      ARM: OMAP2xxx: PM: fix OMAP2xxx-specific UART idle bug in v3.3

Santosh Shilimkar (1):
      ARM: OMAP2: Fix the OMAP2 only build break seen with 2011+ ARM tool-chains

Tony Lindgren (1):
      Merge branch 'fixes-dt' into fixes

 arch/arm/mach-omap2/Makefile                  |    4 ++--
 arch/arm/mach-omap2/board-cm-t35.c            |    2 +-
 arch/arm/mach-omap2/board-generic.c           |    4 ++++
 arch/arm/mach-omap2/pm24xx.c                  |    8 +-------
 arch/arm/plat-omap/include/plat/omap-secure.h |    2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

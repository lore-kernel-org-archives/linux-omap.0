From: Tony Lindgren <tony@atomide.com>
Subject: git-pull request for omap-fixes for 2.6.28
Date: Wed, 26 Nov 2008 15:27:09 -0800
Message-ID: <20081126232707.GN11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60793 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbYKZX1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 18:27:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi Russell,

I have three trivial fixes for 2.6.28 that I'll post as a reply to
this thread.

Following is also the pull request for you assuming you don't have
issues with these patches.

Regards,

Tony


The following changes since commit 13d428afc007fcfcd6deeb215618f54cf9c0cae6:
  Linus Torvalds (1):
        Linux 2.6.28-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Amit Kucheria (1):
      ARM: OMAP: Typo fix for clock_allow_idle

Tero Kristo (1):
      ARM: OMAP: Fixes for suspend / resume GPIO wake-up handling

Tony Lindgren (1):
      ARM: OMAP: Remove broken LCD driver for SX1

 arch/arm/plat-omap/gpio.c            |    5 +-
 arch/arm/plat-omap/include/mach/pm.h |    2 +-
 drivers/video/omap/Makefile          |    1 -
 drivers/video/omap/lcd_sx1.c         |  327 ----------------------------------
 4 files changed, 4 insertions(+), 331 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_sx1.c

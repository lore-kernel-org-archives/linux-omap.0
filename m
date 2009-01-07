From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for omap compile fixes, mailbox and hsmmc for
	current merge window
Date: Wed, 7 Jan 2009 13:25:57 +0200
Message-ID: <20090107112556.GI27566@atomide.com>
References: <20090107111415.GF27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55431 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZAGLZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 06:25:59 -0500
Content-Disposition: inline
In-Reply-To: <20090107111415.GF27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>

* Tony Lindgren <tony@atomide.com> [090107 13:14]:
> Hi,
> 
> Here are two patches to fix omap builds.

Russell, here's the pull request for few misc omap patches
for the current merge window:

- These two build fixes

- The hsmmc driver posted earlier and acked by Pierre [1]

- Mailbox updates for omap3 posted earlier by Hiroshi [2]

Regards,

Tony

[1] http://lists.arm.linux.org.uk/lurker/thread/20081207.215139.ba39f495.en.html#20081207.215139.ba39f495
[2] http://lists.arm.linux.org.uk/lurker/thread/20090107.111220.eb4aadfb.en.html#20090107.111220.eb4aadfb


The following changes since commit ede6f5aea054d3fb67c78857f7abdee602302043:
  Linus Torvalds (1):
        Fix up 64-bit byte swaps for most 32-bit architectures

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-misc-for-rmk

Hiroshi DOYU (10):
      omap mailbox: cleanup omap2 register definition with macro
      omap mailbox: add initial omap3 support
      omap mailbox: print hardware revision at startup
      omap mailbox: fix empty struct device for omap_mbox
      omap mailbox: fix empty struct device for omap1
      omap mailbox: fix empty struct device for omap2
      omap mailbox: add save_/restore_ctx() for PM
      omap mailbox: move mailbox.h into mailbox.c
      omap mailbox: convert sequence bit checking to module paramter
      omap mailbox: remove unnecessary header file inclusion

Jarkko Nikula (1):
      ARM: OMAP: Fix gpio by switching to generic gpio calls

Madhusudhan Chikkature (1):
      omap mmc: Add new omap hsmmc controller for 2430 and 34xx, v3

Tony Lindgren (1):
      ARM: OMAP: Fix missing includes

 arch/arm/mach-omap1/board-sx1.c            |    6 +-
 arch/arm/mach-omap1/devices.c              |    2 +-
 arch/arm/mach-omap1/mailbox.c              |   31 +-
 arch/arm/mach-omap1/mcbsp.c                |    1 +
 arch/arm/mach-omap2/board-apollon.c        |   49 +-
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/devices.c              |   38 +-
 arch/arm/mach-omap2/mailbox.c              |  195 +++--
 arch/arm/mach-omap2/mcbsp.c                |    1 +
 arch/arm/plat-omap/Kconfig                 |    8 +
 arch/arm/plat-omap/i2c.c                   |    1 +
 arch/arm/plat-omap/include/mach/gpio.h     |   10 -
 arch/arm/plat-omap/include/mach/mailbox.h  |   27 +-
 arch/arm/plat-omap/include/mach/omap34xx.h |    1 +
 arch/arm/plat-omap/mailbox.c               |  152 +++-
 arch/arm/plat-omap/mailbox.h               |  100 ---
 drivers/mfd/twl4030-core.c                 |    1 +
 drivers/mmc/host/Kconfig                   |   10 +
 drivers/mmc/host/Makefile                  |    1 +
 drivers/mmc/host/omap_hsmmc.c              | 1242 ++++++++++++++++++++++++++++
 drivers/mtd/onenand/omap2.c                |    6 +-
 21 files changed, 1598 insertions(+), 286 deletions(-)
 delete mode 100644 arch/arm/plat-omap/mailbox.h
 create mode 100644 drivers/mmc/host/omap_hsmmc.c
